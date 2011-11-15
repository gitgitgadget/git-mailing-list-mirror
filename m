From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] ll-merge: initialize default_opts const
Date: Tue, 15 Nov 2011 15:17:02 -0800
Message-ID: <7vty65t1qp.fsf@alter.siamese.dyndns.org>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
 <1321376379-31750-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQSFc-0002Q5-3a
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab1KOXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:17:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957Ab1KOXRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:17:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C941859A0;
	Tue, 15 Nov 2011 18:17:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6NN7JhtWlbu2LIKUYOGJx1qLmQ=; b=vexhKQ
	OI7WAdKUI0nJw9VIYFKVUk1N8LcyfsuBW/iBNmUzszOYZfP0OFN8owuAFhh+vaVf
	J3hDfUJ0NoaSRMLacGhSWj3UVqcl/scHmlaenKrv8quBSI4VgCZ2P/hmsArcshFU
	aA7z6kRFNLZtG63RlCA0bhSwwWJ6xjEMgvQF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gyvvCWtaYbJmN3tMSEDhaEc/HnTlzeU4
	gRL05CeXQd0oeZmJ5VgFWbH3Ci+Q//OmMDcPVmfbRSBk00xsdOXSCtLBX9nQdOCW
	xlKRIfTzt+nmu9yfu1c9A3CHwUbqnvg1iKxxyT5RBI956UaAA3kCO+Ga8sR9wlCH
	ckfKp7StQco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10AD599F;
	Tue, 15 Nov 2011 18:17:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 566FA599E; Tue, 15 Nov 2011
 18:17:04 -0500 (EST)
In-Reply-To: <1321376379-31750-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 15 Nov 2011 22:29:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE0B0ED0-0FDF-11E1-9B9C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185496>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  ll-merge.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/ll-merge.c b/ll-merge.c
> index da59738..205aed3 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -351,7 +351,7 @@ int ll_merge(mmbuffer_t *result_buf,
>  	     const struct ll_merge_options *opts)
>  {
>  	static struct git_attr_check check[2];
> -	static const struct ll_merge_options default_opts;
> +	static const struct ll_merge_options default_opts = {0, 0, 0, 0};

Doesn't "static" tell us that it will be in BSS, initialized to all zero
by definition?
