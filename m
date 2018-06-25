Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2539B1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbeFYXDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 19:03:16 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:47017 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933257AbeFYXDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 19:03:13 -0400
Received: by mail-yw0-f201.google.com with SMTP id v80-v6so12116831ywc.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Hcq9sGFq5Oir3NSuaOOpVfuxk3yInSPvWq9HlYm0phU=;
        b=pEagv4pEjp3eq7jjpBnw/tOGTOz97LZDrZqPzUtcESkmIZXTKhJFDg87UPzvipmeYO
         DhcBxk0UfvnUeGhiAuXLNGAouHHki8x0+8ykg2YXhtVZmsJg2i2AQ764kxw1EZWTnxk7
         sdhFUw/Qlxfx/f2hQ1sfGHeJkMfWPkTWvorNMDai+77ZFYv4CGBS4ruV5vD+pW6kHHXe
         FNL3c9S5Vu0hvItyTAMDPGYsrRZy7dZobPU3oFzcJ6gGjObHsoZk9qYack/TceCOIi0T
         MhDSFw2hF7VhXH2ND/j+uI5+kAsH8g/Me0Kj1hFRxNK9LDw7BvwEomVmIIH5s+m8kD4/
         ITlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Hcq9sGFq5Oir3NSuaOOpVfuxk3yInSPvWq9HlYm0phU=;
        b=D9gtlwPlWq4RPyUHiSLMArKdyJnkYNdblllrmzwWd8sjFBFidiDd90uydA6lOHpPGy
         z2QN6FLsxgQhGWL6ENMMn7PVPwpqC2XYMJ/GhPjJFIgCpW8iwThbQvkyzcIlAiAWtvIS
         mEOfpuZgdEJLujD26SaH6+yhFSoYuo+2LowhKcGV5kRnINeJ1Ahfw5pTcS2NS0k/V0Xp
         EhAtjyp9vNylcH1xteM7InnpsPFFx687n7FqyDbhuUWGrxBxTAU/i1TAFujH19afYVlT
         rK3HhWVGvE8KVo9WW4n5ZrVphVNbwkkTiZssPvUsLL1CEfYXZ+TuODWRf0ttI8ntPozX
         128g==
X-Gm-Message-State: APt69E1Ko5iiuysD5wnpiN+6CImrr7cQGaxGh4M+9wtdo1qWfsLmo/Sf
        jLkQa/lMlo5S4DoFi6nCXpuEbvu3uySJGXzxWjEU
X-Google-Smtp-Source: ADUXVKIa6wbXu+Xao46Oo0kFpIQUt2xOo+xoefKADc+8Tdr6XJuNhqEbNuNI3FgONQbGy7p3zJhwhTmw3FthwuZFib09
MIME-Version: 1.0
X-Received: by 2002:a81:7305:: with SMTP id o5-v6mr4343885ywc.118.1529967792989;
 Mon, 25 Jun 2018 16:03:12 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:03:10 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180625230310.210182-1-jonathantanmy@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v4 0/8] ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Changes in v4 are fairly minor.  There are a few documentation changes,
> commit message updates, as well as a few small style tweaks based on
> reviewer comments.

Patches 4 and 7, which I have commented on previously, look good.

As for patch 2, it still has a missing period in the documentation that
I remarked upon in [1], but I'm not too worried about that. Having said
that, Jonathan Nieder suggested [2]:

> Stefan mentioned that the spec says
> 
>         * The server MUST NOT send any refs which were not requested
>           using 'want-ref' lines.
> 
> Can client enforce that?  If not, can the spec say SHOULD NOT for the
> server and add a MUST describing appropriate client behavior?

I noticed that you did use "SHOULD NOT" instead of "MUST NOT" - in this
case, you should probably also follow the second part about appropriate
client behavior - it's probably best to document and implement that we
ignore all unwanted refs. But considering this situation, though, I
think it's better to just put "MUST NOT" and have the client enforce
this.

One more thing - I think that the fetch part needs to be tested more. In
particular, test cases similar to that of the upload-pack tests
(multiple ref names, ref name + exact SHA-1), and in addition, handling
of wildcards (for example, a wildcard that expands to nothing and a
wildcard that expands to 2 refs).

[1] https://public-inbox.org/git/20180625174056.53053-1-jonathantanmy@google.com/

[2] https://public-inbox.org/git/20180622230119.GL12013@aiede.svl.corp.google.com/
