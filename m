From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Thu, 10 May 2012 09:49:30 -0700
Message-ID: <7v4nronfqd.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <4FA904C3.7070208@viscovery.net>
 <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
 <7vd36ey70y.fsf@alter.siamese.dyndns.org>
 <CABPQNSbBwpVJUx9BSSO2nqAnPxUESZBz-GEqOPPEyqvdcutb6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 10 18:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWYd-00031S-7j
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab2EJQte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:49:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab2EJQtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849997F1E;
	Thu, 10 May 2012 12:49:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jo0BgdtQvmTqMnbajjGT1+6TVGo=; b=I7Cz2f
	IzlBmdmyQgi2UffnwowIWIN/PhDZMG7pm8Gfk+irvICJJqqBktLmimH59wiwgn0L
	FAb0VjFBDncmVEJSVBRF7GxDO1fjt5Q81XGYyPtB/Mjv1sbgD/4w6/GPltUzgQy7
	bjjNnQP6m/fuHcr8gJOMWSGR+XiRgLUuzFoYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EqyzY7VwVK7eZWDqUvyzCcypkPCTpBXi
	7ULN1TUnSwy+8Ch+syTQrxqZK/UUuiu2FVceG1wcksPnTlTdu2EYc2ZmKLg24Quq
	7AuEvcSJRQV5BmTwHcL24PEprk6IErfoMWzMccBBeC8mrXngcSQXtfx3i8kRKobZ
	fN03E+TTg+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A95E7F1D;
	Thu, 10 May 2012 12:49:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09B6E7F1B; Thu, 10 May 2012
 12:49:31 -0400 (EDT)
In-Reply-To: <CABPQNSbBwpVJUx9BSSO2nqAnPxUESZBz-GEqOPPEyqvdcutb6w@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 10 May 2012 16:22:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DB32576-9AC0-11E1-89AB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197599>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Tue, May 8, 2012 at 6:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Am I missing some corner cases that we _should_ error out, perhaps for the
>> sake of safety?
>
> I don't know, and I was kind of hoping someone would jump in and
> enlighten me of something, but that didn't happen (yet).
>
> I have a slight preference for this operation, though I'm not
> religious; it simply seem more consistent with other "git checkout"
> operation.
>
> Do you want me to prepare a proper patch including a variation of the
> test-case from the other patch?

I think an official looking patch would draw more attention from others
and may uncover cases we did not anticipate if this turns out to be a bad
idea.
