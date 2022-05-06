Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52792C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 11:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391543AbiEFL5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391544AbiEFL5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 07:57:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072CE644E5
        for <git@vger.kernel.org>; Fri,  6 May 2022 04:54:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id iq10so6840545pjb.0
        for <git@vger.kernel.org>; Fri, 06 May 2022 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHfbi0IfoX4Wo7b7mUAL3uaulr1Cxd9seXLVbpWC7rw=;
        b=U2zqTSIyYTzt2ErujPe+2YpjhB9MPUK4jFrq8PFwL6wJJ5lhY8m27XCE/iHBq8jKvN
         k3JUK3MOENYXyjg9f2CltSLXNjV+0+9iVMg0YRxUXz+4iggi82PykgKJ2GNv6opb1ElK
         AXnfY9ij37ebeQGiTIHxFBhMEgR7ipfEjOxM3M1DihWOGQhU+TqBkTXPfVWRGpEdJtqP
         A/4QfyzchVrrNOCo0LtYP8R63YSKV3JZpljZzH1zK+AtKlvRrA2766aNPJHgGYft1jpc
         72+5bJts0VEmnxuqM7FpK2jU2otOX4I4fSdsprM3J9R2wFldAtFeNmww+Tgpxt2W6YBI
         QEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHfbi0IfoX4Wo7b7mUAL3uaulr1Cxd9seXLVbpWC7rw=;
        b=HVKi8HL06XFcR9aUDeJfjS0isLPSg4YkwKmrwo9aRBHjtaOaUANtraPq9UGzNazwoc
         WvAaCBH4903y8gGRNgW/pFuLSdvsgb1YwK3E40gz3kYMtcITgL7arulr+SLOhEGzIyjd
         Z8aFYWV+VEM/GIed9TAg1+ktqMI6DJht9QrQ1mwyMd/Q8RzLzWs1q5vF/ITZoIFu94Mq
         /A6cnlvS4p0/H8YY+JaQDnet6UvvvePuSdpOe2HLOQlMvnF1GDQNIlKZa4NzdcjKcBOS
         H8qnoH6v9JAutsNPiln02WuXn2N1odtZp5Xt4cRGIAC80rhWjlYCYvt3eOS+TvhxfX8c
         asTw==
X-Gm-Message-State: AOAM5312cDSXu8MxmyW6ikLFDF5Lmf00t3eeWMqGATXb+efsMoFAR4jF
        V4zlEbFLWNr77WpsJccVsFU=
X-Google-Smtp-Source: ABdhPJyvEHGVW313cfvL2YJManMn7zo+70YAyKnyN1sJuGZ1PZQ9hiqCSAQo1+S8GehJkhGt4Lp6Yg==
X-Received: by 2002:a17:90b:e14:b0:1d9:5122:be75 with SMTP id ge20-20020a17090b0e1400b001d95122be75mr3709318pjb.178.1651838042362;
        Fri, 06 May 2022 04:54:02 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.37])
        by smtp.gmail.com with ESMTPSA id d22-20020a621d16000000b0050dc7628193sm3167449pfd.109.2022.05.06.04.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 04:54:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Fri,  6 May 2022 19:53:56 +0800
Message-Id: <20220506115356.100838-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g1a169d7b5e
In-Reply-To: <220421.86k0bi77mb.gmgdl@evledraar.gmail.com>
References: <220421.86k0bi77mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hrm, so re my comment on 5/5 are you trying to use the "try to open" as
> a timer to see what our start time is?
> 
> I think probably not, in which case this whole variable flip-around is
> something we won't need.
> 
> But if we do actually need it perhaps a sub-region for the timing?

By the way, I think it will be better replace "try to open" with the
bitmap name so we can also know about what kind of bitmap we are opening
by filename.

Before: 

      19:38:43.008724 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
      19:38:43.008738 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001173 |  0.000013 | bitmap       | ..try to open bitmap:/home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
      19:38:43.008754 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001191 |  0.000031 | pack-bitmap  | label:open_bitmap

After:
      
      19:38:43.008724 pack-bitmap.c:536            | d0 | main                     | region_enter | r0  |  0.001160 |           | pack-bitmap  | label:open_bitmap
      19:38:43.008738 pack-bitmap.c:390            | d0 | main                     | data         | r0  |  0.001173 |  0.000013 | bitmap       | ../home/tenglong.tl/test/dyrone/.git/objects/pack/pack-2d1b3f749fb859b874710e33263d0847ef009e03.bitmap
      19:38:43.008754 pack-bitmap.c:543            | d0 | main                     | region_leave | r0  |  0.001191 |  0.000031 | pack-bitmap  | label:open_bitmap

Thanks.
