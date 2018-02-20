Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C147B1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeBTUtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:49:08 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45320 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBTUtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:49:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id p104so16827038wrc.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aUzodbCUqVGEqO/qVRo+dmG/y49FEpaEDj6hMMSXceQ=;
        b=IyKy+xOP03a3sKYFJMDR4wXeW1HHUXhHfJYprbvSVAzCqsaNR8yQkie45XuJiARN5Q
         HkX3pi+7gBTKwxfEq5TeimNZEa+OS2j2zKwnYwaRmripU+ccQODHAWgQ5sP6PNXoF4ct
         fppMFk/gFuKspSIJlRDOvyTGyCqb6CZk5+uYITtF2nU+eaqfi+LSbEitXLMP2HVUnjb3
         VvsiwP1p85PxzqR5e9AjniIhHhe3qJdgEkgBL4SI2uEoBijCzs7DJi66WN/WQRurMS6Y
         XdtRgGsC00ryyr1r9dQp/4tEcE47wp/4k0z8TB2S7xtV7GuHhTV4TJtVZZHIEY/n86Ex
         NXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aUzodbCUqVGEqO/qVRo+dmG/y49FEpaEDj6hMMSXceQ=;
        b=d51TiDjB8dqaiTPlxj7JN1G6qQChTGUIDngriePUuvTFe3KZZVcA+ijSShscpdyqaI
         EaGyOGKNRrrVCZ5GfddyX7LEDaUwz2YBD8ll1w/SyQ1Rw50np5uAVC8js6kayeCdS7h5
         FR/osjJvTFS7nthbv6LUv9HgtTpcm8odGAgvIqmTDd+ptDxrNBZqyzhNI84KU3j4j1PL
         Hr3GPViv6+MeAVFCo65jbcI/6vj73aeVXhfkHlXnh16HQGi/1dfxL7Vt1R1mfIcBOm/a
         mhXZ70v/x86maLP5TcqtZznmpSI+/4q7zo5hQZz11t5PQI/7P9Yp8k4sYYRf5sqkBAhc
         chOw==
X-Gm-Message-State: APf1xPBM3jkCcXZSI1O9eIcN7HZmCNpZkJ11SI8hJqZ21GbOczEJRess
        gKY27CVWFqY5YxJ+qm91IS4=
X-Google-Smtp-Source: AH8x224HLDaTH0zgOQv3ad/VCg/t6c5zTDdC1xL5l/hI2Ib9j9HkUNVvNYbYrqbm1JgoCtgQdjaBjQ==
X-Received: by 10.28.91.17 with SMTP id p17mr214792wmb.151.1519159745986;
        Tue, 20 Feb 2018 12:49:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 2sm24696098wra.58.2018.02.20.12.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 12:49:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
Date:   Tue, 20 Feb 2018 12:49:04 -0800
In-Reply-To: <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:14 -0500")
Message-ID: <xmqqa7w32xq7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>  Documentation/technical/commit-graph-format.txt | 90 +++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/technical/commit-graph-format.txt

Hopefully just a few remaining nits.  Overall I find this written
really clearly.

> +== graph-*.graph files have the following format:
> +
> +In order to allow extensions that add extra data to the graph, we organize
> +the body into "chunks" and provide a binary lookup table at the beginning
> +of the body. The header includes certain values, such as number of chunks,
> +hash lengths and types.

We no longer have lengths stored.

> + ...
> +  The remaining data in the body is described one chunk at a time, and
> +  these chunks may be given in any order. Chunks are required unless
> +  otherwise specified.

It is good that this explicitly says chunks can come in any order,
and which ones are required.  It should also say which chunk can
appear multiple times.  I think all four chunk types we currently
define can have at most one instance in a file.

> +CHUNK DATA:
> +
> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).
> +
> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +      The OIDs for all commits in the graph, sorted in ascending order.

Somewhere in this document, we probably would want to say that this
format allows at most (1<<31)-1 commits recorded in the file (as
CGET and EDGE uses 31-bit uint to index into this table, using MSB
for other purposes, and the all-1-bit pattern is also special), and
when we refer to "int-ids" of a commit, it is this 31-bit number
that is an index into this table.

> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
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
> +      all octopus merges. The second parent value in the commit data stores
> +      an array position within this list along with the most-significant bit
> +      on. Starting at that array position, iterate through this list of int-ids
> +      for the parents until reaching a value with the most-significant bit on.
> +      The other bits correspond to the int-id of the last parent.
> +
> +TRAILER:
> +
> +	H-byte HASH-checksum of all of the above.
> +
