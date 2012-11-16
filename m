From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Fri, 16 Nov 2012 12:04:00 -0800
Message-ID: <7vzk2hl3gv.fsf@alter.siamese.dyndns.org>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
 <7vvcd6954q.fsf@alter.siamese.dyndns.org>
 <20121115172845.GA20298@sigill.intra.peff.net>
 <7vzk2i6s9h.fsf@alter.siamese.dyndns.org>
 <20121116190811.GB2310@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZS9D-00064t-F5
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab2KPUEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:04:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2KPUED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:04:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E518A60E;
	Fri, 16 Nov 2012 15:04:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dTP/b0jDtYZMytO4Qeut2rQtyjM=; b=nWjlJc
	pxa7TOkHVXPbral24U84lcqL9VbmJBt4NB5L1S1bs8rgPp9APIi2dQ9S6ng0YHB5
	rmyQKQF/TYMq6ku4HmCgRaJYmPO7aQI7P1VwSyZeDsU3PXgfmxuAjqDzz/sqdj5o
	wzbaXHEAmpsdZbdvlJtQajG9yTYUnBE8dB9U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWoW3WnmwzJQwtmSr9Ty8wVWgAm1wOOZ
	SV4EFNhSa7BMvKTBhln0pN0ysDsnqNJVru8lCicJ1Ul6Ax4qJCPqaDE88ROt05Dz
	AfRf2TKBBZVVkc3jNjINK3kHE5i5Vkx3WfFMeaKykG2LN9xD+Xv2sVPRpxP1uhMV
	PJWu0ZxKHm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D0BA60D;
	Fri, 16 Nov 2012 15:04:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6229A60C; Fri, 16 Nov 2012
 15:04:01 -0500 (EST)
In-Reply-To: <20121116190811.GB2310@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Nov 2012 11:08:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3DF85C2-3028-11E2-BDAE-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209902>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 15, 2012 at 09:17:30PM -0800, Junio C Hamano wrote:
> ...
>> OK.  Tentatively I replaced your old series with these 8 patches
>> including the last one, as I tend to agree with the value the
>> earlier clean-up in the series gives us in the longer term.  As you
>> and Felipe discussed, we may want to replace the last one with a
>> simpler "don't bother asking" patch, but I think that is more or
>> less an orthogonal issue.
>
> I'm not sure how orthogonal it is. The latter half of my series is about
> exposing the user_ident_sufficiently_given() flag. If we go with
> Felipe's patch, then that exposed information has no users, and it may
> not be worth it (OTOH, it's possible that some third-party script may
> want it).

Oh, no, you are correct.  I shouldn't have said "the last one", but
instead "the later ones".  The first two we should definitely keep,
at least, but the other three are not so clear.
