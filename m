Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B38207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbcJCRSf (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:18:35 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36403 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbcJCRSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:18:33 -0400
Received: by mail-it0-f47.google.com with SMTP id 188so40480384iti.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L+/2VH8M9w+lgxx4CR2KAvwIdrh+zV+OF5pT22CwSTo=;
        b=mzwIzG5h68nsAVMtXThhP2kZqLHaXObQIuKT+AIxSEZTnBF71cNRBjEHQnkdvLeugI
         muDWWuqBlx5OIfGNcVNIh7n8IoFGMR+EYdufbNPqDrHFijbfMNf+x8mBCe1prQWMM4g3
         c1Pt5PGYmea6VyOWHjSGM1ydcfhoAtNKdp0mHNg7HaEZDzF3+9iy0zC3VDHpH7x3ULEC
         9RWDILk8URotdT6UhJfo2jr0hX1EEimiabWXwo/5kRhC8k3RMWh+112sbhoXPZq/CVTy
         /ok/aEj605DDB4IemTS6aIoVGuu3pV2lik59d1gQojls9+j3shcXJQLceR2V8mUXKbJk
         KYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L+/2VH8M9w+lgxx4CR2KAvwIdrh+zV+OF5pT22CwSTo=;
        b=Chzc/Pu0yfQFwLeYrjJxVFfqlUPbDYGQStZGrgCsX30Awm/zCo3/4G8vLABkCJ+JX4
         n1d2xJ/CtEWu2VDA+U+ao2Qul22HSvlIaCD5yRnyTqDrcT0UNLA6rQavpepJCVIXR6J5
         Yq+9UdgRLv7M1sGsE+2j7NoXUHyVl/sySmKFcIuB5HGKlJXHCeKOa93MlDMcaTAkDFNg
         LzI0eQBi7JNVbvakt8AWdYNCq2vSvQpkPXWENA0Vpup87Gy2byp1x+QpuFUssdOrJLw6
         BhDEjaPciiAi58qvvOCPipYMKrszWAGe9LSyeHX6qqiZyZJa2+2ZdT/zoawHU6caF+/8
         jPVg==
X-Gm-Message-State: AA6/9Rl1049HO4rdvNN4ffGMQmfYtep6BfdLLUcAwAdpNcnc/aHFHozO6X5acZs83Uy23sO6fdENpOgQCCLXBKm3
X-Received: by 10.36.192.193 with SMTP id u184mr17107088itf.91.1475515112606;
 Mon, 03 Oct 2016 10:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 10:18:32 -0700 (PDT)
In-Reply-To: <57F27B02.8080803@game-point.net>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <57F27B02.8080803@game-point.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 10:18:32 -0700
Message-ID: <CAGZ79kbNVy7VFj31m7VKZYP6xphkV_d9Y1x9Q0_=5PZ+_068HA@mail.gmail.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
To:     Jeremy Morton <admin@game-point.net>
Cc:     Chris Packham <judge.packham@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        mara.kim@vanderbilt.edu, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 8:36 AM, Jeremy Morton <admin@game-point.net> wrote:
> Did this ever get anywhere?  Can we recursively update submodules with "git
> pull" in the supermodule now?

I think the idea is sound.

>> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
>> index 7ca10b8..fc2c189 100755
>> --- a/t/t7407-submodule-foreach.sh
>> +++ b/t/t7407-submodule-foreach.sh

Not sure if t7407-submodule-foreach.sh is the best place to put these tests,
as it is not `submodule foreach`, maybe put it into 7400 (though that
is larger already)

>> +test_expect_success 'use "git clone" with clone.recursesubmodules to
>> checkout all submodules' '
>> +       git config --local clone.recursesubmodules true&&

Nit of the day:
I think we prefer a single white space between the line and the ending
&&.

No need for --local as that is the default.
However I'd propose to use test_config here,
as then the option is cleaned up after the test
automatically.

>> +       git clone super clone7&&
>> +       (
>> +               cd clone7&&
>> +               git rev-parse --resolve-git-dir .git&&
>> +               git rev-parse --resolve-git-dir sub1/.git&&
>> +               git rev-parse --resolve-git-dir sub2/.git&&
>> +               git rev-parse --resolve-git-dir sub3/.git&&
>> +               git rev-parse --resolve-git-dir nested1/.git&&
>> +               git rev-parse --resolve-git-dir nested1/nested2/.git&&
>> +               git rev-parse --resolve-git-dir
>> nested1/nested2/nested3/.git&&
>> +               git rev-parse --resolve-git-dir
>> nested1/nested2/nested3/submodule/.git
>> +       )&&
>> +       git config --local --unset clone.recursesubmodules

No need to unset it here when test_config is used.

We'd maybe would want to also test that
git -c clone.recursesubmodules clone --no-recursive ...
works as expected (the --no-recursive taking precedence
over the config option)
