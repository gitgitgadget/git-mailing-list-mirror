Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36250C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiKNXPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKNXPs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:15:48 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B92513F29
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:15:48 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id s10so9432399ioa.5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRPofAEqzMJLcVK8Lg9JWap2tGh7sUg4F7uHUGaz1QA=;
        b=6ega1tBeUcIIHST8NIAG2MDyK0kKvHbY1OIsYjTrGk7DnvRFZrfMPRFdzOkib021sV
         hsD1lMOQRluk2Hm1sG4aqT/JSU+1CKDlPiOO54E2gGWcs9w33Cr+a3va+qdcQDV8D+Qc
         wQ0TVREi7yAwA12o8HuatGrx5DhD2tOkR7Tt6AgDb902K/b6xBZjQN6rx8ZbeoJYxvr9
         AKrPSfylQbG4sfkFHHnSReCGcwyKSmiBfDvt9iw/by4c2mgTr1UV4KjHb6SunjAPHJo7
         /0TJC5GBq52eE2kSsoTw4HDj2OykKDYaazLowIM2WcJuIUWGn+LRxSbTIu9k1INSnPjw
         oOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRPofAEqzMJLcVK8Lg9JWap2tGh7sUg4F7uHUGaz1QA=;
        b=vp5frHCHrd3YP2YTqEkkZ9+ypEqKB+I9vSTSItDEeS/42xwlKLSsbzarVuAWjXqU0I
         7ucNIYL5z/OiYS1Cf2n8NkNFsrkAT7Q6NTB53nx+6rZiJwPkoY59VL4s2MzKm5Ln7HWv
         zuCqX7t9NYST81PDAxKx8OYQh2w8XyJRs0Az/MAXIQ3Zgm5cFsfNe276mtNaIgfxKVfo
         Ta+ethWFJZZB713PwCfRjXje44ATJaeP6ynGvsKbv6Aq1tTVPlb5NQ5PvTxR3PygZ49+
         /H0kSiDbKZIw4bQfk00eD9t4K2rCEoAt+n1HvXMn8z1jjJIq8/63/eNwYFE/yh55fuoq
         6trQ==
X-Gm-Message-State: ANoB5pkMCclaKPADhe+a5d0d5Hx3YiWr2ZvSqNPDoeJvYzIR07n9YvuO
        Vu00ayDyAPsf1YKgY2pXN9J53NKx1TvMmQ==
X-Google-Smtp-Source: AA0mqf5uil361hhEmbI8lF15+rlnpNkRLXypVttN8nKikP+ok3MEbL6xhhhhGLgzGS2NpMkQWt28lA==
X-Received: by 2002:a02:7306:0:b0:375:2f49:e237 with SMTP id y6-20020a027306000000b003752f49e237mr6674963jab.64.1668467747349;
        Mon, 14 Nov 2022 15:15:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 20-20020a056e0211b400b002f1d7850037sm4403979ilj.44.2022.11.14.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:15:46 -0800 (PST)
Date:   Mon, 14 Nov 2022 18:15:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Vlad-Stefan Harbuz <vlad@vladh.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo
Message-ID: <Y3LMIdiNJwZMfdwP@nand.local>
References: <20221113124809.12169-1-vlad@vladh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221113124809.12169-1-vlad@vladh.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2022 at 12:48:09PM +0000, Vlad-Stefan Harbuz wrote:
>  Documentation/MyFirstContribution.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this looks obviously correct to me. Will queue.

Thanks,
Taylor
