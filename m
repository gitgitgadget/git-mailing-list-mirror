From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Mon, 22 Jul 2013 10:23:56 -0700
Message-ID: <7vr4eqcxub.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<51DC6B37.9030108@alum.mit.edu>
	<7vli5fv5ud.fsf@alter.siamese.dyndns.org>
	<CAPig+cTh2t_Rc13U_F-prmm=sjs2OEHX5AX2DbC5DH+Tx_E5jg@mail.gmail.com>
	<87r4er2ct4.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 22 19:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Jq9-0003pI-GG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 19:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328Ab3GVRYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 13:24:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163Ab3GVRX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 13:23:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C3A732616;
	Mon, 22 Jul 2013 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/L3qxbileZPKWfvjxcubukJhpKk=; b=XColrz
	WWWnCvH/OKEP2KCXP74D10z54wPzicHCB/jZD22GpgEZpccHBTbBHnC1z+aYAq6+
	mIY1IwkO3QI0Khq0phStugTzq7dd3omHqWY+Li4XL1LYIomMQDn5K+kBS3PWoWIW
	oDlPnRY6+vlHzdwS3gYHDhSjyGhEjbnIzXxbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QuPM/+t3EQ3wt4aRF58QpIxBVPqreCex
	ONQxO77Tx89hj0PelfhPRIy9O7FfxKvx9DZx1g0vgu+tiP8h7x1A7Ie/5fZTgvL2
	zbiaPGtFN1UFOhrh1jlP+zqT2uqj6qupKaSZZYW5qa36k333iP5GY1vgEbmKSdFe
	00AkWCJlI6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7001B32615;
	Mon, 22 Jul 2013 17:23:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B69BF32613;
	Mon, 22 Jul 2013 17:23:57 +0000 (UTC)
In-Reply-To: <87r4er2ct4.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Jul 2013 12:39:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DE376EE-F2F3-11E2-8916-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230982>

Thomas Rast <trast@inf.ethz.ch> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The proposal currently is only for "-L /RE/,whatever" to behave in a
>> relative fashion, beginning the search at the end of the last range
>> specified via -L (or line 1 if there is no previous -L).
>>
>> Would it also make sense to support "-L +N,whatever" as relative to
>> the end of the last range specified via -L (or 1 if none).
>
> Sounds reasonable.
>
> I'm still not sure I am super-happy with /RE/ always being relative,
> though I see Junio's problem space as something worth solving.  How does
> it interact with -L:RE?  Do you now have to know in what order the
> functions appear in the source to correctly specify -L:foo -L:bar or
> similarly, -L/foo/,/^}/ -L/bar/,/^}/?  What if we supported +/RE/ as the
> relative version?

Two gripes I have are:

 (1) That sounds like making common things more cumbersome to ask.

 (2) In "-L /RE1/,/RE2/", you do not have to say +/RE2/ (and you
     shouldn't have to).  /RE3/ without any magic that starts
     searching after the last match in "-L /RE1/,/RE2/ -L /RE3/,+4"
     feels a lot more consistent than requiring a prefix plus.

I am OK if you made /RE/, which starts searching immediately after
the last match, wrap around and continue the search at the beginning
upon finding nothing through the end of the file (and make sure you
stop if you passed the last match again).  That would solve your "I
have two functions, and I can give them in any order", while keeping
the consistency with "In /RE1/,/RE2/, the latter is already relative
to the former".
