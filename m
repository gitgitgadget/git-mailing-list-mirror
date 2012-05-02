From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/4] tests: check --[short]stat output after chmod
Date: Wed, 02 May 2012 09:36:44 +0200
Message-ID: <4FA0E40C.6030809@viscovery.net>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl> <1335892215-21331-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, mj@ucw.cz
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed May 02 09:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPU7N-0000si-BE
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 09:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab2EBHgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 03:36:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54172 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482Ab2EBHgw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 03:36:52 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SPU7B-0002s8-W3; Wed, 02 May 2012 09:36:47 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3E8BE1660F;
	Wed,  2 May 2012 09:36:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1335892215-21331-3-git-send-email-zbyszek@in.waw.pl>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196791>

Am 5/1/2012 19:10, schrieb Zbigniew J=C4=99drzejewski-Szmek:
> +test_expect_success 'prepare binary file' '
> +	git commit -m rezrov &&
> +	dd if=3D/dev/zero of=3Dbinbin bs=3D1024 count=3D1 &&
> +	git add binbin &&
> +	git commit -m binbin
> +'

Please squash in this fixup; we do not have /dev/zero on Windows.


diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 693bfc4..7a3e1f9 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -27,7 +27,7 @@ test_expect_success 'chmod' '
=20
 test_expect_success 'prepare binary file' '
 	git commit -m rezrov &&
-	dd if=3D/dev/zero of=3Dbinbin bs=3D1024 count=3D1 &&
+	printf "\00\01\02\03\04\05\06" >binbin &&
 	git add binbin &&
 	git commit -m binbin
 '
--=20
1.7.10.1.1568.gede6096
