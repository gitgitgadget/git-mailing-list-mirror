From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 17:15:38 +0100
Message-ID: <201202051715.38896.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <CAFA910035B74E56A52A96097E76AC39@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 17:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru4kp-0008Pg-2E
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 17:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab2BEQPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 11:15:46 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56611 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2BEQPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 11:15:46 -0500
Received: by eaah12 with SMTP id h12so2170146eaa.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Hz8ywplwMQD+Vy0eyBPTAU6R/c6C8UVkTgN8KI/ybuU=;
        b=J7ufwQ4D943n/cgjKoGWDoTcD18Ykw1K5B5rBY0njquGm5s+E/Vj115oFvpxmnBHw7
         KK7t2SF+OJiM3meOSVSkvTesr7+XcfOIWduS/NOkjYM+Ia/94zN7KtIt4Mdc39fUERGL
         RpnKcuIRkauTwMvCtGL163MIRXrZi02+NqY44=
Received: by 10.213.8.75 with SMTP id g11mr849903ebg.77.1328458543475;
        Sun, 05 Feb 2012 08:15:43 -0800 (PST)
Received: from [192.168.1.13] (abvp235.neoplus.adsl.tpnet.pl. [83.8.213.235])
        by mx.google.com with ESMTPS id n56sm49867970eeh.6.2012.02.05.08.15.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 08:15:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAFA910035B74E56A52A96097E76AC39@PhilipOakley>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189946>

Please don't remove git mailing list from Cc... Oh, I see that you
forgot to send to list, but resend your email there.

On Sun, 5 Feb 2012, Philip Oakley wrote:
> From: "Jakub Narebski" <jnareb@gmail.com>
> Sent: Saturday, February 04, 2012 7:45 PM

> > Git includes protection against rewriting published history on the
> > receive side with fast-forward check by default (which can be
> > overridden) and various receive.deny* configuration variables,
> > including receive.denyNonFastForwards.
> >
> > Nevertheless git users requested (among others in Git User's Survey)
> > more help on creation side, namely preventing rewriting parts of
> > history which was already made public (or at least warning that one is
> > about to rewrite published history).  The "warn before/when rewriting
> > published history" answer in "17. Which of the following features would
> > you like to see implemented in git?" multiple-choice question in latest
> > Git User's Survey 2011[1] got 24% (1525) responses.
> >
> > [1]: https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL
> >
> > So people would like for git to warn them about rewriting history before
> > they attempt a push and it turns out to not fast-forward.
> 
> Another area that is implicitly related is that of (lack of) publication of 
> sub-module updates. A mechanisms that, in the super project, knows the 
> status of the (local) submodules, such as where they would be sourced from, 
> i.e. what was last pushed & where, could help in such instances.

"Better support for submodules" had almost the same number of requests
in the latest Git User's Survey 2011 (25% which means 1582 responses).
 
Remembering when to do recursive push and where would be a very nice thing.

[...]
> Recording where they were pushed to would be useful for synchronising 
> sub-modules and their super projects. That is, giving remote users a clue as 
> to where they might find mising sub-modules.

Is it a matter of correctly writing configuration with current git?
I don't use submodules myself, so I cannot say.

> > Mercurial documentation talks about phase of a commit, which might
> > be a good UI, ut also about commits in 'public' phase being "immutable".
> > As commits in Git are immutable, and rewriting history is in fact
> > re-doing commits, this description should probably be changed.
> >
> > While default "push matching" behavior makes it possible to have
> > "secret" commits, being able to explicitly mark commits as not for
> > publishing might be a good idea also for Git.
> >
> 
> Being able to mark temporary, out of sequence or other hacks as Secret could 
> be useful, as would recording where Public commits had been sent.

Marking as 'secret' must I think be explicit, but I think 'public' phase
should be inferred from remote-tracking branches.  The idea of phases is
to allow UI to ask about status of commits: can we amend / rebase it or
not, can we push it or not.

-- 
Jakub Narebski
Poland
