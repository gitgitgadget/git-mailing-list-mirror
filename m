Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6B11F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfADSmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:42:22 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:36519 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfADSmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:42:22 -0500
Received: by mail-it1-f173.google.com with SMTP id c9so2697713itj.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goMHoTLdZE6sNTtQpKYPCu1samw+qRZz91geMkLTRL4=;
        b=VUBTxiB4reWbU3QYuXb0Vk0tqcw3F/eCIDKioolSQIm92ih+Qoe2BKQ4jJoEoFziys
         ZkmFEP61ZOb/zmBYPFw4jIVLHtzVwvSgVKVOYrvS4sw+Mi3UYbx2Mzgn7JwozRnWkV/s
         hy0Bm/CdFl/ZD9NALHLU1tzRiFw7sox5BlKNgybOVq6sD8wtAad7SLmhu7kHub7EjnD9
         f1RYeSS5M+ZO8Ua50oCG0EPqAg5QJuYYIulPWF4B8Q85uzwHMzQupaMSolY53r+dem2a
         ZafJErzjS9cVm1CEYwNIB3vqVAWuyZod20jxDLRjvW7SvnSBtTPPnnsle4CYFiHNSMhG
         OFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goMHoTLdZE6sNTtQpKYPCu1samw+qRZz91geMkLTRL4=;
        b=uoOAzqjhb04yOSKyoMtuqGoafQSYNRYgW+vExZxH/I80HFjgkvaJosj6/aIyZ2ZXPI
         2bI5MSVQDtetI1V9DblHcjG1fw3K+5bI7Ny0BRvwyZGoECxH3D2zlVvc9iLBF6l9xcCn
         iAVY3iAkaoiJ6zQWMG9J6WHxlPlv8sq3neDLMb5IY/adfAZV2fKS1vm54eZgJuBBcro4
         TCa2j2cLS/f3k7EHLBSYAp8ZFBiYzeldi1ShvKFa8ohKJp2KUfmC7muuRQNB5a0sPH9h
         1NcmVToxmGj5pf8dXYqFL+z3z7HCLBYYMs/Q8VzwDL4QqqoUx0bFO1JfrBQzlYX28ixu
         KnKQ==
X-Gm-Message-State: AJcUukdhMAlXaxghBbiLRsQWyX9Uxu9yCRJut8X3r09PcoUYqX91dVGL
        twGCOohMXEFgScSaMTjxpqfSry2VcGKhqYhYRxI=
X-Google-Smtp-Source: ALg8bN45FcHPgK5RBya+KqV43gcBlG48MpvpL0ib15qyV1Q6rompPNnDyb2Yt7efKF9WqaaBdeLNVuGgE86RaLVw35Y=
X-Received: by 2002:a05:660c:283:: with SMTP id s3mr1711724itl.135.1546627340563;
 Fri, 04 Jan 2019 10:42:20 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com> <20190103114317.11523-1-szeder.dev@gmail.com>
 <xmqqa7khh4cw.fsf@gitster-ct.c.googlers.com> <20190104093015.GC4673@szeder.dev>
 <xmqq5zv4fyuy.fsf@gitster-ct.c.googlers.com> <20190104123819.GD4673@szeder.dev>
In-Reply-To: <20190104123819.GD4673@szeder.dev>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 4 Jan 2019 10:42:09 -0800
Message-ID: <CAPUEspga6Kjv0pSYiD-BmZUCTf0rd=y0vneY_XvAkj_cCmXC8g@mail.gmail.com>
Subject: Re: [PATCH v2] test-lib: check Bash version for '-x' without using
 shell arrays
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 works fine, as expected

Carlo
