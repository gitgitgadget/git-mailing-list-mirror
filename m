Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D76C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbiAFQyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 11:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 11:54:25 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362A6C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 08:54:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y18so3838659iob.8
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sacGKDSDdiz5rwgVnZCCNfIPMjLc8jUiRE/G/aJPEGM=;
        b=l7CZKzd4Z/QpjR6cm+pB/WUJoQY5HNU1SPYjJxLPH1uUoJG9k783fqIdjTVuufBFmF
         TTEsbWvdHSSVPaS6sHURnmWRjjWq0aWUV4BOSwF1fP3+l56RJ2uqnCm4BKtuohoYFrnd
         L8H0R7mxvx0HKR0F3IMF7jOvavb/f9cBlnAcYI0Yc6OCPzU879kbgUYUZzJFdUM2m01y
         O0TZoQaSww16e577ZBCfJW1B6OVUZUVNiSu0tNQrHFOFr5vbRaAEM2Ft0TBiKg1l1/l+
         s1tw0DxRstIVpZnzpqFz+CgEMJQadINnpBsbzvRE7nJc9sFSx/x7BHej31loxAE34uA5
         /G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sacGKDSDdiz5rwgVnZCCNfIPMjLc8jUiRE/G/aJPEGM=;
        b=CnQxVhppqyqC3YAIiRACCJ4yFTLMhdFf1MGKm93530I6kg9rfOdvlNg0QDq5PfoJq4
         RjCsLhmJowMhyzKx55AyvjjbBT7qHiRNVFGQsatnrpd7ZEQVwWfP2ymsa+4Di7D7Cy7T
         pTsazST0PPmn8LWSpHb8Y6xbJQ2CeygEtFOj116zYUihab6ZBXNer3e4XFKETMBKSBQg
         /cUVe2LA5oDkzVVpkFg6IM7xoITRHXv9cUCJHr1kf4LJuG2h28Ph7QheWygFOylz7eae
         LBNztAQEcy0KLy3HkDEDZ9RHkIKtg0aeObsv0QUEbgdYH2O7UdebzJqp9adUSZz8rnyg
         glcQ==
X-Gm-Message-State: AOAM533dyOhuQ7gXbWTNtQ+UsWQGwiMXQc9DMbvcAVb7gpYMuQDnZlNJ
        DFdvteVP2LqvYZIFgRl21CUJegmJlZ43hA==
X-Google-Smtp-Source: ABdhPJzvehLiy1sV7EVqPxX1v4PCMfTY4xSy3w3stjGSYdBEuv2trpUsEtojl8kAjweBx2x8TGBGzA==
X-Received: by 2002:a5e:a705:: with SMTP id b5mr3052823iod.142.1641488064524;
        Thu, 06 Jan 2022 08:54:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y8sm1478520ilu.72.2022.01.06.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:54:24 -0800 (PST)
Date:   Thu, 6 Jan 2022 11:54:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/cruft-packs (was: Re: What's cooking in git.git (Jan 2022, #02;
 Wed, 5))
Message-ID: <Ydcev8HqCjycBJS+@nand.local>
References: <xmqq1r1lfwyq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r1lfwyq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 05, 2022 at 05:56:45PM -0800, Junio C Hamano wrote:
> * tb/cruft-packs (2021-11-29) 17 commits
>  . sha1-file.c: don't freshen cruft packs
>  . builtin/gc.c: conditionally avoid pruning objects via loose
>  . builtin/repack.c: add cruft packs to MIDX during geometric repack
>  . builtin/repack.c: use named flags for existing_packs
>  . builtin/repack.c: allow configuring cruft pack generation
>  . builtin/repack.c: support generating a cruft pack
>  . builtin/pack-objects.c: --cruft with expiration
>  . reachable: report precise timestamps from objects in cruft packs
>  . reachable: add options to add_unseen_recent_objects_to_traversal
>  . builtin/pack-objects.c: --cruft without expiration
>  . builtin/pack-objects.c: return from create_object_entry()
>  . t/helper: add 'pack-mtimes' test-tool
>  . pack-mtimes: support writing pack .mtimes files
>  . chunk-format.h: extract oid_version()
>  . pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>  . pack-mtimes: support reading .mtimes files
>  . Documentation/technical: add cruft-packs.txt
>
>  Instead of leaving unreachable objects in loose form when packing,
>  or ejecting them into loose form when repacking, gather them in a
>  packfile with an auxiliary file that records the last-use time of
>  these objects.
>
>  Expecting a reroll.
>  cf. <865b99dd-0b18-9a07-49c1-3959a777c685@gmail.com>
>  cf. <c9437c89-9258-4034-9886-8a2aec46aa6b@gmail.com>
>  cf. <YaqiYGM48p5F9lS1@nand.local>
>  source: <cover.1638224692.git.me@ttaylorr.com>

Feel free to eject this for the time being, especially if it makes
managing your tree any more convenient. I have a few small things that I
want to adjust before sending a new version, which likely won't happen
until after we have finished the 2.35 cycle.

Thanks,
Taylor
