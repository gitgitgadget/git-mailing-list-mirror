From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 11:12:37 -0700
Message-ID: <7vk4fpemei.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <20110321122407.GH16334@sigill.intra.peff.net>
 <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
 <20110323162023.GC30337@sigill.intra.peff.net>
 <7v8vw5g4f0.fsf@alter.siamese.dyndns.org>
 <20110323170655.GA4392@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2SYB-0001D9-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487Ab1CWSMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:12:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab1CWSMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:12:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AC744D44;
	Wed, 23 Mar 2011 14:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ihtT8GmcAC76zszmHXpmc+OmD4=; b=AVDY8E
	eR1WvmyARpkGQOIcpaFRybXymE2o78on6XknLrniRFFPj+XCojNk/Ywx6xifD5UZ
	aZTi3g5Fc1KxbyTlzX5anpoZYWzzt+zgqt+yQ1HBtP3ZvoVwYQTrFXuwJUq1B+JM
	kwURrmQu+7Vqz/mJ8e63jTZZ2ji18aiDgbyic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qv+FtBkbmVoagX+xwHin65ltOVKDYaGh
	t0Opn0YgORWg3OctpqtrsfyNh4fvJbZpvJ8onvy1QX9SWiWOqp/PgOHpqurdM2kT
	BpXjb2hBZ4IRci3Nc4fB74/QfpBGVl83qjQLmG/GF5FTJBKpUrdjwIC/mWF7Yb+A
	7LlH1sEEeOc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3967F4D43;
	Wed, 23 Mar 2011 14:14:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 259604D3C; Wed, 23 Mar 2011
 14:14:19 -0400 (EDT)
In-Reply-To: <20110323170655.GA4392@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Mar 2011 13:06:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61D0432A-5579-11E0-9107-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169862>

Jeff King <peff@peff.net> writes:

> Obviously a solution that always provides an exact right answer is
> preferable to "pretty good results", but we'd have to keep in mind the
> performance difference.

And that is why the current --follow hack was declared to be good enough
to give "pretty good results" by its inventor, no?

I still agree with it personally, and if we _were_ to improve it out of
"hack" status, we should aim to do the right thing (provided if there is a
"right thing" exists).
