Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3166A1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeHJSGO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:06:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35576 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJSGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:06:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so2379809wmc.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8855nIX2k1Up7c9tQBRg10TXoD0miORn5Z4FBfJa/BQ=;
        b=PbIOgxa9vSHdieAOBbwSRmJPTv/ehEvNs0ZHM7N/BY61enTAhg/nRGGtQuEMLUCmEt
         IV+x2+ZuBdS8nSsjKfyUxh070AbGV09PnrXQBzO9SsWLKjFgbibamKGUs10AnR5BhX1I
         pVgIDl2nOeEmT04ht5Y8SabDwREqSNgPhmBhBRIHgq15aR8N1DpRZ/xKdEMuAxIUTmqc
         xhVBCi8jpPffc3ajQ26FF1fmTz3GML1fBdt4DfzykU2hIz8iJ742GaGstT634dfY6z/z
         m1+QecIAW14aPiALj91S+T7xk6AVNLdVpfnyDfgXy4aAP+vaEvIQPZCOwkKis/8DnG8w
         qKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8855nIX2k1Up7c9tQBRg10TXoD0miORn5Z4FBfJa/BQ=;
        b=aFIuS82UMIyvDbX088SCdGGI5CWpa81ifr6nG7VcV8bbp+MyM2JcK/N42yhtAwrlvh
         fiGpprY6Gj8V6Y+HpiYulJJDrTlzlbrnuyE0kcKa6sm67FPyi9Gd/fDA/4+85G+ggKau
         gpwHY5qzyEYtipcPs0gEEtOp0yp1uY6DUtaO2SmuBr6x61UMQl7kZcAdYuwvT57T/MEu
         fP9gcuUBo3PmsEQof73gyoAHz5nMhgE1X5bt840cyW3emTSlxAJhuwJeXq0iiSDXccqc
         Y+BLSVn6J+0dzuSPPNHsJF5SVhQOshNJ6r7/6CTrpurEzy/ZewQvLzI9rRGZ3Zq/jDq4
         fRWA==
X-Gm-Message-State: AOUpUlEnETMXgfSfhGJdiB91mrtGZQ64yPDTNzCmVZC/9MXWVK7+ngzV
        rqFFqH1xOfJ20IxT+FqrZxf626v4
X-Google-Smtp-Source: AA+uWPxdKczhi7L/uEHL3p5+kGO0dgBHOQauKMZzA3m87GIc9MCMCKxbj45KTkx5tBd+3uCN+MY1ig==
X-Received: by 2002:a1c:5d55:: with SMTP id r82-v6mr1816308wmb.152.1533915351149;
        Fri, 10 Aug 2018 08:35:51 -0700 (PDT)
Received: from [192.168.0.137] (5-13-198-10.residential.rdsnet.ro. [5.13.198.10])
        by smtp.gmail.com with ESMTPSA id h2-v6sm2543812wmf.28.2018.08.10.08.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:35:50 -0700 (PDT)
Subject: Re: [GSoC][PATCH v7 05/26] stash: convert apply to builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
 <xmqqa7pwfw84.fsf@gitster-ct.c.googlers.com>
 <1ba17df0-e6da-3358-622b-c19092c20eb0@gmail.com>
 <xmqqftznb6hc.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <60b38370-b8ac-fe13-abf7-db3166a04dee@gmail.com>
Date:   Fri, 10 Aug 2018 18:35:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqftznb6hc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hellom

On 10.08.2018 00:00, Junio C Hamano wrote:
> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> 
>>> Good to see that the right way to forward a patch from another
>>> person is used, but is this a GSoC project?
>>
>> Yes, it is. I forgot to add the [GSoC] tag in the last series of patches.
> 
> The reason I asked was because IIRC GSoC was not supposed to be team
> effort but "summer job" by individual students.
> 

Before starting working on this, I discussed with Joel and ask
him whether I could take custody of this patches. He was open
to the idea, so I continued to build on top of them. Since then,
I have made some changes to his code and also added a lot more of
my own.

What I did was to completely convert git stash and apply some
more optimizations on top of that, like reducing the number of
spawned processes. Due to this kind of improvements I was able
to significantly reduce the execution time and this has visible
effects, running about 3 times faster.

Please do not get me wrong, I do not want to bash Joel or his work.
I just wanted to make it clear that I did not copy his work or made
it look like it was mine. After Joel agreed to hand the patches off
to me [1], every line of code that I wrote was written by myself, 
without his (or anyone else) assistance. I really did my best to finish 
this project and I believe that my mentor, dscho, can also confirm this. 
I am really sorry for the confusion.

[1]
https://public-inbox.org/git/CA+CzEk_qwHs5qUstyFeepzwvCBR=9SvH90+__f-gfxFySETZzQ@mail.gmail.com/

Best regards,
Paul Ungureanu
