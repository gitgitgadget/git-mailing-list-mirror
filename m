From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-sequencer.txt
Date: Mon, 09 Jun 2008 09:49:44 -0700 (PDT)
Message-ID: <m3d4mqwnxh.fsf@localhost.localdomain>
References: <20080607220101.GM31040@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kZw-00082o-UO
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbYFIQts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbYFIQts
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:49:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:63853 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbYFIQtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:49:47 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1580852mue.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=gzAwuXkUdxKYG7G0u7AiipqnvrF9ltPgeHaAMOSqOm0=;
        b=xTnT0DH3JWMnMx6Pb+G0/zOhgK64N/Mwxbe1W1ikcfsAoPxAyj89iPXdKE4Q/Ln3Wq
         Ay4SMXBWIy41E6MhzldbMd43kwTIdXYSTAJLa9TklkaJRM0f/7ZPwseMLhZ2GgJ3nKRY
         dwwWQoNiTpAf7D9ieFyJHkMvmpNWRLEJxLBI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KayEOy8R9n27JGkIaDPq5N643Wp9RJ2NFvFTCqncmalZb71ChuqrLzB5z4JUM5haF2
         +uTY64EpOG0KVayRBMkYj7chZlobfYF7HRVzVSHc+3ainWIOC15s+K8Qj/1WAvwxzWhf
         bkVyFZZLsCiKurZm34fqvac/A14ekxYEgJoL0=
Received: by 10.103.170.13 with SMTP id x13mr2563463muo.27.1213030185728;
        Mon, 09 Jun 2008 09:49:45 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.230])
        by mx.google.com with ESMTPS id j10sm17287865muh.18.2008.06.09.09.49.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 09:49:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m59GqjuZ017705;
	Mon, 9 Jun 2008 18:52:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m59GqgRH017702;
	Mon, 9 Jun 2008 18:52:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080607220101.GM31040@leksak.fem-net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84402>

Stephan Beyer <s-beyer@gmx.net> writes:

> ------------------------------ git-sequencer.txt ------------------------------
> git-sequencer(1)
> ================
> 
> NAME
> ----
> git-sequencer - Execute a sequence of git instructions
> 
> SYNOPSIS
> --------
> [verse]
> 'git-sequencer' [-v | --verbose] <file> [<branch>]

I think that you should think carefully if there would be no troubles
with this way of specifying options.  Perhaps explicit file option
(-F/--file=<file>), or optional '--' separating revisions.  But
perhaps my fears are for nothing, and current proposal is good
solution.

> 'git-sequencer' --continue | --skip | --abort | --edit

The common '--continue | --skip | --abort' infrastructure is, I think,
one of the most important things about this.  I'd like to have
'--what' (or '--status') option to tell us if we are in the middle of
sequence of oprations, and what this sequence is (rebase, rebase -i,
am, revert, cherry-pick, sequencer <file>,...).

> TODO FILE FORMAT
> ----------------
> edit <commit>::
> file [<options>] <file>::
> mark <mark>::
> merge [<options>] <commit-ish1> <commit-ish2> ... <commit-ishN>::

> pick [<options>] <commit>::
> 	Pick (see linkgit:git-cherry-pick[1]) a commit.
> 	Sequencer will pause on conflicts.

Two comments (as I don't use "git rebase -i", preferring to work with
StGIT, Quilt-like patch management interface).

First, if git-sequencer is to become backbone for cherry-pick,
allowing for example long requested cherry-picking multiple commits
(squasing them or not into single commit), is should be able to use it
also for git-revert.  Thus I'd like to have either "pick -R" or
"revert" command.

Second, about "pick" accepring (I guess) git-cherry-pick options: I
would like to have documentation on '--mainline <parent-number>'
option in git-sequencer manpage, or at lest explicitely mentioned that
it can be used to pick merge commits.  BTW, is "pick --no-commit"
symmetric equivalent^W alternative to "squash"?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
