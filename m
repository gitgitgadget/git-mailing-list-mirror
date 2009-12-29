From: Junio C Hamano <gitster@pobox.com>
Subject: Re: signing tags: user.name assumed to be gpg uid?
Date: Tue, 29 Dec 2009 13:12:05 -0800
Message-ID: <7vaax1bi3e.fsf@alter.siamese.dyndns.org>
References: <20091229203637.GA3036@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjMb-00040D-S1
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbZL2VMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZL2VMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:12:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbZL2VMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:12:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0A58C622;
	Tue, 29 Dec 2009 16:12:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mq7mqhVQSXALVtpSG5BxEX11W0M=; b=SNDJ4u
	zYMT9SJVYbIxiGuL1SZrcMcqHtYxIr52lKCSkMrOrfxy3N8H7U2lpmNCbE4Icjqx
	HXflTvKIfBGsH/x99+LVuXHCyc1gNmyt9cKvRx/fpIEDD75dTxdlFwmpCuhEMHg/
	leF2rEEKTIFFAfKa2n8pLhUtfWPs+67VFLcd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKRN5C6/oCPJG9EDAugnQcK18siL+1r4
	HBTuj7HGyUC+lKJeRYPG4uS8Mn/6YVsirLrSJdq061K1GozFcJ25mvCOF5K9Zlim
	m7THFEShh66Fa/Lo8eUOhKm05PNA7dt4iCzXIWWSFrCOoFEM2vMKL89EdsX3ZvIk
	UNxMHtpKUr8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A58338C621;
	Tue, 29 Dec 2009 16:12:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FEEB8C61E; Tue, 29 Dec
 2009 16:12:06 -0500 (EST)
In-Reply-To: <20091229203637.GA3036@screwed.box> (Peter Vereshagin's message
 of "Wed\, 30 Dec 2009 00\:36\:37 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3764ED8-F4BE-11DE-9CC0-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135824>

Peter Vereshagin <peter@vereshagin.org> writes:

> I notice that after I init and config user.name and user.email the
> user.comment gets taken from ~/.gpg automatically.

What is "user.comment"?

> Is it a correct behaviour?

Yes, matching with user.name/user.email (actually committer information)
is often the most convenient thing to do.

You can use user.signingkey configuration to use a key that doesn't match
your name, too.
