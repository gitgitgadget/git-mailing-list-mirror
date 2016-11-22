Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F6D1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbcKVUDf (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:03:35 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35302 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756709AbcKVUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:03:34 -0500
Received: by mail-qk0-f181.google.com with SMTP id n204so40957102qke.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 12:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P2iz1GHUsRN7RrHi4c4rMuoipRBaHOoNRL9elL33N+s=;
        b=pH1Juf09TAfjL1+kr/GIKTP0YR1h47gr/FJ6vV/UV6brwjLT5Sg/t/7sA+B6bLvFom
         Gk7fdoRESZbjyABJKUy5Pqz7/GwGt4FIKpewuW7i7FHklFlyUJ3+s2YImZq5JdxP1nkN
         qzY4ji+AIscRukNVygZ0deWULjzVuK3BuGyQBsowreMfcSWm0sV4xtlUemPP6p6Ny1rc
         pf4JmKJ1Qdx1rqAk/J5TBEL+KrShkTTumMEUHD3LdmvIITjYVMoHerf4I7HuhGe0OBeP
         xjZGptu6OR8fnhzXCqDGu24p5Z3Wf8nGbF+NwQgzbrL7jjIfCGhJk2WJgnRbJ8KheDNs
         ePug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P2iz1GHUsRN7RrHi4c4rMuoipRBaHOoNRL9elL33N+s=;
        b=PMtlCa1Em0MblRnL/wCRSUD5wi5LvTgfCWHhaOy8W83GbiQEbcSBQ9az6wnC9q8Ryq
         YjycuvfyETWlwFeenC4C4VcMsQitvhFr6FxSMgEyOspVgSkLhw2oVTeT/JelIfGPA6ns
         ytaFVS+Bue6G2Z0DEVt9sHcHJE1YHG7lvFFbwge6K6oJxfeRHcV9+/jwub9CuXbydjtk
         8GjYgBMLtNE4o1qijNaOdkzVRfxRQEhFgXuVgjv4hOpkJH1RgETqKjBb+vC+sXak0F5C
         yfyD55I2QTFEkdDZIxxJK6GcfufAA9feBxtjscSHlP2zXh3jW6za5+mDR/DnGby6Oqwi
         KlmA==
X-Gm-Message-State: AKaTC01uiNENC5e1frpOn7+yGdrsQ02jWaZB8eDMIOqa1ALa1C5zudhu7ywZdJqdQ2Q2S0LLY+YD8M030GU21ds5
X-Received: by 10.233.216.196 with SMTP id u187mr23534422qkf.220.1479845012250;
 Tue, 22 Nov 2016 12:03:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 22 Nov 2016 12:03:31 -0800 (PST)
In-Reply-To: <xmqq8tscgp75.fsf@gitster.mtv.corp.google.com>
References: <20161121232709.8906-1-sbeller@google.com> <20161121232709.8906-3-sbeller@google.com>
 <xmqq8tscgp75.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Nov 2016 12:03:31 -0800
Message-ID: <CAGZ79kavcVs2utBut=tHaKoWzRJSEwBpEjZR9Eh=BbH8Bh_NiQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to commit_or_tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 7:37 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Doesn't (the) "above", aka submodule_from_path() want the same
> treatment?

fixed in a resend.

> I do not think the commit-sha1 (or commit-or-tree-object-name) is
> "ITS" object name for the submodule.  The name belongs to the
> containing superproject commit (or tree), no?
>
>     Given a tree-ish in the superproject and a path, return the
>     submodule that is bound at the path in the named tree.

I'll take this.

>
> is what I would write for that one.  Thinking about it a bit
> further, "treeish_name" would be a much better name for the variable

ok, so treeish_name it is.

>> +'
>
> Perhaps also test a tag that points at the commit?

will fix in a resend.
