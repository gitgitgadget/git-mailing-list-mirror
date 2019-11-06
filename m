Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9271F454
	for <e@80x24.org>; Wed,  6 Nov 2019 22:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfKFWEk (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 17:04:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43356 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKFWEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 17:04:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so73704pfb.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUIX5jUArZ+xm9snPIhLBkk7fwvxuU7fyD+W9uXlabg=;
        b=YDKQ6WW3gFj5yqi6vDSaBnDvC4HKwvzVZ8FzRmCjyEtwmwguZogjTiwaJpreBd29Qv
         tFvfMcUhJYewSLJOyRxoj3oScHuu/T07ulIHh5svuyzKr/p0oesHdl472vJh+PKNd/BW
         AYGiKXGNGy3S3PGFGagHxNok9kkWcUpVKk4NWqbjHl0Pt/4UHkjB9w3vM/SpjHsm2toD
         1KCyMZ+h/toNdXGWv5qdRSccZei2CHcLjij029pvGfCukIltKYHZ7U23o2pexdDtAeVH
         6hyPjsqkDdM9+U2a1zm0e2oKndWTpiMUhFg+hOqdDjkaW8FAlEhy7KmM0qw/uRzP+tRl
         bIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUIX5jUArZ+xm9snPIhLBkk7fwvxuU7fyD+W9uXlabg=;
        b=sefIRhyF8Z2gnDivAJ+El5k7lEHZgY4QqzbJPDV0KZ+yKOefvxjkgr2rbw+mJbTVPC
         FXuU31YYKXNGB3GadBaMspABm81aFhCgCzF11IFhvxJI2swG4CZvWsbaPAkczSULCIqs
         55k91I2VHjGCaQFE8tXRAdDVNRO78vlfqjOzlzvGWzcGxmvKR6SmFJnuelVDKL8nfqBn
         boItd9q7xJ0gQlT4PHRGbu3AbdhaIT7dK30PLnXOibcE05Nb+UlQIyzH+aGDIeRHYXOL
         0upE0ws9czgPoA2X7H44krh8k7021H0y02O7g+aiQFoF5DSx3vohYySfsO6TE6VlmDyR
         3vdg==
X-Gm-Message-State: APjAAAWWAMmXRAfZGm2w1bzM5whLfJvTD38i44OoWJh5cv3L0tWOZHTo
        f6PVDiSN2hrL2DNzHkbB6bCGHA==
X-Google-Smtp-Source: APXvYqz72gycUeVahhCTMyPDpppcqX37liBfvLh0ywLX6JuHgrHIogR4whu8HAsFEJGW1rCPt7ZwyA==
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr178079pjs.94.1573077879504;
        Wed, 06 Nov 2019 14:04:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k32sm4721099pje.10.2019.11.06.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 14:04:39 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:04:34 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/20] cache: move doc to cache.h
Message-ID: <20191106220434.GE229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <a280cf7f90f6769202840858ea3684e118b3dc26.1573034387.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a280cf7f90f6769202840858ea3684e118b3dc26.1573034387.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:39AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-allocation-growing.txt
> to cache.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
> 
> Also documentation/technical/api-allocation-growing.txt is removed because the
> information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header file.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
