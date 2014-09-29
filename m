From: John Tapsell <johnflux@gmail.com>
Subject: Re: Code changes in merge commits
Date: Mon, 29 Sep 2014 11:01:30 +0100
Message-ID: <CAHQ6N+rJDtq_vtfotM+GXLdN_P==oTqGbFZ97ZQea9+mcoRBog@mail.gmail.com>
References: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 12:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYXmG-00065J-5O
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 12:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaI2KBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 06:01:52 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:44175 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaI2KBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 06:01:51 -0400
Received: by mail-we0-f169.google.com with SMTP id k48so12727162wev.0
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=nDOesdJT9I5szAxfE4KhOGkrXUc0X/kTDVuo09pA0FA=;
        b=VZlQ9Lovlz8739dSN7Hv2v7dW/xjy/E2VlygWQqH/t7wGkSO4Zz4JNblp0sM8cS5JN
         k50IzKeG72kBbEu7wMY/fCJZ4trx7MoChzWm+IInfo6fsicNBRkAnz0sF+DB+Tb/Ha/w
         RbDfm2rZ4eBqN0mDcaomaL9U5GEkUpRnM8CwHTyi3TIrbhVjceNOu20Xg9wEJYHeFFW3
         WODkGWoxoceFtVKSJH6dY7hMB5Li8upuQb8VZIxMIRe57mXymEi4gtmqfN35XOA/Pi+X
         JHBNiBaQJknWZs2T0xGL/HTul9MHD8goUMkFoBc07j7ATmMDeqeEofAGzXfD4uo7GUQF
         nGuA==
X-Received: by 10.194.133.135 with SMTP id pc7mr32977921wjb.54.1411984910819;
 Mon, 29 Sep 2014 03:01:50 -0700 (PDT)
Received: by 10.27.130.193 with HTTP; Mon, 29 Sep 2014 03:01:30 -0700 (PDT)
In-Reply-To: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257618>

Rereading what I wrote, I came across as unintentionally harsh and
rude.  Sorry about that - I was trying to be concise and terse, and it
went a bit wrong :)


What I was thinking to improve this is two short-term fixes:

1. Can we get   git log -m -p .     in the top level directory to show
the same commits as just git log -m -p ?
2. Can we get   git log -m -p somefile           to show all the
changes to that file?  Including when lines are added and then removed
by the merge somehow?

But in the longer term, I was thinking about how this could be improved...

What if merge commits were forced into being always trivial?   i.e.
prevent merges with conflicts or code changes?
Then conflict resolution and code changes are pushed into a second
"ordinary" commit.  That way you can always see what changes have been
made to the code.

E.g.  If you have branch "master"  and branch "A", and there are
conflicts when you merge, you could end up with:

merge commit
   |                  \
   |                  preparation changes to fix conflicts with oldmaster
oldmaster           |
                          A


I know this isn't great, but maybe something along these lines?
Ideally I'd like to see all the code changes to a code base just with
"git log -p".

Any thoughts?

Thanks,

John Tapsell
