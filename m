Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566491FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdJYE0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:26:33 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:51080 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdJYE0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:26:32 -0400
Received: by mail-qk0-f194.google.com with SMTP id o187so29004975qke.7
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lfiIM9X92whhLJtltqZ9nKC33CuF4g0w+DrdbI9lSFc=;
        b=apuoVLP2ApgHHfZHSbApYY2CMX0ZanoPe6oIWMep80uP37iv4ClLXIjZxas+nGFmUZ
         Ga8wVtcy5YlyonoP1fp8QtxTz2KjKG1LpbDUWPhlyzmHf6GoyAldkYd3jV7eI+Mh+jmn
         t09aDcf/QIClf5ueeU/fhciEIR+PlDJgw7MM3KNt99JNyt/Ihz87NzMbc18wXIgjEj1t
         WFbvvDpIicSIKKp6Q4y36Ixy4UF5gY+V0nLpxgOw+ujkwjq9tepyAHJpKrQluCITrWwG
         eqzEULWsyBc7+QVGbfYHFEMjguJw8IN+TaqwL2FGYO2AzM6QSDgN+/kxNXhoV2A37g7L
         8kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lfiIM9X92whhLJtltqZ9nKC33CuF4g0w+DrdbI9lSFc=;
        b=L9PaIalzArSgdn0OluFhZaxKdSMNyiNe3ZrFcYlWzkXFqWMhX+jPmWlKxtlPBTK/Sa
         wWFqLjfoAb2BMZxj02f093BTS+j/1UCFEht2NHoaQIK58PunlRRXpJl3q7ZmzKXMj6i/
         JZ/YzRqO8caLH1s4ZWF10VJYhOre2PG/gBDBCclnZAGM0brx2QL9P03k0rWSISnzThfA
         nyIGQjUaos24Y4tc27UsgY2w7xG8tKVPZu0GHWwHzR/F/fyaNw4+URNxHwClUmNhX9nk
         O5uKo/qgDvj2ZDimBZvlkM4Xxzmkaj/ihBif80W6m+ruiKCETWNf/EizZ2mNpjk1JlJq
         GoVQ==
X-Gm-Message-State: AMCzsaWu6zoV1UftkMwobCmHOVH5397+RVSxwTJR+2QR+Me76D8H7+2L
        4H3d6BYfJuyKeZXQcdlFi48SuRZT3CpuiOcbr5E=
X-Google-Smtp-Source: ABhQp+ThNJJ9x242kG5zh6NyqCX/NZGrr0HF6JWdPw8UfRn0HcA3AEvQJTHISz+aHeB53AUZ+VU1d2DLQBQdgOqDJqE=
X-Received: by 10.55.113.70 with SMTP id m67mr1281986qkc.23.1508905591766;
 Tue, 24 Oct 2017 21:26:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 24 Oct 2017 21:26:31 -0700 (PDT)
In-Reply-To: <20171024234234.10944-2-sbeller@google.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
 <20171024234234.10944-1-sbeller@google.com> <20171024234234.10944-2-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Oct 2017 00:26:31 -0400
X-Google-Sender-Auth: KGHSN4q0ucxg5rw_sQ9GpBUAbXE
Message-ID: <CAPig+cR1Lw=JGJ7BoTdvM_PG+sjAoas=GTbs2fkRTYq35Mj2sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 7:42 PM, Stefan Beller <sbeller@google.com> wrote:
> This will turn out to be useful in a later patch.
>
> xdl_recmatch is exported in xdiff/xutils.h, to be used by various
> xdiff/*.c files, but not outside of xdiff/. This one makes it available
> to the outside, too.
>
> While at it, add documentation.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> @@ -29,4 +29,20 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
> +/*
> + * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
> + * Returns 1 if the strings are deemed equal, 0 otherwise.
> + * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
> + * are treated for the comparision.
> + */
> +extern int xdiff_compare_lines(const char *a, long len_a,
> +                              const char *b, long len_b, long flags);

The comment block talks about 'l1', 'l2', 's1', and 's2', but the
declaration uses 'a', 'b, 'len_a', 'len_b'. Confusing.
