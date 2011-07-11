From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Mon, 11 Jul 2011 13:07:20 -0700
Message-ID: <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:19:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNtP-0003Vy-Ou
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab1GKVTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:19:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab1GKVTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:19:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF54269F4;
	Mon, 11 Jul 2011 17:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=t2nI1c/yI9vOp9uyPBnZjyvc3Ks=; b=ULceMKMrRW+t0KoNPwir
	fbgOCv0A8jYgI/IORaRcncQUmqOwYeCkNZ69h7Y8BzZ8LiMl36ax6p+oqW6YlQdt
	1pVN8OmyCjl3mnNU4k6Uk3upM/gad7qWSodkHj3OY8rRn8Q/2M+B9IaBozrVtGce
	7v5UBY3V0RJA8CHNC5ysiSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Q3aD/xFR/k40c5p4pygZ6g4vuyfFvvzvQjEJUYydO7MIHj
	xhDxu2ZcqLIOUkM+zEBwvr/LPZ3vv8RZ98d2j6l8wTPllrcC8uDuolltL/pOQ9Nl
	Ibap8Si/4u2TFmb1Hzz/S7SGacAWigBkLv8RKQeFT43a89r7/OKfKCS+50Fr8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D86A969F3;
	Mon, 11 Jul 2011 17:19:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C62969F2; Mon, 11 Jul 2011
 17:19:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CE31562-AC03-11E0-8AEB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176896>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The basic questions:
> ...

All good suggestions.

> To be precise, the format used includes
> 
> 	strategy-option = patience | renormalize
>
> to represent the effect of "-Xpatience -Xrenormalize".  My only worry
> about that is that the "|" can sound like "or", which would seem
> strange to a user that does not necessarily develop software (so is
> not thinking about bitfields).  The format used in config files puts
>
> 	strategy-option = patience
> 	strategy-option = renormalize
>
> as separate lines.  

A very good point again. I do not think anywhere in our codebase we use
"|" as a separator for state files (either used for internal or exposed to
the end user), and we probably would want to be consistent across
commands.

>> 4. New tests and documentation.  There's really no end to this
>
> Once each new feature has been documented and each new feature or
> fixed bug has an associated test, you've reached the end of this.

Yes.

> My main worry is still the commit messages.  They don't need to be
> elaborate but they should explain the purpose and effect of each
> patch.

Doubly yes.

> I don't know how to move forward on that.  I can explain what's
> missing in each message, but I get the impression that you already
> understand that and there's something else (e.g., time) preventing
> them from getting fixed.

Understanding that does not lead to an action does not really count, does
it? After all, this series was labeled "for inclusion", not an RFC, which
would mean the submitter, helpers, and reviewers all made reasonable
effort to perfect the series to their ability, no?
