Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207E41F404
	for <e@80x24.org>; Sat, 11 Aug 2018 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHKLiF (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 07:38:05 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46403 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeHKLiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 07:38:05 -0400
Received: by mail-ed1-f45.google.com with SMTP id o8-v6so5877731edt.13
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7Zk/cspWSYg5Gb5lja3qPIHy43BrtXsfHDfw9lvXjw=;
        b=mI8dJ5g2XlJ+39bujcRr/0Mh/NWdXs2WFe6Fd2GBP4ykTce9N8TKcLztNemlYRlYps
         eCdvjC2e3ffIxJlxF8dqObfG1Kr8ZJb8xj83MgNlqVc8U+zacPVddJ0ZtRw9ZyJdW1e6
         PFTcZ3MQthQEeI48h2MqaUluaQSQQu6jKS6RnRUq9MjODcGJPVp49Gl6oJvZVav4Pr8z
         U/5U/kuJysEoGfZuWlMY9TaeuDn4VEebMPvqPBnatR/KWPfFlmdht4LSeiEOGn/DhUfc
         jEfe8pCsn5pR2gfk+LgKRH1iHuyYRNH/bxrLnX/qm6J6g9pAUo3OIbzgksfjNYPDrm0j
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7Zk/cspWSYg5Gb5lja3qPIHy43BrtXsfHDfw9lvXjw=;
        b=ExaKNfhHQZkXiDAGiBDLdsWF9Mt1WR8MdxFE1+3cwyIgaVL2F/P/Nq8C/jXEgqaugB
         q6s6FA7B2gAIHrXxwiMZVOWOWXEBqlA8lTEICJUuzJQz8AZBpQ2ng9RhsHT3axt70kZX
         XpOUsrOKBQgHhv0DOuNLhSAVsA9tH3qdl/GrOsNFpierFqbeH336MwMJHfC4SZ6Cxe/T
         b89YRiOP7t6EvI5uLN1z2uT8tBIqWdM7JvjKo70RBX8WMDRsLuJpSnOzkEEXskvvfXWO
         uwPDwrBC/VDtsS2FLspzfapJLn+sZvgwyfrsOb0DuxL1V5j9aXJpblcioYeoL0q53B6j
         O4lg==
X-Gm-Message-State: AOUpUlFtL27rkEbrf7pifAcspNLwmpAZhpEH2GutQTCtCB6i4gecGn4A
        DWH+y3DvayL3/0aRrVq1Lxw=
X-Google-Smtp-Source: AA+uWPx88in8Iujl6lHfuklDpdlixYaNKuEWF2yCfCushQtgiYonnRq+Fj0fkSFb5LODgfsy0MTdwQ==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr12422963edj.62.1533978272089;
        Sat, 11 Aug 2018 02:04:32 -0700 (PDT)
Received: from localhost.localdomain (x4db10f1c.dyn.telefonica.de. [77.177.15.28])
        by smtp.gmail.com with ESMTPSA id r11-v6sm4136057edp.60.2018.08.11.02.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 02:04:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/8] Add delta-islands.{c,h}
Date:   Sat, 11 Aug 2018 11:04:18 +0200
Message-Id: <20180811090418.26674-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180809155532.26151-3-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org> <20180809155532.26151-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/delta-islands.c b/delta-islands.c
> new file mode 100644
> index 0000000000..448ddcbbe4
> --- /dev/null
> +++ b/delta-islands.c

> +static void deduplicate_islands(void)
> +{
> +	struct remote_island *island, *core = NULL, **list;
> +	unsigned int island_count, dst, src, ref, i = 0;
> +
> +	island_count = kh_size(remote_islands);
> +	list = xmalloc(island_count * sizeof(struct remote_island *));

Please use ALLOC_ARRAY here.

> +
> +	kh_foreach_value(remote_islands, island, {
> +		list[i++] = island;
> +	});
> +
> +	for (ref = 0; ref + 1 < island_count; ref++) {
> +		for (src = ref + 1, dst = src; src < island_count; src++) {
> +			if (list[ref]->hash == list[src]->hash)
> +				continue;
> +
> +			if (src != dst)
> +				list[dst] = list[src];
> +
> +			dst++;
> +		}
> +		island_count = dst;
> +	}
> +
> +	island_bitmap_size = (island_count / 32) + 1;
> +	core = get_core_island();
> +
> +	for (i = 0; i < island_count; ++i) {
> +		mark_remote_island_1(list[i], core && list[i]->hash == core->hash);
> +	}
> +
> +	free(list);
> +}
