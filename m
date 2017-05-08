Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF04F20188
	for <e@80x24.org>; Mon,  8 May 2017 05:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdEHFLX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:11:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34799 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdEHFLX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:11:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so2608859pfk.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d45RPBoLBptZLlhIHCWhgn8DUaPq8cyBdSNnjZfzdc8=;
        b=VVwTnvryfRmqVGgTKguQ9Dp8Ux1i4Hg+hn7Nu4OrMOgVLLwILpPMwHu7lX40hK54ES
         5aszheHXfYPmeRfknqBjAFs8VenlL5VuDkWmAjWK1GKWAxdOr7lQBVxDcUnae3cfrL25
         6BcG0J+6SB94gIR+cncAJyGjwgjOSwKlvEQpxJG/NEWt95YOKax/Yqa0m/zKUuJ+H4ci
         7cbN368cM/uMAy5g/KKDkGtv9hhP2WT/IQcwowM/ioLXkNOsuXxxHPabu6UfhjkMwTUG
         uhizuZaL6OmU9pVM2fAm7RHt78TgxTVBo+qGvcaVoZVHMk4kWBXgHersF9ekTKNgDLQv
         2ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d45RPBoLBptZLlhIHCWhgn8DUaPq8cyBdSNnjZfzdc8=;
        b=ZB+r55o5I9qzA59BXGn/W9AhvHkRBGklBn2pdyKOcnrmtmK4kJDuyI+WtD5XNrVz7W
         L47uiuG+s90UtAJrwzabtn36Lmf9knV0nxGSj2+sSAdHMiuHQjrlr512PRb1x+RlfelU
         xmr8RdONZzYAhfcELfPBi4UAdx6i90k0DX2UaEdEG649SDmsBCkz+8/5LgNSE2hZnjW4
         /zufyCoOmH+xDckCVjfncVJbFClVrm7xqe67wuA+d4oR1o179yCbF5lJs1g85KNECU0U
         bJL8aADq/VggsWpB3z8G5VfCk7uLp/BJMbX9ksNnVDJvXlA3gHBk0R3gVsMhvW8a+RQA
         EStw==
X-Gm-Message-State: AN3rC/6vqnBDjWsFwVPSS7M1xeM35ckZfVSEriRu0+hb8Ghk2MSP7fJi
        t193AtuucMchmDwwsYI=
X-Received: by 10.99.109.199 with SMTP id i190mr16289627pgc.71.1494220282314;
        Sun, 07 May 2017 22:11:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id j125sm15752506pgc.53.2017.05.07.22.11.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:11:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/7] git-new-workdir: mark script as LF-only
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <fbba7450f2d4475b6d9a0d740dc43e22c81b104e.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:11:21 +0900
In-Reply-To: <fbba7450f2d4475b6d9a0d740dc43e22c81b104e.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:49:23 +0200
        (CEST)")
Message-ID: <xmqqvapc7x1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Bash does not handle scripts with CR/LF line endings correctly, therefore
> they *have* to be forced to LF-only line endings.
>
> Funnily enough, this fixes t3000-ls-files-others and
> t1021-rerere-in-workdir when git.git was checked out with
> core.autocrlf=true, as these test still use git-new-workdir (once `git
> worktree` is no longer marked as experimental, both scripts probably
> want to be ported to using that command instead).
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I wouldn't bother fixing these myself, but the above two credit
lines are swapped.  You wrote, then Jonathan reviewed (to which I'll
append my own as the 'editor' of the history when I commit).

>  contrib/workdir/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 contrib/workdir/.gitattributes
>
> diff --git a/contrib/workdir/.gitattributes b/contrib/workdir/.gitattributes
> new file mode 100644
> index 00000000000..1f78c5d1bd3
> --- /dev/null
> +++ b/contrib/workdir/.gitattributes
> @@ -0,0 +1 @@
> +/git-new-workdir eol=lf
