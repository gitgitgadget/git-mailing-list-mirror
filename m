Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E928C203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbcG0RVl (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:21:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752073AbcG0RVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:21:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E42C2E6A4;
	Wed, 27 Jul 2016 13:21:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=168c4hKdKJrHaCPBdHAIVxisjU4=; b=kkQT9P
	YZLLIQavkzFxLOBZ5OKDDpCoHl7brHBFhoEa5XmzCqQIo+rQKtrEVYzl77MoG2Lj
	VQDSY5jyL8jFZAkNseK/ajeQQIcWE8ICRO6XWPQjpISlkeW3N9ettIJIS2n/lLAB
	U2PA83QRtJvYWFbik4pyETpgoAlL5Em8k5m0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+iAYGQUp5zBGlmPr0IYorxQ1y3bRrNE
	pIgKELScwmvSn9EXCEV+GZAzjeHL3YsLQSZM4vJvzfW6xAnjpJOuuL0cESpJIOX0
	e8kDPhyO1IyZb1ZwRBBWVe8kzwAL+eL+zJZ794zsPdwi9cyKdX6i3sjiQof2BTb+
	Ihc1omO4n9w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46FB82E6A3;
	Wed, 27 Jul 2016 13:21:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C88CC2E6A2;
	Wed, 27 Jul 2016 13:21:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Chris Packham <judge.packham@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
References: <20160727083406.10241-1-judge.packham@gmail.com>
Date:	Wed, 27 Jul 2016 10:21:36 -0700
In-Reply-To: <20160727083406.10241-1-judge.packham@gmail.com> (Chris Packham's
	message of "Wed, 27 Jul 2016 20:34:06 +1200")
Message-ID: <xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93E44FF6-541E-11E6-84F8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> Hi,
>
> I noticed --recurse-submodules was missing from the bash completion. This adds
> it. I went for '--recurse-submodules' instead of '--recursive' as I seem to
> recall the former being agreed upon as the better (or least ambiguous) of the
> two terms.

Yup, that position is consistent with what 3446a54c (clone: fixup
recurse_submodules option, 2011-02-11) gave us.

Perhaps we should think about deprecating "--recursive"?  I dunno.

>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 37888f4..7c06455 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1136,6 +1136,7 @@ _git_clone ()
>  			--depth
>  			--single-branch
>  			--branch
> +			--recurse-submodules
>  			"
>  		return
>  		;;
