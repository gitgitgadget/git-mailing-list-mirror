Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60DB81F453
	for <e@80x24.org>; Fri, 25 Jan 2019 02:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfAYC0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 21:26:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45011 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfAYC0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 21:26:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so3966377pfh.11
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 18:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFbhHYPHhhbsGD6Kh33le+iD57WLZMvZ84QUZLIwQFs=;
        b=SvGqMiQMAXoWD18//om7vGgSiXGB4lM5bQMtM0AN7glsZDAivXbCAr4xfrMXytXDT0
         S9Aawe9a9z93S69nGHJ98ENcrgd0UvD+yGpJLrCdDfSN1KZIHs38Euc6gxCqpLowkpRk
         9vsfqbGEak5wQlU880LY0Wa/NUfwgZiTTaMBFln8e+rRojgFcGZ1pkiOQN0NXIYjqLfH
         lHULqzVg3ZE81Tj8a6agS32PMectl76dh/cEMQD84SL2m+qHCn+aihqVsjPU1dNy49uT
         e0ymM2RGeiUfgblMT3Xm6krl/EpLmeNtbr+ujrH9jJ9DInbe32Hyd5pWKl7PID5YZAN1
         cgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFbhHYPHhhbsGD6Kh33le+iD57WLZMvZ84QUZLIwQFs=;
        b=kh9Yp7NVDQ5iCcoPa4gHqwMWAiCN8QCLVOCTUmVSQ+7JmDlyN1iJr+463+kHhX94Sj
         1LJWw+wpCvT2+cRpEZpiBYft69KuG+BgxcPSqWUebtcZygAyBRf/i2kici9y0H7hfSiQ
         f6KbY98g13HPpvwfan/R3Di3mWUjSVjNMa1XcBMeKILuhs/Y5dmYOxO89iAZIRAxseTD
         7Rnv/BMPvvv4r97uY9Ryl/eJiC8EYc4PL1NYAhDa1bw7HgJEymOqO+oxEhwnjfbggA0y
         P3YKlXm8PS7/RGajUB+TD660mqNmu7FkdxqG6HequKJSu8dcv2f+oG8ICF/D0g7OlMGJ
         9tJQ==
X-Gm-Message-State: AJcUukdN75vDTgJby5N8wDUCMbcoKYeVpJT3mGCItMbGUQ52OEPYrSBC
        bJeaoUZs6KYyJJ+sBKfzBs8=
X-Google-Smtp-Source: ALg8bN4YI0KdL2rB97ZplNi3pOQySDXk2LdgA/mVQv7Ab4513Phr++1jHkp08GQKa9DIsPy921lsjw==
X-Received: by 2002:a63:ff62:: with SMTP id s34mr8315140pgk.325.1548383212387;
        Thu, 24 Jan 2019 18:26:52 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u87sm60022772pfi.2.2019.01.24.18.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 18:26:51 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:26:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190125022649.GA540@google.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
 <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
 <20190124011244.GE34357@google.com>
 <xmqq8sz9hd6e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sz9hd6e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I find --ignore-removal fairly easy to understand, and I had no idea
>> what --overlay would mean.
>>
>> I realize this is just one user's experience.
>
> Exactly.  My impression was the exact opposite from yours.
>
> The phrase "removal" in the context of checkout does not click for
> me at all, and neither it does in the context of add, especially
> given that Git tracks states (i.e. snapshots), not changes.

Thanks.  What do you think of --skip-removals (or --skip-deletions)?
The idea is "among the changes that you would be making to the
worktree, skip any unlink() steps".

If that seems sensible, we can use it for "git checkout" and,
optionally, add it as a synonym for --ignore-removal to "git add" as
well.

Jonathan
