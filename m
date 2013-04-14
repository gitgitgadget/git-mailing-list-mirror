From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Sun, 14 Apr 2013 11:45:10 -0700
Message-ID: <7vobdh54uh.fsf@alter.siamese.dyndns.org>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
 <20130411043346.GE14551@sigill.intra.peff.net>
 <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
 <20130411050509.GC27795@sigill.intra.peff.net>
 <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
 <CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
 <7v8v4l7ils.fsf@alter.siamese.dyndns.org>
 <CAMP44s22N9_E4oBG0UztXE0yAkX8TmQaE9-x1_wDHqv3bvZ0EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 20:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URRvV-00044J-JN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 20:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3DNSpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 14:45:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab3DNSpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 14:45:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41ADE16A4F;
	Sun, 14 Apr 2013 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Te9iEBUKJz1/kZ+FGe0SQudOBoM=; b=pDktnr
	a/ttOsK916Xiei/+ylIaEJzTZA2W/LyCxIvMBIY4wGuH31qJ3TKVUBzJG1uFWADR
	Bkn398q38vMAoK+EOfL05OmFR0+lO2qtcmyqQOVoqmr3dqrsiExm3YSk/7pR8ozj
	Fa2UiOi0qO4mUKLWsp4X/mBicOFIqW5ymBFsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NvudzAs+E6YWIMDvb7KLAVi40VtbYnU0
	SidFBvlgEiRf0HuyeL9Kn3bYzDITp682CD6WBVNSd5QKqIfq1++5TFivO1VGtGj1
	4Ka/EM1YDBiG3AIJ4MdsKdQqp+X3jhM05IIsSov8dLg+Qf6cilJd9sbRhN0jXVuV
	ivPupFCpGgM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37AD316A4E;
	Sun, 14 Apr 2013 18:45:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A1EF16A4D; Sun, 14 Apr
 2013 18:45:12 +0000 (UTC)
In-Reply-To: <CAMP44s22N9_E4oBG0UztXE0yAkX8TmQaE9-x1_wDHqv3bvZ0EQ@mail.gmail.com> (Felipe
 Contreras's message of "Sun, 14 Apr 2013 10:42:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70A6B562-A533-11E2-8795-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221147>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 14, 2013 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Why wasn't this patch merged to 'pu'? To my knowledge nobody raised
>>> any real concerns.
>>
>> There are many reasons not to queue _everything_ ever posted to the
>> list on 'pu', and they are almost always not a deliberate rejection.
>>
>> The maintainer may have thought he is not the best person to judge
>> changes to the area the patch touches, and may be expecting further
>> comments from others, but haven't said "Comments?" and waiting for
>> them to say something without being asked. Or the maintainer may
>> have judged that it is likely to result in wasted work if he queues
>> that version of the patch, fixing trivial nits himself, only to see
>> a reroll arrive before the day's integration cycle finishes (which
>> makes him run the cycle again). Or the maintainer may have been busy
>> tending to other topics. Or the maintainer may have pushed the patch
>> down the queue for any of the above reasons to deal with it later,
>> and after having tended to others' topics, may have forgotten about
>> that patch.
>
> The world is full of possibilities, but most of them are irrelevant,
> specially since 'the maintainer' is right here and can mention the
> reason himself. Is there anything wrong in asking?

An earlier draft of my message starte with "Do you have to be
combative to ask a simple 'did you forget this?' question?", but
later I removed it. That was what made it irrelevant ;-)

Just rerolling with what _you_ think is an appropriate level of
explanation (either or both in log and in-code) and see what happens
would probably be the best way to proceed, I think, at this
point. Either you hear "It still is wrong and too sketchy", "Yeah,
thinking about it again, this is sufficient" from others.  Or a
silent, which I am inclined to take as much closer to the latter
after all the discussion.
