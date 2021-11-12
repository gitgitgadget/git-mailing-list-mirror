Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839EC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 03:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3989E60E90
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 03:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhKLDZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLDZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 22:25:42 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32116C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 19:22:52 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id v22so2629319qtx.8
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 19:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0b829adlpcU04VDFMzRUWtDomy37Gyj/hPa/sOUouEw=;
        b=lWIkXyNmddutW4wHOT3PkKz32LjBzqw7JIM8xwmU/RqCfaYmCf5ecA9/VgLHDAtwXh
         fRIABJfoXLcA7DS0JBdPdnAcX6jf1IFTY08SiuqBuLWJPagZAP71X2nQ4azoyasmBmmO
         T9Y27bUCRZ29PSu8DDovjXYVlsnCZ0HLFozJEtxAn4XnaduA3jFuT/YdolSOt1+WTZx6
         eCu/1Q1zHeseJRt97/ESVxRI1V8TU4niXSfxzfrNpcHfIwiQYWL0M6lQTVaeEow4BHo2
         6Zm44a099/B0yq0HCV8IrlT14Az94bHH+GUNAmMqGRdGz2MdTmn5nqTKcUF3ktXeW8AF
         MMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0b829adlpcU04VDFMzRUWtDomy37Gyj/hPa/sOUouEw=;
        b=wH8/DCds5d40lc7LYCZpovPEuQRxCUMAjqA4RHMnBx9I7WSTngrZsynx/rtpOLxf1D
         CK9pUjJl4JKK3ijBkSMvEY4WeL6uNKD4evTg9AG7poba8n94zyGx/MNTPNPNj1XYn7Qn
         jU0CylyTW40GQIqtFZjfYua39jhrU/9LYFrhkEyOITjmJ32PlDIzBIQfzSfz8z79J3wZ
         EgnUSSHeyZd0WEARMdtWnOQqfWJO/qCDcwzBQoslJGQwm02wyWvPdUuGn4p7Vxd2GK2u
         oruFJnoYZbuSVf4NFwqhKzM6hkuguNIlD4i/Ez00DOWaSnPcECJBxuj/fxl7MY5lvWXi
         URsQ==
X-Gm-Message-State: AOAM5317/h+fx9rBb9Dppz3eKMV+8Dc1TCVukMCVRPp8DvNjCyIM1Bn0
        EMNF77Y4ATrbtxvF6IqfF26vF/9dUeM=
X-Google-Smtp-Source: ABdhPJzcZNMwu9HaP6AUSxKQf9IOl4fWmk0req6cNL0ylZ9Pz5x+2oVaSptK38hthygHic/XUBvCKQ==
X-Received: by 2002:ac8:5f88:: with SMTP id j8mr12727272qta.275.1636687371163;
        Thu, 11 Nov 2021 19:22:51 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id t35sm2903004qtc.83.2021.11.11.19.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 19:22:50 -0800 (PST)
Subject: Re: [RFC] Branches with --recurse-submodules
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f88923bc-4a3d-e6e8-2c04-d75bef8a35d9@gmail.com>
Date:   Thu, 11 Nov 2021 22:22:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-11-10 à 13:21, Glen Choo a écrit :
> 
> I found some points that I should have given more attention to in the
> RFC. I'd appreciate any and all feedback :)
> 
> Glen Choo <chooglen@google.com> writes:
> 
>> In a superproject-submodule relationship there is some ambiguity in what
>> ‘checkout the branch `topic`’ should mean (does the submodule use its
>> topic branch, or the version recorded in the superproject’s gitlink?).
>> Our approach is to preserve existing semantics where reasonable - the
>> ref name refers to the superproject’s ref, just as it does without
>> --recurse-submodules.
> 
> Because a gitlink only contains a commit id, the submodule branch will
> use a plain commit id as the branch point. This gives the correct ref,
> but it gives no hints as to what the submodule branch should track.
> 
> The current thought process is to set up tracking using the ref name and
> the submodule's config. Thus, a more complete description of
> 
>    git branch --recurse-submodules topic origin/main
> 
> is something like:
> 
> * for each repository, create the 'topic' branch where each 'topic'
>    branch points to the version recorded in the superproject's
>    'origin/main'
> * for each repository, setup tracking for the 'topic' branch using the
>    repository's own 'origin/main' as the branch point
> 
> Note that there is no guarantee that a submodule's 'origin/main' points
> to the same commit as the superproject's 'origin/main', or if the
> submodule's 'origin/main' even exists.
> 
> If tracking information cannot be setup, we will still create the
> branch; we will only warn users when they run a command that requires
> tracking information e.g. fetch or push.

OK. That makes sense. Another option could be to track the branch pointed
to by origin/HEAD in the submodule (in an ideal world, that would point to
the default branch, but that has to be done mostly manually as of today...)


