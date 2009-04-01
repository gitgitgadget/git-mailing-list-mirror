From: P Baker <me@retrodict.com>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers on 
	active trees]
Date: Tue, 31 Mar 2009 22:47:36 -0400
Message-ID: <526944450903311947w2f398c71n95a4a7aa47ecdb7f@mail.gmail.com>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
	 <20090330153245.GD23521@spearce.org>
	 <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
	 <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
	 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>
	 <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302>
	 <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com>
	 <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 04:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoqVs-0005K4-28
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 04:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZDACrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 22:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZDACrj
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 22:47:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:38644 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZDACri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 22:47:38 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1864859wah.21
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=WkWWuUhuaYN+K4XM+Cq1PQRzQzqHXSIoYzYEnmOQ5BQ=;
        b=i2eYrbcqPdAPOk+4f7a7yvd+dMnXtBXcgt0HoOnEFKrdOF43lQQcDk0ZCj7d1TZxLb
         KDypSD5U748TlHE/vUe2y+Gm6jy1GiHBYZISsGF/yPLzJ7kAGLYvalCMSIUDD4ZGwsd3
         DkL+vCVp3QN216+vIMAvBYw7Ed3s7tvrTCAls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=bG5xHSq+Iel4v1M+Syx4J2kaHwLZXN1Sf7fyIYIjHU+FxBthnfSaM1OQgdMo+fO4iy
         dKmZWWgWnpgcitkqSqmB9zvoXOJ5BgmxDaDk10XRUkbI3DCA84xLl/zbNYwr32SKuADB
         3ZSOvwwONKETOejrZlEuS08EEmo9cpNNfVjFY=
Received: by 10.114.130.8 with SMTP id c8mr4882566wad.15.1238554056841; Tue, 
	31 Mar 2009 19:47:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: f03b9888439a95f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115337>

>  > *Moving objects from submodule .git directories into the base .git/
>  > directory would protect the submodules and is a good idea.
>
>
> No, I did not say that.
>
>  Even worse, I think that moving the .git/ directory into the
>  superproject's .git/ would be at least quite a bit awkward in the nested
>  case.
>

Tthe initial prompt for the proposal was: "Rewrite git-submodule,
placing the repository for each referenced submodules in the
superproject's $GIT_DIR/modules...This resolves issues related to
switching between versions of the superproject..." The prompt, and
past experience with git, helped me to form my proposal which it seems
would fix numerous problems with git submodule, with the implied cost
of some awkwardness/complexity. Am I misunderstanding the prompt? Or
do you think this could be accomplished more elegantly?

>  I said that moving submodules' working directory need to protected when
>  renaming/deleting submodules.

I'm sorry, I still don't understand. Where would this occur? What is
being protected? What is the submodules' working directory? I'm still
learning the intricacies of git, so I'd appreciate any pointers you
can give.

>
>
>  > *It would be a good idea for git submodule to work with foreign VCS,
>  > through Daniel's patches.
>
>
> But that would not only apply to submodules, but rather all repositories,
>  to the point that "git submodule" does not need any change.
>
>

Fair enough. There's plenty of other work to be done!

>  > I appreciate the guidance, it's helping me to see that some of this work
>  > has already been done, it needs to be finished and pushed into a public
>  > release. As an intense user of submodules, what does it do poorly/not do
>  > for your needs?
>
>
> One gripe I have, but which should be rather easy to fix: "git checkout --
>  submodule/" does not update the index, last time I checked.  (It correctly
>  does not touch the submodule's working directory.)
>

I'll add it to the list. In terms of general gripes: git submodule add
(or all of git submodule?) handles relative links poorly (see
http://kerneltrap.org/mailarchive/git/2007/12/10/485597). And the
'Gotchas' listed at
http://git.or.cz/gitwiki/GitSubmoduleTutorial#head-a3cba9cbd1e125c0667dfb3b9249100be7f815ad.

>  Another one: The most common mistake with submodules is to commit and push
>  the superproject, after having committed (but not pushed) in the
>  submodule.  Not sure how that could be helped.
>

Seems like this is on the git submodule wiki 'Gotcha' list, too.
There's a spectrum of options: failing, warning, generating an output
message, etc. I think it is worth working on. What is git's policy on
interrupting users when their actions _could_ be counterproductive to
their intentions? Would hooks on the submodule's commit written by the
user fix this? That's not a built-in solution.

>  Further, often it would come in rather handy to be able to say something
>  like "git diff $REVISION_AS_COMMITTED_IN_THE_SUPERPROJECT" from within
>  the submodule...
>

That sounds complex, and would break expectations. This would only
work if git in the submodule working directory knows its a submodule.
Is there a way to reference it's super project?

>  git submodule summary should output to the pager by default.
>
Added to the list.

>  Oh, and it would not hurt performance on Windows at all if git-submodule
>  would be finally made a builtin.

You mean rewriting git-submodule.sh in C? What other impacts might that have?

Thanks,

Phillip Baker

>  Ciao,
>  Dscho
>
>
