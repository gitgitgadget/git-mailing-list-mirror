From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fwd: Runaway "git remote" if group definition contains a remote by
 the same name
Date: Sat, 28 Dec 2013 15:56:55 +0100
Message-ID: <CALxABCbRZ4MmiYS4JF20qf1-iubeTfa+3OLibqdb5+raekuKQg@mail.gmail.com>
References: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 15:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwvKK-00077M-Pk
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 15:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414Ab3L1O5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 09:57:16 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:59071 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3L1O5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 09:57:16 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so10706884oag.28
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=t0XBxgkUujiXayKuiaYACzw8+UT108ay+DHjAkm/8qs=;
        b=hbz9YQR9LdnJKuv9VOdmdevVTMu4yLy3at99STxx1CLv6b+9b8FIs/ystiqjTsDMM+
         QCBQJL+BBv2KBMFpW1oYOImqRdPw0yIGlYtlEUr9FbKdDzJL7209l3cS/Lt3ZBUVn+pB
         vXWkhOrU/HZTB3zZnDiVSRKEeCylx6eEpLzaJR4iDtSFX2kyk/FtoUqfsQrzipJf04Xd
         1cuTe4EvPFyVsL7Nx74f1ktl/o+vUTBykdaFXtqgdwpgiBydkgn5fn7r2tklqVY+HYUl
         Rn7H+u26QZKtTUgIAulj2vavwVy6QOilZCsxxDaS+x3x0dqpQmrrcClbLApczeWNvUQv
         wMlg==
X-Received: by 10.182.121.137 with SMTP id lk9mr37909113obb.32.1388242635479;
 Sat, 28 Dec 2013 06:57:15 -0800 (PST)
Received: by 10.60.50.166 with HTTP; Sat, 28 Dec 2013 06:56:55 -0800 (PST)
In-Reply-To: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239785>

FWIW, the issue is still present.

---------- Forwarded message ----------
From: Alex Riesen <raa.lkml@gmail.com>
Date: Wed, Nov 17, 2010 at 6:10 PM
Subject: Runaway "git remote" if group definition contains a remote by
the same name
To: Git Mailing List <git@vger.kernel.org>


Hi,

it is also a way to create a fork bomb out of the innocent tool on platforms
where pressing Ctrl-C does not terminate subprocesses of the foreground
process (like, of course, Windows).

To reproduce, run

   git -c remotes.origin='origin other' remote update origin

I just cannot look at it right now, and have to resolve to only reporting
the problem to warn people. Something seems to resolve the remotes group
definition over and over again.
