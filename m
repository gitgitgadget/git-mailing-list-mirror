Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EF5211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfAOPmy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:42:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35868 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfAOPmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 10:42:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so2915174edb.3
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9bDjMpWwu80b1KsNS6d0Xkx9jdj1YMDLN+NS9Zicqrk=;
        b=sxRe70iBji9M1x5nCeWeMbS/wLjq6haJpv6kVJdXw0NWYtYdd+clN4AvQ0BKLtpy3i
         fZYu6hpDPzSZDT4TUljvtdGenbk13CNk8ceIiGDA9cdfQ0rxc53RTwG4bEym66ieOfZC
         JUXBqUfCNg93uPfyaT832tGRJ5nz5xeBDqRUjR8wE0gwtZuedvcsy/ERF7dh6MMotNKg
         8cuyJplUJe9UNfm/b7P1MIU7xsuaCqsZ45e9QuVnNd/SPgOusAZ275V8WS2E/defaOMq
         3h3YO7/s80LVGwDJkJAoBo0J0rIytUfRaDPEi81Pw0J3ViWsPg5DFUCzl284/jD6BoxQ
         jktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9bDjMpWwu80b1KsNS6d0Xkx9jdj1YMDLN+NS9Zicqrk=;
        b=oq/46oGnhqYXv6NZrFZ4iOfpPcJLGBqQXa/Pycsn3A3OcIM9evOEVNg6cUOsHsFI2u
         pAnpCUOkqNGM6E4NkX/xE3+MPoDqiC9pDgV4K6alWb9jij58j5O+ecsnP6lyMtdIJwj8
         IUHqU1mGlHpVxQjmDL6yIVHdg/dFJwD1J4N8/vgqsAk8vp3h1LwNjw6n/2+FHWItkYz4
         NbCuvERMfvsPReTbQkOEteoFSa6W5Zs56SvFMfXOgyf5Tdq396+FJfaM7n4EAi5FaMEy
         NNPH/kuNRZpHJZsjxguCgHacen5DNwADIpVZWx0IZ8ajqIwMz7tH/cVhZCBL4xQ+8gGs
         igyg==
X-Gm-Message-State: AJcUukc4eLPaMXT7au54fm6/CTthiXnZtXdp7nw2oebg8727gdfG3heL
        /XMNyM/4Ix8D9o5+xbL0rvmCXsxr
X-Google-Smtp-Source: ALg8bN4XF0xN9YiCkmewJ39zrf/US+Pv84HUI3j/jes9eDoTnSCseEAxDgQKbprZVPFPTu5uVOuB4g==
X-Received: by 2002:a50:8689:: with SMTP id r9mr3683715eda.227.1547566972131;
        Tue, 15 Jan 2019 07:42:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-v6sm2818869ejz.30.2019.01.15.07.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 07:42:51 -0800 (PST)
Date:   Tue, 15 Jan 2019 07:42:51 -0800 (PST)
X-Google-Original-Date: Tue, 15 Jan 2019 15:42:49 GMT
Message-Id: <pull.107.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Be careful about left-over files from git add --edit runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

J Wyman reported almost a year ago (and I fixed this issue in Git for
Windows around that time) that the .git/ADD_EDIT.patch file might still lie
around at the beginning of git add --edit from previous runs, and if the new
patch is smaller than the old one, the resulting diff is obviously corrupt.

This is yet another Git for Windows patch finally making it to the Git
mailing list.

Johannes Schindelin (1):
  add --edit: truncate the patch file

 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: ecbdaf0899161c067986e9d9d564586d4b045d62
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-107%2Fdscho%2Fadd-e-truncate-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-107/dscho/add-e-truncate-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/107
-- 
gitgitgadget
