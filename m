Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578A11F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIRDb0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:31:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34141 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRDb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:31:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so8201601pfi.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQiCES17ebgOTFIQRtY0Q/0Ra/fDn0eluH7eNdzeKg4=;
        b=LEnroJ1Gb9SzQ3EdWjZyu2ArjsFmUMMU8CAmkhCYqW5eHODRnO64bMDKxJraP15/ib
         J+h6laXf5cd3eFnqYD2j5BT7junw8kjkeMXX9YWlciHFxmW+5xHGbrqmZLRnNm1RvHbn
         /6Dxo5YG97ffB+XcZpVg5vNP61OCg6cE1gp5QBPpKKzcOtkeOJGPOgRYV6hd8MQzuwqO
         Y95RD0enSHwxVdgbvr4mH+2wODKeBdcAIMNpSKWQ7Ul4U+T7NtWnfOMnETjkzjHPv9eL
         LVZmaGkSLcDL6EkH9LTzjHEuhUrXnc9mq5ieFSAtm/TPKD6qMveaMdY2sTgj7enMomm/
         i02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQiCES17ebgOTFIQRtY0Q/0Ra/fDn0eluH7eNdzeKg4=;
        b=RiI0PDCPq93ZqY16RRnym+RAruzIvulAGvj3k1Ob6muygrhUOAXwNydOE+6sJFwAFr
         HT7fblCa9c4OAKGaak7GnbWgJjZ645l2LCJa9bNkK1kYjNFNjWZJU9BHl7xA0wa9OVOH
         m0gQre+X+6p83z+Q7twoeoFTNG0ugqMK34wttky/S3Sl5YZw8bbqULqNL7lZ/uYH05Y6
         9eGAfv513JA6Mt/y/20jQYs2GRcsi/EIPamsp9Zh977X5qBdeFb2SLaZS21zLffGsQME
         R8evCN9JXPIB27HEo/N8+0IXAiHT8i6vcXWnqOD81FpnZgYrDCnsGVZ3192PjuMCwg4S
         TE9Q==
X-Gm-Message-State: APzg51BIrfKNEzHJ/MNHxV2/R5NrPGth8zGtjYl4ctKrresMz1rw89zu
        6PFMBU20h96tJvs6uHUou8Y=
X-Google-Smtp-Source: ANB0VdZwWquksK3th83CksGx36ywfMe4B0TwKL1Bf2TfDbvI7UpCyRwx0ma2+cKexPCVWm9ydBSAzQ==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr24871550pgh.175.1537221731701;
        Mon, 17 Sep 2018 15:02:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h4-v6sm22699769pfe.49.2018.09.17.15.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 15:02:11 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:02:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>
Subject: Re: [Question] Alternative to git-lfs under go
Message-ID: <20180917220209.GJ140909@aiede.svl.corp.google.com>
References: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com>
 <20180917192753.GF140909@aiede.svl.corp.google.com>
 <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Taylor Blau, git-lfs expert)
Randall S. Becker wrote:
> On September 17, 2018 3:28 PM, Jonathan Nieder wrote:
>> Randall S. Becker wrote:

>>> Does anyone know whether it is practical to rework git-lfs under a
>>> language other than "go"? GCC is not even close to being possible to
>>> port to my NonStop platform (may have tried, some have died - joke -
>>> trying). I would like to convert this directly to C or something more
>>> widely portable. Is there a protocol doc out there I can reference?
>>
>> Can you say more about the context?  You might like
>>
>>  git clone --filter=blob:limit=512m <repo>
>>
>> which tells Git to avoid downloading any blobs larger than 512 megabytes
>> until you know they need them.  See Documentation/technical/partial-clone.txt
>> for more details.
>
> Sorry, I was not clear. I am not having issues with large files or blob
> limits.  Members of my community wish to use Git LFS support on their
> enterprise git servers, so as platform maintainer for git on NonStop, I am
> trying to accommodate them. The stumbling block is that "Go" language will
> not port to the platform.

Thanks.  Then the answer is "no": there has not been a
reimplementation of Git LFS in another language, and my advice to
someone pursuing that would be to use the native Git feature described
above instead (or to get Go working on their platform).

If I'm reading
https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
correctly, the preferred way to contact the Git LFS maintainers is
using Github's issue tracker.

Thanks and sorry I don't have better news,
Jonathan
