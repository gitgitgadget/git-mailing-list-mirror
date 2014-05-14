From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 15:24:51 -0700
Message-ID: <xmqq61l8hubw.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
	<87mweku2pt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 15 00:25:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkhbh-0003Cf-9p
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaENWY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:24:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62437 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbaENWY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:24:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2653318819;
	Wed, 14 May 2014 18:24:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J7SCGeUqRSEF5jpFHAqQ0ysWlsk=; b=yaHXPM
	svGNTe4H03xbdygHO6fO/p/1ugzOL6/9JVwOIl14GaRnquTSXQY/ZzIR2gYvisDA
	E+k3wq2Hl8/EdPG6/nNxLHJ7+m0e7tw6RJe67YJNBWJgpewvalfDcgYt6jl3ymdc
	iUFcvsfU50k61UgjOGf1oD948Zv+T0F5O5lp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7oZ8oC4WBjlmuu6bBi5xBHGlqUvFaMI
	5p/W2YR/4uFeFelzyt8rdpsQ8o6Nlq2nPIcVqEstyJuHbHI3Bn2TO6rYVITyBcVT
	Ri3i3sBokDbDMcx1hbbBcfXvEjoObh5zqWaMfftSZcjf7y/q9aSBC23e/YP5vuGT
	gbrZ8WvsE4Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D4C218818;
	Wed, 14 May 2014 18:24:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6785318816;
	Wed, 14 May 2014 18:24:53 -0400 (EDT)
In-Reply-To: <87mweku2pt.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 14 May 2014 11:30:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 922F7574-DBB6-11E3-AF94-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249040>

David Kastrup <dak@gnu.org> writes:

> Philippe Vaucher <philippe.vaucher@gmail.com> writes:
>
>> Thanks for the explanation. I think it underlines well the A)
>> technical issues (quality commits) and the B) social issues (ability
>> to communicate in a friendly way & respond constructively), which we
>> discovered are both *essential* for contributing to git.
>
> I'm not entirely convinced of that: there is something akin to drop-dead
> gorgeous code: code that is so well done that it would not matter with
> regard to its maintenance whether or not its author dropped dead because
> it's both done well as well as documented in a manner where the original
> author could not offer significant additional help.

I would have to say that you are living in a fantasy land.  During
the entire life of Git, I do not think I ever saw such a code that
is perfect from the get-go and did not require any maintenance to
adjust to the changing time.
