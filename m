From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Sun, 5 Oct 2014 22:49:09 +0200
Message-ID: <CAENte7gQm-Mb=73M9dv=vR+N8y=tUsrhLdrwDu4LxOcEFKNB3g@mail.gmail.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
 <20141002161006.GB2505@peff.net> <20141002173551.GA12591@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Dan Johnson <computerdruid@gmail.com>,
	Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 22:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaskJ-0004Xv-BG
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 22:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaJEUtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2014 16:49:31 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:38256 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbaJEUta (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 16:49:30 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so3169154qcw.31
        for <git@vger.kernel.org>; Sun, 05 Oct 2014 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i6yU0SZtas8CMCjumB9Wm3RISGX3XPFGdAU/7e8XEFw=;
        b=bFBro9/nGwrK+7Sb3EKjA3chroJVvtRkbv8tYqVA5+Mt8hhnmoKwX6oziZS/VQb7un
         DWHDXBeAL0bXJHanN+oe8nQelQn56K4PkXtI+okYZ2O3TwmZMQ9069afBYAGmIZfOMhL
         0PJjoKbhYWj9Zb0zdZYBcFnmCQGaPp3LiljKG3jtbHJbjUBWfaMDeB9Ut+bAlaodnNr/
         nUmnb6PTLfri0rIicCEDhpMePN7pd2y4/xuZWqDtBm5oWuep/rh55R0+9zjNCTqeaHqh
         aRYFaUTsI1ArEguuu0hT3Rl6IfjFICXXL9Fe9ZYHyq21UotpTi27O8yCo+/W30c3q/TE
         48lw==
X-Received: by 10.224.125.4 with SMTP id w4mr25456430qar.20.1412542170067;
 Sun, 05 Oct 2014 13:49:30 -0700 (PDT)
Received: by 10.96.61.5 with HTTP; Sun, 5 Oct 2014 13:49:09 -0700 (PDT)
In-Reply-To: <20141002173551.GA12591@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257903>

I also like the feature of being able to fetch commits by SHA-1. My
problem is that it is not clear to end users whether they can fetch
SHA-1 from a specific server or not. For exactly the same server a
"git fetch origin <id-of-commit-x>" first doesn't work and all of the
sudden that command works and updates e.g. FETCH_HEAD. That's because
between the first and the second fetch you fetched that commit already
by fetching a branch.

And even if the commit is known only to the local repo then the fetch
works. I tried to fetch a commit which I just created locally. And the
output is:

> git fetch eclipse 382dfeab0e11bd88388d7195114c046c3ec27d8f
From https://git.eclipse.org/r/jgit/jgit
 * branch            382dfeab0e11bd88388d7195114c046c3ec27d8f -> FETCH_HEAD

This gives me the impression that that update was triggered by data
coming from the server https://git.eclipse.org/r/jgit/jgit. But the
server doesn't know the commit. In my eyes the fetch should fail if
the server doesn't know the commit.

Ciao
  Chris
