From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 16:44:03 -0400
Message-ID: <4FE0E493.1010308@desrt.ca>
References: <4FE091FB.7020202@desrt.ca> <87a9zztdxt.fsf@thomas.inf.ethz.ch> <7v8vfj17de.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh5HW-0000BZ-6R
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab2FSUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:44:05 -0400
Received: from manic.desrt.ca ([207.192.74.61]:45440 "EHLO mail.desrt.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab2FSUoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:44:04 -0400
Received: from [172.16.0.159] (173-230-190-244.cable.teksavvy.com [173.230.190.244])
	by manic.desrt.ca (Postfix) with ESMTPSA id 1960412CD23;
	Tue, 19 Jun 2012 15:44:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7v8vfj17de.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200242>

hi,

On 12-06-19 02:31 PM, Junio C Hamano wrote:
> But I do not think "git branch" can sensibly and
> correctly make that decision for the user---at least I do not sense
> any of the people who is in this thread has clear idea on what to
> base that decision on, and "the same name appears in an existing
> remote" is not it.  "The same name appears, and the new branch is
> not set to integrate with it" may be closer, but that may forbid
> valid use cases too much.

My originally intended point was that it should be prevented in the case 
where 'git branch' is given no additional arguments (ie: implicitly 
creating the branch from HEAD).  Obviously it should be possible to 
create a 'gtk-3-4' branch that is based on the origin one.  In any case, 
I should have made that more clear.

So to restate the feature request more clearly: "git branch X" with no 
explicitly specified start-point should prevent the branch "X" from 
being created when a branch with the same name already exists on a 
remote (perhaps only considering 'origin').

When stated in this more explicit way, it becomes clear that a --force 
option would not even be required; you could just say:

   git branch gtk-3-4 HEAD

to make it clear that this was your intention.

Nobody making a casual mistake would type that in full.


Cheers
