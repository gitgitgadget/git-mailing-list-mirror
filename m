Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55DC202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 17:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbdI1Rix (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 13:38:53 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:50206 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdI1Rix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 13:38:53 -0400
Received: by mail-pg0-f48.google.com with SMTP id p5so1319804pgn.7
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmLWM2qJFkfO/NLlnOcJ2S1dzY9S/1+74u4opDoRS/w=;
        b=gGZgi+1p6FY5esqXYYigFlssnxOGOscph0NC/cF1ariDfKqlVvbpGkDtWhkGUevEVF
         bgFT/npmGdfjFTIGQAMVmU9coXVOH+iitvPctc4I74JQ1hJ+svOuN8OOdQAcszfMfiE6
         fax9UcaT6dAxxXB2zrLoZZRwvOsG23snCTs7oaPxLH5gNdTI3EjjH3aa6ZT8TzXxWRKM
         IkSSG2NbDlZ6Qc/hN68dBWd3iupK727rAegJ9HrqE9r2NXpo7wGag6GkUtQHY7cINqRc
         cdqCD5QmNqGdTBGbj4jw3SeWQ5CicA6RjrKNxL8zULky8eReST82f0Y24j7MomnzQ6sF
         /hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmLWM2qJFkfO/NLlnOcJ2S1dzY9S/1+74u4opDoRS/w=;
        b=MrjY2/ykabV4K13JdDRciFQNs06WJzjhiLObGv5fv0UEiVjyT8Jvrd0iEVgkUfIjoP
         738dWfUkkjwB2p40RzU92GwOnTypABqA4u2+l0Cl2Q7PSnv8mK8Hun977YExoIcguy08
         3J86bLMcIGf0Hbp51WFSppB/fj7XEe+E1nA4WeZmetqkPbGfT05cs7Q11P9VSV8Lp7yf
         WPM/ApAAJkTaivm++HnkcN2BgzyRGda2g5WawXG0WOsUM6LpsJlaxFNCVOpQtANHiqRF
         qJmf1zXy1qMf4PokbNy32iVbURizBnYM4Pa3NXGX/XCXbPe9BbXbWsq7X767v7qdjaTr
         6F0w==
X-Gm-Message-State: AHPjjUgB1+ueOanVy/h40DivfgAzgCvF0bJ18ZEEf6pAgxtNoEpPNtvZ
        2C/TzHoJ9ZODJyk1PInjvB0tPA==
X-Google-Smtp-Source: AOwi7QCUraVMeLcTpMI8WxLrF11gUOQG0/l/1B33KNfQQOx9vV5exGocgW7ltf4nMBg/qH7UzfXdpA==
X-Received: by 10.84.129.229 with SMTP id b92mr4734888plb.362.1506620332477;
        Thu, 28 Sep 2017 10:38:52 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:6d10:3370:77a8:b2d0])
        by smtp.gmail.com with ESMTPSA id t17sm4367088pfi.31.2017.09.28.10.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 10:38:51 -0700 (PDT)
Date:   Thu, 28 Sep 2017 10:38:50 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-Id: <20170928103850.449bd743d5f10f2c948b0c83@google.com>
In-Reply-To: <xmqqr2ur348z.fsf@gitster.mtv.corp.google.com>
References: <20170927221910.164552-1-jonathantanmy@google.com>
        <xmqqr2ur348z.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Sep 2017 12:13:00 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > This is similar to using the hashmap in hashmap.c, but with an
> > easier-to-use API. In particular, custom entry comparisons no longer
> > need to be written, and lookups can be done without constructing a
> > temporary entry structure.
>=20
> A na=EFve question is why this needs to duplicate so much code, just
> to build something similar in spirit to hashmap but unlike hashmap
> that can take caller-defined keys, limited to using oid as the keys,
> instead of just being a thin API wrapper that uses hashmap as its
> internal implementation detail. =20
>=20
> Is the way hashmap API is structured so hard to use it in such a
> way, or something?

Another reason that I probably should have mentioned is the opportunity
to save 4 bytes. I didn't mention it in the commit message at first
because I felt that the benefit was very specific and, as far as I know,
wouldn't be seen on architectures with 8-byte-aligned pointers until we
change the hash function. But I should have probably written something
like this in the commit message:

    Using oidmap also saves 4 bytes per entry, compared to hashmap,
    because the hash does not need to be stored separately as an int.
    (However, alignment considerations might mean that we will not
    observe these savings until we change the hash function, since
    currently 20-byte hashes are being used.)

If we decide that the 4 bytes are not important, right now at least, I
can change it so that this is a thin API wrapper over hashmap. We could
always change it later.
