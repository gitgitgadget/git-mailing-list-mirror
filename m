From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Take four on fixing OPT_SET_PTR issues
Date: Mon, 31 Mar 2014 15:54:34 -0700
Message-ID: <xmqqy4zq0yj9.fsf@gitster.dls.corp.google.com>
References: <7vtxago359.fsf@alter.siamese.dyndns.org>
	<cover.1396177207.git.marat@slonopotamus.org>
	<xmqq4n2e8eov.fsf@gitster.dls.corp.google.com>
	<20140331210714.GA6422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUl6I-0006xM-N6
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaCaWyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbaCaWyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544387948B;
	Mon, 31 Mar 2014 18:54:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f2SOpLaXOhEwG+8OYdts4dK/w3g=; b=vmgxQd
	gCia+T1NsVi+halETLTbtTXrmVUZOtRy5nX7wsGmYglp83ypMyKntn8MQ161+dwW
	0SBrcyUQxvnMatuR2wa3MjrAQjMzAoJDnnJrlMMvh7tuPkVFlzKTGnliJYXv4PVQ
	oa82p+N2MtegcmkU0UYVssG3Iik+XxoDVGTTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b52pX56bttgf09Z8I0sCFhX6ZwbvfGHv
	4rCwLNdIrE1yvTHKxpmRSVyz8pXKRTDO5WadyD+suM8ovNPZ0wVzabnLCsQknnuE
	UJlTmnHltdAKMZciHE8Y4b+YNf+N8GUJEkZnjH1EyPZYpNcGnHaqjqjD8mI1aBV7
	LglObQq6kUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 455847948A;
	Mon, 31 Mar 2014 18:54:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE0E79488;
	Mon, 31 Mar 2014 18:54:36 -0400 (EDT)
In-Reply-To: <20140331210714.GA6422@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 31 Mar 2014 17:07:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E93EBD8-B927-11E3-BCE9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245566>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 31, 2014 at 10:23:44AM -0700, Junio C Hamano wrote:
>
>> SET_PTR() may not be used, but are there places where SET_INT() is
>> abused with a cast-to-pointer for the same effect?  I didn't check,
>> but if there are such places, converting them to use SET_PTR() with
>> their existing cast removed may be a better way to go.
>
> Anyone doing that should be beaten with a clue stick.
>
> Fortunately, I grepped through and I did not see any cases. My clue
> stick remains untouched.

Yeah, I quickly did the same after sending the message out.

Perhaps instead of taking all these three patches, it may be a good
idea to just queue a single patch to remove both the feature and the
"string (unset)" bit from the test.

Thanks.
