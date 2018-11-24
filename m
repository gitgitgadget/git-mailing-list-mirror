Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DCA1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKYGRC (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 01:17:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39017 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKYGRC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 01:17:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so12670410edt.6
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 11:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lOyINhIsDUAM/I15CCLH8BgV9k3DLBVNP31/QQr4TbY=;
        b=nomlsngG7q76MvoMfERWysjoxMKVOnVstdx+mTn/e+xHo8Awl8uu6FfPosEa9oHU1W
         t2YtdHfAqD4x1Rx1rcfiWzEZXRyE0jDP2cFnlLxgTigbEnHLwOcy8Jl+SdyYLx0lB0YH
         RsCcsUgS+o1yTjT7KdfvKREFr3OMAJfzyNMGodQUAqvfE6PGn6Zbrfpw41eqHRdy+Gnt
         zd85kuefnjpgjHJrNy5cIxc8Klwvn7JgZguUxwrRZgamdSIGAdTfapAmLKwZd7MOfJpv
         Wk9cDwcU2fjuWOpLJ/6zu7cef/QkhyKY4XDhnO7NrxTSMCUOfNq3HUa5EThgVrEukgNF
         AYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lOyINhIsDUAM/I15CCLH8BgV9k3DLBVNP31/QQr4TbY=;
        b=JQpVvAuQUA0dRj+PGt0kcsXI9RJz0PQaIVrE2C2+1D6Do8m3Tmq3EMylkm+b07+8LB
         hd6VL6EfoHf+JoKhbniE/BAp0/7eycwzP/ccpj14Yxj7fkC/dIvSgv52CceKGxTi9J6/
         jRu6xTDvPj6tZWm1wgPTBW+hs1mzWukc1GSanx2RK2reHLSDEkLif1EQGVpTsh68eX/v
         wWat6DteZKnH/i/Ob6MvK/6tMJBGjvKPUgNJ82i/U/PUsT87p24GtsVOi+qh9+8jfdCf
         HCC2gDeCOBoez1Fq1HHW/YIJOK6fe5Q+keZBvEOEJDgC8yxTlXDvCI2UcDX+CJqNQgrv
         rUnA==
X-Gm-Message-State: AA+aEWajHFjaBCIFOvCBHq2WWEEoCeCq93K4KVOQBk6hWQCdEryM8Kv1
        dol3P7/1HHimxzaW3ZctFit0j/GN
X-Google-Smtp-Source: AFSGD/XsTHnBhsoerl0BjpJyVOsQHKrTvg8i5fKjzMHlwq3Nt3ShLkqmjcImWVd49PJ+npQJ+ngfPg==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr17688869edq.170.1543087674610;
        Sat, 24 Nov 2018 11:27:54 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id r46sm3084517edd.18.2018.11.24.11.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 11:27:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
References: <20180929191029.13994-1-pclouds@gmail.com> <20181021080859.3203-1-pclouds@gmail.com> <20181021080859.3203-4-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181021080859.3203-4-pclouds@gmail.com>
Date:   Sat, 24 Nov 2018 20:27:52 +0100
Message-ID: <87a7ly1djb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 21 2018, Nguyễn Thái Ngọc Duy wrote:

This change has a regression in 2.20:

> [...]
>  static void files_reflog_path(struct files_ref_store *refs,
>  			      struct strbuf *sb,
>  			      const char *refname)
> @@ -158,6 +178,9 @@ static void files_reflog_path(struct files_ref_store *refs,
>  	case REF_TYPE_PSEUDOREF:
>  		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
>  		break;
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +		return files_reflog_path_other_worktrees(refs, sb, refname);
>  	case REF_TYPE_NORMAL:
>  		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
>  		break;

SunCC on Solaris hard errors on this:

    "refs/files-backend.c", line 183: void function cannot return value

Needs to be files...(); break; instead.
