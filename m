Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C834C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352989AbiA2SJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiA2SJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:09:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD7C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:09:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso14042068pjv.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dAad/I3J2tVkQoUF7SQYfCZKBgyWo5AMoir1H0T49GQ=;
        b=dBzymi48Z+6Xvls48HHW9AqDvN8amV6DV35Qix6k/fMoed5QZ7INTjTGgg/7LWUSiZ
         ALK8KqbXgoX60oEMzUv/+IPPsnYJJjkdOgo6ElY8NBhn9epQXm+/8rzSWo07ny+NwXnf
         5UB7rXektta+QiRBDl/5xrf2kxkz2L8kNuJAag63xKxqVCjR3dYLDYA6piu+bcWCY2TG
         L8XssSZb8Pfcb1OGshOLR/auBndsQqbBJotvwZEEJ9jY1RyX6Ba+WRQ0Fr0GNRmIQK/B
         6LOSPBp2peMltQ0UgBD10Tg+y8xwU1AgbIxQ6wrGutMRRntOYDLqHxxs6yzGg9SfSjH6
         AbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dAad/I3J2tVkQoUF7SQYfCZKBgyWo5AMoir1H0T49GQ=;
        b=U7NkRxRmaqsfSWbSw3SikKL2Dn4zHG87MsgItKzanyywkVVSSGuZR36PGdNrjXg+Y9
         JHQNUAMvFZkM+2aMc5SGJ9+o934oZxoTaQcuAj9KaA0uQMJAiByoDwrYjPSAniKN95S4
         VcWvpk7Rw2TlGTMZZ8WY3mayMB0YbXPNLf6pev+2Iu88TrJDtPuSZmkxWK7AK05K+ZUJ
         ET9zmRPO9Wxub/BsiKlEddHzIam2DMJidKyTJjn+JNpZMY4hX39NhcdZXIVTJcP7QHtG
         bGvTJQrb1oIYoPsx4/i15LRjjIADoNUchavfSvNSirN826f4kSGp0+dF/5GVQ4tebD79
         5nPA==
X-Gm-Message-State: AOAM531FPt8uarmMEYLCXiNoR/H4rhzRHlv4hwomrK9m02lejNDVJKxN
        2bROsvSrZBlaCGuSw4k4L1A=
X-Google-Smtp-Source: ABdhPJxBUt7KQvjFO3xNThLBQC2uoYAVNA6lzhHrwn68Ut/FqhQma/QtH4hhX1RYB+Eilh6DUy0LOQ==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr14456092plt.98.1643479771043;
        Sat, 29 Jan 2022 10:09:31 -0800 (PST)
Received: from [192.168.208.38] ([49.204.143.33])
        by smtp.gmail.com with ESMTPSA id rm3sm6358344pjb.13.2022.01.29.10.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 10:09:30 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local>
 <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <f850f137-79a2-6fcb-cd2f-de382c314fad@gmail.com>
Date:   Sat, 29 Jan 2022 23:39:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/01/22 3:02 pm, Christian Couder wrote:
> Hi,
> 
> On Wed, Jan 26, 2022 at 9:05 PM Taylor Blau <me@ttaylorr.com> wrote:
> 
>> On Wed, Jan 26, 2022 at 11:59:16PM +0530, Kaartic Sivaraam wrote:
>>> First, are we interested in participating in the 2022 round of
>>> GSoC?
>>
>> I think it would be great to participate this year, provided that we can
>> come up with some interesting projects and mentors to help out.
> 
> I agree.
> 

Great. :)

>>>      Taylor showed interest in a bitmap-related project during
>>>      the Outreachy application period [4]. Taylor, are you still
>>>      interested in mentoring a bitmap-related project? Would it
>>>      be possible for you to do so for the upcoming GSoC?
>>
>> I'm available and interested in mentoring. I don't think I found many
>> interested folks via Outreachy who wanted to work on bitmaps, but I
>> think it's worth trying again via GSoC. I can rejigger the proposed
>> projects there a bit, too.
> 
> I am also available and interested in mentoring and I can reuse a
> project prepared for the last Outreachy round too.
> 

That's nice.

I've opened a PR in the git.github.io repo to create a mostly empty ideas
document for GSoC 2022. Here's the link for reference:

   https://github.com/git/git.github.io/pull/540

Once that's merged, anyone could feel free to open PRs with their
ideas to this document:

   https://github.com/git/git.github.io/blob/master/SoC-2022-Ideas.md

   (note: currently returns a 404; it should work if the PR is merged)

Alternatively, if you share information about a project idea here, I would
be glad to add them to the document. For some motivation, you could see the
project ideas page of 2021:

   https://git.github.io/SoC-2021-Ideas/

-- 
Sivaraam
