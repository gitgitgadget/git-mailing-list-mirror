Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FCA1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbeDXQpC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 12:45:02 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34249 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXQpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 12:45:01 -0400
Received: by mail-qk0-f169.google.com with SMTP id p186so17415582qkd.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hy+6y5MpdJ4Rp0kLMyRYRBv22Sglw7skBKDpjAaj8XM=;
        b=q7MkLtZs7wIlH8JhPm22l7VZYs9ysQsSJ8/LH9J0/0psf8PsiXuUnwbKS9vyktp7wP
         cjUkBd10aLFLh4CaFA+DwuOb8JwnpdO4f+3fjFwHjEkCVPXNh+jaQjvt/fvwFvM20gPu
         JRhQFtP9GTm4I8XckTtcxg7Msanhnr+ObDsCRPt40ps2CaEwwvPhTifGTKasa/imAYIw
         N4HaYGSaXwqV3Lu5tWpsm7VDObW7FTUsBqCTkHRVwbMz7Dkb/VXqoO2MjLXMXWOKCHUV
         /bb1Dn9BQUQDW523QuiTa8O3F6p7uJ7OmgxGAHZWZbzi2H/Im9FakIYALaM9PM2Zql9j
         6aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hy+6y5MpdJ4Rp0kLMyRYRBv22Sglw7skBKDpjAaj8XM=;
        b=jhvEW4AGbgEBt3Yh69uuFRs3smHU7haSuSEXkVcOaCo8ngHGoYLlz7w89q1FkIJ5ef
         r/3osScCsY1tlUwFYp03OYQ0nrNqfh7gK6NIwjn03oFvWcqBYzfxlIzBDQmhZ38I0hx/
         qis3A2CvkVgOuGFmCud5XN5Rb64o/IbsRkcdyu2R+BAfKNaVZ7jaKfxhcijbiyWaWoh7
         Dc7G/15JPZAFsF3NJ8LaisXatQLvCftvCHy7wlTICQzv8OHvWvCikmCKAsUxU909MptL
         ebAL8KOZfsXpFKAMb3u4yQaflyXewY9MwCioAc8a5zq5ySxwFeyEOKhWYJxTN3FmQ9ci
         IvxQ==
X-Gm-Message-State: ALQs6tA7UMR2gslSjhjEI1hDlG18tQpdJTTlGfw+C+Xv8lu3DqWBavng
        Ng6W7CIys1L1soAnF0O1Bc0=
X-Google-Smtp-Source: AB8JxZrAtvtOD6PHlWRVCkhYZTodsWB4zCXAIGaLFfnoPRLj0oG5Q1B1N9nhQrk+toe1mOIl6jQ/vQ==
X-Received: by 10.55.15.17 with SMTP id z17mr27225635qkg.184.1524588300828;
        Tue, 24 Apr 2018 09:45:00 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l62sm7212020qkf.46.2018.04.24.09.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 09:44:59 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] merge: Add merge.aggressive config setting
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-3-benpeart@microsoft.com>
 <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com>
Date:   Tue, 24 Apr 2018 12:45:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2018 1:22 PM, Elijah Newren wrote:
> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> Add the ability to control the aggressive flag passed to read-tree via a config setting.
> 
> This feels like a workaround to the performance problems with index
> updates in merge-recursive.c.  

This change wasn't done to solve performance problems.  We turned it on 
because it reduced the number of unmerged entries (from 40K to 1) in the 
particular merge we were looking at.  The additional 3 scenarios that 
--aggressive resolves made that much difference.

That said, it makes sense to me to do
> this when rename detection is turned off.  In fact, I think you'd
> automatically want to set aggressive to true whenever rename detection
> is turned off (whether by your merge.renames option or the
> -Xno-renames flag).
> > I can't think of any reason this setting would be useful separate from
> turning rename detection off, and it'd actively harm rename detection
> performance improvements I have in the pipeline.  I'd really prefer to
> not add this option, and instead combine the setting of aggressive
> with the other flag.  Do you have an independent reason for wanting
> this?
> 

While combining them would work for our specific use scenario (since we 
turn both on already along with turning off merge.stat), I really 
hesitate to tie these two different flags and code paths together with a 
single config setting.

While I don't want to needlessly complicate your optimizations in this 
area (they are already complex enough!) I believe we need to keep the 
option to turn on --aggressive without turning off rename detection as a 
viable option.  Perhaps if that is the case, your optimizations have 
less impact or don't apply but the user should be able to make that 
choice for their specific situation.

> Thanks,
> Elijah
> 
