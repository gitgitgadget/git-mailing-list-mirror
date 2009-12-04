From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 04 Dec 2009 09:44:49 -0800
Message-ID: <7vws12r5v2.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcDO-0000zk-OR
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbZLDRpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbZLDRpA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:45:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbZLDRo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:44:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69354A48E0;
	Fri,  4 Dec 2009 12:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0lxzdyK9i2IIFHOXjjQny2w6PvA=; b=r1ajsD
	UF0UHxb2mfq6e41eOGI7Yf3HkJlWucHIHP3hd0LuePX8DoHAi+EWWZt7/2bO3E8t
	JL6zB54riMz9CbWXYMAi7rQKgtIEIr15XXBiC4R1g895/vwUB2mIrUT8ATjL8+Rn
	VPZJCJ06kT9VqoYg5j/DPYFd5K6PjkIrd7he8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uq31O+SuwY0pN8Bp6d4ChQ4hCgmJduV9
	OGECILm8VU959Ylahoe9gPhT0do+h9zHdTCWqs62Ys5ytjUpemlAkjp13py33FeZ
	XHQ7VgZOGZfd7p9t/wbH28b6usqlR1s1RrDqZCDgC8k/tR/+km72+IcDU8vHBmOE
	DKHde2xF3mw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D099A48D9;
	Fri,  4 Dec 2009 12:45:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 04775A48D8; Fri,  4 Dec 2009
 12:44:51 -0500 (EST)
In-Reply-To: <vpqfx7qocwl.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 04 Dec 2009 18\:40\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE8957E8-E0FC-11DE-BDE4-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134556>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>> If the idea of a "fix" command is acceptable, then I would like to
>>> implement a further convenience: if a group of commits to be folded
>>> together includes *only* "fix" commits, then the first log message
>>> should be used without even opening an editor.  But I would like to
>>> get a reaction to the "fix" command in general before doing so.
>>
>> I'd say that would make a useful command ("fix") even more useful, being
>> just the right counterpart to "reword" for trivial commit message fixes.
>
> +1 for fix, and +1 for the "don't even launch the editor" too.

I like it, too.  Also I vaguely recall that there was a series that died
that would have allowed you to give hints to help this behaviour at the
time you make "fix-up" commits; we may want to resurrect it on top of this
feature.
