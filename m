Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C3320986
	for <e@80x24.org>; Wed, 19 Oct 2016 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943839AbcJSTTb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 15:19:31 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36654 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbcJSTTa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 15:19:30 -0400
Received: by mail-vk0-f67.google.com with SMTP id b186so1611886vkb.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Aox/2HUl18GMN8vSCugbw+az6gYRHc50ae4qicEvrGM=;
        b=TMmezPQoFzySnsC2HnDuTjq8abtMl+8MgRREmeCUceYwWZvpABSYNvKpo9DR4QMzHI
         il4Spi3hMcI1NMHfZ7OWjFL+nYKIe5QOnC53xedcnVG+dOskJV5KgcbYz1wDLIqI1J7w
         3UJJzSllm6HO3zVLfXcGay0y24dIJI2lHAurYbSEAdae8g6RXIcG706tdbJJigf0YgtB
         8b+NAwwrKO0q6xcgcm0YE1L4texLwsnbBWzvxAOGEErMjkoaoRFevOMb0H4UCn3zdMqe
         WBj+qN1de1WpgzB/OvUBrThEgxDmV6SPAdiCXvrDCKT31z8+tEt8ppkMNmarYMev2iD/
         si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Aox/2HUl18GMN8vSCugbw+az6gYRHc50ae4qicEvrGM=;
        b=b8lO8lQcx+OIL8ChzPb63gSeoF0oQp3E6L/HI8PfyJZTVCx5hEknT+BFM6FubBZntF
         f6Rq7C/tuS/w0nvLs4O4qrPxtNCWQapBkllTMv4kcuRsfqJ03TIYFboE/wu+XWSBJaTC
         ciIqTROPPD69aCFavrFUEqwyLhKBJCtihgVNEb05wIehOVFUQIwF95vUqVtBO4iN66ya
         xqu6XGiCXWDonVz4BGR19HQxwIJRGOIcBF2nBGT7dVEVtGyRrUpOu2HwU7FInBJ96gyX
         7pjmx7bI48PkdqYwOwjj9qet/PCZO5nwUhD5QrzrGpFLCpEp9xgQwJqubNUa9O93X/1W
         cYoA==
X-Gm-Message-State: AA6/9RmNP0pWnZZFv/ZGP5Gxuu46RZm0658SbGrNLXnCmL82r3PveGX90uoFHuKUe8vfKkXx/grmcaG01OsfHg==
X-Received: by 10.31.141.5 with SMTP id p5mr6969802vkd.136.1476904769594; Wed,
 19 Oct 2016 12:19:29 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Wed, 19 Oct 2016 12:19:29 -0700 (PDT)
In-Reply-To: <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
 <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com> <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 19 Oct 2016 14:19:29 -0500
X-Google-Sender-Auth: qtXIWp54DxU94-o5Gy9KEkUAPSQ
Message-ID: <CAHd499D_fehBHsNdH9PLQj+H_WAJqbbMhDwv_nCT3fZcX60ENA@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Stefan Beller <sbeller@google.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 11:23 AM, Stefan Beller <sbeller@google.com> wrote:
> You could try this patch series:
> https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
> (rebased to a newer version; no functional changes:)
> https://github.com/stefanbeller/git/tree/submodule-co
> (I'll rebase that later to origin/master)
>
>>
>> Do you have any info on how I can prevent that error? Ideally I want
>> the integration to go smoothly and transparently, not just for the
>> person doing the actual transition (me) but for everyone else that
>> gets those changes from upstream. They should not even notice that it
>> happened (i.e. no failed commands, awkward behavior, or manual steps).
>
> It depends on how long you want to postpone the transition, but I plan to
> upstream the series referenced above in the near future,
> which would enable your situation to Just Work (tm). ;)

At first glance, what you've linked to essentially looks like
automated `git submodule update` for every `git checkout`. Am I
misunderstanding?

If I'm correct, this is not the same as what I'm talking about. The
problem appears to be more internal: When a submodule is removed, the
physical files that were there are not removed by Git. It leaves them
there in the working copy as untracked files. The next step Git takes
(again, just from outside observation) is to add those very same files
to the working copy, since they were added to a commit. However, at
this point Git fails because it's trying to create (write) files to
the working copy when an exact file of that name already exists there.
Git will not overwrite untracked files, so at this point it fails.

What needs to happen, somehow, is Git sees that the files were
actually part of a submodule (which was removed) and remove the
physical files as well, assuming that they were not modified in the
submodule itself. This will ensure that the next step (creating the
files) will succeed since the files no longer block it.
