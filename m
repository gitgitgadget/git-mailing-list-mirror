Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF4C209A6
	for <e@80x24.org>; Tue, 27 Sep 2016 10:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbcI0K7M (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 06:59:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34558 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbcI0K7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 06:59:10 -0400
Received: by mail-io0-f193.google.com with SMTP id y139so693339ioy.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IPX94FXYexk1APEldcML8djOeU2iSdpBuEVgt9Xx6Wo=;
        b=xclNxSLgEz1KqyUkj/s8NipLWp1FSZ2sd29HF6Aiy50FygGwJLQb6OY/e91jZpXckb
         OMtpq8vKbgyJuzvpjiqFdj1mXPYIqtbg8HFDbS0tIzGv77jycrHcXAoYbkLJnzV+NxFj
         e14oESXEAdTug5ICALVPePxRrkbRyb21BtzV3HGBflCSlvVKbnVPeE7OYEU7xqJdnJ29
         bueBgtQErhqdFsE5suVfBsRFR7u9WpDbArZmb7vT4R5aS23QBzhA4uDbdyAJMahvi+ib
         TB3I1ViBdQBMGSjhQMNAKJDrhgQYCB6Nfc2oYispImhad/PLm6Xf1/J2hapdv6aTIDBn
         JHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IPX94FXYexk1APEldcML8djOeU2iSdpBuEVgt9Xx6Wo=;
        b=fQG34jqt5PlWOmfTp1jddla7CaJ75RsAA4nJ87RBpQVNspcSkvDecl8hRErjvP5PCs
         2TTf7MYOG5JgxaI2PBi9WEO/xySV4sllXEdkQFjLNC9qYxKU4S+ckUsjDonKrBWd+4YQ
         5pUJMYaHTPvNqMgeTjgyktB0SI/5k8lt6561L++AgB1GKzf2VIL6AJvC2iqzSfX7QtPt
         aIzMx33sAoN9KaN/TyxLCqQsL336M+hu1DxIJKnmtPlqisnxicmW65U3hrgydQTSTLX/
         /Ax0upDV9zTH1Pc9LBVGgfmxSXn/Og0bIvQ+hREzGb+tjWb0q/n4R6kdpDLC4g56Du5j
         ksGA==
X-Gm-Message-State: AA6/9Rmu/sRSwiFzkTz4mHUoll4WqEUlHO9boJ/H4mlZI2koOQuIWP6FA7L5/P1a1cKCex0DCGMaskBdy6T8xw==
X-Received: by 10.107.175.18 with SMTP id y18mr726749ioe.86.1474973949692;
 Tue, 27 Sep 2016 03:59:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Tue, 27 Sep 2016 03:58:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606091815310.2680@virtualbox>
References: <20160606111643.7122-1-pclouds@gmail.com> <20160606111643.7122-3-pclouds@gmail.com>
 <alpine.DEB.2.20.1606091815310.2680@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Sep 2016 17:58:39 +0700
Message-ID: <CACsJy8A_CWgcS5za-Dha6Khgd6HqHk9UWHq7qqAeR-kns-syXg@mail.gmail.com>
Subject: Re: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(sorry for a very late reply, I'm just picking this series up again)

On Thu, Jun 9, 2016 at 11:18 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Mon, 6 Jun 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> diff --git a/diff.h b/diff.h
>> index b497078..9e42556 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -92,6 +92,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff=
_options *opt, void *data)
>>  #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
>>  #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
>>  #define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
>> +#define DIFF_OPT_SHIFT_INTENT_TO_ADD (1UL << 32)
>
> I am afraid that this is not enough. On Windows, sizeof(unsigned long) is
> 4 (and it is perfectly legal). That means that you would have to use at
> least (1ULL << 32),

OK.

> but then you also have to change the type of xdl_opts
> to uint64_t, which in turn means that you will have to change the
> definition of xpparam_t's "flags" field from unsigned long to uint64_t.

I miss a connection here. This new flag is intended to be used in
"flags" field in struct diff_options. Is there any chance it can be
set on xdl_opts (of the same struct, I assume)?

> Maybe this can be avoided?

I don't see a good way to avoid it. We normally enable or disable diff
features as bit flags and now we run out of bits. Adding something
like "flags2" works, but not pretty. Any suggestion is welcome.
--=20
Duy
