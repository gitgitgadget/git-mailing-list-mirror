Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B37C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiEZSJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEZSJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:09:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D83AF1C2
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:08:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z20so2382497iof.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dE+05YUB3OnqXqxbdDpxLStxP5EiwwzWZ3v+ntih128=;
        b=qzHb0niteolk82tB3CfOknkIUQGC44Kgi1vKy94uZhURaNl/11E72FSP2abtnLBe6H
         WQ59jmyw0fsM+BQakCwXiOaIkFRAeQ1d5l5a7MZdb9ifDQQhh4KhPWzWSrHivuKmwAvt
         qMe0/mHTjd3WCtpGil++2xVF2cP0Bsx4flkDQk0yYRNeFctzuheYj1al/tntBGMh9NB2
         hZfTWSHGAWG0+XAABTIWHb6KCnJtkeobN3KQveyUQ2f7CvR2vAcLZEWQrGsoJ+BbZ4KK
         345QhAsaRBCBhyIwkB+2SvlMAv6fbbdHgrzmbrTxcwsCSkweat5hyLWhLZ/TOCb01u8n
         TVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dE+05YUB3OnqXqxbdDpxLStxP5EiwwzWZ3v+ntih128=;
        b=fGS3mHOQOuMnxW4NzMElgON3gcNgxDYrRbxzhzxCMffRBrfP8WEBohwZjykiDkGeEw
         RMJhmbbXZXm5BwiM/7Yes7k6uDPW4XRBSoLL8BQtUjCNRmfZqZL6Mf+bIjuLN+Rtm+XV
         GCm9YD+r+JLK0J0jsq3UI/5cKffp4ao9sPe2/dgbbyY1oFCTLiqzPn8SfcYRG+Sp+cse
         XZEjLrDCn1yxLCn17WwDfM7Xo2pluwcJSxPJJuX7MiEiFwRl+XCtBv5eolcSrmX2xww/
         3ee1DfKkoJ0gt5z0X0FasIK+QLaGWZva967gDnla6zHJlI4D5dwpOk1LFn8Pkh5OiRzc
         0mIQ==
X-Gm-Message-State: AOAM532i//2MNNcnp0vEtSyqPk7KJUPhmj1z/eKr7uebSB1ds9D2CMIt
        8xEKxCYolVGNdzuEHSMCH0LZMg==
X-Google-Smtp-Source: ABdhPJzIKF54gOckeFOZruR52wcucIGYkqmtszdtAoycb+OA17uaOBKx4/07zIa4Ml75KzBz7dgzig==
X-Received: by 2002:a05:6638:300b:b0:317:a127:53ac with SMTP id r11-20020a056638300b00b00317a12753acmr19264502jak.77.1653588539260;
        Thu, 26 May 2022 11:08:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t19-20020a02c913000000b0033074471f78sm570386jao.101.2022.05.26.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:08:58 -0700 (PDT)
Date:   Thu, 26 May 2022 14:08:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/cruft-packs (was Re: What's cooking in git.git (May 2022, #07;
 Wed, 25))
Message-ID: <Yo/CObnqie21V2Mg@nand.local>
References: <xmqqzgj41ya2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgj41ya2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 01:41:25AM -0700, Junio C Hamano wrote:
> * tb/cruft-packs (2022-05-25) 18 commits
>  - sha1-file.c: don't freshen cruft packs
>  - builtin/gc.c: conditionally avoid pruning objects via loose
>  - builtin/repack.c: add cruft packs to MIDX during geometric repack
>  - builtin/repack.c: use named flags for existing_packs
>  - builtin/repack.c: allow configuring cruft pack generation
>  - builtin/repack.c: support generating a cruft pack
>  - builtin/pack-objects.c: --cruft with expiration
>  - reachable: report precise timestamps from objects in cruft packs
>  - reachable: add options to add_unseen_recent_objects_to_traversal
>  - builtin/pack-objects.c: --cruft without expiration
>  - builtin/pack-objects.c: return from create_object_entry()
>  - t/helper: add 'pack-mtimes' test-tool
>  - pack-mtimes: support writing pack .mtimes files
>  - chunk-format.h: extract oid_version()
>  - pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>  - fixup! pack-mtimes: support reading .mtimes files
>  - pack-mtimes: support reading .mtimes files
>  - Documentation/technical: add cruft-packs.txt
>
>  A mechanism to pack unreachable objects into a "cruft pack",
>  instead of ejecting them into loose form to be reclaimed later, has
>  been introduced.
>
>  Will merge to 'next' after squashing fixup! in???
>  source: <cover.1653088640.git.me@ttaylorr.com>

I think this is ready. This topic has been thoroughly reviewed, and the
outstanding topics:

  - user-facing documentation cautioning about mixed-version cruft GCs
    (similar to what I added in Documentation/technical/cruft-packs.txt
    in v4)

  - 64-bit timestamps, if desired

Can easily be done on top. The first one is trivial, and I'll send
some patches before getting too close to the -rc phase. The latter is
more substantial, but isn't a requirement for merging this (and the
format is extensible so this could be done on top if there is
significant interest).

Thanks,
Taylor
