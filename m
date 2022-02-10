Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9BFC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiBJOkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:40:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiBJOkD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 09:40:03 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA05BCD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:40:03 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so6554130ooa.11
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/eLvIOAXYxOtGGdCYCSjMMni0Vqfmqh65nmCkF/+ric=;
        b=lQaSQ6FJgzRoVxKrxfgmrVJSgmqW+NWC53a8il4MNptaiRgD92ugYqxPbLtyVdEBCd
         yxjwU1EZHcJv47xi3V4GrtdMVAPxRiUycrCuGnzFurYgsugPJ7FDwF8rZqUD4jA+3ECC
         PkuZlYDQbMkPsOKMDN1yIKMwrrufteafUDtY5a6aqMBJjo45TsBhEFzxYPovwB7CiZxY
         bZNW4etIhXNME6JZ/BIUCrqNq0bDXdz/EKeHjom60IHB3SkmPR4Ma+LPi1PNaorpb7yp
         KVlx/DUjHGa/frPWvLGK6liMQp0N7VAvdI1cAZlmtpIBSd/OC4f7vvHnQp27N3154RKq
         tyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/eLvIOAXYxOtGGdCYCSjMMni0Vqfmqh65nmCkF/+ric=;
        b=ukA3HY2RLg5HCHRrvNxWaXav4PmG4ThLdjIUvs+Kg19uXnrmrtOKBDl3AyqSpxeSq3
         TdDXqZzvpZtWIYoUUmoiKpTppjnvHEZvHPP3DeFRHPq22qpWh6McVhFkzV9WPzyUNs9F
         ziRZJzebyoGB6LbqffZWAsq3xvPUuLzekqz5F85JgvTC2ooXrMY0p27UZS6vkLY6bWNc
         6mQfFGxLwx4WbvTQeLUYdX0/xFXnwxjXCXGU8pTJjghvU53RQPp4xcjr6bOB1me0cphJ
         /DuxFC8blGjnpMieRXXl+8bnqDLcthTZvmTjFETA/rPYpR4CNeTd+JhOATleGbdhEYCI
         9MVA==
X-Gm-Message-State: AOAM533o8AR+uiKIkpB/VrKh/j6geMTG+FgYVkXjsYbjJimgQFgOH9Oi
        A24os7NxYrwHfsxn3OsjDVM4cscr8u8=
X-Google-Smtp-Source: ABdhPJyl8XNcnzKF1ag916nbfqwd8dC432lFwb0KiBNOrn9G93hH1P0Qbhlea/SHrw+yEA7qMf24ig==
X-Received: by 2002:a05:6870:3a33:: with SMTP id du51mr824132oab.13.1644504003189;
        Thu, 10 Feb 2022 06:40:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9556:7d7f:ddbf:443c? ([2600:1700:e72:80a0:9556:7d7f:ddbf:443c])
        by smtp.gmail.com with ESMTPSA id y4sm7961468otj.22.2022.02.10.06.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:40:02 -0800 (PST)
Message-ID: <3228c238-815e-3dd6-bfe4-e00c4cc43c34@gmail.com>
Date:   Thu, 10 Feb 2022 09:40:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] glossary: describe "worktree"
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <xmqqczjvxy3o.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqczjvxy3o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 9:19 PM, Junio C Hamano wrote:
> We have description on "per worktree ref", but "worktree" is not
> described in the glossary.  We do have "working tree", though.

>  * Mostly unchanged from the version in the original discussion
>    https://lore.kernel.org/git/xmqqo83hatm1.fsf@gitster.g/ except
>    that we now mention that pseudorefs are also per worktree.

This version looks good to me! Thanks.

>    One thing that makes me worried somewhat is what I did not touch,
>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
>    special and it may be impossible to coax it into refs API for
>    writing, so the text there makes sense for it, but there are
>    other all-caps-and-directly-under-dot-git-directory files like
>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
>    API, so the description would have to be updated there.

I agree that such changes would be nice. Shouldn't hold up
this change, though.

Thanks,
-Stolee
