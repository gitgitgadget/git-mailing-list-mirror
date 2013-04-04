From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 04:02:48 +0530
Message-ID: <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com> <7vy5cyexuf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:34:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsjI-0000pZ-3K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765304Ab3DDWda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:33:30 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36420 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765298Ab3DDWda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:33:30 -0400
Received: by mail-bk0-f49.google.com with SMTP id w12so1803690bku.22
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sg75kqZdWafy3cc/ZFh+5Qm/uUSbcD1eHm/SUg4zDXg=;
        b=dfAmd6MBasA5WdznA2oteUsQmgeSKhhNYIiXdQJPN85PLhfxPzvE5b6RgpKt4kr3E1
         YdPJ5QjOC1vhW5YosMiDk4gTwNhLTTAvuZUrPzNy1GO7ElXmT27eUZ9HPWUej9EL3pnC
         5qgudJVpvk5XCSG7nNSjYqvmjpKH48qrChkBWaPek4rjPzoOGTQDw4fJNIakIEEwoX/h
         qxZ+Qk4NHe8HDqYGsB7QPgdk3IS5sxRO1wXkC5YcVs3LVI7qhJDprNG8Gno7RXyVhtxg
         lN9P/4MjfLwldddqcPj29+kFtTuCSTz2caXWbLemwqacvPJkcz8YgbJafRK+b3cOgpBh
         ZwaA==
X-Received: by 10.205.74.136 with SMTP id yw8mr5708780bkb.129.1365114808851;
 Thu, 04 Apr 2013 15:33:28 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Thu, 4 Apr 2013 15:32:48 -0700 (PDT)
In-Reply-To: <7vy5cyexuf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220119>

Junio C Hamano wrote:
> Sounds like you are saying that you can pile a new command on top of
> new command to solve what the existing tools people are familar with
> can already solve in a consistent way without adding anything new.
> Are you going to dupliate various options to "git diff" and "git
> log" in "git diff-link"?  Will you then next need "git log-link"?

What I'm saying is: As always, we start with plumbing and work our way
up to porcelain.  We do have git diff-files, diff-index, diff-tree, so
I don't see what the problem with diff-link is.  The point is that we
can get an initial scripted version out quickly.

And no, I never suggested a git log-link.
