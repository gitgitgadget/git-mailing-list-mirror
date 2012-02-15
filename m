From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3 v4] diff --stat: use the full terminal width
Date: Wed, 15 Feb 2012 08:39:10 +0100
Message-ID: <4F3B611E.4060504@viscovery.net>
References: <7vsjie9q77.fsf@alter.siamese.dyndns.org> <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 08:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxZSs-0000cd-9d
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 08:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab2BOHjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 02:39:37 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18323 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295Ab2BOHjS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 02:39:18 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RxZSJ-0005v3-7j; Wed, 15 Feb 2012 08:39:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C73C31660F;
	Wed, 15 Feb 2012 08:39:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190815>

Am 2/15/2012 0:45, schrieb Zbigniew J=C4=99drzejewski-Szmek:
> +test_expect_success 'preparation' '
> +	> abcd &&
> +	git add abcd &&
> +	git commit -m message &&
> +	seq 1000 > abcd &&
> +	git commit -m message abcd

Please don't use seq (here and in some more places in this series); we
don't have it on Windows. You can write it explicitly:

	i=3D0 &&
	while test $i -lt 1000
	do
		i=3D$(($i + 1))
		echo $i &&
	done >abcd &&
	...

-- Hannes
