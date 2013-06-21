From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 09:03:40 -0700
Message-ID: <7vfvwbo3hf.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
	<20130620133422.GA18200@sigill.intra.peff.net>
	<CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
	<20130621070539.GA31552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3oS-0001xD-5D
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824Ab3FUQDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161419Ab3FUQDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:03:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0190E2995C;
	Fri, 21 Jun 2013 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bi6QX9mbhG9NGyKDHp/jPfUp4j0=; b=kTEI98
	zXXzRSVfzmYFDArhkMmEqMAi4AHHQ0Kfv9IuF40a5nHMSCeFyrTDmMR3mMIhgnu8
	pEeI22+bvU+bIUVz9VwOJqpDHiGepN2konVBwiTU/AGtnQHxOCcCXJ5So5UyK5ui
	IOqmDYN/HjWlxOhA//cLPIPE983BKTfFTA0Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aWFqMA45OvbnjSyciMHNQt5YMwGXh8Dg
	t14BxyHgS3V8k2gVCfyu0pNNfD1ojIXj2R7Z9ekus8jYPD5o+6/VP64CV4z7GjaH
	JEJ29v8cHcyeoYT/Jqwxh7dCBlZUnUCUWRg+8WNQ0Z9WNJZCeieXbt6/dUu4GPEw
	bPG+tsUJVZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D637C2995B;
	Fri, 21 Jun 2013 16:03:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 577282995A;
	Fri, 21 Jun 2013 16:03:42 +0000 (UTC)
In-Reply-To: <20130621070539.GA31552@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Jun 2013 03:05:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24E552EE-DA8C-11E2-93D0-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228622>

Jeff King <peff@peff.net> writes:

> Note that I haven't thought too hard about this; there may be a way to
> detect for specific operations that we were expecting more data from the
> helper and didn't get it. But even if we do want to go that route, I
> think reverting the change to recvline_fh is probably going to be the
> first step.

Yeah, I agree with that assessment.  Will queue.
