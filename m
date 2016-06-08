From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: mark the file-local vtable symbols as static
Date: Wed, 08 Jun 2016 11:55:55 -0700
Message-ID: <xmqqfusnldc4.fsf@gitster.mtv.corp.google.com>
References: <57583022.2030205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:56:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAieB-00025j-4l
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425313AbcFHS4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:56:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423712AbcFHSz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:55:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27B9820DA9;
	Wed,  8 Jun 2016 14:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eAwRIu/reytKGvAS4fqPimKNWI0=; b=MWjOrB
	0a7x8nAIfK2K9zKsR/Yu4Gf/nh1BrqGAXGJyepuVk5XINXn4pTcxj8L2kXnaX4uN
	z1sTrjVTuqpd2hwTQiHE/YSLeGivDYpQu78ERUK3R1Xv1yABBPVVkJeDqu04IQOV
	A+JLNP93lou9ygWlwslfdGncnNzzckKA2kXDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ht+u45ETSxfQbaHufnMD8eQJ5W4uL4Rt
	6svQcrTiE/lV00mAi9YBy42h6JZM5l3Lh7dpWfQ6nreRdf4h0K/w3cRtEkN/ECQY
	JVZk52h34rTT3Pj8Kp5cUC5g2QvtMuxUor3Lc3hJPI4jeBT8do7YVD/UlUgJNWxm
	1JEl+78lS9U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC9820DA8;
	Wed,  8 Jun 2016 14:55:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 885B720DA6;
	Wed,  8 Jun 2016 14:55:57 -0400 (EDT)
In-Reply-To: <57583022.2030205@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 8 Jun 2016 15:48:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A285492E-2DAA-11E6-ACCC-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296832>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Michael, Junio,
>
> I would normally ask you to squash this into the relevant patch when
> you next re-roll your 'mh/ref-iterators' branch, but this has already
> been merged into next. (I normally have a bit more time ... sorry!).
>
> Perhaps, after the release, when the next branch is re-wound/re-built,
> this could be squashed into your branch then.

Yup, sounds like a plan.

>
> Anyway, after applying this patch, the following symbols are still
> 'public but unused':
>
> 	> refs/files-backend.o	- files_reflog_iterator_begin
> 	> refs/iterator.o	- is_empty_ref_iterator
> 	> refs/iterator.o	- merge_ref_iterator_begin
>
> These all look (potentially) useful for the implementation of
> additional 'ref-iter' types and look to be part of the _internal_
> iterator API - so they should not be marked static. Can you just
> confirm my interpretation.

I am not Michael, but FWIW I think that is sensible.
