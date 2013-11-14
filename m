From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: introduce %(upstream:track[short])
Date: Thu, 14 Nov 2013 12:23:29 +0530
Message-ID: <CALkWK0kSuSLjmShPx6cibysjvhrU0xqBvm=ivGLCn3L1kTDBFw@mail.gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
 <1384335406-16332-3-git-send-email-artagnon@gmail.com> <xmqqk3gcdr6z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 07:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgqoh-0007FU-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 07:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab3KNGyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 01:54:11 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:51740 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3KNGyK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 01:54:10 -0500
Received: by mail-ie0-f172.google.com with SMTP id to1so2233140ieb.3
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 22:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9eydUc6FK6KjcnkMsTdz1ZghhTcAkSf1bwciCqBkpYA=;
        b=i52wlJ/20L3X3rBuwedCNJMGVbKBc4KZdhtFRytCrfNkoZts9rXxbqmijW3zHaZF2W
         K1xeZ8qP+/r7bf2Sgc9lYbTAayM0dtEtpUIkvhH0noAQdulft8tjXta7sxtREMJA29wS
         Wg8w/su5M/1FfqkmmIlwiF+/0zfsBtcWM3g7JH29nyf7fpAYpfVhx7WOXdCOqSJnQ6k7
         PSIIwkfNvujTmNw3dEn4egRpmUIv2I119Nx3eP0PQyU/cJ64xqw++t4ZcpMcwCngqiEJ
         C+1Cs4vC3CtGzE83F4Q7Vpf8Dw1dTg5KrHpV5o73n6kP/1IG/fQgVTHTKCNoZoh1ThYU
         21IA==
X-Received: by 10.50.40.37 with SMTP id u5mr489316igk.29.1384412049448; Wed,
 13 Nov 2013 22:54:09 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Wed, 13 Nov 2013 22:53:29 -0800 (PST)
In-Reply-To: <xmqqk3gcdr6z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237811>

Junio C Hamano wrote:
> builtin/for-each-ref.c: In function 'populate_value':
> builtin/for-each-ref.c:701:13: error: 'refname' may be used uninitial=
ized in this function [-Werror=3Duninitialized]

In my defense, the gcc on my end (4.8.2) doesn't seem to complain. Are
you using extra cflags?

However, I do get the following compile warnings:

wt-status.c: In function =E2=80=98wt_status_print_unmerged_header=E2=80=
=99:
wt-status.c:187:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, c, "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_cached_header=E2=80=99=
:
wt-status.c:203:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, c, "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_dirty_header=E2=80=99=
:
wt-status.c:222:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, c, "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_other_header=E2=80=99=
:
wt-status.c:234:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, c, "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_trailer=E2=80=99:
wt-status.c:239:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_other=E2=80=99:
wt-status.c:767:2: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
  status_printf_ln(s, GIT_COLOR_NORMAL, "");
  ^
wt-status.c: In function =E2=80=98wt_status_print_tracking=E2=80=99:
wt-status.c:827:3: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
   fprintf_ln(s->fp, "");
   ^
wt-status.c: In function =E2=80=98wt_status_print=E2=80=99:
wt-status.c:1243:3: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
   status_printf(s, color(WT_STATUS_HEADER, s), "");
   ^
wt-status.c:1256:3: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
   status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
   ^
wt-status.c:1258:3: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
   status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
   ^
wt-status.c:1275:4: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
    status_printf_ln(s, GIT_COLOR_NORMAL, "");
    ^
builtin/commit.c: In function =E2=80=98prepare_to_commit=E2=80=99:
builtin/commit.c:808:4: warning: zero-length gnu_printf format string
[-Wformat-zero-length]
    status_printf_ln(s, GIT_COLOR_NORMAL, "");
    ^
