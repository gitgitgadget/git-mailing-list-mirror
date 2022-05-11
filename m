Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9185FC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbiEKVtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347411AbiEKVsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 17:48:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150A6830D
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:48:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id fu47so3046298qtb.5
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k0+l3KiwXYiRLrTgMHsZ6Fll3d8SYkUfkTOrLMdPHMQ=;
        b=I/yvWFk5lY/ZOB6nIva0INDsA/BKbwBf0sUW31RuwSidxQNzqEOVCAl0XtZqQdN6v5
         Je0/ic8hGP2+fcqKjURHzcikXKZyatqoM6ZKqNSOotespJdDVj9CHsTi/2yGH0//W1kF
         vZn8P/5lIKN2/4u8goErA2SfPph4dRGPQBCq5SLHfStoPpauIyF5Bj6dkO3luTz3sAqH
         yrWLQgClK46v/P6dxrvWwJJXOKLE63iIuibk4sTOcI14zQfnrb38H0SC9jxottBi8cM0
         GwiP356OIYiK7FFWRb1rktTBWhc/J5nTnGN3j4xg5O5RrB/MzqPHVYXDrpaX/fltRB3e
         Jg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0+l3KiwXYiRLrTgMHsZ6Fll3d8SYkUfkTOrLMdPHMQ=;
        b=Nkop3mmDj6NRjg+dKxUE8qqHYUdHqw2YDuAJDg/YhVZFSrnh+l2V8psLt+u7OQToms
         Qpsopjcp1WwdESAcNMgfspLqRUYyhzu9GWCRHVSAqbf2LQHu3tGmFOEMlSFkT9bi9/1+
         V11BW4gyhSpC2AmtzK/S/69E6I6aFg84EhXj1t1EX9T+O7YltiyefyMinYzEetjJOclJ
         7CMnZUf0wR1HN2ATCM45F16RkjamjWW54J36GhctDlKV1Nros30HIYAVsHbLm6lLGSGp
         IqQQ3rivD6M1m1Dwoc9mzov3rIfoYB99+ZLjALiXPyRn5XgZf/bQnJxZv+BiGbwAauV0
         io2w==
X-Gm-Message-State: AOAM531qAvrupGaOqhKxhn4Kgt62EBzir2PKBTqboky48GVFDr+jYnsQ
        eHabG64/TEgGZi9AGkCogeY=
X-Google-Smtp-Source: ABdhPJxUdy4GxADA4Wg2NZKmPdZG0RzHgj9K5OtIdTkuL+l/mrfUpbK9VfRCRfUQ8l80TYxnr58k0g==
X-Received: by 2002:a05:622a:1a18:b0:2f3:d6f8:5b43 with SMTP id f24-20020a05622a1a1800b002f3d6f85b43mr17280441qtb.660.1652305711587;
        Wed, 11 May 2022 14:48:31 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84e42000000b002f39b99f6c6sm2164249qtw.96.2022.05.11.14.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 14:48:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
 <YntVo0G8G2mQYCLZ@debian.me> <xmqqh75viwoo.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9e766e57-3b6c-494e-84b6-406a91ccf6ea@gmail.com>
Date:   Wed, 11 May 2022 17:48:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqh75viwoo.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas and Junio,

Le 2022-05-11 à 17:30, Junio C Hamano a écrit :
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On Wed, May 11, 2022 at 01:47:30AM +0000, Philippe Blain via GitGitGadget wrote:
>>> +We can note a few things:
>>> +
>>> +- Each commit is sent as a separate email, with the commit message title as
>>> +  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
>>> +  _n_-commit series.
>>> +- Each patch is sent as a reply to an introductory email called the _cover
>>> +  letter_ of the series, prefixed "[PATCH 0/_n_]".
>>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>>> +  letter of the previous iteration (more on that below).
>>> +
>>> +At this point the tutorial diverges, in order to demonstrate two
>>>  different methods of formatting your patchset and getting it reviewed.
>>>
>>
>> In case of single-patch series submissions, the anatomy is simple: first
>> the email subject is commit message title prefixed with "[PATCH]" or
>> "[PATCH v_n_]" (in case of n-th iteration), then commit message and the
>> actual diff.
> 
> Correct.  There is no single-patch topic in the summary view shown
> in the document, so it does not belong to the above "We can note a
> few things" list.  But I agree that there should be a mention for a
> single-patch topic somewhere in this document, both for a patch and
> (the usual lack of) cover-letter for such a topic.
> 
> The sample topic this tutorial uses is a multi-patch series and
> everything in the document revolves around handing a multi-patch
> series, so finding a good place to fit it may be a bit tricky,
> though.

There is already a small section on single-patch topics, at the end of
the 'git send-email' section [1]. And I add a link to it in the GGG
section in patch 5/5.

[1] https://git-scm.com/docs/MyFirstContribution#single-patch

>> Regarding n-th iteration series, sometimes it is desirable to break the
>> threading so that the original thread (of previous iterations) doesn't
>> get too long, by sending the series as completely new thread. Some
>> contributors (including myself) prefer that way. In that case, the link
>> to previous iteration is provided to aid reviewers.
> 
> This is often not very friendly to reviewers, unless the "new topic"
> is so different that it is almost totally unrelated to the old one.
> 
> Even in a "in earlier round, we perceived X as a problem and tried
> to solve it, but it turns out it is better to solve Y instead" case,
> it often helps to learn the reason why we ended up not addressing X
> after you use "git blame" to find a commit that solved Y in a later
> iteration and wonder why an approach to solve X was not taken.  It
> is a very good idea to mention the need to add a link to a previous
> thread if the submitter decides to break the thread.

Thanks for confirming. I think for a beginner tutorial like MyFirstContribution,
we should keep things simple, so I would leave the content as-is regarding threading.
If we ever revive the "mailing list etiquette" series, then I think we could add
notes regarding this kind of things.

Cheers,
Philippe.
