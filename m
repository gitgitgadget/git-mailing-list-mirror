From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Thu, 24 May 2012 13:57:52 -0700
Message-ID: <7vhav5wb3j.fsf@alter.siamese.dyndns.org>
References: <20120523122135.GA58204@tgummerer.unibz.it>
 <87vcjll554.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<pclouds@gmail.com>, <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 24 22:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXf6d-0007Up-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab2EXU5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:57:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab2EXU5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:57:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F199463;
	Thu, 24 May 2012 16:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+LJd14cTeFuwJM5aXbYhUqtPsH8=; b=lKHwIP
	EPNgoe8lUyeHbbVFwz6MyKnN3tMZWL3MNO4g3y4wRMETAzwDj8v/+X3xxzBfdZBz
	+ZzKihtLXrwiND9e/nakuiMTzm+W7vohmoRfyEKF54sYT4mJGCNzuvc1b9gbMybW
	lnsSZsuFR7l4fvcy37jzmmFQm8nCje3tT87Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NEYBlW2ZcOLi/sBLDNU1p2QmO/DnbqbA
	MUvIOBbVcs21d0jkiZKCRyxH6/kBhugBoWpf1KZFvQnilOBXYphLKg+YF/RbbsSY
	W1UbEi596TfUcACqvxZhcgqd+h+w3sMlqySEDzGAwBixAwQnPUeingfGr9nw/Yqd
	MlfjygZEwQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99D499462;
	Thu, 24 May 2012 16:57:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FAA59461; Thu, 24 May 2012
 16:57:54 -0400 (EDT)
In-Reply-To: <87vcjll554.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 24 May 2012 22:01:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21DC509A-A5E3-11E1-9994-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198429>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas asked for feedback on IRC, and Michael requested that I put it in
> email for posterity, so here goes.

I agree with everything you said in your review.

As to the example index-v4 series, it needs to be stressed that the series
did *not* happen in the order it was presented.  While the series was
being written, it looked pretty much "Ok, now we can read the header but
nothing else works" kind of "implemetation steps".  Only very few people
can write a series in the right presentation order from the beginning.

Thanks for a nice summary of what is happening.
