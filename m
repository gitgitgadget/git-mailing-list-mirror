Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471471F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAaHn5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:43:57 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42822 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAaHn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:43:56 -0500
Received: by mail-pf1-f180.google.com with SMTP id 64so1100915pfr.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hL75AtXnsbZipI4pYOJ1zPZ6hi5aLY9OLen8NXCkLYc=;
        b=tXhFjBytg6g8YmV5k2Dpd0yzStTZTj14hjs/WYYlvSNDh+tJ4z/ibv+3H+hfNt0wes
         2x0vh6Sj1XNyWNRcPLuO7YnFjRaqhkb/pEXVFp8MhBtAVOC3LqZnGRy3qIotZ+wm4Avm
         i+q9wWN08JLjnb/jsBC22W1o82JaIp9ANlxPVK2Gq9AQShOdRgGzdcl61h6X6saPDxRY
         /9CWClPz8SCw8KxAnp9q7D3iRKAU1vARSGGPL0GUNOY0qjI8f5T7+dv5nnNn44byEMfG
         81nLH/b8MmP5rkTgqIZcyShewgD5NooZdmhEWCps/0UUbUYrvAdhXg+eVvPu0gIxBLUj
         9cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hL75AtXnsbZipI4pYOJ1zPZ6hi5aLY9OLen8NXCkLYc=;
        b=JP9//8dUXsuQiB1qoqEUav3pjQe5Nu5XB4STjCq6DEVjphu9kcJ8PnZ9P9iLhD8okU
         jCcGY/uqeTmHgx4IAXcHE2GDhCwJkNZOf2r9yrum3pChB9kSBX9a7QMAVmbLXeOS2khy
         BhkWDDilgy3gilrsQ4wDJnThrmzS8No1URLTgNqgGIkQJ/OaZ+kSf2nGxq+iMwTs5WgJ
         /SQ5HYYanD4IwB2VCT/KXGftDz454a0fOKRdsLN7omsadOkgjnzunQnIHywbezgkikmN
         H+A3WEjv3Rh+v1iIZLsKn5Mnoaqt6NRFm6N//SdMjg+ySyZPdscN/gVu0hfPHvvENhGw
         egNw==
X-Gm-Message-State: AJcUukf+ZlGxrC3EfxNXOMJzMiybNSJzpAqKc95Vs29PFmZvsP7MjHLe
        7gRVnaycAXSV1hwxaIP5fvuPkemz
X-Google-Smtp-Source: ALg8bN48XbMgwaqCi9/hL4HVRKdz4IepZaxxwzcsqn9dR90Te4HvgYq57MCJqKMICRXG7k2a27bQnA==
X-Received: by 2002:a65:500c:: with SMTP id f12mr30187842pgo.226.1548920636029;
        Wed, 30 Jan 2019 23:43:56 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id r187sm15479669pfc.63.2019.01.30.23.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 23:43:55 -0800 (PST)
Date:   Wed, 30 Jan 2019 23:43:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
Message-ID: <20190131074353.GA2647@archbookpro.localdomain>
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 02:15:36PM -0800, Junio C Hamano wrote:
> * dl/merge-cleanup-scissors-fix (2019-01-27) 5 commits
>  - init docs: correct a punctuation typo
>  - merge: add scissors line on merge conflict
>  - merge: cleanup messages like commit
>  - t7600: clean up 'merge --squash c3 with c7' test
>  - commit: extract cleanup_mode functions to sequencer
> 
>  The list of conflicted paths shown in the editor while concluding a
>  conflicted merge was shown above the scissors line when the
>  clean-up mode is set to "scissors", even though it was commented
>  out just like the list of updated paths and other information to
>  help the user explain the merge better.
> 
>  Comments?

Not a code review comment but I believe that you mistakenly included the
"init docs" patch in the branch. That commit wasn't part of my patchset.

Thanks!

-Denton
