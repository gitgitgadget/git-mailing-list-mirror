Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA36820136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934833AbdBQS5g (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:57:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34669 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755276AbdBQS5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:57:35 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so5582015pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gw3p/QAZGImFKq10iomO7Mci/bRWirm13N/6CLZ5VTs=;
        b=YbsZluCCf5aabKmQIwtdzRlXz8hnTS6S4tStl/+m7cAIcX1hvikNt6hmIHT2xR8qPd
         5zAqdkhHKtMELHZRUEYQgL9CyldzGGLQljmgk85561cwcSKqrZXzsr7a4LxGIBSZXZFs
         KyYE2GUhah119OVZPNXBlNmD0OLHCtDdDxkl7f5w2f41WjpoSrNFKQCc+tF7WTzXCtwF
         6PwsMy2a/ZByPsL8oC3+z8ysi60sfy2WRiiO1x3LH4jGvbEtEv+UG/i5FE0Cs167zegF
         +1diQSvpAMNiFan9S8WMPBl6WRoEtLJlhnVyYqK5bVoNbs6+Zcn3cBeYQJx5qJQ1Tblb
         0B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gw3p/QAZGImFKq10iomO7Mci/bRWirm13N/6CLZ5VTs=;
        b=Tlytpi2A44oNXG94P+EE2N5BJ6YNlCdJCfq88WeCX0z8Z+KuqA8elx1Pkf6x4BenaO
         C1ifuNWieq9Jg28U/uT6/gw9akL9y/pclZNPFOM+VMw+TWyLeemeG9Vxr9eQogqGdUYe
         Xp6dCFJ6+qxffns07cFj5B9xvseZSGSxiQcGNxjTG2wgTuEghX0H4qdIPQjF0v5BnRUr
         kXP7AEM6iiyH1N2rcSeuMK7SkkVBa33LTNZynvDlBUVaMRn8Ml2A6WgBVnOJgChX51dD
         R+YYCPKZDJfB5hwSs3hgQ+RKdq3XPW7H4qgSepKCayzNFj2ZNO2uN0K/SDm8CGJ24oA8
         pYwg==
X-Gm-Message-State: AMke39km88tY+hSmcRMxQkIun0r2Wq/MWIWdWrR/wUhmnYY4tfHzTj8Xn/fnbZY7hdjQuA==
X-Received: by 10.84.215.154 with SMTP id l26mr13287701pli.120.1487357854348;
        Fri, 17 Feb 2017 10:57:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 19sm20992171pft.46.2017.02.17.10.57.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 10:57:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v3 03/16] files-backend: add files_path()
References: <20170216114818.6080-1-pclouds@gmail.com>
        <20170217140436.17336-1-pclouds@gmail.com>
        <20170217140436.17336-4-pclouds@gmail.com>
Date:   Fri, 17 Feb 2017 10:57:27 -0800
In-Reply-To: <20170217140436.17336-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 17 Feb 2017 21:04:23 +0700")
Message-ID: <xmqqvas8sl0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This will be the replacement for both git_path() and git_path_submodule()
> in this file. The idea is backend takes a git path and use that,
> oblivious of submodule, linked worktrees and such.
>
> This is the middle step towards that. Eventually the "submodule" field
> in 'struct files_ref_store' should be replace by "gitdir". And a

s/replace/&d/;

> compound ref_store is created to combine two files backends together,
> one represents the shared refs in $GIT_COMMON_DIR, one per-worktree. At
> that point, files_path() becomes a wrapper of strbuf_vaddf().

I like the general direction, obviously ;-)

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f0c878b92..abb8a95e0 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -930,6 +930,24 @@ struct files_ref_store {
>  /* Lock used for the main packed-refs file: */
>  static struct lock_file packlock;
>  
> +__attribute__((format (printf, 3, 4)))
> +static void files_path(struct files_ref_store *refs, struct strbuf *sb,
> +		       const char *fmt, ...)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	va_list vap;
> +
> +	va_start(vap, fmt);
> +	strbuf_vaddf(&tmp, fmt, vap);
> +	va_end(vap);
> +	if (refs->submodule)
> +		strbuf_git_path_submodule(sb, refs->submodule,
> +					  "%s", tmp.buf);
> +	else
> +		strbuf_git_path(sb, "%s", tmp.buf);
> +	strbuf_release(&tmp);
> +}
> +
>  /*
>   * Increment the reference count of *packed_refs.
>   */
