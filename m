From: Elliott Cable <me@ell.io>
Subject: Feature-request: Ordering `git log --graph` based on *author's* timestamp
Date: Tue, 28 May 2013 05:54:57 -0400
Message-ID: <CAPZ477NO6svcG924AE3NijGYusFiUuj=xRnwMxW21FJoC=t28g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 11:55:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhGcR-00079f-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 11:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3E1Jy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 05:54:59 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60687 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab3E1Jy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 May 2013 05:54:58 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so9760639oag.1
        for <git@vger.kernel.org>; Tue, 28 May 2013 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=wDUrxyb0GeaigvMZ5Cps7J76nW6I+D8C1j6FeYK6fks=;
        b=XN3ezotZ9ZQp59RYqayU/Ou/d+jFpqefNZL4ASMJDRI4eMzpI8sFbSC04GNVoT1BQX
         bujoRluuSaI97BauRwgfpWh85FPsQ6qaEUcx0w5schxnOp6uQh+QRynQB9/w8aNVYs1H
         fsRt1Z8R92DHYDCyB8uEr8TfwmGaM1d1OGzTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=wDUrxyb0GeaigvMZ5Cps7J76nW6I+D8C1j6FeYK6fks=;
        b=oyKB6kNyhdQKkVIZlpQhtIvQm9ybTfxzY0mI3P5oPdLYEaA3voWgvdGyXU+VpaVwVp
         eEDV2tttQX6UMsR7FmBdzBALH/L7SkI5XcL7cLZ2rbeUCCQhq/VeFCnOC2JV8h1cg3aj
         iCFU/U17nA8o0pqF/JfPWnFougP618UqF6dmSxipziH6SQdePN91UUpqmQp2saJ2tQak
         darXFEkQcOyp4/rbwEpBZ2xaLsIzMf1BNBSV2h4oK34K1sVc6CaJ/M+wR6HBvCGVZx0x
         l2nR1tza18b794GLXeiVP3L2cNskOUuTW/P+eBLL4bxTmoj3VGTr5agTwTOwQ0MKl4VS
         Ihcw==
X-Received: by 10.182.241.194 with SMTP id wk2mr20159326obc.77.1369734897104;
 Tue, 28 May 2013 02:54:57 -0700 (PDT)
Received: by 10.60.131.167 with HTTP; Tue, 28 May 2013 02:54:57 -0700 (PDT)
X-Originating-IP: [174.106.131.94]
X-Gm-Message-State: ALoCoQkp7FAlBBS/SCzT2xPP6PsXI8D6jUYU3+x2+7kehL6f385hLIRM+E6wVqKw5edi/b/y2U8Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225624>

I use a fairly complex `git-log` command involving `--date-order` to
get an overview of my repository's status; but unfortunately,
`--date-order` seems to use the *committer* date, not the *author*
date. That means that each time I bring my topic branches up to date
by rebasing them onto the current upstream, I lose the helpful
chronological ordering in my `git-log` of relative commits in my topic
branches (that is, each branch becomes a single long line, because all
of its commits got rebased to sequential and nearly-identical
committer timestamps.)

After a bit of activity on [a Stack Overflow question][1], I've
realized that this is basically impossible without 1. dumping `git
log`'s `--graph` feature *entirely*, and writing a very complex custom
system to order and re-graph commits, or 2. getting `git log`
**itself** patched to support an `--author-order` flag or something.

(I've never posted here before, forgive me if this is the wrong way to
go about this =E2=80=A6 the #git channel on Freenode pointed me here. :=
)

   [1]: <http://stackoverflow.com/questions/8576503/how-can-i-make-git-=
log-order-based-on-authors-timestamp>
