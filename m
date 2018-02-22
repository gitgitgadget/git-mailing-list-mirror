Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FD81F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeBVAvx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:51:53 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:41048 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBVAvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:51:52 -0500
Received: by mail-pl0-f53.google.com with SMTP id k8so1948529pli.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dlSloGpFT9+hshEhZw9+ypZXgGeBSpUZ7mLVqBXFut0=;
        b=fpFpvG16dWpDMVR1czHciMRvs0bg9Nu9DixuFlFfH35iyUu4H26EhQqM0s/wiOt/6z
         4XSTf0IFSLJIXae2tgtsqtWkr92y2vb82+WbZgArUD+kSYGNOoXBRZH02FZMVbtCqTKf
         lO6DZELM/REXpi1S70Rb2nFzfQSAoG9KG1CyvuUvMRxr1t+qky40yjMmKZOiw6XtT5rR
         +BnYr4vjgDVyhGa8spVIpJ1o7ZXBgVY2+Gs6oI8bqB5m9C4pJkxWxSswkkk9US6dmbWm
         C7ltzTq0J6MZXRjEqH74fwENwzOhuipOAtTIKvmP/YqjsD4PQbeUMpGJoGSzsyBXxvNb
         0xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlSloGpFT9+hshEhZw9+ypZXgGeBSpUZ7mLVqBXFut0=;
        b=eD5x7i1dO15H1SaLzQ1sF9YvEpRDuSUIpgZo5rxxVD+nNaTE6+IHKDBHEaHyz878u1
         g7/yFsGYqOB1oDlm0hLHC5StX58BbCX7AvXjPnwtyIb7r6nN2ZAGNPTI+9MLpkIpUKiW
         5bDEQFhSoTOExifYXjx1fmk1H7+foIlprvkNFQNu0eOq+wgRy93YukLXjgILbo2nPXWD
         krYp5knsurFQ9YJSc4V/EGGqgXMp+fq+kVGMN3Wz9LyDi8WUy2Xt3T7ouoIKjHr0M7by
         OMv5F+VJcsv8Kkoi1HHhJEI6WIPHloKFZ8wvqP5ruQW0s+0CF2YZc5+F83E21yKIYXuP
         guvA==
X-Gm-Message-State: APf1xPAoV63aZ5x2rnjY1920ofSJ7MA1Rbc5Oy+rcCcgQIp72jsURpmp
        EIbG71CrRfrSnyN7TRlWFryE2TibKw0=
X-Google-Smtp-Source: AH8x225EU8sGA3ysYzTUOQprLLwVx80fnHiP07jCtOCaCsfD9eN/UZMfX2nLk2dxLK7JTbHEAxNDow==
X-Received: by 2002:a17:902:c24:: with SMTP id 33-v6mr4831798pls.24.1519260711435;
        Wed, 21 Feb 2018 16:51:51 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 7sm1412068pft.84.2018.02.21.16.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:51:50 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:51:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/27] sha1_file: add repository argument to
 sha1_file_name
Message-ID: <20180222005149.GH127348@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-17-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-17-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> Add a repository argument to allow sha1_file_name callers to be more
> specific about which repository to handle. This is a small mechanical
> change; it doesn't change the implementation to handle repositories
> other than the_repository yet.
> 
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
> 
> While at it, move the declaration to object-store.h, where it should
> be easier to find.

Seems like we may want to make a sha1-file.h or an oid-file.h or
something like that at some point as that seems like a better place for
the function than in the object-store.h file?


-- 
Brandon Williams
