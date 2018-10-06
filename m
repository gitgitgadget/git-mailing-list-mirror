Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15F41F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 16:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJFXNj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 19:13:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35550 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXNj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 19:13:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so16448402wrt.2
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RhaPtLfOQY1NFg6GbiGiPGsBKsEXgSYEGwuUUp4dY+k=;
        b=SBpH55CxPtb9Luett8p7t8KkUCsqhJH00NUW02mRcT3QO7MkojeDKeS5ubs+Ateid1
         047GVlwp4d8V8VT7qu7QCTUS+GU1TI9I50PAJVFPswruANYPyvgmNnvorZJZfU+yuXX9
         yCuP4Zm7vT+Dg6FJE+X021FVo0ZXxhRQEqvmYs1VZSoJrEHauC25oube6Y44TBvH4jhw
         j6WPsWjY8QBbfdTBcqPdpdBsD7NhcNTk891GEKMXJ9BHOGZ/IcOQDUML2RDH0VKIuxut
         gzSEAUAe5qOzeYzz6XyWxoBgxz2/67DZDmm8XoOjnV08DSOPXzu7pdnii5Dw5WfuUu82
         JBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=RhaPtLfOQY1NFg6GbiGiPGsBKsEXgSYEGwuUUp4dY+k=;
        b=cJlCL8V1RlHgjfDezXXIPROE60z5G4KuDyXVhbOvIsamkc5PYu8I+R+S9pF+oQc8Cg
         zJhxuU6ATI3PlKp9nb6tyX7KabLPmD8phLbFxmGmxqS28eIRD2FLSeJKJ3vOFMGTKBq4
         GJq3p5cZXfUFC6u4cFnd58xZSXjvWTI5vHqXhBANa0QbeW2vruU6tbEu8mF8tTjwleT3
         UrZ364Q0IK6dKHke0Mt43x2BL4A3o+snm9MbVgjAtm5OKCmvMg47JhIbIutidZVlecK5
         WjF9EYO1DWjIrn+c5k/kpXm7jnaqYwGcXubG3yIxZXvG9hLGjwlEXEkpqXA153k36Txn
         //tA==
X-Gm-Message-State: ABuFfogd1A5eToroM1aTTvZ3ABsJBFepuFDj5W3q1bqYyxYJDjUo/q+1
        pQBp20H6bBSzilMIKfCwDkE=
X-Google-Smtp-Source: ACcGV60caTjx47Z77NT+LtARr3ffkX7RhZ12qNDOf/PR1jpVyprbQmvmWzAaY5d03z1AotQBdjp/9g==
X-Received: by 2002:adf:91e4:: with SMTP id 91-v6mr11695918wri.97.1538842184497;
        Sat, 06 Oct 2018 09:09:44 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (eka203.neoplus.adsl.tpnet.pl. [83.21.168.203])
        by smtp.gmail.com with ESMTPSA id z184-v6sm7901216wmz.0.2018.10.06.09.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 09:09:42 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@microsoft.com>
Subject: Re: [PATCH 0/1] v2.19.0-rc1 Performance Regression in 'git merge-base'
References: <pull.28.git.gitgitgadget@gmail.com>
Date:   Sat, 06 Oct 2018 18:09:40 +0200
In-Reply-To: <pull.28.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Thu, 30 Aug 2018 05:58:07 -0700 (PDT)")
Message-ID: <865zyfys3f.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As I was testing the release candidate, I stumbled across a regression in
> 'git merge-base' as a result of the switch to generation numbers. The com=
mit
> message in [PATCH 1/1] describes the topology involved, but you can test =
it
> yourself by comparing 'git merge-base v4.8 v4.9' in the Linux kernel. The
> regression does not show up when running merge-base for tags at least v4.=
9,
> which is why I didn't see it when I was testing earlier.

Strange that it happens; I'll take a look.

> The solution is simple, but also will conflict with ds/reachable in next.=
 I
> can send a similar patch that applies the same diff into commit-reach.c.
>
> With the integration of generation numbers into most commit walks coming =
to
> a close [1], it will be time to re-investigate other options for
> reachability indexes [2]. As I was digging into the issue with this
> regression, I discovered a way we can modify our generation numbers and p=
air
> them with commit dates to give us a simple-to-compute, immutable
> two-dimensional reachability index that would be immune to this regressio=
n.
> I will investigate that more and report back, but it is more important to
> fix this regression now.

I am interested in what you have created, especially because commit
creation dates are imperfect indicators because of clock skew etc.

>
> Thanks, -Stolee
>
> [1] https://public-inbox.org/git/pull.25.git.gitgitgadget@gmail.com/[PATCH
> 0/6] Use generation numbers for --topo-order
>
> [2] https://public-inbox.org/git/86muxcuyod.fsf@gmail.com/[RFC] Other chu=
nks
> for commit-graph, part 2 - reachability indexes

Since then I have found few more possible approaches:
- working with repository metagraph[1], where all chains of commits were
  replaced by edge, perhaps together with DAG Reduction[2] boosting
  framework on this metagraph
- using FELINE-like index (the Graph+Label approch, also known as online
  search), and for those where this index have false results, use Labels
  only approach[3]

[1] Xian Tang et. al., "An Optimized Labeling Scheme for Reachability
    Queries", CMC, vol.55, no.2, pp.267-283, 2018
[2] Marco Biazzini, Martin Monperrus, Benoit Baudry "On Analyzing the
    Topology of Commit Histories in Decentralized Version Control
    Systems", ICSME 2014 (conference paper)
[3] Junfeng Zhou et. al., "Accelerating reachability query processing
    based on DAG reduction", The VLDB Journal (2018) 27: 271

--
Jakub Nar=C4=99bski
