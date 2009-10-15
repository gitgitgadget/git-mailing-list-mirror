From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 15:08:29 -0700
Message-ID: <7vfx9k1faa.fsf@alter.siamese.dyndns.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyYYK-0005DA-K9
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062AbZJOWJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762966AbZJOWJc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:09:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762953AbZJOWJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:09:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5768F793B9;
	Thu, 15 Oct 2009 18:08:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7JO8OSA40lhn+kCvfsW9p9cRLkg=; b=tkfdl6
	U3yc33UCA9kFoNCpwOFUan0Y20VghMX4jXUnUsHBLMz5tY/Kg6cnXcIhTgqhXljZ
	EPdAjh1hWDhB9JLsnoBBBsOGpqIi/oVD9QUCaHiJ/UUodrDPQVXt4/S3Z7H0nguE
	rAazk6ROU2OQi0sWl7ZVqYUevkROlJfLRa7tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0itle5WY3Q5wfLSP6xTsB594bF7d/qt
	h6cq82OQdI0OugJI/n4dmGcvJ3dBPPLW6QPTnOSteLXP9cvI7PiLvWZi8AVy/S2G
	I7mnI9rlRn9+pcS7pRqYp28qus5dhfXNe1+fwDdjXnLzfIRDRv7NCzmhzU8xywy+
	BWhveNJdKbM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07346793B8;
	Thu, 15 Oct 2009 18:08:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BB8E8793B7; Thu, 15 Oct 2009
 18:08:30 -0400 (EDT)
In-Reply-To: <7v1vl42uid.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 15 Oct 2009 14\:54\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D12B420-B9D7-11DE-8F8E-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130428>

Junio C Hamano <gitster@pobox.com> writes:

>     $ git checkout origin/next ;# ditto
>     $ git symbolic-ref HEAD
>     refs/remotes/origin/next

Ok, after reading Daniel's message to remind us that "git fetch" after
this will get us into trouble, I agree that detaching HEAD is inevitable.
