Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E361F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJQHeX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:34:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50432 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQHeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:34:23 -0400
Received: by mail-pg1-f201.google.com with SMTP id r16-v6so18483486pgv.17
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HXO+ymd4hvejkT2LVUQIS40ii5FqVe6kiJbuFH9OZXI=;
        b=U8xajiLYOGJokvb24hzNMZ6jCOynzTgXVseqIt62o5La/C4PfIntsYVHL+ShRqctY3
         IvkfuROXMepIgZnWfeLo7ZEy5V5igARcyo+hp/tpmNIVhZT/aYL/kuFrm5L2Y/uULf2b
         6aK4hzechiluRS1VORYb3JWaQWa6dw9xk4Sy9H8c3tc41D75LJeYpFqRaUnzUrmvnp02
         jcBq77YPGzoZ6KJgWX4uAWvfLdgsEg08HBcIuDROcqpPYSX89MbgKHWxNixMnnqJs3A+
         nlm3V20XQS1GccqhmJBVNiImbqf8nzAsQ/c8Rb62BAqRFuGV2jjFsrWJlxFIPw74+F0q
         GImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HXO+ymd4hvejkT2LVUQIS40ii5FqVe6kiJbuFH9OZXI=;
        b=l2D+j7gpnqf9y/50cWYKPEYYKTIw0QK6RsbovyxjDHqzhEeRk662OBNll6MBrO8xYS
         JfTwZ3fLGD76y/KYsKS6CBZCq5X0z4GRprqOSFTihFav3nvli8mlmPevssFjDbNND2l9
         HgZdhMErmHQe+i1lj2vfOBvPv00+j0McU7ho2Ob7gLbOIYD3MAErWorK0d7iAViWghqs
         o3aK1h9HPFcfekiPt1fgyVh9iFn03d1Lu9XYiH7UlSy2fzlO4skMLo7xxjLBREPLNDvs
         VVqBJ6AXXItzFw0CpIW0nSURJzqCYdA9MG4FdupoF725PL8VBPMaGDguyya6n2lk0yBJ
         2D2A==
X-Gm-Message-State: ABuFfojJHz4F3lbRLDGukhuCnlFC9yzWRjQn4ojkgm6lArO8ykswrTMK
        nyeU1MXqHfu7WugNRW8sv0qaSQDN+qdvIkhEhdeG
X-Google-Smtp-Source: ACcGV61XPywmDyeBELCffUuyZfZz3oUIM9Z+czItBi7n5/2x3HGIkdnzB57Y8WWjfz421j9BMIwd5EqwYuidRSLczy6x
X-Received: by 2002:a63:c40e:: with SMTP id h14-v6mr11554879pgd.53.1539733297234;
 Tue, 16 Oct 2018 16:41:37 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:41:29 -0700
In-Reply-To: <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
Message-Id: <20181016234129.194138-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 0/4] Bloom filter experiment
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> | Implementation | Queries | Maybe | FP # | FP %=C2=A0 |
> |----------------|---------|-------|------|-------|
> | Szeder=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66095=C2=A0=C2=
=A0 | 1142=C2=A0 | 256=C2=A0 | 0.38% |
> | Jonathan=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66459=C2=A0=C2=A0 | 107=
=C2=A0=C2=A0 | 89=C2=A0=C2=A0 | 0.16% |
> | Stolee=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53025=C2=A0=C2=
=A0 | 492=C2=A0=C2=A0 | 479=C2=A0 | 0.90% |
>=20
> (Note that we must have used different starting points, which is why my=
=20
> "Queries" is so much smaller.)

I suspect it's because your bloom filter implementation covers only the
first parent (if I'm understanding get_bloom_filter() correctly). When I
only covered the first parent in my initial test (see patch 2 of [1]), I
got (following the columns in the table above):

  53096 107 89 0.001676

Also, I think that the rejecting power (Queries - Maybe)/(Total tree
comparisons if no bloom filters were used) needs to be in the evaluation
criteria somewhere, as that indicates how many tree comparisons we
managed to avoid.

Also, we probably should also test on a file that changes more
frequently :-)

[1] https://public-inbox.org/git/cover.1539219248.git.jonathantanmy@google.=
com/

> The increase in false-positive percentage is expected in my=20
> implementation. I'm using the correct filter sizes to hit a <1% FP=20
> ratio. This could be lowered by changing the settings, and the size=20
> would dynamically grow. For my Git repo (which contains=20
> git-for-windows/git and microsoft/git) this implementation grows the=20
> commmit-graph file from 5.8 MB to 7.3 MB (1.5 MB total, compared to=20
> Szeder's 8MB filter). For 105,260 commits, that rounds out to less than=
=20
> 20 bytes per commit (compared to Jonathan's 256 bytes per commit).

Mine has 256 bits per commit, which is 32 bytes per commit (still more
than yours).

Having said all that, thanks for writing up your version - in
particular, variable sized filters (like in yours) seem to be the way to
go.

> We'll see how much time I have to do this polish, but I think the=20
> benefit is proven.

Agreed.
