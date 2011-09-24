From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 23:10:14 +0100
Message-ID: <nbd7plmz30x2.mafpxaq9xl9r.dlg@40tude.net>
References: <4E7C9AAD.7060209@gmail.com> <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <m362khr6kh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:10:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7aQh-00010L-Sh
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 00:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab1IXWK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 18:10:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:49029 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1IXWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 18:10:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7aQV-0000xL-Fr
	for git@vger.kernel.org; Sun, 25 Sep 2011 00:10:27 +0200
Received: from 31.64.20.37 ([31.64.20.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:10:27 +0200
Received: from a5158017 by 31.64.20.37 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:10:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.20.37
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182046>

Jakub Narebski wrote:

>>> > Generally Alice shouldn't have uncommitted changes when doing
>>> > "git pull".
>>> 
>>> That's what the tutorial said but I'm trying to understand
>>> what happens if she does have uncommitted changes. I'm
>>> trying to understand the total picture.
>> 
>> Mercurial allows this, and it's a very powerful feature.
> 
> You *do* realize thet "hg pull" is "git fetch", don't you?

Yes.  This is what I mean:

    c:\test>hg diff

    diff --git a/foo b/foo
    --- a/foo
    +++ b/foo
    @@ -1,1 +1,2 @@
     test
    +new line

    c:\test>hg incoming --patch clone

    comparing with clone
    searching for changes
    changeset:   1:0a897c3462a8
    tag:         tip
    user:        tactical
    date:        Sat Sep 24 23:03:21 2011 +0100
    summary:     bar

    diff --git a/foo b/foo
    --- a/foo
    +++ b/foo
    @@ -1,1 +1,2 @@
     test
    +bar

    c:\test>hg pull clone

    pulling from clone
    searching for changes
    adding changesets
    adding manifests
    adding file changes
    added 1 changesets with 1 changes to 1 files
    (run 'hg update' to get a working copy)

    c:\test>hg update

    merging foo

Now KDiff3 automagically appears (because of the line conflict).

>>  After reading 
>> this thread, I could not believe Git didn't pulling with local changes, and 
>> so I tried it, and also asked on IRC -- and it seems that Git really 
>> doesn't.
>> 
>> If this is an important part of your workflow (as it is mine), I'd 
>> recommend using Mercurial if possible.
>> 
> 
> So the question is if mercurial allows _merging_ with local
> changes... and from the thread it looks like git dies allow it, as
> long as changes are isolated from changes brought by merge.

For that reason, Git doesn't support my workflow at all.

> Anyway merging with local changes is an easy way to f**k up your
> changes in unrecoverable way, IMVHO...

Mercurial backs everything up before doing this merge, so if I do lose my
local changes, I can start over with this:

    hg resolve --unmark --all
    hg resolve --all

Now KDiff3 comes up again, with the same data as before.  No data lost.
