From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t5000 on Windows: do not mistake "sh.exe" as "sh"
Date: Mon, 24 Nov 2014 21:02:31 +0100
Message-ID: <54738ED7.3000508@web.de>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de> <54735638.9000502@web.de> <54737911.2040502@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XszqV-0000Ob-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 21:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbaKXUCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 15:02:48 -0500
Received: from mout.web.de ([212.227.17.11]:53340 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbaKXUCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 15:02:47 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LzsC7-1XwYIh2VEZ-01522x; Mon, 24 Nov 2014 21:02:38
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54737911.2040502@kdbg.org>
X-Provags-ID: V03:K0:Pu0F2QrRTmPax0MCyxcSDsw5BWYXkvQco2H8OFfarhhyUHsPa4i
 naWx0FvEptmZfK3nn2oi4QceWIiGDLbb+dEwgisjBbS4hGNiDhScSKxCDvstf8xlAwZoRw1
 5pP4IdXiXc+p75bmyYlem5MstRvcrWZEkpjww0H4GnNBUk7MvrPLqn9G+Q5lIEBILTofeDO
 fBM4Minbw6rLRy/sGF2rw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260141>

> 
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index d01bbdc..4b68bba 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -101,7 +101,7 @@ test_expect_success \
>       ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
>       echo long filename >a/four$hundred &&
>       mkdir a/bin &&
> -     cp /bin/sh a/bin &&
> +     test-genrandom "frotz" 500000 >a/bin/sh &&

That's a fast respose :-)
The patch works for me, Thanks
