Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1763202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 05:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbdKNFZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:25:30 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:56402 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbdKNFZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:25:29 -0500
Received: by mail-it0-f46.google.com with SMTP id r127so12145889itb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 21:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=q6teA5ud9xKtOAo43VB4+XBXwXyQDwaiDXo5K1Ac7g0=;
        b=jZhyc5Ggvy7fU/u6FQWB662Gypkv+JDgvguqOeDDrbLKPPzzoCQipCLhBXXwptUqLc
         cVFNYl4u+pKsXcTqrc5tk4UP3Tqg5PO2D3SclM0/Reqh4aBKemRVfiIvH1BXG142dHmd
         W8A1rsV/hRB2ln9qj06jF2w9QSPdMD/G7asliZuVeawjVBb8LAyNfi+sn+DbR8JWugdx
         m1PslnxA7odpzmdzCkjIH2XeodAcMhWynKn+rk4YpKqHvV4KWEaiPgbn9oE/OdVkG7Vb
         hdBs95mUICKzYAo4flYAxp7L5C9Mfqg+DzthkxOfQSvRgTy+B0mEoWFAWI8xsThvLvYj
         IUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=q6teA5ud9xKtOAo43VB4+XBXwXyQDwaiDXo5K1Ac7g0=;
        b=BBtlay9PAJ8r1Yivw75p/pPQTkYNtv+jfF7LTjpthGrZBmzsJWt9WQHI0GVJ5NQfwu
         oaxa5kHsUALXhkTb92N81BPbM8fJ2ireTUBygnUcsGcqXBoY/mVJLrw98OCnkkvYfiag
         AOvc/FvukW3sweHl9PN+GTUwSvX52MOihcx4gpZqNrAYTT4zMxfd13LTjlf6fb9nGCmi
         waXUXSL7SiwInSlFuDVt9vP9G5UPl5mn9UEuBoLV6XuHeiVMjzBvo7ATqJ3wiRRbC0jU
         ln3gXDKV6bf/uQSB4M2ZeVMX0cObCsZ8Kvj9D0IOEeLft+vKwOxka0Pp8HJsnfUhFoss
         ZpHA==
X-Gm-Message-State: AJaThX4M2/7PiE26LxTaiLoJYKdEMdNmB6QPY7u4ewCn/zWWDlJqouf9
        PYGuywWFZGlYXNVE5Ra33wQ=
X-Google-Smtp-Source: AGs4zMYfPAzTbUT2xzm16fezYRKYcja/IH3Xha0204C2We/DRUrpkqIZP9m23R70oHtru2uXEO62Fw==
X-Received: by 10.36.160.201 with SMTP id o192mr12401108ite.58.1510637128868;
        Mon, 13 Nov 2017 21:25:28 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:2f84:b67d:915d:8353:ad4c? ([2405:204:73cd:2f84:b67d:915d:8353:ad4c])
        by smtp.gmail.com with ESMTPSA id f12sm8154762ioh.21.2017.11.13.21.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 21:25:27 -0800 (PST)
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
To:     Kevin Daudt <me@ikke.info>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
 <20171112182322.GA17612@alpha.vpn.ikke.info>
 <29bd81e4-e8df-8fb8-9436-d70902106f49@gmail.com>
 <20171113113018.GB17612@alpha.vpn.ikke.info>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <5a0edab6-4e34-e9aa-4a27-0a19606b9b8d@gmail.com>
Date:   Tue, 14 Nov 2017 10:55:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20171113113018.GB17612@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 13 November 2017 05:00 PM, Kevin Daudt wrote:
> On Mon, Nov 13, 2017 at 08:01:12AM +0530, Kaartic Sivaraam wrote:
>> That was a little attribution I wanted make to the strbuf API as this was
>> the first time I leveraged it to this extent and I was surprised by the way
>> it made string manipulation easier in C. Just documented my excitation. In
>> case it seems to be noise (?) which should removed, let me know.
>
> I guess that would fit better below the the ---
>

That's a nice point. Thanks. (Why didn't I think of it before)


---
Kaartic
