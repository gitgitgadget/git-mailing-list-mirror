Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ED2C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 20:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiEIUb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiEIUbU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 16:31:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B652E0E11
        for <git@vger.kernel.org>; Mon,  9 May 2022 13:13:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l18so28927697ejc.7
        for <git@vger.kernel.org>; Mon, 09 May 2022 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=krC+RS8dqUNELNsb2IqnjregGES/kgwvFakH46oRPOw=;
        b=B+5TJo8ixBC2stAG18lpREh0Jjh1xOSU+7fLwi8zOGcFN7m6BneeLT3rPxbzqUyJks
         ah7x/MU+cMYVaTEVhOumFyi8YKYKlrY82euE1RCc/PDHuYDUSWfWskkrapOZ4WKXfefu
         Q6rjPPJ1NV/7ke3hu13Kme7z70ZGstSHEdiGo5H5vtJnm53sHYURPI7VrggVALlAlTjL
         PQDm83/ZPrj8py576dq9/I3I0cjMHfM0h6YqDnkpnjNye7d2AlKDt4IjWEf8SfMUDkrD
         4BojMuug/CKGqSnfYHZqWXzPoj88Ub/xY+FudsPxTmr9/ieAQXFCCkMiglJJnsFid+5p
         Le8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=krC+RS8dqUNELNsb2IqnjregGES/kgwvFakH46oRPOw=;
        b=LRQLYPh+XFTU1ijJyOwJD6XzFnZZfFY2FByWjIdwZNWoxE2xtnXMU/6Rm58uIr9LqD
         4j9xShKh31TT0N8Z/yUPdIU7e2a9sjfi2pGQV4cM2BgCmdPxsQlMfRCNqwxfhDt0Zh0E
         lhXdKjZ4pzWoyDRhTglFGZk1wukOIp92RG23sorlbra271D2o2hmQnpQINGVBVoZDALG
         gMC4u2chSR0HIpnC5zHAYdS1cEAS6RBYBNPzBHRtnL25LISPWVR+XpdbJBR46nbbpxvn
         +FEQrcAbDanp2G0fTenRhV8kr8NmZhSUOAjO31I5sDs2lp6MvXmgxPDQ9yRIq/EvZPJ5
         V13g==
X-Gm-Message-State: AOAM533L0xWy+8oTdu76ATCTftMEBbVhmaL8VyVKvC/sQMrJ+0YGY+jW
        +oRp/hqvblfq1eANcqixTHpwlDfoVOg=
X-Google-Smtp-Source: ABdhPJwOkiqSgVyjz3DOzvRIyQ/sgkW2DvcaRizor393T01FjIfOHNXLGD6TD2zGrVsqAUNwCUM8hg==
X-Received: by 2002:a17:906:3ec1:b0:6e8:aae3:90de with SMTP id d1-20020a1709063ec100b006e8aae390demr16018393ejj.127.1652127219776;
        Mon, 09 May 2022 13:13:39 -0700 (PDT)
Received: from localhost ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id en20-20020a17090728d400b006f3ef214e20sm5390954ejc.134.2022.05.09.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 13:13:39 -0700 (PDT)
Date:   Mon, 9 May 2022 23:13:32 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <20220509201332.sxedn4rrgfsqmrm3@compass>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
 <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/09 12:14PM, Kaartic Sivaraam wrote:
> Hello all,

Hey Kaartic,

> We were reviewing the proposals and noticed some missing information.
> Hence we wanted to gather the information now.
> 
> Shubham,
> You have mentioned that you'll be able to dedicate 35-40 hours per week.
> We just confirm if that's feasible despite you having the commitment of
> a full-time job.
> 
> Also, do let us know if you would have any other commitments during the
> GSoC period that you're already aware of.
> 
> Plato,
> Do leṭ us know if you would have any other commitments during the GSoC
> period that you're already aware of.

GSoC is my priority and I already spend most of my time studying Git and the
project's related material. I've got some university classes and assignments
until early June, but it's something I've already been doing in parallel with
GSoC and my work on dir-iterator [1]. I don't have something major planned for
the summer since I would prefer investing most of my time into Git and GSoC.
After this semester ends in early June I'll be completely free to focus on GSoC.

[1]: https://lore.kernel.org/git/20220509175159.2948802-1-kioplato@gmail.com/

Thanks,
Plato

> Apologies for reaching out late. Since the project selection deadline is
> approaching soon, do respond as soon as it is feasible for you.
> 
> 
> --
> Sivaraam
