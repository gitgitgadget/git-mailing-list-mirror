From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 15:41:47 -0700
Message-ID: <xmqqy57l780k.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
	<20130828201803.GB8088@sigill.intra.peff.net>
	<xmqqmwo18pgw.fsf@gitster.dls.corp.google.com>
	<CAJDDKr6RDiAxgUdaE5aH4-wxYRY7fKnUukX1D-t07=-_P0CZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 00:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEoR3-0007h2-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 00:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab3H1Wlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 18:41:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab3H1Wlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 18:41:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EADCA3D151;
	Wed, 28 Aug 2013 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l69wY8j3xNyq/w2T6d5+ddxyTJA=; b=n4IDXW
	Le1S3GzXVMi9+Bf00YRrONskI6JBZRLA8uUe2VWHPop+Gp/l1NPKXRLxi3OhMdkv
	bkibeuOBI/HiUWpUng/pAJK+iuTA4Kq4B8FxO2YGy6fTEfo2hlcXqMdkhi8sEjcV
	//GhqCnseoIFU2ecIx4WZ2UzESiCVpWzFpJdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FwhFcc8sLy5ndOup809AkZ6GxRqhs4h5
	DzHpifAyeaVprfnmV/ij0GJphfdA87lVb+zfbDLWGox4kPH9tIYwyOw+lov7HHuI
	pcxZcDaFrTbNteYF1qUQFZcHhIGD6LEG2YpRiaGUnRQEo+ayBTvwnmZHgICptMRA
	FZ+QrK7sNTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE0CE3D150;
	Wed, 28 Aug 2013 22:41:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D0E3D14E;
	Wed, 28 Aug 2013 22:41:50 +0000 (UTC)
In-Reply-To: <CAJDDKr6RDiAxgUdaE5aH4-wxYRY7fKnUukX1D-t07=-_P0CZAg@mail.gmail.com>
	(David Aguilar's message of "Wed, 28 Aug 2013 14:59:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 079D19E2-1033-11E3-8D96-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233227>

David Aguilar <davvid@gmail.com> writes:

> On Wed, Aug 28, 2013 at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Wed, Aug 28, 2013 at 01:05:38PM -0700, Junio C Hamano wrote:
>>>
>>>> What are our plans to help existing scripts people have written over
>>>> time, especially before "status -s" was invented, that will be
>>>> broken by use of this?
>>>
>>> I thought that our response to parsing the long output of "git status"
>>> was always "you are doing it wrong". The right way has always been to
>>> run the plumbing tools yourself, followed eventually by the --porcelain
>>> mode to "git status" being blessed as a convenient plumbing.
>>>
>>> I will not say that people might not do it anyway, but at what point do
>>> we say "you were warned"?
>>
>> OK, sounds good enough.
>
> I personally think it's a little strange for this to be configurable.
>
> I have a poor imagination and cannot imagine why it needs to be
> switchable.  If someone switches it to "a" does that mean that any
> commit message line that starts with the letter "a" will be filtered
> out?
>
> Specifically, core.commentchar seems really unnecessary to me.  What
> is the benefit?
>
> I do see downsides -- folks do parse the output, they don't read the
> release notes, they don't know any better, but, hey, "it works", so
> they'll be broken just because someone doesn't like "#"?
>
> What about hooks that write custom commit messages?  Do they need to
> start caring about core.commentchar?

They are valid questions, I think, but are best asked to those who
wanted core.commentchar configuration, not to people involved in
this thread.  Also unfortunately it is too late by two releases to
ask that question.
