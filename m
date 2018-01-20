Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038011F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeATA1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:27:30 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40702 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeATA13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 19:27:29 -0500
Received: by mail-qt0-f193.google.com with SMTP id s39so8091044qth.7
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=12O7sz06c+N6tus6tvF4WkNYWkNM+v8TCI+K0CAGlcw=;
        b=Ehvbu1MhmG39JduTqizq5NdgbfzYDN2zPnw69eP60b0xwZCfHALbBOZvPeTyn3GdSf
         KZf7etKmGRLYvE4R4TGhrKH8tpR8W8ieuKfMFSDLVaSBgqVg2P1oO7+7bkUXM9UxxVQY
         qTUXWv3Aos/8K8SQshQcV+x5eMBVoG5VkPqS5kENPrj9b6Mal7zIfDCmHYOMzhirEzsf
         wuAcgxagQ6aZ+NHDvl4wVswpMIjYsp3oI+5G7xvGOB7NtNCVm9P9x2Q2PXnVAFOxGnCs
         BmF0OnFh+Yc/cUgGvcn6ru94qNySrmxWprPjwlYC4m/Vmak1SOe/wPfQhFcS4P0ciUc9
         HpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=12O7sz06c+N6tus6tvF4WkNYWkNM+v8TCI+K0CAGlcw=;
        b=fmQUgmVGnSLH5HP4nqmGxxA5gkyHjHepGyAagyumFJwaFgVBbI/QY6A/mzYWV3SiY5
         1oCoOsjvanFjaHbaPT9iknF4abeVLG19k0SIsWd1oOV+POT/Ys6gMRzg9AJlBnrVyBFM
         Ksfxgj3ZWj8B5zvIgfhQZ7dopcYPlJW//40CSTforZ80+5st8i7iXv958TsblAJyI31D
         0mI7Mupbsr5t8VFPIx45Zow8PBpARMF5bTo8tsRP8taq9fAEUyJXFyBDFsGLgGiEAyRA
         oJB3SWD/goh9jiW6myVGQ2OYFRXw+NAmS3JLaMatxabfQwAgG/2yeInZsJ6+2EfP7ibU
         D+xg==
X-Gm-Message-State: AKwxytdeTF8I6U8oBO8eCnjrjbVMOs4DoqSruv4ciCzYNHC/vyNu2FW1
        +h4dtZebdvEGVisqWZvq6qzRJ5nRE8h91LUlYtY=
X-Google-Smtp-Source: AH8x224l882OEGSOmnYAwMmovnN2mE6hlO8lpYSZ4vZoGDbjF01g22V/lfGC29JHAxNYsRMW34XXx58bzkWxYJnGx04=
X-Received: by 10.55.177.135 with SMTP id a129mr400538qkf.112.1516408048460;
 Fri, 19 Jan 2018 16:27:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 16:27:28 -0800 (PST)
In-Reply-To: <20180120002346.GA8965@genre.crustytoothpaste.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net> <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local> <20180119223130.GC222163@genre.crustytoothpaste.net>
 <CAPig+cQmWqQWQrRQHHn=3hn6UFzJxT=9d5kKnJht_dt8sCgwkQ@mail.gmail.com> <20180120002346.GA8965@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 19:27:28 -0500
X-Google-Sender-Auth: fKvnhp3mSdT8gMvQTUxrZ1AuM08
Message-ID: <CAPig+cQe5EC79nUk9aCgsS5rfu6cb2oikhZpiUuSSDoBYSfU5w@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 7:23 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Fri, Jan 19, 2018 at 07:15:45PM -0500, Eric Sunshine wrote:
>> Are you planning on submitting the test as a proper patch as follow-up
>> to [1]? I couldn't quite decide in which test script it should reside.
>
> Sure, I can.  Since you wrote it, may I have permission to add your
> sign-off?

You may...

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> I'll try to set up a temporary FAT device and verify that I can
> reproduce the problem on Linux as well.
