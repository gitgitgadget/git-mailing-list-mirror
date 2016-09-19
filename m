Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DEC2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965320AbcISNPj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:15:39 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34947 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935293AbcISNPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:15:32 -0400
Received: by mail-it0-f52.google.com with SMTP id r192so67874209ita.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lkdTDCe0Nk3NzcvMzJhZ0zTfiSMD4UWNCvtacyen/kg=;
        b=z4FQ1DLaC5UX2EaWW1WlG9uQk1GVR9Ew2K8A4XIcqvYSSFONpE7ccD4FthP/TpaSRm
         X6QGvw6Rqw7daILGeuhY7hZYaKDr88KGQRfR+GkRAWKbqw5H0rkVxe0sOZ4C+NdDDTsW
         FTmgTinxOX3STSfJK2XPR3/TRMu0AgzHhhcKys3XHjNfCCCaK/QmlG8ugbeKdg91uZVH
         k35OGH3NGVHk8439C+gXHIzdKpesI2NCIlFBZaTLpiaAKsXmulXFunn3VKQy5iyh9Ca0
         pqB5SQpTV5ufepQ+x0AVyjkosrMkdiV3Rd+wVWM7zDHBlinx2PEacUnLl8Yevzt75urQ
         ObWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lkdTDCe0Nk3NzcvMzJhZ0zTfiSMD4UWNCvtacyen/kg=;
        b=LfrDgBNGxQxoDIHbYJLxThUQYcIltJfnT80Hrxo0eM5zRCC30+MXWZDRGBHwcLalKS
         7YrhzOy8NEpyQLxcXQTy2rZ2r5lQXeEnDhxuVGe/9bz9pB+E/75usBAte8L51w+bUDwj
         gG/I1reFRF2YwYFrLbfHrs+mKxJVocAN7tBPr6o/YiM41WEu38ctTHLbCtoXceIU1Kr9
         aCKhjg+moZZMLnqmdZdoVoSmpGrJxRmUNvtwmays/6K+1Jda0xDVcaH6XsgdwolRRlji
         DW41Uccpz8kpKswiXN2qs0ikrVcRjHLWu9e7IHtaM3hbLCdyQ6DRdPutPEaOrnu7H5xN
         CjZw==
X-Gm-Message-State: AE9vXwMqzGabSf/TEYyZQBj6/JsMX5zpiVMWVYD63WQIWS4QwHoH3Qyxm1kB8kAhrQbnoOBOkefyhFCKeeceFA==
X-Received: by 10.36.239.134 with SMTP id i128mr11163751ith.88.1474290931208;
 Mon, 19 Sep 2016 06:15:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 06:15:00 -0700 (PDT)
In-Reply-To: <1473984742-12516-3-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com> <1473984742-12516-3-git-send-email-kevin.m.wern@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 20:15:00 +0700
Message-ID: <CACsJy8ARu_PkduP-McnE26OFEgr_YAkLtmfaxwYX7i9m47mJmg@mail.gmail.com>
Subject: Re: [PATCH 02/11] Resumable clone: add prime-clone endpoints
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
>  static struct daemon_service daemon_service[] = {
>         { "upload-archive", "uploadarch", upload_archive, 0, 1 },
>         { "upload-pack", "uploadpack", upload_pack, 1, 1 },
>         { "receive-pack", "receivepack", receive_pack, 0, 1 },
> +       { "prime-clone", "primeclone", prime_clone, 0, 1 },
>  };

I guess this is why you chose to implement a new command in 01/11,
simpler to be called from http-backend?

> +               // prime-clone does not need --stateless-rpc and
> +               // --advertise-refs options. Maybe it will in the future, but
> +               // until then it seems best to do this instead of adding
> +               // "dummy" options.

Stick to /* .. */

> +               if (strcmp(svc->name, "prime-clone") != 0) {
> +                       argv_array_pushl(&argv, "--stateless-rpc",
> +                                        "--advertise-refs", NULL);
> +               }

We also have an exception for select_getanyfile() below. I think it's
time we add a function callback in struct rpc_service to run each
service the way they want. Then prime-clone won't need an exception
(neither does select_anyfile, mostly)
-- 
Duy
