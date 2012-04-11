From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Wed, 11 Apr 2012 14:56:19 -0400
Message-ID: <20120411185618.GC24833@hmsreliant.think-freely.org>
References: <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
 <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
 <20120411004419.GA19616@neilslaptop.think-freely.org>
 <7v62d6mcsa.fsf@alter.siamese.dyndns.org>
 <20120411182927.GA24833@hmsreliant.think-freely.org>
 <7vy5q2je6i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2ij-0008HU-TO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931Ab2DKS4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:56:38 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36499 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949Ab2DKS4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:56:37 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SI2iK-0004CP-0J; Wed, 11 Apr 2012 14:56:35 -0400
Content-Disposition: inline
In-Reply-To: <7vy5q2je6i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195238>

On Wed, Apr 11, 2012 at 11:50:29AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> >> But that cannot be correct, without --continue [*1*], i.e.
> >> 
> >> 	$ git cherry-pick --allow-empty --continue
> >> 
> >> no?  I didn't check, but if the command without --continue in the above
> >> sequence does not error out, I think it is a bug.
> >> 
> > No, it errors out.  I'm sorry to have confused you.  The only point that I was
> > trying to make here is that, when running git cherry-pick, its seems awkward to
> > a user to get advice indicating that git commit --allow-empty should be run.
> 
> I was only saying that "git cherry-pick --allow-empty" is a *bad*
> suggestion because it does *not* work and errors out, and you seem to
> agree with me on that point.  I also said I am OK if the suggestion for
> this case were to run "git cherry-pick --continue".
> 
> But you sound like you are disagreeing with me; I am not sure where you
> found what I said not agreeable.  So I am not sure what to say at this
> point.
> 
I'm sorry, I think I see where our mutual confusion is.  git cherry-pick
--allow-empty _does_ error out on its own.  The advice that I rewrote was meant
to imply that the cherry-pick command should have been rerun with the
--allow-empty option, i.e.:
git cherry-pick --allow-empty <commit>

I can see however, looking at from what I think was your point of view, how the
advice would have been bad, because taken strictly as given, it would fail.

Its all moot however, I've reverted the advice in my tree here.  As soon as I
complete testing of the optimization/rewites to git_run_commit and
is_original_commit_empty, I'll have another set for review.

Regards
Neil
