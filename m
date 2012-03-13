From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 16:02:50 +0100
Message-ID: <4F5F619A.3040806@op5.se>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net> <vpqy5r44zg7.fsf@bauges.imag.fr> <7vehswljxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:03:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7TFj-00079G-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 16:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab2CMPDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 11:03:02 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51630 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab2CMPDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 11:03:00 -0400
Received: by lbbgm6 with SMTP id gm6so276821lbb.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 08:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=v/o5g5G7W4i1oig/oD0n6yNWpISDX2Yl+uBqP0RNKqc=;
        b=b4iHM6xgJsyEeU3plGmZvguihUhrccHVzMGmztzpN21fQxUMWzv1JDLczq5P08ttpF
         AzhPc3SEaTsDNvpNwms+2Hg7VPYRtJXVZxYXYfF8FvsR1YVdj3ncjgihWT9A7kJIx+D0
         hC/9c7f6edP8eWdV19mDsS19wiV+g7yeMpHdLA2qtiiFzpVbNI/aBmzMss3ooXxysCA9
         Nj6UNpEG3XzdJnkc9WkxEnn0f8EkM5HC2AFQmgwy8cdWC30PgRvn7gQFg+IlZ16bkTrY
         TwSDxkWcmCq3oKlGoYPvn3jZRQgDO1VY8wWNFGfkR/nAsTcQV4qf6eWKAvWLwa8HxX3B
         8DzQ==
Received: by 10.112.104.136 with SMTP id ge8mr6048892lbb.63.1331650978854;
        Tue, 13 Mar 2012 08:02:58 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id gn6sm879831lbb.5.2012.03.13.08.02.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 08:02:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <7vehswljxi.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnaJNPeANyAoLBRu4r0GABe/ViXpZSCvaxrDlwZuo2vuYlE10TPTmey8qTokVK8pzB8gtQM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193031>

On 03/13/2012 02:17 PM, Junio C Hamano wrote:
> Matthieu Moy<Matthieu.Moy@grenoble-inp.fr>  writes:
> 
>> There's a rule of thumb which works very well for beginners: when "git
>> push" tells you to pull before, then pull before. This rule of thumb
>> works, but only provided "push" and "pull" are symmetrical.
> 
> I actually think the "pull before push again" was written with only
> CVS style non-branching workflow in mind, in other words, only to
> help somebody who works on his master against the central master.
> Obviously "push and pull are symmetrical" holds true for that single
> branch workflow, but that does not mean a more complex workflow must
> be symmetrical.
> 
> Even though I think 'upstream' will be a superset of what 'current'
> wants to do in an ideal world where the user configures everything
> right (hence it ought to be the better default between the two), I
> do not think that the target audience "let's change the default"
> folks are trying to help is those who set @{upstream} correctly
> point the destination for a branch they want to push to and leave it
> unset for a strictly private branch. If we choose the default that
> would primarily make it efficient for people who can configure
> everything right, we are missing the point of this discussion. I
> think the target audience to be helped is the people who do not
> (yet) do anything complex, and the point of this discussion is to
> help them avoid getting surprised.
> 
> And by "surprised", I do not necessarily mean "dangerous". While we
> should aim to avoid "dangerous", we should avoid "ununderstandable"
> even more.
> 
> Pushing 'current' from a branch 'topic' forked from either 'master'
> or 'origin/master' will create a new branch 'topic' at the central
> repository. But that is straightforward and understandable. The user
> will see what happened in the feedback from the command, and there
> is no need for the user to be experienced enough to know the mapping
> of @{upstream} to understand why it happened.  "I am on 'topic' and
> I pushed, I created 'topic' there".  Very simple explanation exists.
> 
> On the other hand, the user needs to know not just 'branch' but also
> understand the concept of @{upstream} in order to use 'upstream'
> without surprise.  When something goes wrong, prerequisite knowledge
> that is required to understand it is greater.  Also the current
> implementation of 'upstream' has some weird semantics (or undesigned
> bugs) pointed out by Peff, which would make it even more confusing.
> 
> That makes me suspect that 'current' might be a more appropriate
> default between the two. From that simple default, those in the
> "shared central repository" world can graduate to 'upstream' once
> they know what an 'upstream' is and how to take advantage of
> per-branch configuration.  Similarly, those in the "publish to be
> pulled" world would graduate to 'matching'.


Sensible sentiments, sir.

Even with advanced usage, 'current' is what I think does the right
thing in 99% of all cases, and it errs on the side of "least extra
work when things go wrong".

The questions to ask, I think, are these:
* What would newcomers to git expect?
You answered this nicely.

* What does advanced users use *most of the time*?
At $dayjob, 99.9% of all pushes are to get the changes of the current
branch to the sharepoint repo. Once in a while (when tagging, usually
whatnot) for some repositories, I wish to push maint and master to a
public repository for the masses to use. This happens roughly once
every 200 commits, according to a quick "git log" in two repos, but
only for about 10 or so of the 60-odd repos we're maintaining, and
only for two of the six developers working on them.
It's very rare that I work on multiple already-created topics and
they all finish at the same time. At most, I wish to push "maint"
and "master" in one go.

If I notice I've done the bad push, I need to make sure noone else
fetched the thing during the time it takes me to undo the push, or
I may have to quickly fix up the potentially broken branch. Either
way, it can be a lot of work that I rarely have time for right then.


* What causes the least damage when the default is less suitable?
Quite a few times I've managed to push work-in-progress commits to
random topics at work with the default "matching". If I miss that
I've done so, undoing the damage is a great big pain in the butt,
since it means either force-pushing to sharepoint or un-bisectable
commits. The worst case for "current" would be if I merge one branch
to master, forget to push the merged branch but do push 'master'
to our sharepoint, and then someone else comes along and works a
bit more on the topic I accidentally didn't push. When that happens,
I can quite easily rebase my changes on top of the other devs, or
merge with the sharepoint changes, and then re-merge to master
without having to call a flag-day for the devs working on the same
project.

If I notice I've forgotten to push, I can just push again immediately
and git will handle any errors for me. It never leads to any extra
work for me, and never stalls anyone else from progressing with their
own tasks.


In light of that, "current" is really the only sensible way to go.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
