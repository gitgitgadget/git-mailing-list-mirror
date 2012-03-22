From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 07:49:11 +0100
Message-ID: <4F6ACB67.1080503@viscovery.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter J. Weisberg" <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 07:49:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAbps-00031B-J9
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 07:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab2CVGtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 02:49:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10909 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341Ab2CVGtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 02:49:16 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SAbpf-0004Yq-Vd; Thu, 22 Mar 2012 07:49:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7193A1660F;
	Thu, 22 Mar 2012 07:49:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193635>

Am 3/21/2012 23:50, schrieb Peter J. Weisberg:
> +test_expect_failure "diff-files doesn't show case change when ignorecase=true" '
> +	git config core.ignorecase true &&
> +
> +	touch foo &&
> +	git add foo &&
> +	git commit -m "foo" &&
> +	mv foo FOO &&
> +
> +	test -z "$(git diff-files)"
> +'

I tried this in my git.git clone on Windows (NTFS), and it did not produce
the expected failure:

D:\Src\mingw-git>git config core.ignorecase
true

D:\Src\mingw-git>mv git.c GIT.C

D:\Src\mingw-git>git diff-files

D:\Src\mingw-git>echo %ERRORLEVEL%
0

D:\Src\mingw-git>ls -l [Gg][Ii][Tt].[Cc]
-rw-r--r--    1 jsixt    Administ    17166 Mar 22 06:44 GIT.C

What am I missing?

-- Hannes
