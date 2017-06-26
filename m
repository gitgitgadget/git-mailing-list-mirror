Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9AB1207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdFZT2l (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 15:28:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36029 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdFZT2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 15:28:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so1446935pfk.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SNF66nNOnEzjEFFgpInycWSJjVBPq6sao+P5W90DTR8=;
        b=s6Av9ETdpbYQXh1Eq/9WTf/2kfNQ8nSQNgTlns9FskPbj+L4iaolVgp+N7KPiMMk0k
         Qkpt8GeQjMBLVA9mmkCDWp4P4wlnjRZqFuqnmoLtnPj+ZQfyZkTYj9XmkuGkDXpBGpWq
         DfMxwYsJm8hnEyOns5OvnySGzzEA6plEK67gB3pu1er17nMQzJo5l+AysPrzW/kup/wG
         l1x2iRJUEmU3/b8sKEFdLNO6BO4ja9/8NIP3zyOMOToHB8Vj7jE0kXExh5qWZqSDUvSU
         XcFWlCCAESnahsVxklIToSnm+iX9D1L9tfk/1FwWFtSv19N1cUJsBW69psD5v1qOEGVj
         +WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SNF66nNOnEzjEFFgpInycWSJjVBPq6sao+P5W90DTR8=;
        b=QfoEeRS9UdSFSmwojwU5mByVqkqPUo5R8OjGap65pA+AuF8rUq7fl7hxxAxd3UARTu
         O3pxjzGlAKzJCHuCubxARNfStVowl1qPBP0Y2TDINFu09bQ3/1FCLt7okELbOzsOGCNS
         SHs4wMipffYnXCaOYpPQgOjBBtEsNbmhSj1fYQZWoY/XUnx3hqkTyuXAEebL7GI3IE9K
         aO9mZPQjOt/8xYqaX7Ir2EEW7a7UAo6MT4M3hfFA/FxT2vgA9TU6p3xMZLKv+0ApuVv1
         XeMFIgHs7iciRWoeA24Q6gVK7YWJsN//m57v0vH2CanU428ZJfNYVNRWiYfzMkCRtzNq
         hdYw==
X-Gm-Message-State: AKS2vOzbTHZ2kIPXgkPx2uUKUD411ByDmd2sFih4jHbj5zxaHnjcYGMH
        LpM+Z+G0P35NYA==
X-Received: by 10.99.168.5 with SMTP id o5mr1600729pgf.33.1498505317425;
        Mon, 26 Jun 2017 12:28:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id t11sm1558230pfi.66.2017.06.26.12.28.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 12:28:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH] proposal for refs/tracking/* hierarchy
References: <20170623135230.10534-1-jacob.e.keller@intel.com>
        <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
        <aa8a7ff6-2068-645d-061e-3142760a4b2a@xiplink.com>
Date:   Mon, 26 Jun 2017 12:28:35 -0700
In-Reply-To: <aa8a7ff6-2068-645d-061e-3142760a4b2a@xiplink.com> (Marc
        Branchaud's message of "Mon, 26 Jun 2017 14:06:15 -0400")
Message-ID: <xmqqvani4kgs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> OTOH, we shouldn't need to do any conflict resolution on these
> "tracking" refs:  The remote side should update the refs
> properly. Nobody should make local changes to these refs.
>
> I guess I'm advocating that git should only allow "tracking" refs to
> be updated by a fetch, or a successful push of a local, non-"tracking"
> ref.

I do not think anybody is imagining new things to happen inside
refs/tracking other than by fetching, just like refs/remotes/ refs
behave like so.

What I was discussing was mostly the step next to the introduction
of tracking/.  Some things are useful merely by existing (e.g. tags
you got from remote, as long as you can easily refer to them, are
useful to you).  Some other things are cumbersome to use until you
manage to consolidate your views with theirs in order to make
collective progress, and they require merging (e.g. notes).
