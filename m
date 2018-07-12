Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638811F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 21:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeGLVRS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:17:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbeGLVRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:17:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so23030219wrn.7
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vdPOnrEtf6A/4G2zQa1otvK+H9TTQWQ/hNnu86XndiQ=;
        b=hxrnTpNoy64nPUJFzQDrihKi9pzaSQlNj1Hshj4cY97MqpzUXaOFg2c63TB7wcnRqi
         AfMVVSN4+tBB3/f5tZurqwiUjXEGAaWf7ZaGgfUzSVhmEvNLRCr3+pSsF9KKq3WlKeJK
         W7h+z1BPPZImOxpHe3wXZgdredBCnNI3Do0ctZ4wxb0rmeaMbRlvBgrDp2etFiPfGYZD
         hMYopKZbRYJafLOemgF4NRf3wdH8m87AVyWHkQPVU1U42B5ddjS9+cDeOMZJw6jtDUwu
         mqP/4NVVOl+uiTRdzrSW5kT0MpRLrTkXDPOTYG+a8fdzawym5/DhksDLxuWaAbc0KtA5
         8q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vdPOnrEtf6A/4G2zQa1otvK+H9TTQWQ/hNnu86XndiQ=;
        b=FJbofRkqsBuqCrzXtgi6zw+cKhnN0zIcdjgMk0+hfUYC4xGoIezuHtePDL7p1BjJuJ
         zGpTR3l4SZhaSZ2nYZWzKwcM6WbDXV9DT4xyDMYlIhnSHevnhMbkPBoIL4+t6nrtel2V
         5aNBEQyGTW/P1gW4/JtoF6dgktxX8i+bidr4fJDCboFO0erT2hAVkV26HWfVR8hjKA5e
         m3MmcOijK+3HycgABWq1EmOJM/854xDnh8HwLZP/JMtgkahMXLAcYhWxFs5G3BaaCvxT
         tIgJqrRylHk5qJRVOJuU+Jtg4sr80lNb6rQBqhEpdiHlM8KxhFoBY51j7ucdFGg5iVWB
         Q3CA==
X-Gm-Message-State: AOUpUlFpBVlGGXAjR4cobMe6C7bJww4/TbwEyX6ixRZK/k1YR4qURAGz
        X+QSEOrbfF2jqu/bonzkSJk=
X-Google-Smtp-Source: AAOMgpdx/yhT9HGB8O83QNsRXK+VhsEBmHgrvMdh4szm6y9Bqqh5tB1xcAsALYJSJjKscvSS7cPP2g==
X-Received: by 2002:adf:92c3:: with SMTP id 61-v6mr2303283wrn.231.1531429558301;
        Thu, 12 Jul 2018 14:05:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q140-v6sm8078826wmb.35.2018.07.12.14.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:05:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 16/23] config: create core.multiPackIndex setting
References: <20180706005321.124643-1-dstolee@microsoft.com>
        <20180712193940.21065-1-dstolee@microsoft.com>
        <20180712193940.21065-17-dstolee@microsoft.com>
Date:   Thu, 12 Jul 2018 14:05:56 -0700
In-Reply-To: <20180712193940.21065-17-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 12 Jul 2018 15:39:33 -0400")
Message-ID: <xmqqin5kupu3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The core.multiPackIndex config setting controls the multi-pack-
> index (MIDX) feature. If false, the setting will disable all reads
> from the multi-pack-index file.
>
> Read this config setting in the new prepare_multi_pack_index_one()
> which is called during prepare_packed_git(). This check is run once
> per repository.
>
> Add comparison commands in t5319-multi-pack-index.sh to check
> typical Git behavior remains the same as the config setting is turned
> on and off. This currently includes 'git rev-list' and 'git log'
> commands to trigger several object database reads. Currently, these
> would only catch an error in the prepare_multi_pack_index_one(), but
> with later commits will catch errors in object lookups, abbreviations,
> and approximate object counts.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
> midx: prepare midxed_git struct
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

What is going on around here?

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 4a4fa26f7a..601e28a2f0 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -3,6 +3,8 @@
>  test_description='multi-pack-indexes'
>  . ./test-lib.sh
>  
> +objdir=.git/objects
> +
>  midx_read_expect () {
>  	NUM_PACKS=$1
>  	NUM_OBJECTS=$2
> @@ -76,18 +78,35 @@ test_expect_success 'create objects' '
>  '
>  
>  test_expect_success 'write midx with one v1 pack' '
> -	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
> -	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
> -	git multi-pack-index --object-dir=. write &&
> -	midx_read_expect 1 18 4 .
> +	pack=$(git pack-objects --index-version=1 $objdir/pack/test <obj-list) &&
> +	test_when_finished rm $objdir/pack/test-$pack.pack \
> +		$objdir/pack/test-$pack.idx $objdir/pack/multi-pack-index &&
> +	git multi-pack-index --object-dir=$objdir write &&
> +	midx_read_expect 1 18 4 $objdir

Hmph, so we used to run tests as if $cwd were GIT_OBJECT_DIRECTORY
but now we are running them from the top-level of the working tree,
just like all the other tests?  Interesting.

>  '
>  
> +midx_git_two_modes() {
> +	git -c core.multiPackIndex=false $1 >expect &&
> +	git -c core.multiPackIndex=true $1 >actual &&
> +	test_cmp expect actual
> +}
> +
> +compare_results_with_midx() {

Style: "compare_results_with_midx () {", just like mdx_read_expect
near the top of the file, but unlike midx_git_two_modes we see
nearby.  Please keep "git grep 'funcname () {'" a usable way to
locate where a shell function is defined without forcing people to
type an asterisk.
