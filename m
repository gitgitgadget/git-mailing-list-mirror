From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Wed, 3 Oct 2012 12:23:42 -0400
Message-ID: <CABURp0rho3KvzHRNXj9EA9C2OnbTc_dcmiBiW6JZ-VHu4g2m0Q@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
 <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
 <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com> <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJRlA-0000e3-1K
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 18:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965340Ab2JCQYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 12:24:08 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33370 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2JCQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 12:24:05 -0400
Received: by lbon3 with SMTP id n3so6374568lbo.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=My/4RiWhczdAZO0+iaU45QxH9uX6qGJnrIPDUyfFQMg=;
        b=GzxHLxjWg2phSXElqRZehQK40B6kprgeHMnrswqZ0shmD0q0GZAWfIlB0Smh2IH1TM
         qq7hi7ZebSlT1CDKSvgUTWD3TBZvdKW5g1PXIsnuaLsSg5f858bG/4YpwsC6+ft1Dgr7
         LOaFPOv/4+iPeJsQFQ4/vvZb0118+UQyYUSlwh/AQZYgXE4fNqyd5fqADuItNoeVrfa1
         bJgy1KJEJVlmmXbxbmVnY+znzCBfrHa2+ctnz1xSFQ1cVMG+Evn9vCtXsTQMBoV8K8Qq
         jQY2MAekWIT+CAFDXe+ZNkS1b46mCyKMdPN9w12fyjfpChoWj0PKM5SaFBFEiSU/ij8L
         IXDw==
Received: by 10.152.47.97 with SMTP id c1mr2061801lan.37.1349281444060; Wed,
 03 Oct 2012 09:24:04 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Wed, 3 Oct 2012 09:23:42 -0700 (PDT)
In-Reply-To: <CAGK7Mr7+_n4opf=uQARxA7iSUMFNn9GCFGD5TrhCgarwGhEySA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206910>

On Tue, Dec 6, 2011 at 2:34 AM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> Think about why you need to use git-reset.  Why do new users need to
>> use git-reset?  What is it they are after?
>
> Ok, so let's forget about git reset and let's focus on the features
> instead. If I got it right you suggested the features that people
> wants most often are uncommit, unadd/undelete and undo. Here's a new
> proposal (based on your input):

I flagged this for followup in my MUA, but I failed to follow-up after
the holidays. I apologize for that, and I really regret it because I
liked where this was going.  I only remembered it today when it came
up again in another thread.

> uncommit: git jump <commit> (currently "git reset --soft <commit>")
> unadd/undelete: git unstage file (currently "git reset --mixed file"
> (with "git checkout file" for deleted files)
> undo: git checkout --force --clean <commit> (currently "git reset
> --hard <commit> && git clean -fd")
>
> So, let's try out some scenarios:
>
> 1) Newbie user clones/pulls a repository from somewhere. He hacks
> around and then things go bad, and he decides to scratch away
> everything he did to make sure things are like they're supposed to be.
> He'd then type "git checkout --force --clean master". If he didn't
> introduce new files, he would simply type "git checkout --force
> master"

I like this just fine.  I think we can explicitly say that HEAD is the
implied default refspec, yes?  "git checkout --force --clean"

> 2) Newbie adds some file to the index, then realise he added one too
> many. He wants to remove it from being added. He'd then type "git
> unstage file".

I'm afraid of the word "stage" because of previous discussions about
its i18n abilities.  How about "unadd" and "unrm"?  Or maybe "git undo
add", "git undo rm" and "git undo commit".

The fact that "git undo rm $FILE" works the same as "git checkout HEAD
-- $FILE" and does not truly "undo" the delete operation may make this
a non-starter.  And I admit I have other qualms about using "undo"
even though I keep on introducing it into the discussion.  For
example, this hypothetical sequence will do what I expect when I read
it:

   cp bar foo
   git add foo
   echo "more info" >> foo
   git add foo
   git unstage foo   # now index:foo == HEAD:foo

But if I use "git undo add", it will not

   cp bar foo
   git add foo
   echo "more info" >> foo
   git add foo
   git undo add foo   # index:foo == HEAD:foo, not index:foo == bar

Dang.

Well, I personally am ok with 'unstage' but I expect others will not be.

> 3) Average user creates a commit and suddenly realise he actually
> wanted to split that commit in two (he cannot use --amend, and he's
> not a rebase -i guru yet). Or he did a "temp" commit because he don't
> know about "git stash" yet and wants to discard it. He wants to simply
> go back to the previous state while keeping his changes in the index
> and the worktree. He'd then type "git jump HEAD^1".

I fear the HEAD^1 concept is too much for the newbie.  What about "git
uncommit [$REF]" instead?  It would work like "git reset --soft
$REF^", I think, but maybe it should fail if $REF has multiple
parents.

If the user really wants to uncommit a merge commit, she may need to
use "git unmerge".

Phil
