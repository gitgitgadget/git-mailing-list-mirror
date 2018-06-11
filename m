Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF601F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeFKQI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:08:58 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40212 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeFKQI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:08:57 -0400
Received: by mail-ua0-f193.google.com with SMTP id l11-v6so13109716uak.7
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=09JFpKtRRh1/D9/0M9gF4Up1cgJtsgF2uafARvQpVdA=;
        b=h36mKTBpuw8hY+nbU+2CQabIJfmkQAEC/vNTKrLBqEzUw10nwUOGPSP/C05kLHpEuO
         DpXuG2iC6QamVtPOcXakzU1o7/ShfUXSOoZ+g1s8HaqV2SD8OwfRfdCwGrJb7fnfbZVP
         FmDqV6F5PE18TZIztpTu1Lx0Dtxrk2WISpqkXAI/SU3odC0JHCE2+IrFZ+KgF+52kt27
         GVDq1PxjTQLL4XspY4TNfaB5P1q2ZS4jBO5LM+e6Hvg1ZN5Qopi/xBBNHs1BljyWjVRZ
         kr3Y+jokQ57fQ0f0UIV1v4ahCzejwN95QUd8sPE7DEpCGnuFMmdjB9HMWJqPIQZlj3yb
         V6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=09JFpKtRRh1/D9/0M9gF4Up1cgJtsgF2uafARvQpVdA=;
        b=WFkcf1cWPmO+Nv1mU2HEwLFb5q8Iq3YchDKWZJjs20WzpXPnKsbRRRysbEI5O3XY+6
         HqRO2FyQSbrSXfd5CewXNU5nhpgsDCRyXqbk2Zndp8BjtzBbtZNNjnrYoOR5IdhKZxIa
         u2CKosERLibmnE4is/CIUkSdqw+O36r44m/Nl4o08+G7o85pfsBSKaADdCCBK7HftNiv
         x1VZJvvnPCiOPw3a1eyBPdrg5svn+yp1w8MA6qFBqY6OLcwlZ7DPVIPbgvYeNadQCIt/
         qGYTlrQhJThfvdZCAJHzaW1srdOeYZokLA91f1b1tywaI1sW5F9oa0iTbijJ2BzO7epS
         WpVw==
X-Gm-Message-State: APt69E1i9Sq3xKzoQHrQbsuQElT2SRbKoNb+PN2v2hjDycraoc0AcTLl
        3rU8CBy+o3jitKnL1zW40PcY/A0Q5w7soSZjQEa0yQ==
X-Google-Smtp-Source: ADUXVKIlknH4y1eNqU4bW3uhOsViSJrbQ9yzVDTZ8G0jsKo1OcTlJoA5SSDRHKN8Aa7BDUPaIfSRQo3GPOKfM+S/iVk=
X-Received: by 2002:ab0:1723:: with SMTP id j35-v6mr11881038uaf.154.1528733335594;
 Mon, 11 Jun 2018 09:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:08:55
 -0700 (PDT)
In-Reply-To: <7e3d71e6-ae97-f47b-382c-085f6a281792@talktalk.net>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050747.19726-1-newren@gmail.com> <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
 <CABPp-BF7POrGTRbVOZ-AGjRHKcpExMQcA4uSPvrRONbnG2CE8w@mail.gmail.com> <7e3d71e6-ae97-f47b-382c-085f6a281792@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 09:08:55 -0700
Message-ID: <CABPp-BEuZDHDAxixrUUXyzbpBXoVfWhfdJR1g9eFN9MSAMjh_Q@mail.gmail.com>
Subject: Re: [PATCH] git-rebase.sh: handle keep-empty like all other options
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, Jun 11, 2018 at 8:16 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 11/06/18 15:42, Elijah Newren wrote:

>> However, we have a bigger problem with empty commits, in that there
>> are really three modes rather than two:
>>    * Automatically drop empty commits (default for am-based rebase)
>>    * Automatically keep empty commits (as done with --keep-empty)
>>    * Halt the rebase and tell the user how to specify if they want to
>> keep it (default for interactive rebases)
>>
>> Currently, only the first option is available to am-based rebases, and
>> only the second two options are available to interactive-based
>> rebases.
>
>
> I'm not sure that's the case, my understanding is that for an interactive
> rebase unless you give '--keep-empty' then any empty commits will be
> commented out in the todo list and therefore dropped unless they're
> uncommented when editing the list.

Ah, yes, you are right; I was implicitly thinking about cases where
the commit became empty rather than when the commit started
empty...and mis-read --keep-empty (which as I learned now is only for
started-empty cases).

> The third case happens when a commit
> becomes empty when it's rebased (i.e. the original commit is not empty), I'm
> not sure what the am backend does for this.

The am backend does not halt the rebase; it simply drops the commit
and says "No changes -- Patch already applied."

It has always seemed jarring and confusing to me that one rebase mode
stops and asks the user what to do and the other assumes.  I think
both should have the same default (and have options to pick the
alternate behavior).

I'm less certain what the default should be, though.

> cherry-pick has
> '--keep-redundant-commits' for this case but that has never been added to
> rebase.

Thanks for the pointer.
