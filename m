Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718451F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeC3NZl (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:25:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50377 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeC3NZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:25:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id l201so15626841wmg.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DSmlnEutKnF8iq8WUzLKsjp/n8OS9bH5J9VGV0wuozc=;
        b=A1fh0g7XokfuetI0pZIFlVE4cVx0I+btKy/etQBbWZ4uwrhcaVzQ8N5eTVZlQOa6iF
         TxPmVWipAOpO5QExyffb5we6fFIAEbesYnUsmFXzx7NimdrjEqStt94gESheh182JN2w
         1DpvwI+JI9l5N4ovdHvcoTm6Er1IV/SG8x4rPQ9nX1Q+Of1UKx9aSDjvDm154eIEfeKg
         j7ABN2OU9XqoNFvMM3aD6NhP4n/OWEWaUHeWLgLctsvtVqqMv5nb+Pi4H+LdiF7v//0k
         f07Kvwq1NZRSjY5rQ1DHQg99stsJgorSaVFnl6EeMXg4bfCMpTrHY/atVozcmz9CM/WY
         AnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=DSmlnEutKnF8iq8WUzLKsjp/n8OS9bH5J9VGV0wuozc=;
        b=ORi3kGsniTKmxJLdQvCapGQBKJVwlHkCuHCXfPn5yO53A8DjT4xK2f9uj/qOWNmdCl
         ivfDbEwRclS162kRAJlI52UmEUtMXF7cM1iPWAsvASYO4Ri+u9fmjawqQXlBgDtCTsGw
         Kei188M07z2RbpUZwqT2k0fgKE5QJoP43QCxIw9/tXCnD2QyqnOL1LFZXvdbe1yA6NJP
         WVgpx3lVoUXB4qlTPKUGlNXXBwB0+Admd9G1A7OCi7vYY86udSdGrwe3hiuKw36PatMg
         6BH9mN1leCE4pF4JFJ+34U1VSuhqy2Y7itG0k9T9+8+M5jGvE/NIF5fnx2MmlidS7CGW
         2KDg==
X-Gm-Message-State: AElRT7FQF9K4rlMG5oP2PhOaAxZ80l0tFVs3zCNahxAFWWcXcnISZEzx
        e+YgtMFu15sptvnuxGUfewY=
X-Google-Smtp-Source: AIpwx4/n7znBfe8PNdRF5+lWGY0nZBm2UOOhGuZl1leQb/bL4Re/OgLgVrwEQ8h1e8mdaE6yV2IsIw==
X-Received: by 10.28.10.83 with SMTP id 80mr2508452wmk.70.1522416338578;
        Fri, 30 Mar 2018 06:25:38 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (agd201.neoplus.adsl.tpnet.pl. [83.25.159.201])
        by smtp.gmail.com with ESMTPSA id k14sm11469449wrc.62.2018.03.30.06.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 06:25:37 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
Date:   Fri, 30 Mar 2018 15:25:34 +0200
In-Reply-To: <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:14 -0500")
Message-ID: <86370hk84x.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +=3D=3D graph-*.graph files have the following format:

What is this '*' here?

[...]
> +  The remaining data in the body is described one chunk at a time, and
> +  these chunks may be given in any order. Chunks are required unless
> +  otherwise specified.

Does Git need to understand all chunks, or could there be optional
chunks that can be safely ignored (like in PNG format)?  Though this may
be overkill, and could be left for later revision of the format if
deemed necessary.

> +
> +CHUNK DATA:
> +
> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).

All right, it is small enough that can be required even for a very small
number of commits.

> +
> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +      The OIDs for all commits in the graph, sorted in ascending order.
> +
> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)

Do commits need to be put here in the ascending order of OIDs?

If so, this would mean that it is not possible to add information about
new commits by only appending data and maybe overwriting some fields, I
think.  You would need to do full rewrite to insert new commit in
appropriate place.

> +    * The first H bytes are for the OID of the root tree.
> +    * The next 8 bytes are for the int-ids of the first two parents
> +      of the ith commit. Stores value 0xffffffff if no parent in that
> +      position. If there are more than two parents, the second value
> +      has its most-significant bit on and the other bits store an array
> +      position into the Large Edge List chunk.
> +    * The next 8 bytes store the generation number of the commit and
> +      the commit time in seconds since EPOCH. The generation number
> +      uses the higher 30 bits of the first 4 bytes, while the commit
> +      time uses the 32 bits of the second 4 bytes, along with the lowest
> +      2 bits of the lowest byte, storing the 33rd and 34th bit of the
> +      commit time.
> +
> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> +      This list of 4-byte values store the second through nth parents for
> +      all octopus merges. The second parent value in the commit data sto=
res
> +      an array position within this list along with the most-significant=
 bit
> +      on. Starting at that array position, iterate through this list of =
int-ids
> +      for the parents until reaching a value with the most-significant b=
it on.
> +      The other bits correspond to the int-id of the last parent.

All right, that is one chunk that cannot use fixed-length records; this
shouldn't matter much, as we iterate only up to the number of parents
less two.

A question: what happens to the last list of parents?  Is there a
guardian value of 0xffffffff at last place?

> +
> +TRAILER:
> +
> +	H-byte HASH-checksum of all of the above.
> +

Best,
--
Jakub Nar=C4=99bski
