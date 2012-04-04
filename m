From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -p loses amended changes
Date: Wed, 04 Apr 2012 16:20:52 -0700
Message-ID: <7vhawz6q3v.fsf@alter.siamese.dyndns.org>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch>
 <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
 <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
 <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
 <4F7BEA9F.3060805@viscovery.net> <7vpqbna0cd.fsf@alter.siamese.dyndns.org>
 <7viphf8cqh.fsf@alter.siamese.dyndns.org>
 <CAH3AnrrE9Fbs_p_=ETRns4vyz8J879-m+KDF5K4j7vDdTh9bEg@mail.gmail.com>
 <7vlimb6r37.fsf@alter.siamese.dyndns.org>
 <CAH3AnrphGmrZSxALP3j3ADt6Cg4Tr2O83mcDBU2LfUdpdtUCUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 01:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFZVc-0004wl-D4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 01:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab2DDXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 19:20:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127Ab2DDXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 19:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 450A660AF;
	Wed,  4 Apr 2012 19:20:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xGamAYh7EyWOjbOrZ4b5jpft6F0=; b=aUJnle
	2Ng64fDtQFU4v8IBrtIFflnXC7W3JQQo19FISpcrr4PeaDhJka3Zx7+EwpjjzS2Y
	HfM+GBbnluK5rZ0bZt7LKhP+6hXgQAYGk2PeO3TPGgh7B7kMtR8mRAa10Hkq3SWo
	vQE6SRQ10qGbTymorABF33HVFcKkq0+CFWHZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ujQ/dzuhTImLHknq/Go3gCoEIHlWctWV
	S+xFm8NK50X/3lXCn1fNpX7haYQXrnkYRVISsDW+ctSQ/RQodNhvQooVLQQwop2p
	LFrFYgLkzrBTXwC2Tj4e3+trpvztQ2bJbmZc0nWtGapNqFvvEG44n6ZN3nFrGFg1
	0zkNdsQVUJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B99560AE;
	Wed,  4 Apr 2012 19:20:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B339A60AD; Wed,  4 Apr 2012
 19:20:53 -0400 (EDT)
In-Reply-To: <CAH3AnrphGmrZSxALP3j3ADt6Cg4Tr2O83mcDBU2LfUdpdtUCUw@mail.gmail.com> (Jon
 Seymour's message of "Thu, 5 Apr 2012 09:05:16 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D302A31E-7EAC-11E1-BBD8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194754>

Jon Seymour <jon.seymour@gmail.com> writes:

> On Thu, Apr 5, 2012 at 8:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>> Are there any flaws, I wonder?
>>
>> It all depends on how close the base is to M^1. ...
>
> True. I guess it is still true there are no perfect solutions in this
> area. This does seem like a step in a better direction, though.

The nice thing about Hannes's "replay the change between M^1 and M" is
that it sidesteps the fundamentally impossible part of your original idea,
which is to mechanically sift the "evil" part out of "pure merge" part
out.  Instead, it replays the change as a single ball of wax.

That difference between these two approaches may make the replaying of M
easier or harder, depending on how M^1 and your new base relate to each
other, so it is hard to say if it is really a step in a better direction.
Perhaps M is a merge made to the maint branch, and you may be replaying it
on top of a newer codebase based on the master track.  M^1 may lack many
changes the new base has, so replaying M by applying the patch between M^1
and M may give you a lot of conflict that you should not have to resolve
if you simply merged M^2 to the new base.  And the worst part of this
conflict resolution is that you cannot easily tell what the right solution
should be unless you look at M, M^1 and M^2---that forces you to sift the
"evil" part out of "pure merge" part in the original merge. The good news
is that this is *not* mechanical, as you have your own intelligence to
help that process ;-)
