Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9E71F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 15:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfJNPtJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 11:49:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbfJNPtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 11:49:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so20340825wrd.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Bkj5eGg6mM5bABcY11w9q9p+3x7DbGSmNSVddHxQpU=;
        b=U/1w8Flfb9bJfonVRWHyH550xTE2si6sOvgtLQK5x6KEisZwxtNHRy0jbfwPMMEksu
         X11/BjG4sfRYOahMF2+B/dIs6WiiF+7viUsZNrtxc5hRGpC1DIDRp9mOe1moSLFjTLuI
         bFWPKMvWsVfg/bVb/YA/3D/dDxuEzBF/A70VM4hXIgldBUZNnPCGyO/dabpvXOAhZp8U
         zBq3PFhu8WJjvcv9yTgVgJaHjqN7cTcRYk6zsVy/ZSDThPGB0TllIGK+iOD0jBYG++xK
         nGv4pPh9wbM6Qp6B/Yl0uw4k4+e5QZ8EYufonUP7ulRO+04azVJSccJho9U5DlkNwObr
         2RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Bkj5eGg6mM5bABcY11w9q9p+3x7DbGSmNSVddHxQpU=;
        b=R9NYxO/bD7TPDlyjTzMUJuJj0Tyk6HynwuYbFR2fjSAQrJQo2U2l0iyrKZ+h50CvLr
         I4UaRK4a6Bxzy4vAua4GSKloyIsz/jK9YinnWVIG36tvn+hANTfAPzYxO3NlaoWVDhLL
         46aOekCJicn0Ozn+lZWFWPY/Rfwj90I7WBUc8XNaUPUJt6+CbKFLBVr8ify2f3LeVaWC
         EseQCT21NLzQ5KQfJLjh1z41TDIwiwbmOZN34rl3P5Y9CkIBDxi79lz6vkanupDcoaM6
         IPpLqiu2rvYyvnQ/UrHLBH6djUsiYk348pdTok2JtyQ0FdEfF1Zz8HjJiTLUqFzRfiEi
         C6dg==
X-Gm-Message-State: APjAAAU5xMlB6El4ZK0K9w5Dj6eZu92VWC9G0jW0ajj77/liKue1qzJu
        CqHRg/W4B8nQ2/cUiMGKgSHV4gH0Ncs=
X-Google-Smtp-Source: APXvYqx254ta0Ugw5REWuiWPjM/rEh4wHJQQabIcqAzlXU+ba00SGgbGdfI6tfKP1RtB07R3NsYKqg==
X-Received: by 2002:adf:ff87:: with SMTP id j7mr26187531wrr.360.1571068146915;
        Mon, 14 Oct 2019 08:49:06 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id q66sm23203963wme.39.2019.10.14.08.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 08:49:06 -0700 (PDT)
Subject: Re: [PATCH 00/11] Improve the readability of log --graph output
To:     Jeff King <peff@peff.net>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <20191013071500.GA30652@sigill.intra.peff.net>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <34315593-7284-86a7-fe45-6d830352e69b@gmail.com>
Date:   Mon, 14 Oct 2019 16:49:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191013071500.GA30652@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2019 08:15, Jeff King wrote:
> On Thu, Oct 10, 2019 at 09:13:42AM -0700, James Coglan via GitGitGadget wrote:
> 
>> A final addition to that set of changes fixes the coloring of dashes that
>> are drawn next to octopus merges, in a manner compatible with all these
>> changes. The early commits in this set are refactorings that make the
>> functional changes easier to introduce.
> 
> As somebody who has pondered the octopus coloring code (for an
> embarrassingly long time considering that it still has some bugs!), let
> me just say thank you for taking this on. :)
> 
> Moreover, I'll echo Dscho's comments elsewhere on the quality of this
> series. It's a tricky topic to explain, and the way you've broken it up,
> along with the commit messages, comments, and diagrams made it much
> easier to follow.
> 
> Others have already commented on things I saw while reading it, so I'll
> just add a few more thoughts.
> 
>> This series of patches are designed to improve the output of the log --graph
>> command; their effect can be summed up in the following diagram:
>>
>>     Before                    After
>>     ------                    -----
>>
>>     *
>>     |\
>>     | *                       *
>>     | |\                      |\
>>     | | *                     | *
>>     | | |                     | |\
>>     | |  \                    | | *
>>     | *-. \                   | * |
>>     | |\ \ \                  |/|\|
>>     |/ / / /                  | | *
>>     | | | /                   | * |
>>     | | |/                    | |/
>>     | | *                     * /
>>     | * |                     |/
>>     | |/                      *
>>     * |
>>     |/
>>     *
> 
> I wondered if anybody would prefer the sparseness of the "before"
> diagram, and if that would merit having two modes that could selected at
> runtime. I'm not sure I'd want to carry the code for both types, though;
> it seems like a recipe for the non-default output format to accrue a
> bunch of bugs (since the graph code has proven itself to be a magnet for
> off-by-ones and other weirdness).

You're probably right about the non-default mode hiding bugs, but if you did want to do this, I believe the original rendering can be preserved by the following small switches:

- always set `merge_layout = 1`; this will prevent skewing to the left
- do not modify `edges_added` if the last parent fuses with its neighbor

I believe all the layout changes are driven by these values, so you should be able to set in such a way as to preserve the original rendering by ignoring the special cases that lead to them having different values.
