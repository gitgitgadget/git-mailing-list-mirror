Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD27CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 01:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbiCVB1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 21:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVB1W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 21:27:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0736344C9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 18:25:55 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z6so9196212iot.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zz/2T76Mm4Zy+SjIP/22MKcIDO+QSJwYxGV8IefDJJk=;
        b=BCGqLnROvgVSR+BTyQmr+/G8SnOnaq7mIsBw7fSMyvhavIgdZHFv9dmHs7ZMZDphwK
         d2tdacDlcz6Wdvqgwe025rX72mSIRLrh5o0bl/MpdzNx6oDK0MS7k77FBTJzwyBR3wAC
         kdzsaWqKj7bHu7zqgFawdXGmZCDVjT/DzS6s5LjYon09UHsZ7BUgpbZZKyIgvlSigdil
         FdcWJU1g2kaO2bS5L99a14zwA4X+ym7pUxAD3PXwWoEbru3HcsSwiqObUAttQ7JhfvIy
         8lS0PmWmiOBqDKWQj0lbeTFV0pd1z7EezGaGMVF6hJLd1KWna1gosssFbNyv+AfWgF69
         B7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zz/2T76Mm4Zy+SjIP/22MKcIDO+QSJwYxGV8IefDJJk=;
        b=kA7vqllsH33OofSrtqZFlZrzwmQbto4xPGPx7XjjL/DimYL4Fk9Gwa8tNjOV7S+mZ3
         DW8Aimx3R7az5m+EuxwksOw06aqbu/h62twmPPTQwof915I4JgrVjIl6STktvYFQYPRR
         2op/qmhMGKuXAsWYRn/s0ZTTzf6uuaYdEi85McgBYjbVdWl3uCDMBugD4niDb8xl2b1y
         DSDvyG7qNoYyJ45ThhJwJUj2IfwUbc560uu6SxcRbpwp2/EsLnImdWh5imfTclHs50R4
         6fr07uxnQtxufwV+m4rFk4PLg26ZsE4tsvloKDTJF+Y6KZOzdh+STdMLn0o9fw8l/dyw
         mVVg==
X-Gm-Message-State: AOAM531QyWNEQIMv/wehEbmkNZAXx4qn7om8MZNJoCl8117D32jCSdON
        KYrhAj3RfVdfYoDPTsecdVpX45g7XV41e+MV
X-Google-Smtp-Source: ABdhPJw8eiIBaRIVoFCQx9vXuqAsilY/I3XCLjc52FY46WFTCLCFkuv1frBcS6HyvEPHEsWuFFNhRA==
X-Received: by 2002:a05:6602:1645:b0:646:4780:fc28 with SMTP id y5-20020a056602164500b006464780fc28mr11333806iow.194.1647912354211;
        Mon, 21 Mar 2022 18:25:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 12-20020a056e0216cc00b002c841fec17fsm500768ilx.50.2022.03.21.18.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 18:25:53 -0700 (PDT)
Date:   Mon, 21 Mar 2022 21:25:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
Message-ID: <YjkloVk0BTqcgIiL@nand.local>
References: <xmqqv8wcizi4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8wcizi4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 17, 2022 at 04:34:27AM -0700, Junio C Hamano wrote:
> * tb/cruft-packs (2022-03-02) 17 commits
>
>  A mechanism to pack unreachable objects into a "cruft pack",
>  instead of ejecting them into loose form to be reclaimed later, has
>  been introduced.
>
>  Waiting for discussion to settle.
>  cf. <YiZI99yeijQe5Jaq@google.com>
>  source: <cover.1646266835.git.me@ttaylorr.com>

I responded to Jonathan's message here:

    https://lore.kernel.org/git/YjkjaH61dMLHXr0d@nand.local/

and I think it should be settled now. In an earlier thread, there was
some discussion about whether or not a repository format extension is
required. An extension is explicitly not required here, since the
implementation of cruft packs was designed to avoid such a thing (see
[1] for details on "why").

Stolee acked the latest version [2], so from my perspective I would be
happy to see this picked up soon.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YiZMhuI%2FDdpvQ%2FED@nand.local/
[2]: https://lore.kernel.org/git/5063be12-fb66-9936-9ec3-df02d4c9cfd9@github.com/
