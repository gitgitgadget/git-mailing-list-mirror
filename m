From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 16:05:04 +0530
Message-ID: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 12:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V082P-000401-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 12:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229Ab3GSKfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 06:35:46 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51092 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089Ab3GSKfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 06:35:45 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so8985886iea.39
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=xGlOplgfYv1TJ23hQSoeTWBqF9/7ktu04a4bX7kI4UI=;
        b=Cl7qKqqI/eIkqoaMvuvoaRKlPhDn09TFjV2DGwke/sY/RnnKw309W/rTrGZxtluM3A
         JCQZBeR//jV+mZt8hidsjuL6k7rCcHSDiux3t4+NxCDe5hp3tAFNY4LFL7DzRH1+yUyn
         4tQVnI1vOfiwr62s2KQkynCr1NuF3zJqxIzt/z2a+kiVp9EZQH1WBJ3bVnjAyVuStMzG
         T0k0zA3S8U0AwOzpd1wHFCVAVCahBsi0UoJc0IPHewaf42dKX5Jeb4W9VJl4QAMA/jRM
         m0PlS42JLd587NKUJbiBN/JS/buZFypj2cLjePlsRzn1NOMg+CY640i2SIOLoYTv/J7W
         IApQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr9286013icc.61.1374230144948; Fri,
 19 Jul 2013 03:35:44 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 03:35:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230789>

Hi,

Many of my ideas turn out to be really stupid, and I need to throw
away my feature branch.  So, I find myself doing this often:

  # on branch menuconfig-jk
  $ git checkout master
  $ git branch -D<BACKSAPCE>
  # er, what was the branch name again?
  $ git checkout -
  # Ah
  $ git checkout master
  $ git branch -D menuconfig-jk

So, I scripted it for myself.  Perhaps we should get the functionality
in core as `git branch -Dc` (c for "current"; or something)?

Also, perhaps a `git describe -` corresponding to `git checkout -`?
Then I can use it with --contains --all to get the name of the
previous branch.

Thanks.
