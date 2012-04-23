From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH 0/2] git-svn: fixes for intermittent SIGPIPE
Date: Mon, 23 Apr 2012 11:05:37 +0400
Message-ID: <CANiYKX5RNb3YXhGWXzpfDz+XK1PM6zyN=zrDKk3_4StCu2ukzg@mail.gmail.com>
References: <cover.1333381684.git.rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 09:05:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMDLE-0006QB-6B
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 09:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab2DWHFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 03:05:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60388 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2DWHFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 03:05:38 -0400
Received: by obbta14 with SMTP id ta14so12291225obb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fpwd3COqYrtnGvh6jZtVQVKfyeGcAVTgNNUq0ZSPFQk=;
        b=P/i4ehceFYoNkWw0oLqQWrX9kil7VJ9A9ryHxih5OK1DoDprj5azHSMxD4wk+wG+FV
         vOYqUMLbuMgOSrQ5Bz4g51vEaXKbApW4zMVh0tUZmuRTLwNj4Ws3VEenhGt3I9nnuORv
         RIhsaSqvM0fFuAv3chZrG3H3mkrs34y6CxUyWG9+4YuwPsz1ziIFjr4/oA7Bbagucfm0
         4NBkMXA+q814/tbdoFG+ZTDrFEekXgelkiMatWXQvNf5wuAiBmLoUJaY2jM8RUOtIkXj
         UQIJtJs0prXz0OFfJod1EEL0mO64JLKiOU9g4LEgqBza/mDHFBWY8MmAZmxtr9tTOYr1
         z3ww==
Received: by 10.60.11.166 with SMTP id r6mr6465069oeb.2.1335164738003; Mon, 23
 Apr 2012 00:05:38 -0700 (PDT)
Received: by 10.182.46.129 with HTTP; Mon, 23 Apr 2012 00:05:37 -0700 (PDT)
In-Reply-To: <cover.1333381684.git.rkagan@mail.ru>
X-Google-Sender-Auth: mX_ezCJ_EQmxc0pV_JpGu6kHkpI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196097>

2 =C1=D0=D2=C5=CC=D1 2012=9A=C7. 20:13 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=
=D8 Roman Kagan <rkagan@mail.ru> =CE=C1=D0=C9=D3=C1=CC:
> In my work environment subversion is still being used as the main
> revision control system. =9ATherefore many people who prefer to work =
with
> git have to resort to git-svn.
>
> However, in many configurations it used to suffer from the notorious
> "git-svn died of signal 13" problem (see e.g.
> http://thread.gmane.org/gmane.comp.version-control.git/134936 and the
> links therein).
>
> I believe to have tracked down the issue to the connection being clos=
ed
> by the server when http keep-alive is in use, and the client dying on
> SIGPIPE because its handler is left at SIG_DFL when a new request is
> being made.
>
> The patches have been tested on
>
> - Linux Fedora 16 x86_64, git 1.7.7.6, perl v5.14.2, svn 1.6.17
> - Windows 7 x64 + Cygwin, git 1.7.9, perl v5.10.1, svn 1.7.4,
> - Windows 7 x64 + MsysGit, git 1.7.9.msysgit.0, perl v5.8.8, svn 1.4.=
6
>
> Roman Kagan (2):
> =9Agit-svn: use POSIX::sigprocmask to block signals
> =9Agit-svn: ignore SIGPIPE
>
> =9Agit-svn.perl | =9A 20 ++++++++++++++------
> =9A1 files changed, 14 insertions(+), 6 deletions(-)

IIUC the series was approved by Eric.  What do I need to do now to
have it reviewed for accepting into the master tree?

Thanks,
Roman.
