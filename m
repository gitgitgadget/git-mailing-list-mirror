From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/2] test results for v1.7.12-rc0 on cygwin
Date: Sun, 29 Jul 2012 10:57:10 +0200
Message-ID: <5014FAE6.7080009@lsrfire.ath.cx>
References: <50143379.8050500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvPPc-0008Ip-Hq
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 11:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2G2JDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 05:03:35 -0400
Received: from india601.server4you.de ([85.25.151.105]:38295 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2G2JDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 05:03:30 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2012 05:03:30 EDT
Received: from [192.168.2.105] (p4FFD8CEF.dip.t-dialin.net [79.253.140.239])
	by india601.server4you.de (Postfix) with ESMTPSA id B6EB42F8051;
	Sun, 29 Jul 2012 10:57:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <50143379.8050500@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202474>

Am 28.07.2012 20:46, schrieb Ramsay Jones:
> Unfortunately, I was unable to reproduce the final failure in t7810-g=
rep.sh.
> I tried, among other things, to provoke a failure thus:
>
>      $ for i in $(seq 100); do
>      > if ! ./t7810-grep.sh -i -v; then
>      >     break;
>      > fi
>      > done
>      $
>
> but, apart from chewing on the cpu for about 50 minutes, it didn't re=
sult
> in a failure. :(
>
> However, after looking at test 59, it seems to me to be a stale (redu=
ndant)
> test. So, patch #2 removes that test! :-D [I wish I could reproduce t=
he
> failure because I don't like not knowing why it failed, but ...]

Removing the test makes sense, since it was needed for --ext-grep only,=
=20
is relatively expensive and a bit fragile (by depending on MAXARGS).

I'm slightly worried about the non-reproducible failure, though.=20
Perhaps a timing issue is involved and chances are higher if you leave=20
out the option -v?

Thanks,
Ren=E9
