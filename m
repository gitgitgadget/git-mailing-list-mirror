Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D5C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGVLHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiGVLG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:06:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931F40BDE
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:06:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c24so3311171qkm.4
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R2PU0R9YV4x/i9J9Rzvk6kOn7vjMT4IZzDIEfh+TaAc=;
        b=fd7v2tnNM2Iw4OnLiPLCmG17D7WfYfNKODiqJv25HkR/k8qmD3YLdJHHcOFBM26M4/
         HMmC2LzkzYzMhV1R8l9f5kJc6Mdpvs1r/x1i6F7iOhNDdURruoM68coak/VCiqU4BuEg
         bpwPCGYRKAMC0vixNgmu5jgc4jzGj1TQxa7ida+RuV657Vnf3rix52p1D/pacrzoSXtk
         lqDZD6ZPOStxx88/iCLPPQWiiwY4rXw4Sot9q43WamoV7BHaqT6wyA5taIkL+Zdz4zNQ
         QdUfFqQxGPWp3DmjCLbrCUo6nXlwU8gdVG6oxjxy+Hs+8LnlAg1S1OFtz7roMqlkoWzr
         na3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R2PU0R9YV4x/i9J9Rzvk6kOn7vjMT4IZzDIEfh+TaAc=;
        b=r0FFMRjZVgw/7DEUlN6FtZ0go+qWNyBYnjuo5hRDY/rg6NghIuUCnwms181Rlq32ut
         vLfoHIzMoX4G2kvObz3fwS7RVU5BdmSaiiqO7+MbvXZgRtLbXbgdgMNrYWbEr/MNjkIT
         xOaJyC2FEDj3OBE/4JUhwlp8G/MzH7Y2j8yoMaynMLiMwhBsW1XBBO8gZ1dUxX88Cu4b
         XhVMjyDN6YtABSTZXOlfPAhtW/VlMmPTgZYAZnib7MXx0cDmnJD6cLL1gFHVOSRmfDmo
         3LiGER3KNtH5b/+/OEsheSYAi3Kzuk2sWQ0+TSN2A7X4enZMypllQqTk2ZBir1anb3rk
         Uqwg==
X-Gm-Message-State: AJIora/pctrWweuPwoftEKBjiSzpK9dXiaLuwZTh9+R/TGbuENnBMhH3
        75vWPLGSPLxZDWvC/aL69vVv
X-Google-Smtp-Source: AGRyM1tZ+ur1H9N14zFwokSBvoM9SpZAjSMCTZ0awKHFxkN7EnBydPHMdeu+y+vk35epRiPouv9M/A==
X-Received: by 2002:a05:620a:4913:b0:6b6:300:54ad with SMTP id ed19-20020a05620a491300b006b6030054admr69278qkb.68.1658488012638;
        Fri, 22 Jul 2022 04:06:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:150f:b81d:4401:9526? ([2600:1700:e72:80a0:150f:b81d:4401:9526])
        by smtp.gmail.com with ESMTPSA id dt4-20020a05620a478400b006b5cb0c512asm3280125qkb.101.2022.07.22.04.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 04:06:52 -0700 (PDT)
Message-ID: <8315230c-f79c-8027-9711-6e21a4bc25c4@github.com>
Date:   Fri, 22 Jul 2022 07:06:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Question: How to find the commits in the ancestry path of seen
 down to _and_ including a given topic?
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
 <xmqqy1wmlbnn.fsf@gitster.g>
 <CABPp-BEqWX3Nr2HDxwS9d-_QjcKb_jS=fSjsP_Pbutw7-P5gbg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEqWX3Nr2HDxwS9d-_QjcKb_jS=fSjsP_Pbutw7-P5gbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/22 3:34 PM, Elijah Newren wrote:
> On Thu, Jul 21, 2022 at 8:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> A simple question that I'm spinning out of [1]: How can I get `git
>>> log` to show the commits in the ancestry path from seen, back to *and
>>> including* a given topic (but not commits from unrelated topics)?
>>
>> Drawing of a sample history, please.
>>
>> I feel stupid asking this, but I do not think I even understand what
>> the question is X-<.
>>
>> Commits that are ancestors of 'seen' and are descendants of the tip
>> of the topic?
> 
> What you said *plus* commits from the topic itself.  From this graph:
> 
>     A---B---C---J---K <-- main
>             |\       \
>             | \       N---------------O---P---Q <-- seen
>             |  \     /               /
>             |   L---M  <-- topic    /
>              \                     /
>               D---E---F---G---H---I  <-- other_topic
> 
> I want the commits L-Q.  If I run

Here is the thing I misunderstood. "topic" is already in "seen", so
a seen...topic won't work at all.

This idea is complicated by the fact that you have a concrete idea
of which commits are in "topic", but you really can't do that without
a definition of what it's based on. $(git merge-base main topic)
would get you C, but then there are multiple paths from Q to C that
don't go through topic.

You can pull out that "first" commit in topic with this:

  git revlist -1 --reverse main..topic

but it only works if topic is a linear branch off of a single point
in the history of main.

> The closest I seem to be able to get is
> 
>    git log --ancestry-path topic~${commits_in_topic_minus_one}..seen
> 
> which includes all commits I want except the first commit of the topic
> branch.

If you add --boundary, you should get that last commit as you want.

Thanks,
-Stolee
