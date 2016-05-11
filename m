From: Brandon Teska <brandon.teska@gmail.com>
Subject: Pre-Process Files for Commits and Pulls
Date: Wed, 11 May 2016 14:45:29 -0600
Message-ID: <CALo8eZyX+vPMxVzeQgrhn0G+x44myvPot-EqC=DACEo3OwDwQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 22:45:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0b0h-00038n-MB
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 22:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcEKUpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 16:45:31 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33499 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcEKUpa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 16:45:30 -0400
Received: by mail-yw0-f177.google.com with SMTP id t10so61438130ywa.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=CpJDkxdolVejXyD0HmEUq3PVj7TK7UoJKUOUQOpNjik=;
        b=jHA+an5Z7q+GT6K14kiJkQDupqoXbsWvT6QiatfO2FgllGyLonoscNlBZlA6a3RAw6
         T4xhCWjmelb7Cn6EzC2hYGR6gwJoegSiCV7CTUDxmNddyMt6Psz0Bt4tu7/AKsiQSKBc
         JgxolCiVHJskNAOOJD6Z2l9lo5dbxxIJH4YieCI7ZFCOs0A1IRTwIAPYjV3OrAMKGeuj
         vV5AS2wyPxEGx8wOEejZSupRq9tngcdCkt2JGmUbTsgVBazyNLh+U74ekBQeB1veF0pZ
         e5qbbawQBsPeq3K4yRw4APN1BZmMYrIvL3Mb2pqpzAzcbCajaeGAbyb+dK9mehyadu/n
         E/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CpJDkxdolVejXyD0HmEUq3PVj7TK7UoJKUOUQOpNjik=;
        b=isqd3W9UKIycj9STx6sZ+HFYW+/pZoIfvWnVnAIgay3m2OZj+CGocUKPislERFiblG
         93iHTueWEnngzYpBcRQ/ULiitkC0VsRiLQBv09swrZYHYVndX2YvtCtDaA+fwItnc/PE
         WgSubJdYDj8JxUOGMsc/jUsyrbLnVUAvUW3thkZHj/sN+EkgqZlM5KgKisMffv+59F2V
         C91W926UUQo9De9sL8Bvyd4TYJ8OV+ib9rssCHRHBU0hDLntzqSH1cOIrxaDYMh0nWzU
         TMt5unJCTkiAhwvXGN1SZt9xo+b6Ow9jA9wOrSBb/uFn8GNWIXJvm8v7uOX2IHtExUBu
         hQ9A==
X-Gm-Message-State: AOPr4FUzaG0e2t3jZYZ+/0kGTbC38V6v8R+y39bzwn1PNVL/XuK+fAKQTJtfofm/z5Xo2G30RrAtT+qjCz5N2g==
X-Received: by 10.129.103.85 with SMTP id b82mr2648413ywc.127.1462999529406;
 Wed, 11 May 2016 13:45:29 -0700 (PDT)
Received: by 10.129.93.131 with HTTP; Wed, 11 May 2016 13:45:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294363>

Hi everyone,

I have an unusual question. I'm curious if git can pre-process files
before pushing them to a remote repo and then reprocess them on pulls.
Basically, I'm trying to work collaboratively with a few colleagues on
a project using another software program. I've decoded the file we've
been working on, so that we have the "source" that would be well
managed by git. However, I need this to be accessible to laypeople so
I need my workflow to look like this:

1. Person A works on (binary) file locally
2. Person A commits and pushes to the repo
3. Before the push, a script deconstructs the binary file into several
text files
4. Those text files are pushed

Similarly, when Person B pulls from the repo, this is what I need to happen:

1. Person B pulls
2. Before sending the pull, git calls a script that repackages the
text files into a "binary" files that the software can use.
3. Person B can now update the file as he wishes

So, basically I am curious if git can store a different "form" of the
file(s) that what are actually worked on. Is this possible? (I'd like
to avoid running client side scripts if at all possible, but would be
willing if that's a possibility.)

Thanks!

Brandon
