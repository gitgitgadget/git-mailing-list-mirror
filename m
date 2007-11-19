From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 10:54:55 +0100
Message-ID: <3FB7B6E8-FC22-4FDF-BDAD-08312202B29A@zib.de>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <11954023881802-git-send-email-prohaska@zib.de> <119540238994-git-send-email-prohaska@zib.de> <7vwssfqb0w.fsf@gitster.siamese.dyndns.org> <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de> <7vejempudf.fsf@gitster.siamese.dyndns.org> <53F12F4D-73C5-446E-9A97-9D2D4CA9DF9F@zib.de> <7vk5oeocnr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 10:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu3KN-0002QN-0w
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 10:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbXKSJxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 04:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbXKSJxq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 04:53:46 -0500
Received: from mailer.zib.de ([130.73.108.11]:46884 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbXKSJxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 04:53:46 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAJ9rdkU016640;
	Mon, 19 Nov 2007 10:53:40 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAJ9rdJ2013186
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Nov 2007 10:53:39 +0100 (MET)
In-Reply-To: <7vk5oeocnr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65421>


On Nov 19, 2007, at 9:35 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> What's left is a new switch "--current".  Less code, easy
>> to explain.
>
> But won't that force the "current" people always type that from
> the command line, as your previous point was that your earlier
> patch to say "remote.$there.push = HEAD" does not work that way?
> If that configuration works as expected, then I'd 100% agree
> that we would not need push.defaultRefs.  Either you do not have
> "push" at all if your preference is --matching, or you do have
> "push = HEAD" if your preference is --current.  But if it
> doesn't (which was what I gathered from your earlier response),
> having a configuration would help them, wouldn't it?

My main point is that I want to have something that _always_
works as expected without manually tweaking the configuration
variables.  In a setting with shared repos, "git push" doesn't.
Sooner or later it will complain about refusing an update
because of non-fast-forward.  The only thing that currently
works it "git push $correct-remote $correct-branch", but this
depends on the local configuration and on the branch you're on.

"git push --current" would always work as expected; without
setting any configuration variable.

I can tell my users that their workflow is

	git checkout foo
	git pull
	work work work ...
	git push --current

That simple.  I'm fine with that.


> Changing the default, if it will ever happen, is _NOT_ to help
> people who are already using git and want "current" NOW.  The
> current users cannot be helped _unless_ we switch overnight, but
> that is not an option as it introduces a regression to people's
> established workflow.
>
> Changing the default is to help new users who will come in the
> future, if majority of the existing users find --current easier
> to explain to new people _they_ need to train.

I'll not change the default.  I'll only add the --current switch.

	Steffen
