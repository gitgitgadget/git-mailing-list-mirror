From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 08 Jun 2011 08:01:53 -0700
Message-ID: <7vlixc2wpq.fsf@alter.siamese.dyndns.org>
References: <20110608093648.GA19038@elte.hu>
 <20110608203433.61e02ad8.sfr@canb.auug.org.au>
 <20110608125242.GA32745@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKGq-0003N3-NG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab1FHPCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:02:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab1FHPCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:02:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B328845A3;
	Wed,  8 Jun 2011 11:04:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gD3H88A4pQO6XrZ7EOJWmbnI1PA=; b=uGvj/v
	tQctAUpetCxz6HbugmnB3Dvl33midnDKR2caVTnX/bCOc6M3hns8gEmiDW2pHTZq
	CDTcp2rbcZsvcpyutlcdnNjng2T7U+WXvJ3HPY3TB/DPtNVe2wyF16K8buooI+zU
	jVbETtpRXpTddkk6FT6y2ONUvatzc1heXF0f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QxEBEG/g47vB5uSedf/2myMO2YG+J9QY
	DQT//BQ1A/j37mIqMlyvCSWkLSM2S8oc6bBEE3BQaJJ4pXbLlOITr+LiqE1HURsW
	xmPmMGtLTRUWEDehMqkuVOrb4q7ijWjpbcFkL3vBIz4jnglVwfsD38cotXsOdpha
	S2r6qM7OUoY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40AB545A2;
	Wed,  8 Jun 2011 11:04:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B0CDF459A; Wed,  8 Jun 2011
 11:04:05 -0400 (EDT)
In-Reply-To: <20110608125242.GA32745@elte.hu> (Ingo Molnar's message of "Wed,
 8 Jun 2011 14:52:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 918D0E92-91E0-11E0-8810-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175378>

Ingo Molnar <mingo@elte.hu> writes:

> Still it's not entirely logical that 'foreign' tags invade another 
> branch this aggressively.

Is it a problem for "describe", or is the root of the problem that git
allowed you to slurp in 'foreign' tags that you do not care about?
