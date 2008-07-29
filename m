From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 09:18:12 +0100
Message-ID: <320075ff0807290118o62a6fc1eq3e90e32ef7783a17@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	 <20080728205545.GB10409@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
	 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
	 <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
	 <20080729060449.GG11947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Benjamin Collins" <aggieben@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Git ML" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkQP-0002dL-Ji
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbYG2ISQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbYG2ISQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:18:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:30071 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbYG2ISO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:18:14 -0400
Received: by mu-out-0910.google.com with SMTP id w8so5844139mue.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TVIPjO7esEHUA96fsc6MztG0wH93DkfMTAaGpP4K3lo=;
        b=GK9C7pDSWLzeC0WGfuDSry6jV8Naraz/LEP3kDB7lcX2OqKVmtcLS5WR3iu2j4ypT2
         y9sMsDU6hc61wbuthiB62JRCEkESq0S5YdvQUpWWPBaRJ3Q30MmR0OmRXkkRwSmtq6O7
         wfkKvZuJuyTQ47MULPT9hDQb+VvNT0j18w1SA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=R32KabecvXYHtlFJF4AlhDSiSgcBehSsuBvG0J/krI+b1ml4fIDbgGL26SglHW454E
         uobSEIo8/FO1swpHZ+wXNxNg6K8rmCY3LO/tIc1/MUa/rTgQT0bGCueTO/ydwmnDyYXT
         GlVWkE2RwDBlgaeCmU7OG0G16S2f9qh4rqAgg=
Received: by 10.103.221.13 with SMTP id y13mr3165404muq.41.1217319492459;
        Tue, 29 Jul 2008 01:18:12 -0700 (PDT)
Received: by 10.103.8.13 with HTTP; Tue, 29 Jul 2008 01:18:12 -0700 (PDT)
In-Reply-To: <20080729060449.GG11947@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90597>

>> I try to keep all my submodules on (no branch) as much as possible.
>> In a way, I feel like that kind of relieves me of the chore of keeping
>> mapping superproject branches to submodule branches in my head.
>
> At my former day-job we wrote our own "git submodule" in our
> build system before gitlink was available in the core, let alone
> git-submodule was a Porcelain command.
>
> Many developers who were new to Git found having a sea of 11 Git
> repositories+working directories in a single build area difficult to
> manage.  They quickly found the detached HEAD feature in a submodule
> to be a really handy way to know if they made changes there or not.
>
> Most of our developers also modified __git_ps1() in their bash
> completion to use `git name-rev HEAD` to try and pick up a remote
> branch name when on a detached HEAD.  This slowed down their bash
> prompts a little bit, but they found that "origin/foo" hint very
> valuable to let them know they should start a new branch before
> making changes.
>
> So I'm just echoing what Benjamin said above, only we did it
> independently, and came to the same conclusion.
>

Hm.
My developers are (mostly) on windows, so "altering PS1" or even
writing "shell scripts" is way beyond them. They want it to "just
work" (where their previous experience is SVN superprojects with
multiple svn:externals). I have a hard time justifying the experience
that if we're all working on master, then as soon as Joe Q developer
does 'submodule update' then poof - his heads are disconnected.

That said, I do also like the flexibility that having the superproject
on heads/foo and a submodule on heads/bar as it allows you to
integration test divergent submodule branches (indeed our CI system
automatically picks them up and tries all possible combinations).
