From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Thu, 27 Feb 2014 20:57:10 -0600
Message-ID: <85fvn40ws9.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 03:57:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJDdW-0005WY-3O
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 03:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbaB1C5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 21:57:14 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:53856 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751232AbaB1C5N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 21:57:13 -0500
Received: from [75.87.81.6] ([75.87.81.6:53494] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id ED/6D-02678-70BFF035; Fri, 28 Feb 2014 02:57:12 +0000
In-Reply-To: <vpqmwhexidi.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 11:45:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242880>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> lists@haller-berlin.de (Stefan Haller) writes:
>
>> Your intention was clearly to drop the stash, it just wasn't dropped
>> because of the conflict. Dropping it automatically once the conflict
>> is resolved would be nice.
>
> Your intention when you ran "git stash pop", yes. Your intention when
> you ran "git add", I call that guessing.

You might be adding other files for other reasons. But if you add a file
that does resolve a conflict caused by 'git stash pop', it is not
guessing.

> The condition for dropping the stash should be more "conflits
> resolutions are done AND the user is happy with it". Otherwise, if you
> mess up your conflict resolution, and notice it after running "git add",
> then you're screwed because Git just happily discarded your important
> data. The point of keeping the stash is to leave it up to the user to
> decide between "I'm happy, I can drop" or "I'm not, I should re-apply",
> and Git cannot tell which is which.

Yes, that makes sense.

> Hinting the user to run "stash pop" would be more acceptable, but
> talking about "git stash" in "git add"'s code is somehow a dependency
> order violation (stash is normally implemented on top of Git's basic
> features, not the other way around). Does not seem serious from at first
> from the user point of view, but this pushes the codebase one step in
> the direction of an unmaintainable mess.

Also makes sense.

So "git add" and "git stash *" are lower level tools; to get the effect
we are asking for, we should use a front-end (which is why I'm writing
one for Emacs :).

-- 
-- Stephe
