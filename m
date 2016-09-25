Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9734F1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941138AbcIYW56 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 18:57:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936453AbcIYW55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 18:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF10141E97;
        Sun, 25 Sep 2016 18:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SN1WJ/x5yQA0IEPdvRMwj8AbNLg=; b=jjAOuA
        NhvPAQzISW8a58VKvD0aZSbojJ50Dz50PSRoMoXYmSoWO6nusY+fKNCVCxfZnDtr
        UUobMajyEI2QuBO4G34NgNzvXhp2JpwbUnLGZ5xbjtMDVGzL+Q27VrkWXdfSJHxM
        OGeq64rZ92dGTx9jJUZ2csw6WkPKVFwJPi7IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I+iN7YsYDU05qJomawlog6VbomSJOhWV
        yn4qGh6XakS/0yGxxUOHug4tEHQoqNZb9PT5kfyghADquZYSmnlsDYOKBScxx6hN
        yM21SaA8LK4BAVuaQPLvlvZ5kzCyhYDJviOrVfbsPJIWF+iDF7NH9Hv/wEnaZlqt
        5g/wh8ViFLs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB26A41E96;
        Sun, 25 Sep 2016 18:57:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39B5441E94;
        Sun, 25 Sep 2016 18:57:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 03/11] i18n: add--interactive: mark strings with interpolation for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 15:57:54 -0700
In-Reply-To: <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:22 +0000")
Message-ID: <xmqqintjy4ct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F5BFB18-8373-11E6-B360-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -1048,7 +1048,7 @@ sub edit_hunk_manually {
>  	my $hunkfile = $repo->repo_path . "/addp-hunk-edit.diff";
>  	my $fh;
>  	open $fh, '>', $hunkfile
> -		or die "failed to open hunk edit file for writing: " . $!;
> +		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);

OK, $! presumably is given in the user's language, so we let
translators prepare the error-specific text and interpolate $! into
it.

Makes sense.
