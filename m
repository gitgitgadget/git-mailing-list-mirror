Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01774C33CA9
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5A1222D9
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbgALKzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 05:55:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37258 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgALKzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 05:55:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so5776228wru.4
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 02:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agtXR+RHEZYRWj0wjGHcIFcf+TkUIf0bv6rr9QqTraY=;
        b=Z0PwZJah/LuAg+F79/L76szaiEMzguFgCFtcXM8lCNfUjCDJhxsHLMiuxscK0sV375
         u0YRMOPTzGAjjoaw0PV7/6joz8PLO1TPuq50qKkZxh10zWhFNEZnQsGP1IAkQg3KahSv
         tvGWUulHi99xaHmU/zYZTffnmXbD6bzGsuLTo461NN+HpIlSQrG3FLS3oNrFur95C1/k
         pj1wqBFQAh2Qg7dMdPiUG3dDyoGsFt13ss+y8eZDAyQEvA9OEgyadNNpiOrinw3JHOJj
         3ivpJV69FH93a+NnLbRp/Du4+IsROerXdHfrm4oG0ei0LKS7bg2OWpgXwE5QKA+oXrrx
         Qhlg==
X-Gm-Message-State: APjAAAU8+qDJDnxzXK2bhVH4OMJA7ycybIiR5jKVtdmvdccvcPrVsY/n
        gSPALnawURgNBajq5M2Bb9gQbB6w2oStJlsblSA=
X-Google-Smtp-Source: APXvYqz7iJPqIT/UeQvhwF2Y8N8OlNB1uSTtAy7gyVicSXiL5AyiwpSjqQhMD+A/q1Spu0eT8xw3VthjF36OzAeko7w=
X-Received: by 2002:adf:f382:: with SMTP id m2mr13053409wro.163.1578826530372;
 Sun, 12 Jan 2020 02:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20200112064706.2030292-1-marcandre.lureau@redhat.com> <20200112101735.GA19676@flurp.local>
In-Reply-To: <20200112101735.GA19676@flurp.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Jan 2020 05:55:19 -0500
Message-ID: <CAPig+cQqKvBc3ugfVtmaSZb+pBkp2wkBG=++GTPODp7oCaGBhQ@mail.gmail.com>
Subject: Re: [PATCH v4] branch: let '--edit-description' default to
 rebased/bisected branch
To:     marcandre.lureau@redhat.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 5:17 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> +/*
> + * Return branch name of current worktree -- even if HEAD is detached -- or
> + * NULL if no branch is associated with worktree. Caller is responsible for
> + * freeing result.
> + */
> +static char *get_worktree_branch()

This would of course be:

    static char *get_worktree_branch(void)
