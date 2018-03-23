Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5FC1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCWSfy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:35:54 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:42181 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeCWSfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:35:53 -0400
Received: by mail-pg0-f46.google.com with SMTP id f10so4732261pgs.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TKwwPO4RJT81bhRY0eRw1Su8mR2L5O/BvV/5FfFS/3U=;
        b=n/cI+z6HsZcgkoLW7wtBNH/3qp4n+XLuVn3FksNqqUppM1A5+54NO+UkO7Dqk+cxHC
         CL076hPTM40BJCJTns6+R7tM93xI/31ef8a827vj7u8VXZhR36BDf2bfat2jsa6Zn6s5
         YqbFVThE20Rsipco8o6Q+2fIlKHQFtmLhCO6cSNNnlLBNu+LKKfZKws0qSRSrJa7smvi
         ZJDUZFQLeb7/Yim4H3ciqUz7AhxfZXdPfWQjUpvtJ/KrUq7Ll4YvHowf6nxNcKhc4+Yc
         VQoPISQT7728cRCib5Re1cMyGJTqAi7uD7XzA3XSqYHIW03qzhUcR1cvgwbY679QuHcU
         nGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TKwwPO4RJT81bhRY0eRw1Su8mR2L5O/BvV/5FfFS/3U=;
        b=QEwBEyzGGzcedTnYYhaa0baHpuJd5Ds6gQMfHGCzjEO5egMn1kb/h3UdkDTAXUs14/
         5swBwepQ7e4f9yESvfWJQ/BOBl0xCpsqpqce16mBu8Zi5hjwNcIJO9jPhgoDucRSImGB
         f2Vix7gzuh17QVi+fPiifY+jhga/ZLk5mLnphoJY8YjaodnpcFYmVMSSQw9lMoGzDc4+
         xmgnLSkaVqyQ4FGCtwif0JpIq+KW2aBSd2Y+JAXjER90wNU8NfOecmvYjXeuu0b6IG6p
         4U/nlbOL2NDouaPXmjITNwaHf3eJvUndnBfnZQvFRBFFFnMuugAPgxGioQM4Z/CmaHg4
         Wu4w==
X-Gm-Message-State: AElRT7HoBkv81xcoIFhhom8L+4c8qeRZiSKDaqQ5X7SYgP3LZw6t15zW
        6wFWd+ZxQV0DpnMBeGQevXtDdmGt0fM=
X-Google-Smtp-Source: AG47ELuRFzaMXnjovEqxoakqUIYAutWEKmtZNgXTgY1abWg0LEJNzAt5HaCZgh8qgPsaSkpM2ixMLw==
X-Received: by 10.98.74.67 with SMTP id x64mr24861220pfa.135.1521830152488;
        Fri, 23 Mar 2018 11:35:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id i11sm15890178pgq.34.2018.03.23.11.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:35:51 -0700 (PDT)
Date:   Fri, 23 Mar 2018 11:35:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
Message-ID: <20180323183550.GB243756@google.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Nguyễn Thái Ngọc Duy wrote:
> I think I have addressed all comments I've received so far. What I
> decided not to do, I have responded individually. One comment I did
> not respond nor do is the approximate thing, which could be done
> later.
> 
> Interdiff is big due to the "objects." to "objects->" conversion
> (blame Brandon for his suggestion, don't blame me :D)

Haha, I'm guessing you prefer having a pointer too then? :P 

The interdiff looks good, though I'll set some time aside today to go
through the series as a whole again.

-- 
Brandon Williams
