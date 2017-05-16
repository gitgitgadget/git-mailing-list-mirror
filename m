Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507D7201A7
	for <e@80x24.org>; Tue, 16 May 2017 01:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdEPBPq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:15:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33053 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdEPBPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:15:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so7509103pfe.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 18:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xxq2hj3fUgHPrSazyNi1Vrm57eRpeuYEbNdsfc9GZuA=;
        b=H5vuItM8AmlnWmmpYLwI7GHorrKS53gsiEdmap6++vuBNElHf13e6UmothgbLlpBTh
         8vaa5wOVY+BLStY8UK0x4Z0zDrdMTBCilV/Ae1qpiULAqRUizF0RZUXLQ7mWkDXzj0rP
         fwC5bNLi+4x8CPlraqHHjWVlYTBVAfwFPa1GnS75j6T5f4UXu3VTPejmM8F7lQPIqfB2
         HJC/ByTDe4Jsiq9VBYqYKqUVhLh3QObAjODF734dWQMCgBfET2RK5F5/GdnVWhNHShg5
         mb2h5fxXO3mTlJOABZ6+PQLJuh7Opwke/HSmYERWADPfkWPg3yC203TarBQ60LUfShFA
         aHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xxq2hj3fUgHPrSazyNi1Vrm57eRpeuYEbNdsfc9GZuA=;
        b=KrcYa/viXGFdxT8NT9IwYFzQiUyQmI4ZYK4ecHOIyBLXZ179nCWAA9HGFRluqsVjOv
         SNW5uN7XN5izR9/hU/9RlMoANiggedCX/xiO/dE3hdlr+FCxs2HtHJW9Cg/lL5s2qZ1F
         zebpTYl6tacYs4o3eFg/nrcoWnd635ydvvGfb+Usk6Zmf1BTnW6MMvv583DLlDY7bKtk
         Z8LmQsMMaZg/DhlTLSzTEXelGudE9af7nmLSn0QCAaMmiuKn++PfJ/UmEf4yjmlC0HK3
         Z37r50TcvaIBIA/dn7Fibm0quk5OLX2MWOp7qWgGt72VWLmt/kWFmhbPANWpAp9s0Cu2
         vD4w==
X-Gm-Message-State: AODbwcDXDH47dERNaYVS+CRnNYqWAHhNbJ/e/Dy68lYrTbFUeBwhXniD
        4Rqbd/xSqpFMvQ==
X-Received: by 10.98.152.71 with SMTP id q68mr9350940pfd.25.1494897342048;
        Mon, 15 May 2017 18:15:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id p68sm19884013pga.6.2017.05.15.18.15.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 18:15:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] config: match both symlink & realpath versions in IncludeIf.gitdir:*
References: <CACBZZX5nchNUb-V3U8FL9fuhk=3t42Qhz4=Wh9Qk_0C=x85UdQ@mail.gmail.com>
        <20170515191552.5193-1-avarab@gmail.com>
Date:   Tue, 16 May 2017 10:15:40 +0900
In-Reply-To: <20170515191552.5193-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 May 2017 19:15:52 +0000")
Message-ID: <xmqqlgpx4n5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the conditional inclusion mechanism to support
> e.g. gitdir:~/git_tree/repo where ~/git_tree is a symlink to to

s/to to/to/;

> /mnt/stuff/repo.
>
> This worked in the initial version of this facility[1], but regressed
> later in the series while solving a related bug[2].
>
> Now gitdir: will match against the symlinked
> path (e.g. gitdir:~/git_tree/repo) in addition to the current
> /mnt/stuff/repo path.
>
> Since this is already in a release version note in the documentation
> that this behavior changed, so users who expect their configuration to
> work on both v2.13.0 and some future version of git with this fix
> aren't utterly confused.
>
> 1. commit 3efd0bedc6 ("config: add conditional include", 2017-03-01)
> 2. commit 86f9515708 ("config: resolve symlinks in conditional
>    include's patterns", 2017-04-05)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> Here's a non-RFC patch to fix this bug.
>
>  Documentation/config.txt  | 11 +++++++++++
>  config.c                  | 16 ++++++++++++++++
>  t/t1305-config-include.sh | 23 +++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..137502a289 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -140,6 +140,17 @@ A few more notes on matching via `gitdir` and `gitdir/i`:
>  
>   * Symlinks in `$GIT_DIR` are not resolved before matching.
>  
> + * Both the symlink & realpath versions of paths will be matched
> +   outside of `$GIT_DIR`. E.g. if ~/git is a symlink to
> +   /mnt/storage/git, both `gitdir:~/git` and `gitdir:/mnt/storage/git`
> +   will match.
> +
> +   This was not the case in the initial release of this feature in
> +   v2.13.0, which only matched the realpath version. Configuration
> +   that wants to be compatible with the initial release of this
> +   feature needs to either specify only the realpath version, or both
> +   versions.
> +

Does the second paragraph format correctly, or do we need the usual
(and ugly) "+ by itself on a line and then dedent the next
paragraph" trick?

> diff --git a/config.c b/config.c
> index b4a3205da3..0498746112 100644
> --- a/config.c
> +++ b/config.c
> @@ -214,6 +214,7 @@ static int include_by_gitdir(const struct config_options *opts,
>  	struct strbuf pattern = STRBUF_INIT;
>  	int ret = 0, prefix;
>  	const char *git_dir;
> +	int retry = 1;

I think your earlier RFC used a variable with a better name than
this; it is not like we are preparing ourselves for adding a
mechanism here to retry for many random reasons.

The logic would be clearer With an "already_tried_absolute" variable
that is initially 0, retrying unless it is already set, and set it
when we retry, like you did in your RFC.

Thanks.
