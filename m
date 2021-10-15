Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E328CC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C780660F41
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 06:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhJOGxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 02:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhJOGxt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 02:53:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999AFC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 23:51:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id o133so7570716pfg.7
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0LfXKgSgsJCjKAFtGiMWn/mB7eJ1GNi5qeym/N7xelo=;
        b=UJK8fJF2xgTTumVSi6fe7k2Cov/dU/FlbigdrScBVwL2pSiMkwIZ5ps6UHCGlG0+2B
         DG40h3ioMBTqaPYYcPz548cKQUWr8WNVyAi0SdKwRurwb9ov/5l5sZMs90dj0xoTxaKE
         VXlyV8vuOPqCrnlo3TN0wV1FCPm2xiIinWiPmh1pRnULdcZtfwygEezNyYD3Xm6rsnJ6
         FTABmVFgK8gtpaWKH8Xfqy2irKZWhrsbat9W7j86IepcZxjGR52sexxmHQ5rxIgUBFtf
         dE0Wzn5f/o5tFzSuFctbGGX9eL6KPy/kt3CigQHg8OrgynETh3675tgbhCWfAmnMsgfJ
         Fwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0LfXKgSgsJCjKAFtGiMWn/mB7eJ1GNi5qeym/N7xelo=;
        b=YQUM4WALpeW8QEf5ytZrVDnWo5QLPXl5pLuS7Fb/O6VMZNnbdRsGlFcD3pNBWSncuY
         OU77+RS+J7kKlgf+ecUVKkUEeXmnGaK3mS0wUvUjGh1fDl3ECior+fydKDEk5joLYHwC
         1fvQARFGLAD/Yg46nT7mm032LO3TLSD8cgOOFlfFwf6ppsJ0RyF9CBUbFv8dgLNBafS+
         h+w16un1tvx5wGlK9gP0WdszOyDZL+DQIMYeYwgK9rVvKR19cgS/YOKA1Xa4orBATuTc
         SKWzZQy08P4gpOh5a1SGa+qXNOwqCEJ9RotBNicCgl6Xz0RMw36HkzX0ZaVoWQ1060zB
         QgBA==
X-Gm-Message-State: AOAM53289BxPTOYPKzKVfQnW9R3kiRVEYPRJMiI8Sf3d4ZvbH/lnzcAl
        zVn4rWIsc4DSxApnZ0S+AV9ehm4QNBs=
X-Google-Smtp-Source: ABdhPJzwfSyESQYRqe6rO6tsWhMbFZMSma9UZMywQmoGtKLZZPjvMsUOCjtPa+WD9bHc1ErSMuQm9Q==
X-Received: by 2002:a63:9a12:: with SMTP id o18mr7799487pge.419.1634280703111;
        Thu, 14 Oct 2021 23:51:43 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-36.three.co.id. [116.206.12.36])
        by smtp.gmail.com with ESMTPSA id x9sm10869298pjp.50.2021.10.14.23.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 23:51:42 -0700 (PDT)
Message-ID: <f25fae40-0313-287b-5482-1c64cbe8cb64@gmail.com>
Date:   Fri, 15 Oct 2021 13:51:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Documentation: specify base point when generating
 MyFirstContribution patchset
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Carlo Arenas <carenas@gmail.com>
References: <20211013122234.448845-1-bagasdotme@gmail.com>
 <xmqq1r4ofz0o.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqq1r4ofz0o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/21 03.30, Junio C Hamano wrote:
> 	Side note. We want a new feature to be built on 'master' (or
> 	the last feature release, if nothing in flight conflicts
> 	with it)), and a bugfix to be built on one of the older
> 	release point (to be applicable to the maintenance tracks).
> 	But the section we are discussing, i.e. how to run
> 	format-patch, is not the place to do so, as it is too
> 	late---it must be decided before the contributor starts
> 	working on the series.  As the example of this document is
> 	about adding a new "feature", we should have a sentence to
> 	explain, in the "Set up your workspace" section, why we
> 	chose 'master' as the base point (and the existing text
> 	already says why).

It has been described before:

> Let's start by making a development branch to work on our changes. Per
> `Documentation/SubmittingPatches`, since a brand new command is a new feature,
> it's fine to base your work on `master`. However, in the future for bugfixes,
> etc., you should check that document and base it on the appropriate branch.

Leave it as is?

-- 
An old man doll... just what I always wanted! - Clara
