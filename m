Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0161F403
	for <e@80x24.org>; Wed, 20 Jun 2018 15:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeFTPID (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 11:08:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45129 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeFTPIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 11:08:02 -0400
Received: by mail-oi0-f68.google.com with SMTP id 188-v6so3295128oid.12
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CapSJqPDkSMQjP72lJ2ZRCVAL50BUSUqG3yf0fWzS8=;
        b=KmT8uQlVbl0hM5hkvoD8j9s3TcRB4Hk765axvKTIxAxuKGPSRS5TWB4frhHSTVFyHE
         LPoNDJEguiHxrM820ICUVFe+o3o3ggmTKeCIkWSoqFAVGXWRmMy/APi8o2tB3pCdazeR
         TbgO+Kr2jRFOuntmZAFWoBrlDZqb1VCLRqfoH0lLapfouM+sAYjpfUEe3zr1R8lQcU9W
         gTxIA6V86MUp7qNYJz1lgABxeS2z82s4fFfZ1K/Ld6/tW5dODaVR+PboQFOj6mRgdrS5
         9cr+E/j2Myp3R4nagbyUXMGoydJ5cgY39LQm1G0AXCqUxLc6BXsSxLCL3BRxc8PdHuRJ
         9ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CapSJqPDkSMQjP72lJ2ZRCVAL50BUSUqG3yf0fWzS8=;
        b=cu70kTzBQdZEtwlxJWDllDi6MS5uQnQY/UGBKCMschMKk1WxZXlMfkC0c05MzcP7u/
         iDvqQfJNCgbCpZ83iEANVYALKiQRNuuJ+0DNFiIrg6rKzcE3mh7N+cl7AAv6coeoQhqf
         Th6mgkZVwqY4AAWZ5y991cnprjcBYXjaqVtevROAd/1fcGQUvZuYjoDavHxiS5in4Ba7
         XeETFcVOnvCrA1oXEIrXtynMvu98fz4GU427jidLN7oAeAxpbKdNCtUX7PuoyAPvMZqr
         seE8OmjEE0K4/9D6RLHxox1iw6ss+ggXKZgjs+9UwUbD3ZJSSaJpY747ruyZYSVIfZq4
         w59A==
X-Gm-Message-State: APt69E1r12NlmElpgX4JXz/lTkmk9V/GV4OOeflRyo7m3kQ69s3gTzTf
        SxNCmvTNad3HXSyujNk8r0HxO91M8kFZ6M8eIIA=
X-Google-Smtp-Source: ADUXVKIFCLCvM3HdLslyO0gXqk/gSy71G9zh7erOXeCPc5j1YztTjp0vTaFXsufivmhaV4hlMtDVm+ijeuepIONrH4M=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr12433481oie.30.1529507281459;
 Wed, 20 Jun 2018 08:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-7-dstolee@microsoft.com>
 <CACsJy8DG1-YTSBSFkpM8BPcnKmvC-BjjK0W0+EckkdENPC7Ohg@mail.gmail.com> <2906e8e8-ca32-828f-e8d0-35b0dff7db81@gmail.com>
In-Reply-To: <2906e8e8-ca32-828f-e8d0-35b0dff7db81@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Jun 2018 17:07:34 +0200
Message-ID: <CACsJy8B4HBrbuog-38o4YA2dKSQejhd4LOQn4+nswi=Wnod-iQ@mail.gmail.com>
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 3:33 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/7/2018 2:31 PM, Duy Nguyen wrote:
> > On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> >> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
> >> index dcaeb1a91b..919283fdd8 100644
> >> --- a/Documentation/git-midx.txt
> >> +++ b/Documentation/git-midx.txt
> >> @@ -23,6 +23,11 @@ OPTIONS
> >>          <dir>/packs/multi-pack-index for the current MIDX file, and
> >>          <dir>/packs for the pack-files to index.
> >>
> >> +read::
> >> +       When given as the verb, read the current MIDX file and output
> >> +       basic information about its contents. Used for debugging
> >> +       purposes only.
> > On second thought. If you just need a temporary debugging interface,
> > adding a program in t/helper may be a better option. In the end we
> > might still need 'read' to dump a file out, but we should have some
> > stable output format (and json might be a good choice).
>
> My intention with this 'read' pattern in the MIDX (and commit-graph) is
> two-fold:
>
> 1. We can test that we are writing the correct data in our test suite. A
> test-tool builtin would suffice for this purpose.
>
> 2. We can help trouble-shoot users who may be having trouble with their
> MIDX files. Having the subcommand in a plumbing command allows us to do
> this in the shipped versions of Git.
>
> Maybe this second purpose isn't enough to justify the feature in Git and
> we should move this to the test-tool, especially with the 'verify' mode
> coming in a second series. Note that a 'verify' mode doesn't satisfy
> item (1).

Yeah I think normally we just have some "fsck" thing to verify when
things go bad. If you need more than that I think you just ask the
user to send the .midx to you (with full understanding of potentially
revealing confidential info and stuff). It'll be faster than
instructing them to "run this command", "ok, run another command"....
I thought of suggesting a command to dump the midx file in readable
form (like json), but I think if fsck fails then chances of that
command successfully dumping may be very low.

Either way, if the command is meant for troubleshooting, I think it
should be added at the end when the whole midx file is implemented and
understood and we see what we need to troubleshoot. Adding small
pieces of changes from patch to patch makes it really hard to see if
it helps troubleshooting at all, it just helps the first purpose.
-- 
Duy
