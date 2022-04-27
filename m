Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058EC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiD0QFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbiD0QEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:04:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A4321A7F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:01:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so3126673wrv.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lEGZUFu2y+aPk+/8yZWYPldZOmfap5e6ih4QbBdgJBk=;
        b=LtOp85iYlodxE67bSf7rZJ2UjA7JfpztkRZd7x1CzJYa5ZXtrYOgvYOlgx2Rfg6CS0
         NPWd/2I7RTkWe3b/guikPjCAsX16SW6RZdl0QNOvkarA4cUnV5WRsQTtDRXE/6P3z0Ib
         SPcya0zoE3xDt+SAeIqBtOjwYogosAdxdAZugdiTtY3syXKZeWg0Gtu34R/e3Y3WXyL2
         +a2spjQ5YSYQbpxqQCfTtsxkuddNasg+kyeAtzDRYikDTyJ74SmrJvzCWQzV7WfgxiPt
         JDv+cpM4PiTFsYJyOn9ZEEQjHaC1JLisJNNx4Lw2Ll+IZ+idvleef2VGIR9GhFOqDLvU
         vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lEGZUFu2y+aPk+/8yZWYPldZOmfap5e6ih4QbBdgJBk=;
        b=cDyN/mVfv0bjm2GBtSfQ9hY9Y+LONfwIN3Z59omrDph9GpNphUHRUTsZluU/pa1Cbg
         sYASpXOQGvY9az0cnMbiDYWGxen8hO5pE0eDLY7pJc1xdNgQ/ISZeAa5mo6v97r/P+IJ
         nQMECetPc8j2eUxlG5xaW508J6DRdNH9/fLPv00N7KTqQmmFZq6KL09T5FawlSGiezKo
         VxoqrXxgiDWieCLKxVEeRaupLx6GNyHFl4ENSz2NKfWTqv8uax4rcJogunldansvHxJS
         juIfHW/4PeDMcidTCpHaEydG4deqJq6E8Hg3fozJie6X8sr70O8JgQUVtWgMdH5IJ/wj
         1tCA==
X-Gm-Message-State: AOAM533o05CUyyZuN06MvNVf66HIRhCjQSLM9m5McXd6ihCOGnmk8wjJ
        ClPm6GYRgoC6imBgGZ7dp/Fcyzu218c=
X-Google-Smtp-Source: ABdhPJw9W4SLNlc4il8W1vn+g+u+7XdhcY/bzoynImuqdRoW8BtyFyXqIbTAbvat4fbSrlinKG1Qrg==
X-Received: by 2002:adf:fe84:0:b0:20a:dc0b:4f2d with SMTP id l4-20020adffe84000000b0020adc0b4f2dmr12717917wrr.229.1651075249479;
        Wed, 27 Apr 2022 09:00:49 -0700 (PDT)
Received: from localhost ([2a02:2149:8ba4:e400:b4f9:19f2:e54:30c8])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d468c000000b0020af2142a4bsm1032785wrq.47.2022.04.27.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:00:49 -0700 (PDT)
Date:   Wed, 27 Apr 2022 19:00:40 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 5/6] t0066: remove redundant tests
Message-ID: <20220427160040.v5qj3oua2ayetfow@compass>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-6-kioplato@gmail.com>
 <220411.86sfqjj2o0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220411.86sfqjj2o0.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/11 01:10PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Apr 10 2022, Plato Kiorpelidis wrote:
> 
> > Remove dir-iterator redundant tests since the new tests introduced in
> > 045738486f (t0066: better test coverage for dir-iterator, 2022-04-07)
> > supersede them.
> 
> This is presumably a forward-reference to the OID for your local version
> of 2/6. Let's instead squash this change into that commit.

Will do.
