From: Adrian May <adrian.alexander.may@gmail.com>
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What does 
	that say about git?
Date: Tue, 24 Nov 2009 11:48:09 +0800
Message-ID: <65e170e70911231948l3b032dbeu7c99b65ce3ec97ff@mail.gmail.com>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
	 <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
	 <alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de>
	 <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com>
	 <20091123135817.GB2532@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, chromium-discuss@googlegroups.com
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 24 04:48:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCmO1-0007rI-Aj
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 04:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891AbZKXDsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 22:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757884AbZKXDsF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 22:48:05 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:45704 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882AbZKXDsD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 22:48:03 -0500
Received: by iwn1 with SMTP id 1so221695iwn.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 19:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=sBJ9Rw2aJDpFsWb9S2eDTei4x2+KIKh4fJUCM7wmtuI=;
        b=Oxj2Dxe6mvoawzXlMgFxRvmXmURDJJgkAzjGstJEEzbQfqQjNHGG/8r4E3BDS9t6OB
         MAfmOfNVHMHNtL1TwGxvyf3YvQwg5DzM8njmlXWPItGH717mNklkhmqxWa7UJJJO2cti
         I289AfjhNX6p9b1HABPlZs3unJK7vUPGyl4/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PErRZ/fbwrf2VZX3E0w43qyzD+Z8OdoMvtzDwitO6TkN3R+R8EBCqQOZathgeQrvGw
         jr3S2v5MiVs43rzgTwyy17/qr3erBrPMfzEWW5NneHamuQMKzsqW/2zThzzvOPjLmgTP
         4ZScQVsO2tuPijF/w4AhIzIv/2dTi4p9GDV5U=
Received: by 10.231.1.22 with SMTP id 22mr13367ibd.56.1259034489480; Mon, 23 
	Nov 2009 19:48:09 -0800 (PST)
In-Reply-To: <20091123135817.GB2532@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133558>

> If you don't have bolt-on scripts, and you move that into the the core
> SCM, then you force *all* projects to use whatever workflow was
> decided as being the One True Way of doing things as seen by the SCM
> designer.  So the question is whether the SCM *should* regiment all
> projects into following the SCM's designers idea of the One True
> Workflow.

Of course I'd want the workflow configurable by whoever controls the
main repository. I couldn't possibly suggest that all git projects
need the same workflow. The number of developers can vary by five
orders of magnitude - that calls for different workflow models.

> Git's approach is to say that it will be fairly flexible about
> dictating workflow --- who pushs to whom; whether there is a single
> "star" repository topology, or something that is more flexible, etc.
> You seem to hate this flexibility, because it makes life harder until
> you set up these bolt-on scripts.  But that's what many of us like
> about git; that it doesn't force us (the project lead) into a single
> way of doing things.

Leaving aside topology, I suppose we can agree that the subject
divides into two aspects: offering the developer some optional tools,
and asserting control over what gets commited to the official repo.
Perhaps we can also agree that the former belongs under the control of
the developer and the latter should be in the PM's hands. You seem to
have opinions about which of these two aspects is more or less
important, and to what extent git suffices, but I don't. I assume that
the project manager has his own opinions about both aspects and I'm
observing two big projects that independantly have augmented git's
features with their own scripts. Their docs talk about both aspects,
especially repo's, but they are entirely implemented in
developer-overridable scripts. So any repo functions to do with the
second aspect are either features that git needs to grow, or bits of
the git manual that the repo designer didn't read. I'd kinda like to
know which.

Returning to topology, I think that also divides up similarly. The PM
can't forbid you and me from casually swapping diffs back and forth,
but he can dictate who we are supposed to submit our final candidate
to for review. The very existence of a PM, who controls a subset of
the repositories in the world, already implies a star topology, and I
think pretty much everybody is using distributed source control in
this way, at least when it comes down to *controlling* anything.
People may also be causally bouncing diffs around, but that's not
control, it's communication. I've got a one-man project on github
which I edit from two locations, and even on that scale I find myself
working star-fashion because either computer might have junk
experiments in progress, but I only push to github if it's meaningful
and tidy.

That reminds me of a slightly different question: if a longer
experiment that I have committed several stages of turns out to be a
blind alley, I'd like to go back a few steps on main, declare
everything after that to be a side branch that I'll probably never use
again, and continue on main with my next attempt. Is that possible? I
know that I can just start a new branch from the before the bad
experiment, but if that happens a lot, the name of my current main
branch would be changing all the time, and I think that's bad. I
suspect what I want is possible, but I'm not sure how to do it.

> As far as my wanting to impose a particular regimen on my project's
> developers, I've never been a big fan of the Bondage and Discpline
> school of software engineering.  They can use whatever workflow they
> like; they just have to deliver patches that are clean.  If they are,
> I'll pull from their repository.  If they aren't, I won't.

Repo talks a lot about automating the workflow that leads to precisely
that decision. They evidently want something more evolved than
somebody simply having a look at the code. I'm not sure what they
want, but I'm pretty sure it's none of the developer's business.

Adrian.
