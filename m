Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE321F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbcJKRx6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:53:58 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36179 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbcJKRxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:53:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id ry6so18506338pac.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ju+x5yJ5/m663STmOcW9koSl98LTkDvn17uwCrFpyoc=;
        b=PRLl5DAH5Z9BNm7LD+x19WHF9sppVa2/3UPTsUoARSIfPiw+Ts55h4WDOKhZBSWK8g
         ZUJd/E/gNcKi0z/ZGe4s50jaeZp2hxFGtNyZrN1SeXo0t0m/oqnI8bjIZwOF7ysD5PQY
         r5D1WD09J73WcsOr3zq31oPr6mz3olUI+0fkR73zLT3prkCBOvboaaxhqfsM5Z9nhaye
         FUyLVw1Les9ayupMdWAAyJjeZ9Omm2ROr2LPSisgX0LMbLVOq1tvWMnpiBOJ839eSRIJ
         Vv/VmiAPGXFQpseZuutBrCxcDrOy3loE6Y48zB7L+z8VjtC1tRGr+BLVVUzSEc2ulW77
         5taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ju+x5yJ5/m663STmOcW9koSl98LTkDvn17uwCrFpyoc=;
        b=hPEQ9H2cDeJ/J/atAZ2icy56075oAFtMDCSo/d4eVH9rSA3jqgG6QrhE0lxP6FV+GI
         2cuZekyiRcx8pzZ9IikTiYlpxmhAyWomw23hqNBASuz2NIIXTlEjrrEormCoxbYT8AJP
         ssFK/pVWtRUH3SyvluPzZEA7Whe3EBOQhDMI+mdFjQGZOa9nflkIriPJQLUrlLFB/JcT
         XYJwnKff/ypbYRNbJBI4DUcQF07+/ewjgc7Bn+wvvjbouFTorNtjdArbn2jsV2RG+ep3
         Q8jdkX27vDeO3Lg4WVJ6jGGxH5wH/RqcuutNFZFTQB781cNijRcIx1hxP9nApjO2HKPR
         VnZw==
X-Gm-Message-State: AA6/9RlkIw9H5L5UDP8M/uRLBqA8SmXq1plcaji6FHNiQPFMehs70kr/+7BKTZQQ8HwpUwzE
X-Received: by 10.67.3.102 with SMTP id bv6mr8647783pad.61.1476207908748;
        Tue, 11 Oct 2016 10:45:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id b21sm5734872pfj.90.2016.10.11.10.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 10:45:07 -0700 (PDT)
Date:   Tue, 11 Oct 2016 10:45:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
Message-ID: <20161011174506.GD9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-29-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161011002115.23312-29-sbeller@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Stefan Beller wrote:
>   be initalized once as that part will be read only after its
       initialized
>   initialisation, the answer may be different for each path.
should this be the US spelling 'initialization'?

-- 
Brandon Williams
