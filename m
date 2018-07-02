Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1671F516
	for <e@80x24.org>; Mon,  2 Jul 2018 16:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeGBQJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 12:09:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38778 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeGBQJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 12:09:40 -0400
Received: by mail-pg0-f43.google.com with SMTP id c9-v6so7349625pgf.5
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a9AxPCPQOZJP7tjBXmgrEXlHDi5GUhI5qg/Ab+54K+s=;
        b=MJ/+N7pQFjURs2SZZPT41skr9e1t7x8jWLvH3huJ+J/KOg6BqmotmE3YHdEsdGu1dz
         R1pnD7NFOmRCQ92nvCq/UVV2auSqj0T9VW2vTYEam+5j7zgfiz2Kl3Ll5v2lwM196CSp
         tNEd0kGgRZz32QjJAJIyMzCOJmFUGMlXVYZyZ9IWxxRW9cCZlCqXCnf8kNYZ+4QrNuvk
         H1ZcDXMyU8amT3wDC6FmNcm/8iiYuA+LG8Q7ry5vEKWQtcq07cnvQbcHtwJHsOs2rKew
         FF9XlTwjC5tFeOjvH/CBdHzCj2b8h+cXTyqUz2DzoK7MiU+YsXASul+MhImmg7OF8pp9
         GDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a9AxPCPQOZJP7tjBXmgrEXlHDi5GUhI5qg/Ab+54K+s=;
        b=BgGuCMYEh3Og585v9Ns0fWPzU703Xcp7mDedv04co8MFrjeOu90F/l2AefwXyYAqks
         9r07Q2T8gFj+L8IxMp8Bcbxr6aB8R9KCca4DA3YBzTekIUGGLpyb/OzLNISnFhy6+jwY
         nJcLtMIkP4cdRFTh1IJy4Ov+opmbjgEX+/9AttbNNfyiUx3jEe73XN/PWdOnDCZetM2/
         nKUy169nbVc5zcqUkaeOZK2ClOPH+XSPy0DsN8T9Y9dKSx72LoJRJNd6ZFw0rf37STJi
         eFJsqsBYfVLD6kOtWeQBmYbEDTvbRn26fvWlbD8w+Lym0OZXKftsxXzUtMjlrgojrSzY
         sOUg==
X-Gm-Message-State: APt69E3fnRb5J1S3WTnYZ5itL4XWVRLUO8rTBgs3gqWTfBR7PPPChIX4
        MkF3Ph4rX938edbm0zcixyJB4NLSUDg=
X-Google-Smtp-Source: AAOMgpfH0GbjCZjtkQmrt3dnv+9dRvkQSl91E0Ov7W4wNWtB/5cU/fFwotNs/1xRMNy+4Y/vrJDS/w==
X-Received: by 2002:a62:ce81:: with SMTP id y123-v6mr6372782pfg.95.1530547778943;
        Mon, 02 Jul 2018 09:09:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d18-v6sm24490225pfn.118.2018.07.02.09.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 09:09:37 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:09:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/12] Kill the_index part2, header file cleanup
Message-ID: <20180702160936.GA246956@google.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/30, Nguyễn Thái Ngọc Duy wrote:
> Like part 1 this is also boring. I wanted to drop these 'extern'
> everywhere actually, so before I touched any header file in this
> series, I did a clean up first. This is the result (and to reduce diff
> noise later)

I've scanned through the series and it looks good.  Again, thanks for
putting in the work to get this done.  I'm looking forward to the end
product :)

-- 
Brandon Williams
