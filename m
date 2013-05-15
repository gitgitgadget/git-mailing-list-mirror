From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 12:13:26 -0700
Message-ID: <7vd2ssawfd.fsf@alter.siamese.dyndns.org>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
	<7vhai4cgco.fsf@alter.siamese.dyndns.org>
	<20130515173312.GR25742@login.drsnuggles.stderr.nl>
	<7v4ne4cexm.fsf@alter.siamese.dyndns.org>
	<20130515181734.GT25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Wed May 15 21:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uch8n-0005gc-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759974Ab3EOTNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:13:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759961Ab3EOTN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:13:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D011F651;
	Wed, 15 May 2013 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eGJtbifjzlqPb9rMll6VGxA9q0=; b=tnEias
	KQN6yksMo3Vi4ETPooW9LCrO5vuV0jYQGvlN3PB0FWMvEKgD32aJFLT6zJFJ6b3x
	Q9OfIfNdPabR3j5QQttwMPSWikLlHLka0navMryk/oy9qKx+O3X7JyJxWj9DoKJ3
	OC+D6coo9tilifmBl/S+q1obk2DUYmyOgkVH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOU1MGgi8FgpChgFfW0C7L4EcIS3jp0x
	a5F4mM1lueZJq53fiD0qEuALyB7mDPENk09V7CD3EV5N09SD8KWWLrryHZn85qwz
	yWldzLmYtdH9m22HTQgvGMfPSDpl/9yDm4bd9K13xhVOH+XrVWHH4yszmRw+qUcJ
	NeFQQx8lxYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49AA51F650;
	Wed, 15 May 2013 19:13:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2BD71F64D;
	Wed, 15 May 2013 19:13:27 +0000 (UTC)
In-Reply-To: <20130515181734.GT25742@login.drsnuggles.stderr.nl> (Matthijs
	Kooijman's message of "Wed, 15 May 2013 20:17:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85D02810-BD93-11E2-B24A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224441>

Matthijs Kooijman <matthijs@stdin.nl> writes:

>> Could you explain why you think it hides the real problem, and what
>> kind of future enhancement may break it?
> I think the differences is mostly in the locality of the fix. In my
> proposed patch, the no_pre_delete flag is never set on an interesting
> line because it is checked in the line before it. In your patch, it
> never happens because the control flow guarantees the "context" lines
> before each change must be uninteresting.
>
> The net effect is of course identical, but I'm arguing that depending on
> the control flow and some code a doze lines down is easier to break than
> depending on a previous line.

Yeah, that sounds like a reasonable reasoning.
