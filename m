Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395411F453
	for <e@80x24.org>; Sat, 29 Sep 2018 05:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeI2Lsl (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 07:48:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33628 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2Lsl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 07:48:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so6479071lfe.0
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 22:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UapMqf/HaoO2UNv/4uynhwowzdtwtlhQco6AEq586co=;
        b=hezX+8gupm8iQ8U3DYUXCzDB0H2x5hI8V6PG/BLuY/IFylrjgZZ4QnuQhPJ7QTFl4H
         i+XPcDD7/ok5f7qG/vyncShyl+BuHsyeslnxdvJy1NDdJ+kBegKKSKbXEyJEawnMqaJM
         axqAHHLtfmy348R4rKRCm3CuHiz7zFJURnMToLNgR1yw71lvp/i/BhJxoymNp+FxMr6T
         V3oYzqVIgoQk3evYsoiLk2+2wit7C4wapyuA4ghOk4EVH2tgVXlqEecuriXXf4fFOzt5
         X5BwIr2kxlrbsXUCioTJScDi/ezZpCN2EZ+ntwR7iqAGagoWMeNSLJkOnEYirMSe93EN
         hi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UapMqf/HaoO2UNv/4uynhwowzdtwtlhQco6AEq586co=;
        b=KdMkBHq1hm2dcLzVYO/NT6n8dHFuOe2qPpfWOlt0Q167mh38bAo1couU4b5GgiXRtx
         xslpe5hq++fBuKJI2GorRG40WAs5QAhD141nxIGGB5wbBNSVPUgP3mm+2/LHOvjE74av
         i3JkXI6bmsivyL5VDI/ZgKY+QK1kE5pWyPssVwHldnf8jxCkAvjfvLF8eIcY3627ny7V
         mPKo4pyU+BayP/FgYsWxl6z0NJDtqux9eZseyOo0myC8ilqnKCHFTDponeFAxBURWEoS
         etxySM04hguHYLMI93Ijm3hf2fdWooKGaey8Aub9q+wXe1o7KZ5vwn0/GjwnFFGMIDd8
         QzlQ==
X-Gm-Message-State: ABuFfojd/dNHbn2OG7kvFRH+fnmckz81xaOqpTLKQ0/vDbpnUg+W+LLX
        +V9hkr6X2eYPEQHEQGZ+g4A=
X-Google-Smtp-Source: ACcGV60TVb16eEd6OeMDsXlC5Nc8MCKGTx882iBGwuyDVVBx+Q/li/yOkFDpf4+VTSCDmzPVYJtCGg==
X-Received: by 2002:a19:c396:: with SMTP id t144-v6mr713821lff.7.1538198499460;
        Fri, 28 Sep 2018 22:21:39 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1376791lji.60.2018.09.28.22.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 22:21:38 -0700 (PDT)
Date:   Sat, 29 Sep 2018 07:21:36 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] split-index: smudge and add racily clean cache
 entries to split index
Message-ID: <20180929052136.GA20349@duynguyen.home>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
 <20180928162459.17138-7-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928162459.17138-7-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 06:24:59PM +0200, SZEDER Gábor wrote:
> diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
> index fbb77046da..5dc221ef38 100755
> --- a/t/t1701-racy-split-index.sh
> +++ b/t/t1701-racy-split-index.sh
> @@ -148,7 +148,7 @@ done
>  
>  for trial in $trials
>  do
> -	test_expect_failure "update the split index when a racily clean cache entry is stored only in the shared index $trial" '
> +	test_expect_success "update the split index when a racily clean cache entry is stored only in the shared index #$trial" '

The the new '#' before '$trial' intended?

>  		rm -f .git/index .git/sharedindex.* &&
>  
>  		# The next three commands must be run within the same
> @@ -170,8 +170,6 @@ do
>  		# entry of racy-file is only stored in the shared index.
>  		# A corresponding replacement cache entry with smudged
>  		# stat data should be added to the new split index.
> -		#
> -		# Alas, such a smudged replacement entry is not added!
>  		git update-index --add other-file &&
>  
>  		# Subsequent git commands should notice the smudged
> @@ -182,7 +180,7 @@ done
>  
>  for trial in $trials
>  do
> -	test_expect_failure "update the split index after unpack trees() copied a racily clean cache entry from the shared index $trial" '
> +	test_expect_success "update the split index after unpack trees() copied a racily clean cache entry from the shared index #$trial" '
>  		rm -f .git/index .git/sharedindex.* &&
>  
>  		# The next three commands must be run within the same
--
Duy
