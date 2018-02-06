Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FD01F404
	for <e@80x24.org>; Tue,  6 Feb 2018 03:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeBFDfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 22:35:43 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41697 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeBFDfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 22:35:41 -0500
Received: by mail-qt0-f194.google.com with SMTP id r13so627742qtm.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 19:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bLlOCthHSQWaZrKfOSAjsT0dQFBbKsImelbnMFEju10=;
        b=dKSdgCwxYP+1/5bdL46fhOrJNgVH9rz5iGTlye/32ODzUBHhKOGcDSYw3RA2OQAFRV
         eRdN3lzHTv4UVZK2InXHrq9Ap4FE/fPcssUjG9y3ieA6Q6KsAcdnv7JWfhQUDW7YPSy4
         44nPinAdJc4ua327X0Y3aPyKX5AwNysxgaLNluwZFGyz/i/GzVrMfK8wR/LrrpfCfS2+
         9Axm6trn8x3WBJJiG+RrvdmORg80/T/LUO7W+FSa8M6j+PS8U0bXYfFyIcKU7M6T6ZVL
         56u3cYeZsTD3EnUJV3X2885C4bCNPeRqNBUURLcrG/82+FQn4/bcWX6DMtkXRcneROaO
         x0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bLlOCthHSQWaZrKfOSAjsT0dQFBbKsImelbnMFEju10=;
        b=qmXyB0ntl7sCaY2pvEOzjW1nnwNOvnzDnC7WWy9Bjfeptgebeg103CYW5SlmlF3wiO
         zxFNUYglWTP8T5qw3HSLKLGGDKj/lueygPUCNs2rrIT1BtEoOP6cONXBjMOYBNwCAvPD
         BO4dQwCSSTdRW+EE6vUWT/SWej8ieBsehy+dAIAB/iehrNssS3v4wM4VUaDB0p1IK0+N
         rYwbSPR/qvci31ZWdbrY3e9gj1kz8cNhH9OS80BWylaVJOXEPJSopjbBAajgvMUYFb4s
         FQxxfluII7/YBMRtRnt5U1L9qSELMug3/SmmJvYqMRYYXTdhDVTE45BF+iOecmKIc+d+
         Mahw==
X-Gm-Message-State: APf1xPCc9uGDM7imy9m4Dn0xmn1ngLIYw63SJFRvLvSzYCIcDqU9cw9M
        kVJtpv9flJElFK8o4p7s6P8HI3qUQQw7QrJ/zyw=
X-Google-Smtp-Source: AH8x227pTeKOmRyXGv94BEgA+3ZWBX0MZkT763Ju5ss8bcwcawWsNIANuXjonJ1y3pXL886JdV8BpiRfWskinnw0FKQ=
X-Received: by 10.200.9.60 with SMTP id t57mr1532324qth.74.1517888141269; Mon,
 05 Feb 2018 19:35:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 19:35:40 -0800 (PST)
In-Reply-To: <20180206001749.218943-38-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180206001749.218943-1-sbeller@google.com>
 <20180206001749.218943-38-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 22:35:40 -0500
X-Google-Sender-Auth: HRV2-OBvPcijb7kYh4sqSu5vbdE
Message-ID: <CAPig+cSE=tXs4R=VrRntjE9ENBCQE3eUvujiVhw+trQ2A+=nLw@mail.gmail.com>
Subject: Re: [PATCH 136/194] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 7:16 PM, Stefan Beller <sbeller@google.com> wrote:
> We have to convert them all at once, because alloc_report uses funky a

s/funky a/a funky/

> macro for reporting. It is better for the sake of mechanical conversion
> to convert multiple functions at once rather than changing the structure
> of the reporting function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
