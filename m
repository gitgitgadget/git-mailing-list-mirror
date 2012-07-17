From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn tests for SVN 1.7.5.
Date: Tue, 17 Jul 2012 11:58:54 -0700
Message-ID: <5005B5EE.3050704@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrCz8-0003ag-2d
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 20:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab2GQS65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 14:58:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2GQS64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 14:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A927376AF;
	Tue, 17 Jul 2012 14:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=Pfytz3CruDEV
	qtIv/45TFFq/Gvo=; b=fCsDp4Gs14PcXXya7j3z3dwvuY4TmwSey//LSpRiVgiK
	FMH821RDIyFEUi5FqFjlQ3I8QEGFbgDUI/4tTiWMMYz7Lc7EQtSsYIfa16I7y3PM
	nBHBduin8MoS2o3PRZEgG3TCYPvxXiPXNoORJhZTaZNdyBy7X2zjyL8nbwfD17Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EMxcjF
	P8bh8Y20PQEQmV1H4JxQIlJPolzrZFqIqOcYP7Tv9GvPnNMQIdUBqkWBE+cwJc9F
	XTeKMKnggktN9D1AnV7xDQnj9EUpczdd/IPhp7pk84DwhJDdy+0qO03BhPOKMsLT
	7MkmhAkSTDmfreuo8bmw3MxrMNQ5A3oynt/Do=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9615E76AE;
	Tue, 17 Jul 2012 14:58:55 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E52276A2; Tue, 17 Jul
 2012 14:58:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 74FE6910-D041-11E1-B3B6-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201619>

On 2012.7.17 10:44 AM, Jonathan Nieder wrote:
> Michael G Schwern wrote:
>> I've fixed the git-svn tests for SVN 1.7 and tested with SVN 1.7.5.
> 
> Thanks.  git-svn is not maintained by Junio but by Eric and others on
> the list.  I'm cc-ing Eric and Ben Walton so they can benefit from
> your work.

Thanks.


>> There's a lot of work in this change, so I felt it better to submit the
>> patches as a link to a git repository rather than attach a pile of patches.
>> Here is my repository, the work is in the fix-canonical branch.
>> https://github.com/schwern/git
> 
> It is indeed quite the intimidating pile of patches, so I do not think
> we will be able to apply it all in one chunk as-is. :(
> 
> My advice would be to send five or so of the patches that you would
> like to be reviewed first, inline, one per message, in reply to this
> message so we can start to work on that.  Presumably the patches do
> not regress git-svn's behavior but only make it saner, so even if this
> is not a complete fix it should allow us to get started.  See
> Documentation/SubmittingPatches for more hints.

Yes, the refactorings are all as rote as I could make them and only lightly
touch the code enough to make the canonicalization possible... with a bit more
work than was strictly necessary around the Perl build system.

Let me do a bit of rebase work to make things work better as a series of
submissions and I'll get back to you.

I'm new here, and I'll play nice, but let me go on record to state that Git
asking for individual emails with inline patches feels like Sendmail Corp
asking to be faxed an email thread.  I was kinda hoping SubmittingPatches
wasn't serious about that and it was some sort of policy artifact that was
never updated. :-/


-- 
151. The proper way to report to my Commander is "Specialist Schwarz,
     reporting as ordered, Sir" not "You can't prove a thing!"
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
