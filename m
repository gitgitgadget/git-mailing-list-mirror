Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BCDC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 00:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiGUAxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUAxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 20:53:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03F4BD25
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 17:53:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v21so404303plo.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 17:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=bHidlnhL7bO9t1wZuLgvmx/n7G969ESXazG4Svzct4A=;
        b=ehiUeKk2Mb2Kp6WRBDJFyVKvmQ0ICoLaynHiWT/gL8NsJpCXlV/tn+swPsvnKwd7Lg
         7jft9ojqCTThf9DXR+1WvHjvWgpqFCXKsEPW/N2Bvoj8a4t4ftLHUGhfLgHp4nhfW+yh
         wne6VBhnZXz+PMq0Vv4JMTwJvly8CDOF4mcmvapfT52v4oakwFBNGKsmhYLggCpOPBu7
         Xq9W/IaEDyWUmvhR7Ova4HvBfVbdF645ndpa1P4Ct9sbGUHtIOytjdHTHptX3Idhdxfp
         DR6ZH1I7LB540PMFkGFUwGuhPOWcbNGL5Q/lGnnscf364lxPc9NpC1WEdJfCJ6scBAVI
         FzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bHidlnhL7bO9t1wZuLgvmx/n7G969ESXazG4Svzct4A=;
        b=BF/MjMr6+Sw26FkojrKqAgk2Rhfc0ZUaYRUIf42HfDkwLWXHy1ISJAPA/kd5fWCuE8
         CoX+pqCvj9kpT2AsQMlZELHFrMzCq+lW3P2AzGrcFplOVBNaR1B7ZbHgq8EXoB4BROxu
         ey8eLSgVXtMYOiaRuTt7mlLqTWPPovQklMQbGKgqDxhnuyW8hoB/TKTi/Nip5G5k8o9x
         FWEzw3Cy0k8qttt435cjx3urVnk0/TFmwheT61HQbj8lohK0wfg7FuSyGOGqrTtDk+ep
         WEVO8AFK+cKkzgaiGeo7EuDnkejkwTQT+irNQsffyUyYRqL7Lt3Y17CdMzwKSqOC4YvO
         pXnA==
X-Gm-Message-State: AJIora/TeUwl50+hdDzL9ZENisuR5yYrDmJKZmne7joBWu5CmwT8qDbE
        Cm1MvO0cbzn5eC78yqmaaj3E818WIXhQ/Q==
X-Google-Smtp-Source: AGRyM1sBCpE4LOvAyrN7uQ21XkhtTfpGRp1EFtfU8goTkBW17lglBE6d4cpaUFTMYZ5Ejfg1VMbUzw==
X-Received: by 2002:a17:903:191:b0:16c:3d49:b0c8 with SMTP id z17-20020a170903019100b0016c3d49b0c8mr41508495plg.95.1658364784643;
        Wed, 20 Jul 2022 17:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b0016c19417495sm165850plw.239.2022.07.20.17.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 17:53:04 -0700 (PDT)
Message-ID: <eb89cdfd-8461-4673-5bfa-b0f4f6bf28dd@gmail.com>
Date:   Thu, 21 Jul 2022 08:52:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: On-branch topic description support?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilnr1hff.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqilnr1hff.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 7:40 AM, Junio C Hamano wrote:
 > I've been playing with this idea from time to time, but recently I
 > started seeing a related discussion on the b4 front, so I thought I
 > would throw it out and how people would think.
 >
 > We made "git merge" not to silently commit the result, but open the
 > editor to encourage the integrator to describe what the topic is
 > about.  We also made "git format-patch" prepare [PATCH 0/n] aka
 > "cover letter" so that the author of the patch series can express
 > what the overall topic is about.  What the author should say in the
 > cover letter very much overlaps what the integrator wants to have in
 > the log message of the commit that merges the topic to the
 > integration branch.
 >
 > But there are two (and half) links from format-patch to that merge
 > commit that are missing.
 >
 >  - You cannot prepare the cover letter material while working on the
 >    topic---instead, you have to write one by editing the output from
 >    "format-patch --cover-letter";

This bothered me for a long time. Across every "rebase -i", I could see
a chance to modify the cover letter, but only right before sending the
patch I got the chance to compose a summary of what I've done in the
series, and that often makes me forget about things that should be in
the cover letter. And I have to keep a draft somewhere to record the loose
thoughts along the way.

 >  - "git am" at the receiving end discards the cover letter when
 >    queuing the e-mailed patches to a topic.
 >
 >  - "git merge" cannot take advantage of the cover letter that was
 >    discarded when the topic was queued.
 >
 > So, here is how I would imagine a slightly better world may work.
 >
 >  * When you are almost finished with the initial draft of your
 >    topic, you'd write a cover letter, and record it as the log
 >    message of an empty commit at the tip of the topic.  As you go on
 >    polishing the topic with "rebase -i", the empty commit would be
 >    kept (if we currently lose an empty commit by default, we may
 >    need to teach "rebase -i" to special case an empty commit at the
 >    tip of the range to make this convenient to use), and you would
 >    keep it up to date as you update the topic.
 >
 >  * "git format-patch" would notice that the topic has such an empty
 >    commit at the tip, and use the log message from it to
 >    pre-populate the cover letter.

It sounds pretty neat to have this on-the-go topic recorder :-)

--
Thanks,
Shaoxuan

