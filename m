From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option
 [v2]
Date: Thu, 05 Apr 2012 18:20:24 -0700
Message-ID: <7vvcld3bc7.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
 <7vobr551vs.fsf@alter.siamese.dyndns.org>
 <20120405234527.GB8654@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxqr-0008By-CX
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997Ab2DFBU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 21:20:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645Ab2DFBU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 21:20:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8381686D;
	Thu,  5 Apr 2012 21:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqOMleno7+b2FqFTgALA7YOotlg=; b=GMRBOQ
	HZZWfb5mFXeEBYxs41q9nYOWT0Da6w060p3k4sKVQ86vVRU/KlT9SV+BQgSjzfPw
	xAHeJrEJDQuLrkhECkoeFJwTIh89JJ6BGFaOlQ2JhmOhRqnpoCl5hJTaxSKDQiTc
	3jHnC6sOBnYhQBdhKrGcogcGLAZ2gDcSvmj8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCmlpR+q/ZjJDytFiPOytvx9gNV1qujf
	aZAdRe56UJ3B0Q9OmEDFVjs9UQBdr/X4uQCsDz91GaA+P17rjH1i5irbCgGrWeoR
	I6Z2CcZ8GwEeAxjbjQUlXwv6wImym5rEB3Jlg+LZrfBoy0Z/tRuwhAGEs2sTM1Og
	4sG/0qe39uc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE9C0686C;
	Thu,  5 Apr 2012 21:20:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69B80686B; Thu,  5 Apr 2012
 21:20:25 -0400 (EDT)
In-Reply-To: <20120405234527.GB8654@hmsreliant.think-freely.org> (Neil
 Horman's message of "Thu, 5 Apr 2012 19:45:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B016B144-7F86-11E1-81C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194832>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Thu, Apr 05, 2012 at 02:01:43PM -0700, Junio C Hamano wrote:
>
>> I am starting to wonder if it is worth spending time on careful reviewing,
>> or it would be sufficient to give a cursory review quickly to give you
>> more time to polish your re-roll.
>> 
> I'm not sure what you think is so egregious about this changeset, but if
> you have a specific problem, please let me know.

There is no insult involved. I just didn't know where to start, because
the series was littered with many issues from high level design (e.g. does
the command line interface and API addition make sense?) to low level
styles (e.g. does the new code imitate the style of the existing code
around it?), and in between (e.g. pipe2() is never used in the codebase
without this patch. Is it portable enough?). It was clear that it needed a
lot more work to lose a WIP label (the quality standard in this project is
slightly higher than "the end result seems to compile--let's ship it").

In other words, I was simply being honest.

> We all make errors, thats why
> we review work like this.  All your comment above does is toss a purposeless
> insult into the conversation. 

Making mistakes is one thing.  Sending a series that is not sufficiently
proofread is a completely different matter.  The review process is not a
replacement for your own proofreading.  It comes after that.

If you did proofread the patch [3/5], you would have noticed that the fix
you made to the documentation is a fix for patch [2/5]. You are in much
better position than I or other reviewers to notice it---after all, it is
your addition. The same for the typo in the mysteriously named function.

How else do you expect me to react to such a series?
