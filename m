Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CD320754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933514AbdADSKC (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:10:02 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34323 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdADSJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:09:12 -0500
Received: by mail-qk0-f175.google.com with SMTP id a20so19318287qkc.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=if93Zkago/a6ptlxJmhI0Z4Trzah5YacvmEB51qmVp8=;
        b=jGXwfX97aGgRHjMVtXgsgJ/Jpos6o7f2hLarM2znUSTwD7AqD2xCaN0YlfatcxYc6a
         96H2pJg/+j9tg1BIbwoz9smHxwJMKKUBvfVdv0/LFbH520TaMb6PLuV0GKnvv7a20kW6
         ci6et/HNf3dhm9g44UWvehiPSIpYnFbHSyH8FweV960veUcR/+PfASKEbimPS77Ukq39
         iqWNLnq1vmM3US0ZxFH20DHqCS1FFQZN/zT8Gwo543TRqg+RfWCUm9fmPVYY4W+TS3YT
         e3JAECIXXPn4K207Qxsd1GXPjN8otwrahoU6QiakuaEiBynATMtT3YN5fN1Bp4n2xFPT
         4p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=if93Zkago/a6ptlxJmhI0Z4Trzah5YacvmEB51qmVp8=;
        b=ii4MZrP6SiU9aADIozVi3CxGpfmD0vzZNLjbX6wkLmaGEXoTSdLymtRiyccL0YWES6
         K3LO6fzE24W4iupwL2564qXpyQ3g3qO+WtP/i7Y1dLG23IjDdb8rAuVWtoAwW/n2msA4
         grQFfgLzKf/+VP8lShIi8SXz/CLjUMVOQXbXc/zhSx1EFcpBOgFb2MA31RFfCetLq8iy
         RRfSkyxKRNmA4Nml9OG0t9JCMsJkqynJo2Ywrduu+A7auENQSv6f6kNgc8FaA37ew8bZ
         jFOPC3sn+T1p6FKlXaC5HNgc4+QJrktEfbpWD0lmTSbWQWQTVsaPru3xSxze/4C71OfB
         yU6w==
X-Gm-Message-State: AIkVDXKFTVoHksX72LRQMAHwR5+L3A4FFql7qLp2PP0OD5xp+xupu+0bfKkLNFxo2YhkXjpbTgjiGVsxE5rgcku0
X-Received: by 10.233.216.7 with SMTP id u7mr64746945qkf.220.1483553351050;
 Wed, 04 Jan 2017 10:09:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 10:09:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701032231400.3469@virtualbox>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <cover.1483373635.git.johannes.schindelin@gmx.de> <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
 <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com> <alpine.DEB.2.20.1701032231400.3469@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 10:09:10 -0800
Message-ID: <CAGZ79kbNYZpYh9fMDKEhMiO5L8SbbtSC8f79RAa-wsOUxE8LDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d git_exec_path()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 1:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This patch was originally only to appease Coverity, but it actually *does*
> plug a very real memory leak: previously, *every* call to git_exec_path()
> *possibly* returned a newly-malloc()ed buffer. Now, the first call will
> store that pointer in a static variable and reuse it later.
>
> Could you maybe help me with improving the commit message?

As someone not familiar with that area of code, this explained it
enough for me to understand, so maybe:

    exec_cmd: do not leak via git_exec_path

    Every call to git_exec_path() possibly returned a newly-malloc()ed
    buffer. Now, the first call will allocate the buffer and subsequent
    calls return a pointer to it, which then prevents leaking memory
    on each call.

The return value of a "const char *" hints to the caller, that the memory
is not owned by the caller, do we need to be explicit there (i.e. a comment
declaring the memory ownership? Probably not.)

Thanks,
Stefan
