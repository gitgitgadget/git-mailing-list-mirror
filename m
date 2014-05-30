From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 13:44:32 -0700
Message-ID: <xmqqmwdz809b.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
	<CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
	<20140530065737.GA13591@sigill.intra.peff.net>
	<xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
	<20140530170330.GA25443@sigill.intra.peff.net>
	<xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
	<20140530183441.GA3704@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 22:44:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTfR-0002S4-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934246AbaE3Uol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:44:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52644 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933084AbaE3Uok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:44:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 084771A18E;
	Fri, 30 May 2014 16:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Q1224ztFOVVvhv5/4a5D05ew88=; b=foJUoy
	ycIh6c+3hTsEXRfGp+UIWuI0K+Xoad5FBqO0Sg08d3gjyMmowy91mfj2ebgNDMxx
	DtAxis39uwZDxiBy5q3n0Blr/j4YZv2Tki2VLKZSzakeUg3apmh9EODccH6PQ4Qw
	jx8oTA2EzCXb1+CcKJhleS82uAG/seJaUGj7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HuahUlJ53r/aXdX7Rr05whyJfvgRPAb3
	RuJ4CLJ3wbVoTpNx3fNzjMm+MPeGBifuPszwT1vH9n/VCXLdq4t6fUOtEiz9RKom
	JLc1BZ9pFHob8+By3ylxdOFG0FURuNWzx8MfvnMKF73Lag5xVJav2ONDo618TMhS
	FMWwf4FNbAo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFAB21A18D;
	Fri, 30 May 2014 16:44:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 127D51A18C;
	Fri, 30 May 2014 16:44:34 -0400 (EDT)
In-Reply-To: <20140530183441.GA3704@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 14:34:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 34FB72B8-E83B-11E3-802A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250479>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] reuse commit->buffer when parsing signatures
> ...
> Signed-off-by: Jeff King <peff@peff.net>

Hmph, unfortunately this seems to break t7510.
