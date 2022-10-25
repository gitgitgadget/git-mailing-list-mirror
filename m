Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C7C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiJYNuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiJYNuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 09:50:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA922D742
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:50:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so11483050pgb.13
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXzXgjqSnYC7HAFsXnm7gMhdM2Bu/sUwDnZEhVnnmnA=;
        b=m8JQhrt7PkUSM9nuTALw9JDrvf+7A25oO7sGrOsmRJcnjpEuiXuMk5glC85B+49rpG
         kfIcfpe6rFrDTd47jxtVuVyCay6N3GPhjw8ZB4Y7SZRaYs0mcpjvVri+1TtSn4nkQXRE
         uGvxqMRke8l3gMrGkpfGacpyVSKGXUZTFlehFiduCH6miIjBBDyahY9F2+5KIhCbvcbM
         P7HaH68UQxfK6223gLSi4IXg9/c2M8fnYXaUXclPY3GoWc3ZLl1oXsqd2ZNu9VzIlZOe
         jDpmVhDdcNMqJjd1qBVNZT17rJrTlPir3Yof5DhLQF3h4STg4ZQ9NKu7P3/chBJnqNHL
         127Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXzXgjqSnYC7HAFsXnm7gMhdM2Bu/sUwDnZEhVnnmnA=;
        b=I1Taw7wtVS3JAywDBtNz/szMHrMvGxqxGz23bxrFLAjPTBkAfwAnrTOJoHCLtG4njI
         Afrthi+pGjIazeaP776TFIdTK6Ezej/JEEVjhMXs49kmZGimoTOVqwsbSicJnmYkCaWb
         OafNq33XncVzmPlU8FRPEeLRoUgzdh/mDTS0VwmuGLAmdPkYoGAC10GbX4IelcI0sU/f
         lFDZeSDSM03Rqbfdy/nErAYcyO2dQFWtnd81EL5klvOhIik4xVH1uzjVtS7xh3qIrfoP
         BxNwtS41MmNl3N/Suk4qcPABbtdzaMgRn3/vcZbR0Y+II4FtJrH4r9ZlalXgoBebztM8
         coQA==
X-Gm-Message-State: ACrzQf1b2z2q5Q6LneHwuosohE+4dBdLzqVlH+y9iyFTc/MzeGYZgcxr
        O0X2yZAp2ijCQIUVh5y3UDGH2nlfHnk=
X-Google-Smtp-Source: AMsMyM43g4/DrHkqPikfJlFfzDgnW8S2XJ9xSBuBWOUADateobsh4Wsaj22LrZGYti9+L1pVlwVVuA==
X-Received: by 2002:a63:485f:0:b0:458:764a:2224 with SMTP id x31-20020a63485f000000b00458764a2224mr32459772pgk.620.1666705817537;
        Tue, 25 Oct 2022 06:50:17 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id u16-20020a170903125000b00178ac4e70dcsm1254342plh.185.2022.10.25.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:50:17 -0700 (PDT)
Date:   Tue, 25 Oct 2022 20:50:13 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [OUTREACHY] Unify ref-filter formats with other --pretty
 formats[Draft proposal]
Message-ID: <Y1fplaDdGTvfRPdO@danh.dev>
References: <CA+PPyiGtoO4HYA+Z8_te5d0oBLYAxcXeZdTH17AJYaoZ32ObfQ@mail.gmail.com>
 <CAP8UFD0J_vWkMjZAm3=LeS3KvZ3xzpkFXRWHLisuN7AbUui+BQ@mail.gmail.com>
 <CA+PPyiH1GpHePrG7G7oyNJR_LD76A4qKDG=gnHcVLW_qj-DYqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PPyiH1GpHePrG7G7oyNJR_LD76A4qKDG=gnHcVLW_qj-DYqA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-25 13:28:57+0300, NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> wrote:
> >> Step 2:Read through different patches related pretty and ref-filter
> > Maybe s/related/related to/
> 
> I seem not to understand this comment, may be give me some light about it

Apply s/related/related to/ filter (by ed (editor)/sed (stream editor)/vi (visual))
on top of previous (deleted by you, restored by me) comments.

Which will yield:

> >> Step 2:Read through different patches related to pretty and ref-filter

IOW, the comment asked you to change the text with that filter.

-- 
Danh
