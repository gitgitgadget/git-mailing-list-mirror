From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/38] rename_ref_available(): add docstring
Date: Tue, 07 Jun 2016 11:10:07 -0700
Message-ID: <xmqq7fe0rhts.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<5eb96cc20c0f76aff39d1556803ebd4f9f422cea.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:10:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bALSS-0003X7-GY
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbcFGSKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 14:10:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161418AbcFGSKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 14:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A24921756;
	Tue,  7 Jun 2016 14:10:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wbzJizi80gV3YaTReGSR4L3iV2s=; b=w5vq0fRFYvsjuk5l2V3K
	TJqaSNhoMG8bHn6V5ZOPgWY2FSYgFsOD9QKmZ2BC7WwDBexW2hib/NadVdcjA6Vq
	8UlgHSALUL3v1FeTi+2Y8pAwHWAV5EP/Pot6YOhzVa3pQmWn7wqmJY5mFWCT5IMj
	4JSc2F/49hqYt8e3tGRdWjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Lg7KAaX9V1Cpry+DmKdheLzz/i/iwXSWJL4/zflDRGkBAU
	QkzNeYwXTS9uZPsi+bvHUy605E34lidnPb6+wrSVFnNWi2BxTPmQihAH9E3mDTmF
	idJ7e6kXVVfQxRBb5FHfzOGi6ijmJqEUqXIUwtnhXgR1XagFqQ1BVcalKMrCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51BCE21755;
	Tue,  7 Jun 2016 14:10:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C88B821754;
	Tue,  7 Jun 2016 14:10:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 125E052C-2CDB-11E6-B81C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296705>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> From: David Turner <dturner@twopensource.com>
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/refs-internal.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index efe5847..d8a2606 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -240,6 +240,11 @@ const char *find_descendant_ref(const char *dirname,
>  				const struct string_list *extras,
>  				const struct string_list *skip);
>  
> +/*
> + * Check if the new name does not conflict with any existing refs
> + * (other than possibly the old ref).  Return 0 if the ref can be
> + * renamed to the new name.
> + */
>  int rename_ref_available(const char *oldname, const char *newname);

I do not quite understand the comment.  Partly because it is unclear
what "conflict" means here, but I guess it means a D/F conflict that
is explained near verify_refname_available()?

A new name can conflict with an existing, possibly old ref?  Are you
referring to this condition?

    You are trying to rename "refs/a/b" to "refs/a", which would
    conflict, but as long as there is no other ref that share the
    prefix "refs/a/", e.g. "refs/a/c", the new name "refs/a" is
    available.

I wonder if it is necessary to document that this function is not
meant to protect us from others racing with us.  That is, when you
are renaming something to "refs/a", you call this function and it
finds, by calling verify_refname_available(), that the repository
has nothing that conflicts with the name and says "OK", but before
you actually do the rename, somebody may push from sideways to
create "refs/a/b", making the result of an earlier check with this
function invalid.

Or is this to be called only under a lock that protects us from such
a race?
