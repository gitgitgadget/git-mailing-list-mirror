Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEDF1F406
	for <e@80x24.org>; Fri, 19 Jan 2018 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeASHkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 02:40:17 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44406 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeASHkP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 02:40:15 -0500
Received: by mail-io0-f195.google.com with SMTP id z6so1222786iob.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 23:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=grzIY5fr+EdGfapnES360pisF8eL8xUgIBfbFTKt4PE=;
        b=CTg1CTsFlyeSpsM9a4kF54Bwe46LqCeLuCxK0/RLrWiF0RyFHm5xFb021locBJLxPc
         jesz8wAqI++80l1uryqo5Y8hso39AeUNnBh2JKfFzCL7IC+sy/g/JoZcSbgeEcvbrDCX
         GfIoupbO1aq683tmX2gNwswVLw9bvNJNVc1cNSmB0i+NPdsvrWGpOF7VKzW5Olb1Df6q
         DeElpgCKUcX4mJCMUG3u0k200Uje5Dtesxj95ENL5YZPCyECQ13sxR4EJKvDL9lOluAp
         W+pVaOfwcM5YFHwdPIcz0oZ6CV1qU66cGzoeYMpDhWi2T0znadoPbspSZjNfv8WivjqL
         iORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=grzIY5fr+EdGfapnES360pisF8eL8xUgIBfbFTKt4PE=;
        b=izx7z48e65kJ/BauGSGZWPYTSmyxHh+Hwj4OjsRgf+XlUzxOT8Ryvc/1eEKCmNh5qo
         piFIXqUOEPxdgcV9Ry28wPAizxOm66Lm+qQw3Eyx88adg4zttLd+OtvhmGn58w+eX5lQ
         /IZWDOvPJPACZcUb5ofxkPgQIQCjF5nZT/zIi6W6CIwSmEhPosWXuJPvtnhzbBLM9H4s
         oI9IbZnlvW9p/p6GHXKP9LW72fNAmvDrrjtb4evDhx69HDtoH4KYltHEdy3bL7IDU5FW
         sQoRvatWewFVKDU72oDBIheYHi6c0I7mDDZ7zqmdz8iNXKtiFjVN53M4bxbc/oGDgkzx
         D7KQ==
X-Gm-Message-State: AKwxytekaqm32tYa261jZFSqPvS1Ib0/H6ubyVv/M8Yxafp+qpLGtSBx
        cWYra+2C+4ZVg4+dy24hhIw=
X-Google-Smtp-Source: AH8x226DLDJRGu2Gx5j0xlABaylYMMUMzyV+jgDDXI3le8pFQS51OC8QEZftYAEss14+n5Yv4ghC4w==
X-Received: by 10.107.38.21 with SMTP id m21mr996131iom.69.1516347614570;
        Thu, 18 Jan 2018 23:40:14 -0800 (PST)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id n4sm446701itg.2.2018.01.18.23.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 23:40:13 -0800 (PST)
Date:   Fri, 19 Jan 2018 02:40:02 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180119074001.GA55929@flurp.local>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net>
 <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net>
 <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 12:31:58PM +0700, Duy Nguyen wrote:
> On Fri, Jan 19, 2018 at 10:40 AM, brian m. carlson
> > I'm still extremely puzzled as to why this doesn't fail on Linux.  If
> > it's failing in this case, it should very, very clearly fail all the
> > time we access an empty blob or an empty tree.[...]
> 
> I think it's file system related, case-insensitive one in particular.
> 
> The call trace posted at the beginning of this thread should never
> trigger for an initial clone. You only check if an _existing_ entry
> matches what you are about to checkout when you switch trees. For this
> to happen at clone time, I suppose you have to checkout entry "A",
> then re-checkout "A" again. Which can only happen on case-insensitive
> file systems and a case-sensitive repo where the second "A" might
> actually be "a".
> [...]
> On Linux, after I hacked all over the place to force ce_match_stat()
> to eventually call index_fd() which in turns must use one of the
> hashing function, I got a crash.

Nice detective work. This particular manifestation is caught by the
following test which fails without brian's patch on MacOS (and
presumably Windows) and succeeds with it. On Linux and BSD, it will of
course succeed always, so I'm not sure how much practical value it
has.

--- >8 ---
hex2oct() {
	perl -ne 'printf "\\%03o", hex for /../g'
}

test_expect_success 'clone on case-insensitive fs' '
	o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
	t=$(printf "100644 X\0${o}100644 x\0${o}" |
		   git hash-object -w -t tree --stdin) &&
	c=$(git commit-tree -m bogus $t) &&
	git update-ref refs/heads/bogus $c &&
	git clone -b bogus . bogus
'
--- >8 ---

(hex2oct lifted from t1007/t1450)
