Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392B320195
	for <e@80x24.org>; Sat, 16 Jul 2016 06:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbcGPGKq (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 02:10:46 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36411 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcGPGKp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 02:10:45 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so34852951ith.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 23:10:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4040GCJjOvMahRBTTs7Z0nvXIYlFohRu3L0pbYaUupQ=;
        b=AI2OqY8Jz8a3qSXV16K5u4mjyj4ytKsXc1NN8tplN3m0eC26AcP9YdBVgK0aijz1iN
         2FVyIoCVph7fJCmWKtau+FDiDleKzKqXD/EtfojLT2lzKujPSkVxBvkoR+MNLb9x0+Cw
         lZx+fRrWgr3r3fUF4H3S8S40vYfyzGt9RhYw5K+zg6LpZ/rvlY4BWSLvug1VeR5Butbq
         QQvYxV9vR62ymgQyReObqr9YqI0Cpl8aZppo6aqzv1y5XA4A3zeOKaccH+/g/Z1jJCTc
         ytBS5zefwNGMD7gw/P5IEXkr3Byx6HqO/MmBlYbuZ9dPYInkWBz856KIao0J6qFKe7by
         XI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4040GCJjOvMahRBTTs7Z0nvXIYlFohRu3L0pbYaUupQ=;
        b=NxNwWycvDkP1wG1mg44LfPV2VRbAseXKMh3SCGDUnvxZr0/rdRdVkL8qf+CuXzarEn
         Dx6CKOVGWGR/wZTD1VqJ/7xkLTTG6YPyBIk8ZRn09evIzNr+msO43PkER3fNdhYrPcAk
         W3S5DC3zNhfQRlYYoUSr2qSuxggA4s8nJuNTvXC69hVlHtsfz+Y95Q5q+betmKwNiHXI
         0mbmTyRQfI06GdlIlKtmwaV3vlauu5FHSx/mLJTLsTVgnW/RabgUNDZfBNLmzGTg+vnI
         Vj8y6cnp9vgXhkza004pSIo8PyGlZDi9bWt7wNydWdCJG1KsI7x201WHlraLA/1IStGd
         HNIw==
X-Gm-Message-State: ALyK8tLFoxjwXsY4z/xUTnPU08PM4U5ZCSgjd5rNYn0VFY5OEW84rfEFLhGkTvT5Sf7oDBdh9SFC9UegGumfQQ==
X-Received: by 10.36.33.197 with SMTP id e188mr21724172ita.42.1468649444587;
 Fri, 15 Jul 2016 23:10:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 15 Jul 2016 23:10:15 -0700 (PDT)
In-Reply-To: <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
References: <009701d1dd53$72777330$57665990$@gmail.com> <CACsJy8D9b1U9kP4FfBerWh-q_3fEO5a3aHzSJm9V+2mW5w6YGQ@mail.gmail.com>
 <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 16 Jul 2016 08:10:15 +0200
Message-ID: <CACsJy8BEp2is3JEr=zj5L9uWOG2emkadxOLrZbJemjxvnzYU=g@mail.gmail.com>
Subject: Re: Bug in index-helper/watchman?
To:	Ben Peart <peartben@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Cc:	David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 5:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Jul 14, 2016 at 12:11 AM, Ben Peart <peartben@gmail.com> wrote:
>>> I’ve been chasing down an issue where it looks like the untracked cache
>>> logic doesn’t work correctly in the index-helper/watchman patch series.
>>> It’s also entirely possible that I’m just missing something so feel free to
>>> correct my misconceptions.
>>>
>>>
>>>
>>> Ultimately, it appears that none of the untracked cache directories are
>>> getting flagged as invalid from the data in the watchman extension.  I
>>> believe this is happening because untracked->root doesn’t get initialized
>>> until validate_untracked_cache is called from read_directory.  This causes
>>> all calls to lookup_untracked to return NULL so the dir->valid flag is never
>>> set to zero in mark_untracked_invalid.

No, validate_untracked_cache does not do anything fancy in there to
make UC initialized. It may invalidate UC further though.

But you did spot a problem. What if UC extension is loaded _after_
watchman one? Then index->untracked_cache would have nothing in there
and invalidation is no-op when we do it (at watchmain ext loading
time). We can't control extension loading order (technically we can,
but other git implementations may do it differently). So, maybe we
should do the invalidation after _all_ index extensions have been
loaded.

Maybe we can do it in validate_untracked_cache? We already store the
path list in the_index.untracked->invalid_untracked.
validate_untracked_cache has all info it needs.
-- 
Duy
