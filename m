Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A491F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeI0Ajy (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:39:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33336 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeI0Ajy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:39:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so2787468edp.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/Ik5Tw8IUDeY5L8pMCXSmm6gWIH/uPjsYINbyylCKps=;
        b=ZF4ncFypdm5xxX1nmZTxzFfc5Pay6zTz0BfxUXrCkpmBRMtqW9RaTlCWAzEtaYmnPt
         OpgfSVE+4n2A9kM+TW0mNp0IriM4ikEDKZa0JXABNUNFZRK1ggmV3hla55tOraJ4UtKM
         t45tOIS4cHdc6AZ1IPFajASh0kdHh8FXBe9ppYCvvD1OKYRai9+x2uWoyKhA3+E5JmT+
         DIi5JBj/kkSa/ux9H2GtQlrutC49+kYlxPfOobjeWMxVIF/nIz6PaLTjplyOKpOQn1IV
         4mD5TiqX2toaecuKCBrh3PApJsK2luTzZiBmKAkMPcNvzk7ww7Am92Zmp297/3v87dKS
         HamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/Ik5Tw8IUDeY5L8pMCXSmm6gWIH/uPjsYINbyylCKps=;
        b=MSZNqhGyTywrkm4n65Z92h7PpAsOqVHW3Un0BW2bCx6ala08B0LQb6TP2XuZ3/4m7x
         bZpVqJZTDTh/Gqbj9iWDsJV99veyTYaU+rUCWMulUZQrevt8qXyKT1M+aTSacwTwghJG
         iVMaqnGINMTq9oTk9bTpNFefIFvoF2oOXzQ8hZbuoBJIWX6mCjW0ntKHovev72k7ylJZ
         Doj2Kf3KwqOoaGUBx7CmflnuDGQ0PLlCJhFestaZvv1Nj5KrX40h4HGqGmaJ2ScNyimQ
         Hhfe3dDkynAKjFO2QFh2JjINY3vzm9iHiZIYHHn9yXARamucSGrbqe1JyqqP4X50+94U
         kICQ==
X-Gm-Message-State: ABuFfog+f7DTJd83LyOmtHbHYed4tqvknH0phjTGuKZbMto2Bzq+P9Hw
        eD2yoTkxZHfN9dXBO7NbJkY=
X-Google-Smtp-Source: ACcGV60QdI1jz6E/gXMLWMrpVm/50ZyOnMUF0gvghtJBxlCqOLHwBSv66xn0bBj+vePvDVI8+zy5YA==
X-Received: by 2002:a50:8fe6:: with SMTP id y93-v6mr11617068edy.290.1537986340429;
        Wed, 26 Sep 2018 11:25:40 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a11-v6sm31860edn.95.2018.09.26.11.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:25:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] worktree: add per-worktree config files
References: <20180923170438.23610-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180923170438.23610-1-pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 20:25:38 +0200
Message-ID: <87bm8kjeu5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 23 2018, Nguyễn Thái Ngọc Duy wrote:

> +extensions.worktreeConfig::
> +	If set, by default "git config" reads from both "config" and
> +	"config.worktree" file in that order.

How does this interact with config that's now only used if it's in
.git/config? E.g. you can't set remote.<remote>.<url> in ~/.gitconfig,
will that be inherited across the two of these?

> In multiple working
> +	directory mode, "config" file is shared while
> +	"config.worktree" is per-working directory.

"But then how will it work with more than one?" I found myself thinking
before reading some more and remembering .git/worktree. Shouldn't we
consistently say:

    [...]"config" and "worktrees/<worktree name>/config"[...]

Or something like that?
