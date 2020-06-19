Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E62C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F79921531
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnu8KWxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgFSRSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:18:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFSRSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:18:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B747608C0;
        Fri, 19 Jun 2020 13:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YL6m0SN2mN7nR2isACNfjzKb3vg=; b=fnu8KW
        xUa/yzoRzv1QUWOi61xR1xzr9bTWxF3HC89g27gkCbjMalVgNRrhe2jD4lIh6ocw
        Cu374IjIQTIa5H205BIzhFvBKjaTrl8Tl+hM/Bf3HBxo5lDTn/9oUdF+62adqLhM
        rG4U1CActiOoZLvBs+cgX85gWXgTrwTgXN3XI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rUfjfX2oCobsS4iYwNBZp2RLrUA/7pLq
        Qf4WDc3vaI1IXpeQII0ELryRCKsPswh1a7EjcmWib8Bm3S0DH6VIi67qk8iw50vH
        1h1khkkaJpX0dcYBuMuQSewtq0ZwaVqKIJ85JBsBhQsbgQkmXCuflIpITmEKHhV8
        d1IWWStPjgc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 123BA608BF;
        Fri, 19 Jun 2020 13:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 973EF608BE;
        Fri, 19 Jun 2020 13:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git@vger.kernel.org, msuchanek@suse.de,
        Till Maas <tmaas@redhat.com>
Subject: Re: [PATCH v2] tests: do not use "slave branch" nomenclature
References: <20200619093210.31289-1-pbonzini@redhat.com>
Date:   Fri, 19 Jun 2020 10:18:36 -0700
In-Reply-To: <20200619093210.31289-1-pbonzini@redhat.com> (Paolo Bonzini's
        message of "Fri, 19 Jun 2020 11:32:10 +0200")
Message-ID: <xmqqimfnht3n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E91D16D0-B250-11EA-A6DF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Git branches have been qualified as topic branches, integration branches,
> development branches, feature branches, release branches and so on.
> Git has a branch that is the master *for* development, but it is not
> the master *of* any "slave branch": Git does not have slave branches,
> and has never had, except for a single testcase that claims otherwise. :)

Somebody mentioned "claims" was too strong, but I think the smiley
strikes a good balance there.

> Independent of any future change to the naming of the "master" branch,
> removing this sole appearance of the term is a strict improvement: it
> avoids divisive language, and talking about "feature branch" clarifies
> which developer workflow the test is trying to emulate.

Exactly.  As somebody else said, we often call such a branch "side"
in the tests, with the (hopefully widely-held) assumption that any
development, either new feature or bugfix, would be done on a side
branch and then merged to the integration branch.  What the test
tries to do applies equally to the developer workflow to use a side
branch to work on a non feature (like bugfixes), too, but what is
written in this patch is good enough, I would say.

Thank you to all for commenting.

Will queue.

>
> Reported-by: Till Maas <tmaas@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  t/t4014-format-patch.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 575e079cc2..958c2da56e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
>  '
>  
>  test_expect_success "format-patch doesn't consider merge commits" '
> -	git checkout -b slave master &&
> +	git checkout -b feature master &&
>  	echo "Another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #1" &&
> +	git commit -am "Feature branch change #1" &&
>  	echo "Yet another line" >>file &&
>  	test_tick &&
> -	git commit -am "Slave change #2" &&
> +	git commit -am "Feature branch change #2" &&
>  	git checkout -b merger master &&
>  	test_tick &&
> -	git merge --no-ff slave &&
> +	git merge --no-ff feature &&
>  	git format-patch -3 --stdout >patch &&
>  	grep "^From " patch >from &&
>  	test_line_count = 3 from
