Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDFC1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeCZNJP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:09:15 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32810 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeCZNJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:09:14 -0400
Received: by mail-vk0-f51.google.com with SMTP id j85so11106682vke.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 06:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zPzmYgm7DEKQ+TEpQoX3Wo7eoZbb9pS2YSHKz5l1+m0=;
        b=iLsQ2fdK19ZpZ4MtumfZp9MCSgkgVdwfslER0stwtbX15cF/hIi1XB+RBq5RYbskpT
         o+D4T9AKxb5sKzIv5IjXyx8qLWFi8FdIsFb3UI0TKVmWcoBGsvRixc5ee14mroP+7oKJ
         TnUv+KJUOHNmdRLCDuCI62AMBSmIBGIf1cCIViFiNMw74WFAhpdxllNDyCe1PreYLIN/
         A8I9PjbV4sAMztRmG8cWoIwMdK7N/VAY0E1RgboyL9KRp08edGkOch71G82FTmGCkFNE
         L6dHlX8DJZEd1FRSy+hw/lVqQY0LlikSoTuf7BdnJRwj+UudCb1CCAyJfGXl5xWDpnSf
         D9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zPzmYgm7DEKQ+TEpQoX3Wo7eoZbb9pS2YSHKz5l1+m0=;
        b=aB6YW1Ke1E+VR9o4rwEwyXDiIB+WraNdwl3NsmvHN4chOpRtwqDmZZjJflAGMGXw8M
         g14+aGpqquB3WLIgD2lfqJhNCib/+btVkoAA572VQro41ruB7CBtoVYVAs+G35w56s/U
         sMH+my+ua5zZb7pZTrOyxOxo5jb7o4fvTeVximyy+A5jJd4cfHnA3gF4FwZK1P7VaGtm
         s911CfSqkLkm6XCehJL3p30fcjiGbHprC59c6z2hUWbGYe6wuNIgKEUKNrn1RaxdOwVU
         r0tGccncb4yCc5p77S5t7FmEkZda7agzMgyPEeY6StWJ6pNJVwJc5LwDwWt1WfKr2iXo
         IE4w==
X-Gm-Message-State: AElRT7EMO2L5A0LytVut3Nc+1gJV122Tg5huE6dsYsUaWsyXLKx2oaYY
        a/3tF74uU3z3IynQlv8tFYxPxegw/2gpMlwpdn8=
X-Google-Smtp-Source: AG47ELuUUx08Rkmc9cbkr3u0GFiJPnjowVLWQhqGaq9tD/R5lsh05vpECXSUvJniccaThuqm1n+FAQYINvcCgDaSE9k=
X-Received: by 10.31.81.197 with SMTP id f188mr10100389vkb.48.1522069754067;
 Mon, 26 Mar 2018 06:09:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 26 Mar 2018 06:09:13 -0700 (PDT)
In-Reply-To: <20180326124847.GA21993@sigill.intra.peff.net>
References: <20180326115815.10180-1-szeder.dev@gmail.com> <20180326124847.GA21993@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 26 Mar 2018 15:09:13 +0200
Message-ID: <CAM0VKjmCNDAKF=ueDBtscTUMJzVEZoFDA_CO6Oz9sTLUpyyiuQ@mail.gmail.com>
Subject: Re: [PATCH] test_must_be_empty: simplify file existence check
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 2:48 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 26, 2018 at 01:58:15PM +0200, SZEDER G=C3=A1bor wrote:
>
>> Commit ea3c87d0b7 (test_must_be_empty: make sure the file exists, not
>> just empty, 2018-02-27) basically duplicated the 'test_path_is_file'
>> helper function in 'test_must_be_empty'.
>>
>> Just call 'test_path_is_file' to avoid this code duplication.
>
> This looks like an improvement to me.
>
> I think you meant to reference 11395a3b4b16d9fc637ca2e41a6892ea2e6289ce,
> though (I don't have ea3c87d0b7 at all).

Indeed.  I remember picking up that patch from the mailing list, which
then became ea3c87d0b7 in my repo.  What I don't remember is how I
managed to build on top of this hand-picked commit instead of what has
been in git.git for a month...
