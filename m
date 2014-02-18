From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename read_replace_refs to check_replace_refs
Date: Tue, 18 Feb 2014 13:30:54 -0800
Message-ID: <xmqqppmkcdm9.fsf@gitster.dls.corp.google.com>
References: <1392722695-31815-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 18 22:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsFu-0000XG-It
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbaBRVa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:30:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbaBRVa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:30:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFCF66E9A8;
	Tue, 18 Feb 2014 16:30:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Btcw+klvtsp++VLWN6rKtyg6Iko=; b=KytALX
	BKt2CP8tNPhOA417HU/l1gf0wHyygMMabcpmpBgbvjHNis8i5qYh4QapuQOGYX0n
	ruT7wZoVOyFQ463jLRlJ/r4Rv+S1TEEduZEwLTWm2MXqsnkbPz/oPFOI8fhA59wq
	4GwznbPJRGx72Y2K47RYfk9OQ0GGa5EwxDLGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vN50h+3IjrXDkecnJuGw6AmQ34jMVhbN
	ZKs61ayhYHtQH+t1hVORiS0vAiCF5nMU+TdUp01l7mlUL+fqIIaV20WFADbFjLrm
	WktkK3t3k3ErDRH7LPjlUToNgN8yMBQ16sK8vFLz3kwZuFpiF011KjMxtyGuq2VW
	n3T58ghqaYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A28F6E9A6;
	Tue, 18 Feb 2014 16:30:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE3366E9A0;
	Tue, 18 Feb 2014 16:30:56 -0500 (EST)
In-Reply-To: <1392722695-31815-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 18 Feb 2014 12:24:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3F56B12-98E3-11E3-9FAC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242360>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The semantics of this flag was changed in commit
>
>     e1111cef23 inline lookup_replace_object() calls
>
> but wasn't renamed at the time to minimize code churn.  Rename it now,
> and add a comment explaining its use.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This change doesn't conflict with anything in pu; perhaps we can
> squeeze it in now?

I think it is a good time to do this kind of clean-up once the
post-release dusts settle.

Thanks.
