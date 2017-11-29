Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1AE20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbdK2UXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:23:25 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:44302 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbdK2UXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:23:08 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so5569097itc.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X41Q+UNVlp9lT1Ae9EaQ3CUIYCeZ4EA36y4d/WUPhzs=;
        b=HKtrg/lAIoX2z1ME8hWqqH5pMpXxV0pq8Spt3clQAuT2VKTNn77ETvVV5z+c8u/Jyl
         spDOfSHE8fNSWmCJU4Rhktuk9GVplDAKyePIVFf6UnUCROUHDIgpHNfdM1AplZw5jwVe
         nfI6TaWfFYQvnqLHhy/qyCzOYfCbFHiSzgGLPcAP01AQu93YIRjc9mqS2fkJp3egeyp8
         SXlZRxPserRl1wY2V3Tg9BgV07z3vhA7j16rn1vrhOI+cQTsWDlEUY7cV9LB4bO/RLho
         Akc6YIdr7SEDUWEe4H+iKe+GJrIQB7B32ISVMfYaeA/yS0Ozjr3ug8QgObwW2B5a74+h
         r0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X41Q+UNVlp9lT1Ae9EaQ3CUIYCeZ4EA36y4d/WUPhzs=;
        b=OGXqak7UlcuFsr9kE+uQC4at2AhmdYe7uyaXmjyRkKSwiiWWaokgkqYALhkxbj7TQb
         J1IQFWM9rZ10dfgy6tK7GRut2Z6034TgXmRWsXy0m92KjKu1M0GXz3k9Ma+0fn23GlcO
         SO44cQ+VEjKVLdWudiizt1Td1EcVJIZLSIl6P/oX4BvaUXgHR8sRnKm/5gHorMWzE0Km
         N7f37YczGWavVjlM1TRf5FK+rLi54URKyKCpHKdL9yyBSEWHdy/6cwyX15qTGEaN1MPc
         v8dpSE54fr4MCQfOBl1fJQkBcZQa2gIOh6pY0XdqoG78Igs8oj96Ao9OaY8h18qy6XE1
         0YEA==
X-Gm-Message-State: AJaThX48YosqfOCMtOgGedmmK9XKwzAo2Cul3P/oS1LSaAHuyo6j1/Wz
        Uo9+lQZJPFgWcX9dOb9Sh0o=
X-Google-Smtp-Source: AGs4zMYZx5aL9hUZ29EYVmObTTMM786Ge1j4bwYI5CfgaT1VdftNordDJiq5XK8ZQJoNEYX2vB8YSg==
X-Received: by 10.36.154.71 with SMTP id l68mr38871ite.57.1511986988169;
        Wed, 29 Nov 2017 12:23:08 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 137sm1381859itl.35.2017.11.29.12.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:23:07 -0800 (PST)
Date:   Wed, 29 Nov 2017 12:23:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH on en/rename-progress v2] diffcore-rename: make diff-tree
 -l0 mean -l<large>
Message-ID: <20171129202305.GC15098@aiede.mtv.corp.google.com>
References: <20171129183200.178183-1-jonathantanmy@google.com>
 <20171129201154.192379-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129201154.192379-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> In the documentation of diff-tree, it is stated that the -l option
> "prevents rename/copy detection from running if the number of
> rename/copy targets exceeds the specified number". The documentation
> does not mention any special handling for the number 0, but the
> implementation before commit 9f7e4bfa3b ("diff: remove silent clamp of
> renameLimit", 2017-11-13) treated 0 as a special value indicating that
> the rename limit is to be a very large number instead.
>
> The commit 9f7e4bfa3b changed that behavior, treating 0 as 0. Revert
> this behavior to what it was previously. This allows existing scripts
> and tools that use "-l0" to continue working. The alternative (to have
> "-l0" suppress rename detection) is probably much less useful, since
> users can just refrain from specifying -M and/or -C to have the same
> effect.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> v2 is exactly the same as previously, except that the commit message is
> changed following Elijah Newren's and Jonathan Nieder's comments.
>
>  diffcore-rename.c      |  2 ++
>  t/t4001-diff-rename.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks again.

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 9ca0eaec7..245e999fe 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -392,6 +392,8 @@ static int too_many_rename_candidates(int num_create,
>  	 *
>  	 *    num_create * num_src > rename_limit * rename_limit
>  	 */
> +	if (rename_limit <= 0)
> +		rename_limit = 32767;
>  	if ((num_create <= rename_limit || num_src <= rename_limit) &&
>  	    ((uint64_t)num_create * (uint64_t)num_src
>  	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 0d1fa45d2..eadf4f624 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -230,4 +230,19 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
>  	test_i18ngrep " d/f/{ => f}/e " output
>  '
>  
> +test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
> +	test_write_lines line1 line2 line3 >myfile &&
> +	git add myfile &&
> +	git commit -m x &&
> +
> +	test_write_lines line1 line2 line4 >myotherfile &&
> +	git rm myfile &&
> +	git add myotherfile &&
> +	git commit -m x &&
> +
> +	git diff-tree -M -l0 HEAD HEAD^ >actual &&
> +	# Verify that a rename from myotherfile to myfile was detected
> +	grep "myotherfile.*myfile" actual
> +'
> +
>  test_done
