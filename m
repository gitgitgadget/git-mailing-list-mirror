Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847C81F955
	for <e@80x24.org>; Fri, 29 Jul 2016 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbcG2PwY (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 11:52:24 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38228 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcG2PwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 11:52:22 -0400
Received: by mail-it0-f50.google.com with SMTP id j124so113143735ith.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 08:52:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bBZF5JvwS8QsTVSIQqT49v+v0F6G63j1x9dz/oQ2En8=;
        b=vofujEQRhW28XIrhLjiyQBFgJ8L8LG3JGYyBjy5G9AzHGJPm4puZ1yET7K2tSLtElh
         oiFgRUVV+Uqy3Z8cgqJFNwzOqmZyqDKhINiTp6WVlu7uz7JHy6O9EWLKS+jp/iKpQuqx
         tu6Cze1r0HZDTqTn3sbJufsfOBqrk3WAQZnKf7IT/RXPY3WLS7rQUA+h4ewkvfw9cErD
         lRRBwmH2MYdV0FGKpMd83Jjw/tyB1Jbn1ymbc5p4PI9eSfbOafrZOQ457TUqWzkjOGyk
         Pic5v20w6HiCw5QvQgPImBgNvXm09O/7C8O1W81byJa8t2DHyzDIXVPnu+gWSwYxoFSQ
         RYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bBZF5JvwS8QsTVSIQqT49v+v0F6G63j1x9dz/oQ2En8=;
        b=DoxqOYjWOejFxvFB3K5d9A0l4mE75SBv4E9M7cjMzWKO073nzA1HlE7+G5DK0DE0d6
         V0EpJ082V8Ydat71kSAE3v58BoMBEUc6Ch+SHpYOgfxignWGAIBwG1UZfQ+5Lb/Q0w35
         1IrNdS/8tULXCFQgWJox+EeOIXRRLkaKx/XpsNGrajtR9L0T7/xIiQ/yaRCbnVbPRhnd
         EyjMZRsLuZbIAjf7nIM4/81USwgJMz2Tbp417yaOSRgJ+9o6/yUdL26V5kNC4lq2YhUI
         bDRWcXDdfrJGl6DPKVIbzmkOms5Ca9naGiJ5Ndl7+OC6OUfvHjfC37tbW3PUtHZSKRIV
         /yfw==
X-Gm-Message-State: AEkoousrGHfutH4GyMXgb6+98uV8Xj5cTgf8f8bncTUqWUgoBx8ebmGDWTgRBhUrbzdLpz285HZ6EECKFBGPtg==
X-Received: by 10.36.91.134 with SMTP id g128mr46902404itb.42.1469807541921;
 Fri, 29 Jul 2016 08:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 29 Jul 2016 08:51:52 -0700 (PDT)
In-Reply-To: <xmqqlh0lqz8y.fsf@gitster.mtv.corp.google.com>
References: <20160728160226.24018-1-r.ruede@gmail.com> <CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
 <xmqqlh0lqz8y.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 29 Jul 2016 17:51:52 +0200
Message-ID: <CACsJy8AeWmDh+24shCTi1SjYAxnkNJsi=Npq7mYA0_c5ZQ740g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/7] Add possibility to clone specific subdirectories
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Robin Ruede <r.ruede@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 10:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> 4. Fsck complains about missing blobs. Should be fairly easy to fix.
>>
>> Not really. You'll have to associate path information with blobs
>> before you decide that a blob should exist or not.
>
> Also the same blob or the tree can exist both inside and outside the
> narrowed area, as people reorganize their trees all the time.  I am
> not quite convinced a path-based approach (either yours or Robin's)
> is workable in the longer term.

I think it should be ok. What I meant was when we travel the trees to
find connected blobs, if a tree points to paths outside the narrowed
area, we do not add those blobs to our fsck list. Trees inside the
narrow area work as usually so those shared blobs are added to fsck
list anyway. Object islands are going to be problem (because we can't
assign paths to them)...
-- 
Duy
