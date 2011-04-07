From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Thu, 07 Apr 2011 15:19:05 -0700
Message-ID: <7vk4f5emcm.fsf@alter.siamese.dyndns.org>
References: <201103260141.20798.robert.david.public@gmail.com>
 <201104040943.10030.robert.david.public@gmail.com>
 <20110405165212.GB9965@sigill.intra.peff.net>
 <201104071530.19566.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 00:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7xYB-0003N8-Kw
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 00:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929Ab1DGWT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 18:19:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab1DGWTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 18:19:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A1B25376;
	Thu,  7 Apr 2011 18:21:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tYoEnYrTYv7RT4+BAsrQhEse1aE=; b=yIwvAq
	rV2V9S6CMKE4EhkceODP/1H9JNF2lG6zPT2YCPXw9pF/WA2wil5qE+/9q4ybBGuG
	sSUL9ssBIJniFavz2x3rd0oOUtzfsAGZ4k8DJnTFf4kLLnQjDAigaGPw2uCvGuqc
	eGYsceSmaFKkpb4lEPrM94vdBohb3cv9c7RQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0bB6m1JIIVF1bGEI7CRZv8EhJqBrit0
	wExCsQEbgpZtmRrn8l2auZOuf+ezqBDjZt4LRUpsDym3bUPrwOBCGWxv0t0p90rx
	/dvopOlsuQYyzvjA54iQ0ZLgsqXZkk3ORLPdGTVjtJr0mYULMVNMssstKh67V0wC
	iNaDY7DWQkY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC9405373;
	Thu,  7 Apr 2011 18:21:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 07B125372; Thu,  7 Apr 2011
 18:21:02 -0400 (EDT)
In-Reply-To: <201104071530.19566.robert.david.public@gmail.com> (Robert
 David's message of "Thu, 7 Apr 2011 15:30:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 576DB42E-6165-11E0-A451-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171087>

Robert David <robert.david.public@gmail.com> writes:

> This task also include cleaning the functionality of this code, to make these 
> functions more "standardized". 
> This means consolidate the differences in these functions and make them more 
> consistent in the user point of view.

Standardized, consolidate, consistent are all pretty words but at the same
time they are highly subjective. Even though you may not have to have the
detailed description of everything in the proposal, you would need to at
least have a handful of examples of what are wrong with the current code
in mind when making such a sweeping statement, but I cannot sense that
from this proposal.

While reading the current add-i code recently, I noticed that over time
the code quality deteriorated compared to the reasonably clean design in
the original version, perhaps due to excessive copying and mimicing,
especially when "Edit patch" feature was added and then more recently when
new modes to apply patches in different directions are added to allow
other commands like "git reset" and "git checkout" to implement their
"--patch" options.

An example of a clean-up in the right direction may be a patch I posted a
few days ago:

  http://thread.gmane.org/gmane.comp.version-control.git/170685/focus=171017 

Is that the kind of "consolidation" you have in mind?

Also I am a bit puzzled by the inconsistency between the various stages of
your goals.  A clearly stated primary goal is:

> Main and final project goal is integrating fully git-add--interactive into 
> current git-add code.

but the success criteria is only about the above "This task also include"?
