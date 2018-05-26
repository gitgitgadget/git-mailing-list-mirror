Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCF91F42D
	for <e@80x24.org>; Sat, 26 May 2018 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032300AbeEZSqO (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 14:46:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39112 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032274AbeEZSqM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 14:46:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so2241960wrn.6
        for <git@vger.kernel.org>; Sat, 26 May 2018 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j9sC3kvHf16mfmBjhn0OuHCpvFqcGx01TI/pkg2mrfM=;
        b=Xpshid1eAa4ZHBrWbie/cH5WUodCwDzrVIQQ5iCFmjT4ybZr7lOGUr68wsEA/gv2Yq
         aMHi4l5RLQm6Ekwzsf8Vz3xl66YFObKrTDqt+0m/WfB2eYk+Ni0Kmrywil07SwmnZlbj
         EQtlHuwYMJVaUhzsYk1/0u/JwHQpCX53Bw4DXnsuVllE4Rb6aaNWTj7aoT/RUBT4hqRM
         SLbDj6zMzIzNRvJc+9v1asWcSV6pAUQpghv5ZyGj/37Xq1HIZSh8cxmQXmdnGUtqA0zf
         8rVx++74863B8iqDRqvAL9ir6jg9PpaTBGnQ5s8ylVc87QMJmEvOyGFNBjxMw597fgMc
         jhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=j9sC3kvHf16mfmBjhn0OuHCpvFqcGx01TI/pkg2mrfM=;
        b=RM0hfxTzqln5/taOzHQCtxiqADxLE3/jA/4j1d17tIWr5CHQuAiZhcS1ORN0wtK1MF
         E4smXu9LnOCCnXyXpNMj6iQvDamlEwtT4deCDYvyBl4+wBcuKR9zmSUPhd9kCtPZdv5h
         auXHeVmV0hnrEffLirhz9oXexB7F93oELs0kzAI4rjbuiAUmExkn9x5QSW/33PB8g4me
         VvMGVJe0jbfr/tQV2deOXHG+kFnHllVQLCZfrbz4u2q+HPkJHrt8Yw589RVuJgtWJzQ/
         t47t399YyyKEi0V7awUUH7IbToaZZBrLUA2MsXMkjDWIku9M5k+hRKWIxe+DtW68MEEo
         eMJA==
X-Gm-Message-State: ALKqPweZOU8oTIYq+ImOGNDxHz/UPG//6DqWUl6zoXhmnOgamFYKzKGB
        5fkynwN2oKNb4SXuNamIp2M=
X-Google-Smtp-Source: AB8JxZon/GC0s+G0/O9j3xkRyXUtDZpZKZg+9MYKlD+c/N/2pUV+ObFGSqR9uOTYSa8MgDS2n6Tb2A==
X-Received: by 2002:adf:8290:: with SMTP id 16-v6mr5707758wrc.38.1527360371536;
        Sat, 26 May 2018 11:46:11 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egg40.neoplus.adsl.tpnet.pl. [83.21.70.40])
        by smtp.gmail.com with ESMTPSA id y42-v6sm49090075wry.21.2018.05.26.11.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 11:46:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 02/20] commit-graph: fix GRAPH_MIN_SIZE
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-3-dstolee@microsoft.com>
Date:   Sat, 26 May 2018 20:46:09 +0200
In-Reply-To: <20180524162504.158394-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:29 +0000")
Message-ID: <868t861ci6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
> commit-graph file. However, the minimum number of chunks was wrong.
> It is possible to write a commit-graph file with zero commits, and
> that violates this macro's value.
>
> Rewrite the macro, and use extra macros to better explain the magic
> constants.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index a8c337dd77..82295f0975 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -33,10 +33,11 @@
>=20=20
>  #define GRAPH_LAST_EDGE 0x80000000
>=20=20
> +#define GRAPH_HEADER_SIZE 8

Nice.

>  #define GRAPH_FANOUT_SIZE (4 * 256)
>  #define GRAPH_CHUNKLOOKUP_WIDTH 12
> -#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE =
+ \
> -			GRAPH_OID_LEN + 8)
> +#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
> +			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)

So in this case we have file header (4-byte signature, 1-byte version
number, 1-byte oid/hash version, 1-byte number of chunks, 1-byte
reserved: 4+1+1+1+1 =3D 8 bytes), chunk lookup: 3 required chunks plus
terminating label =3D 4 entries, constant-size fanout chunks, and
checksum.  Two remaining required chunks (OID Lookup and Commit Data)
can have length of 0.


One issue: in the future when Git moves to NewHash, it could encounter
then both commit-graph files using SHA-1 and using NewHash.  What about
GRPH_OID_LEN then: for one of those it would be incorrect.  Unless it is
about minimal length of checksum, that is we assume that NewHash would
be longer than SHA-1, but ten why name it GRAPH_OID_LEN?

This may be going too much in the future; there is no need to borrow
trouble now, where we have only SHA-1 supported as OID.  Still...

>=20=20
>  char *get_commit_graph_filename(const char *obj_dir)
>  {

Best,
--=20
Jakub Nar=C4=99bski
