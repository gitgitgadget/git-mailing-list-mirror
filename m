From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: add '-d' as shorthand for '--delete'
Date: Wed, 16 Dec 2015 12:29:38 -0800
Message-ID: <xmqqr3imcf2l.fsf@gitster.mtv.corp.google.com>
References: <1450106584-22313-1-git-send-email-ps@pks.im>
	<1450106584-22313-2-git-send-email-ps@pks.im>
	<20151214211856.GF14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Ihk-0006Hj-VB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbLPU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:29:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750801AbbLPU3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:29:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB02C33565;
	Wed, 16 Dec 2015 15:29:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6o8DFTZ7wtVzyY9EHgViANjoDNc=; b=gNMqCK
	8fzP7x2FhtgHIcxoj9m3/85HocvdwisndxseaPTjg0wFYWTwjToVE2wLtqqaRRBy
	nzUY/F+k9mjJk26aaleBr/p+2bRFbvFjfHfVKM+xBQTaWOE1zdsN5pT3ybkJ+Jyw
	VBtmq0tjwvmYgR9yn5McbRla+QvEG+0DVPgbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cX0lbC33d0wSSPhqJWTgS1e2nk6Vak09
	XL0Jl3ZGXo3k39QW9EJ5LFj6QA6YRAo91r4d0aiL2aDllzk4ZOPZpKZVa5FOfjPc
	CAugdQjbkLUlSNzdLqKnmao3L2/jUqLsxRRW3j7Cq2AZOmnD4hKghzU7mFz0KeRr
	Q1GzjQVPIpQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E245133564;
	Wed, 16 Dec 2015 15:29:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60D9533560;
	Wed, 16 Dec 2015 15:29:39 -0500 (EST)
In-Reply-To: <20151214211856.GF14788@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Dec 2015 16:18:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB1BA4F2-A433-11E5-9D00-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282585>

Jeff King <peff@peff.net> writes:

> At this point, it seems that "--delete" is useful, and nothing else has
> been proposed for "-d" in the intervening years. It seems like a
> reasonable use of the flag to me.

I think there were two (and a half) reasons why we didn't let
"--delete" use a short-and-sweet "-d", and I agree that "something
else that is more useful did not come" removes one of them.

The other reason was to avoid the chance of fat-fingering, because
deleting is destructive, and it is even harder to recover from if
the damage is done remotely (and the remaining one-half is that
deleting is a rare event).

Even though I do not think the need for the "safety" has been
reduced over time to warrant this change, a similarity with "branch"
that has "-d/--delete" would be a good enough argument to support
this change.

Thanks.
