Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFEC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67856613B8
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhFIN0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:26:47 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:34780 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFIN0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:26:46 -0400
Received: by mail-qv1-f47.google.com with SMTP id 5so2476261qvf.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5ALo2dPb5Eq922l96GtzKgUz1PfObpLg5u4JkRz/OM=;
        b=UmV3s81h0htjgtdoHu82oUzC8lNUS9k9yPil1FlRx9GtdlxLpYNbLwzg+TaqTLfom1
         IxXaOh4z2L4Tp1uiGOC1Sn1EnBdeRZd9jSwAhLYe+nChbVCft77C74Th7YiYcYyi9VZd
         60QdvJgsmR1G+Fyf64bCFDLJ6VxTrccG58+m7y0CMYsWleVOvKSSq8RVyJYgQtEpI8b3
         rlru79ml9cFTCc/puDCSGHB92tuNPc+slDgH5jR/MIdol9zCTN9JvJTEBJ+urZPufRuE
         B8xFxOytew8OL/mULuf1yX6575Lgvfd71L0OBXFDjCDBS4KgFLXIEisKLSjZTrxKmpmA
         bJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5ALo2dPb5Eq922l96GtzKgUz1PfObpLg5u4JkRz/OM=;
        b=pPIqVBBKaANu9NEVb7lPQH2VnR+4kH/M9t6mp4gVkunAYS1XnrmFkWa2/VsYIQd7lZ
         bc/BEBKVWuzXGdk+3dkjWL+p+iO5Y/TSNWcR9ebgDiJUnhjGLgboHjw45ZTF2weU0S3G
         dXipeCVyd6zNSAIDQ0f9jDhS+J14pq/n2wvV6eu/Ie+JhWZQ2xaj8ke2CRJjGWSo7EKS
         jNACG7LOhfhnzJtM+RQAyxYo+zpbzd+RaAao06UuULKCojAD5xN1i7EXmWfcTuF8IZiD
         MfL48lVbCEbAnkFzB9PH3me6WhmWFdcbwFk0n7zOZUy3hnQt1Ngdi8zCIaDF2wa8JjP0
         Gxrw==
X-Gm-Message-State: AOAM5317wV8ZjwYq2Cwm+ITb/SjdaMHzwDIasyD5nPV90Fwpl6Phgq40
        xCZW4VeM1AkpBkFZdewPcEA=
X-Google-Smtp-Source: ABdhPJw/rnZ74aPRibeUdD3Pm3/cEBucbBh6wyG2KHIsoZWAkritVUV2xcZiyIGwyiV00zIkED7ZOg==
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr5789840qvn.36.1623245031513;
        Wed, 09 Jun 2021 06:23:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2? ([2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2])
        by smtp.gmail.com with ESMTPSA id 3sm26489qka.4.2021.06.09.06.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:23:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <YL8X7PepIggpKlSl@coredump.intra.peff.net>
 <60bf2634beff5_1a700820836@natae.notmuch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <baa4b326-19c3-6471-36d7-701716d0a836@gmail.com>
Date:   Wed, 9 Jun 2021 09:23:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60bf2634beff5_1a700820836@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2021 4:11 AM, Felipe Contreras wrote:
> Jeff King wrote:
>> On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
>>> pronouns, then we can avoid this congitive load on the reader.
>>>
>>> Using singular "they" is also incredibly efficient. Choosing a gendered
>>> pronoun is usually arbitrary between "he" or "she". Using constructs
>>> such as "he or she", "s/he", or "(s)he" are more complicated than
>>> singular "they".
>>
>> In general, I do like the efficiency and readability of singular "they".
>> As a native speaker, I have no problem reading it, and I have little
>> sense that most of my native-speaker acquaintances would, either.
> 
> Does this sound correct to you?
> 
>   We thank the reviewer for their helpful comments

In the case of an anonymous reviewer (such as a single-blind review of
an academic paper), then this is exactly how one should acknowledge a
single reviewer.

If we know the identity of the reviewer, then we should use their
preferred pronouns to the best of our ability.

Thanks,
-Stolee
