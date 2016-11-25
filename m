Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06321FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 20:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbcKYUd6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 15:33:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36475 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbcKYUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 15:33:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so9292328wma.3;
        Fri, 25 Nov 2016 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NVcvVmKG2ykfyKet18XmHUhyyFbQyuWfZ+ehsep5maM=;
        b=bSwvWv3Ap1cHuJeZDitxPB+B80uI81JlgKJ14WEQGIhENLieAV5fiQY7srgNjRwo51
         ph9ihz6uqKkfwzNQTjQqWVe7tgpthFNE9CiF2n5pz3AG7RruRUXxCZttKwy2G0Y5hQuX
         pqCcyrLAiZHqvR4QZPCQnV/qWkrU4tsfNniKXd02K2DXpkpZkjHPKeD9o8ToC/BkBREb
         yM7PxhIbSebgMRf71HZW1xmCZtB0fHT0H1JrAWN9waUSIAtg0dwQ5NRUV3/i1FoATQ0n
         +UmBYY7Wi3jEKR07GEO+MCvQS3tt/k3AEuSUYqKEyFwNZOuHWQi55sYS2ZNqNMcOTM3t
         gX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NVcvVmKG2ykfyKet18XmHUhyyFbQyuWfZ+ehsep5maM=;
        b=C+NTHJbBEi0VJdRSnkNZOps45PYvbkb2zFZOnSoR8XqFCCDNGlgUNrDto633MU1nj5
         pxeVk1eVEnPC6/LMtyikxO34aG3iOuzCQJbh/iL00oSNwGfuCQcEG2eF2RP+iwZlb2bT
         FxeDTLNZtT8kMBnCYO/HoPVKkSyriuOFDx5Zo0JqEFTM7PVZlvTiFINKKOz3/ad0F+JS
         jo8xFgSD2GcCi6vi2CamqqNJ4FXsVJIMBmdmFzMgODVeKLGh3r+ixGYwOrhGqqihBRy8
         ydEZH8dlv9EKin2MZzi7MAFWFlAdQ0Ej1gfQfITFFfW9vXShrpzQ7hI2ZO3pNXHG5QGy
         BZIA==
X-Gm-Message-State: AKaTC033kd9IAGY/HwGm2Vl3COvHICeyhLyllcj3ulI07NTRvUAq+kuTrcnUhOy60BvgCw==
X-Received: by 10.28.19.67 with SMTP id 64mr9136773wmt.111.1480106034426;
        Fri, 25 Nov 2016 12:33:54 -0800 (PST)
Received: from [192.168.1.26] (adan31.neoplus.adsl.tpnet.pl. [83.11.249.31])
        by smtp.googlemail.com with ESMTPSA id vr9sm48740394wjc.35.2016.11.25.12.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 12:33:53 -0800 (PST)
Subject: Re: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
To:     Jeff King <peff@peff.net>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
 <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
 <5B8DA87D05A7694D9FA63FD143655C1B54331476@hasmsx108.ger.corp.intel.com>
 <20161125031425.gefijvssvygp6pl4@sigill.intra.peff.net>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e11d28d3-c1b5-2c04-643f-0b3bd96cb4d3@gmail.com>
Date:   Fri, 25 Nov 2016 21:33:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161125031425.gefijvssvygp6pl4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.11.2016 o 04:14, Jeff King pisze:
> On Thu, Nov 24, 2016 at 10:37:14PM +0000, Winkler, Tomas wrote:
> 
>>>>> Cc: <stable@vger.kernel.org> # 4.4+
>>>>
>>>> Looks like git send-email is not able to parse this address correctly
>>>> though this is suggested format by Documentation/stable_kernel_rules.txt.
>>>> Create wrong address If git parsers is used : 'stable@vger.kernel.org#4.4+'
[...]

> The patch just brings parity to the Mail::Address behavior and git's
> fallback parser, so that you don't end up with the broken
> stable@vger.kernel.org#4.4+ address. Instead, that content goes into the
> name part of the address.
> 
> It sounds like you want the "# 4.4+" to be dropped entirely in the
> rfc822 header. It looks like send-email used to do that, but stopped in
> b1c8a11c8 (send-email: allow multiple emails using --cc, --to and --bcc,
> 2015-06-30).
> 
> So perhaps there are further fixes required, but it's hard to know. The
> input isn't a valid rfc822 header, so it's not entirely clear what the
> output is supposed to be. I can buy either "drop it completely" or
> "stick it in the name field of the cc header" as reasonable.

Well, we could always convert it to email address comment, converting
for example the following trailer:

  Cc: John Doe <john@example.com> # comment

to the following address:

  John Doe <john@example.com> (comment)

Just FYI.  Though I'm not sure how well this would work...

Best,
-- 
Jakub Narębski
