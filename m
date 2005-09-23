From: Robert Watson <robert.oo.watson@gmail.com>
Subject: Re: command to show diff of a commit
Date: Fri, 23 Sep 2005 11:06:04 +0100
Message-ID: <72499e3b05092303062a466e37@mail.gmail.com>
References: <72499e3b05092202583f9a751d@mail.gmail.com>
	 <Pine.LNX.4.58.0509220820011.2553@g5.osdl.org>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 23 12:06:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIkRb-0006Eu-Hf
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 12:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVIWKGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 06:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVIWKGL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 06:06:11 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:55987 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750876AbVIWKGJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 06:06:09 -0400
Received: by qproxy.gmail.com with SMTP id v40so148864qbe
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 03:06:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QBAUs9PmINqJzY27X2hNVJmREbn9Eq0mMTDCtCaJlfgyUWlB+6KOsveRqgBAdQ9D4kXz+N8YhWQBMRBCEaWsklqvXE4f8iMBub+liUvtWyLJ4HpDkHcP80bASKIQXzs5Lpr/5RcCXWskdHyA5pFbPB+1zWDD0yXM3NbkDfqApNY=
Received: by 10.65.11.15 with SMTP id o15mr214250qbi;
        Fri, 23 Sep 2005 03:06:04 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Fri, 23 Sep 2005 03:06:04 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509220820011.2553@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9175>

On 9/22/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 22 Sep 2005, Robert Watson wrote:
> >
> > I am wondering what is the best way to show the change introduced by a
> > commit. In the other words, is there a better way to do this:
> >
> > git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
> > b163512d4eb36ee946908b682c7863658c5a8db4
>
> Oh, absolutely.
>
> Do
>
>         git-diff-tree -p --pretty b163512d4eb36ee946908b682c7863658c5a8db4
>
> and you're done.
>
> If you _just_ want the diff (and not the message), skip the "--pretty".
>
>                 Linus
>

Many thanks.  I know there must be a way to do this.

Here is a patch to make the document a bit clearer.

Regards,
Robertoo

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,12 +9,15 @@ git-diff-tree - Compares the content and

 SYNOPSIS
 --------
-'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [<common
diff options>] <tree-ish> <tree-ish> [<path>...]
+'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [<common
diff options>] <tree-ish> [<tree-ish>] [<path>...]

 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found via two tree objects.

+If there is only one <tree-ish> given, the commit is compared with its parents
+(see --stdin below).
+
 Note that "git-diff-tree" can use the tree encapsulated in a commit object.

 OPTIONS
