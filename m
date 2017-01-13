Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4B62093C
	for <e@80x24.org>; Fri, 13 Jan 2017 06:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdAMG6N (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 01:58:13 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35407 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdAMG6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 01:58:12 -0500
Received: by mail-lf0-f44.google.com with SMTP id m78so29561801lfg.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 22:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5TTnJ98qfIIhlMIKqoPVIB2/1mq/Ro3J2rhfPckS+Tg=;
        b=it0UEuBNIl4SvoNBwjLapR7u4n0Q1SMyps2zZtUwgvUk94hJuWTqk8VoNkOwhO8gsD
         Jhp2Ho/+p9yeRgEmZpr5ZG8MY8AF3aId/7WPnDwplDXWQrPp++vF7SCww9wyr5NWznV+
         fj4mlB31OOv+LYz0UEn8d1T49xGS7dMe9SnobzX4k/TC3A3nnZbKBS7Ku3v6yA0phpvx
         3OBr9wEe6y/Pu2lp8SQY6txHOs6hNVE2cN1otMjbU0JiPnDt35zMmvrlBx1dFuVEP0YQ
         uk6oiVx4EAmqS29GkyviSHoyT0CWA2mfcf1wXIHomT31YGCRx7Z6Wk2h+0t/adReiiH2
         naNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5TTnJ98qfIIhlMIKqoPVIB2/1mq/Ro3J2rhfPckS+Tg=;
        b=IgLWdApSUKlprFWux8ozJVtJ2rm5uAlthkjNeNbFxzzRJbvD+imBxKXZbj1DK238mS
         vXVKkmQz6OIi+EcO4MsnxEPeOOBhkn6gZrcRxsTDGOJSg3LEh617GqhmobGgvWMCHrkA
         jWafh7KJC95Ty1Th3PzXRb7o+6ciFF/K0LkySs54BxVtXzOM7nb93Xjf6qHCQEYrrrp5
         ZRQgTNyiXzcOMPzFw2CUbsPs08QF4I/PlqClNYnQGY1VtppvGY9vXUmUUazICQcrwMCp
         +K1wpR/hBmxVSx1nhpqsDLF1vz/tFGDhFV1avGoR5TavdegY7yDxRPKjCTGpOxA7WbA1
         fI4w==
X-Gm-Message-State: AIkVDXJBAyKhIsFn6TFQhlymRFX5/SZS3LjM2i4zDVWeLwBG2kHqR4UJ8xdSbtc/BtihGxYiaP0+i1uUUv8spg==
X-Received: by 10.46.14.9 with SMTP id 9mr6399604ljo.59.1484290669156; Thu, 12
 Jan 2017 22:57:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 12 Jan 2017 22:57:28 -0800 (PST)
In-Reply-To: <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com> <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
 <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com> <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Jan 2017 22:57:28 -0800
Message-ID: <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 13.01.2017 um 01:59 schrieb Jacob Keller:
>>
>> I think that --exclude makes sense, but the current implementation
>> does not differentiate ordering, since both are merely accumulated
>> into string_lists and then matched together. I'm not sure how order
>> would impact things here? In the current implementation, if something
>> is excluded and matched, it will be excluded. That is, exclusion
>> patterns take precedence over match patterns. I think this makes the
>> most sense semantically.
>
>
> When you write
>
>   git log --exclude=wip/* --branches --remotes
>
> --exclude applies only to --branches, not to --remotes.
>
>  When you write
>
>   git log --branches --exclude=origin/* --remotes
>
> --exclude=origin/* applies only to --remotes, but not to --branches.
>
> -- Hannes
>

Well for describe I don't think the order matters.

Thanks,
Jake
