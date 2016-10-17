Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66F720988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758687AbcJQJqQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:46:16 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33278 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757919AbcJQJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:46:14 -0400
Received: by mail-io0-f177.google.com with SMTP id q192so182492035iod.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/yX0BXIPZvDg97X+d3l/CV89A3gMC6VrSB+2KP1cwDk=;
        b=PdDPNysEkRVRlVhc3veE+OLizL1zueCSYrRF0MeqvO63tbGGg9Pp6txG+mEgspUFFX
         JUYXEUmKg90U+YTe0kxFFW2+zdswTffdjpL9tnHXyLg+/Fw5JVGBeAw7ercKQRA8i+7Z
         EKM5yRpsi5pk0iHI8TxXZIuTdx24szUIdMeQjEDFsDxKFle17aJhqVkXN2KKIOcF3uZ5
         FnqC2mHJeFInKSIaowOVraxuCIpPOyBZ49Bgmc66NS13g3hNLANG1EV/0Sj+1AAhzuG7
         Pg3GTmxTbRgPhw5knBHOo6bUhjLtJ7Od2BDfmlS8oGbXTz+JJ2uG1L1lBNVQisVuHxgc
         PnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/yX0BXIPZvDg97X+d3l/CV89A3gMC6VrSB+2KP1cwDk=;
        b=N/DPjvswTxjBg5rsjhyYk/VzI+zIxQi/SPMgG3ErB1k/SczrC1weGsdEHbIpFCmxp4
         7illqcFZ3CeZCKWuAgSjc21/CL34LNkLqPgZW/pvl8izGHi3aFPlBh0RQjhM+L0xkot6
         UiO3YsRAFuf1Ua1Xz5VMPAzvyGdafAcO8dSa4H7N3e4Z8RxpuNR7HQnnEtR1ajTiTAJA
         Zr38RmpyE0I5Hl4Bdl7m/Xi/ZdMpUFab5gHHhS5pBL166IhjhvKx4kbWkbvdeerGF/hr
         7oe5/LOxn2gHc+8rvzUE4mQQXnCm6sGlulCMXmSPHU3giwhQkxAAi3iU5mNY+ACIxcVl
         Ybyg==
X-Gm-Message-State: AA6/9Rk0qXG3S1QP1vEchQdozwO2WCz3yzwbOQbBYw098CaZJxgv0LIskAhPUmaKIj78GQYTVUldfAw9gXgdBw==
X-Received: by 10.107.59.6 with SMTP id i6mr25569688ioa.176.1476697573799;
 Mon, 17 Oct 2016 02:46:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 17 Oct 2016 02:45:43 -0700 (PDT)
In-Reply-To: <f0c11de1bd4d414d8a9464e6ccc1d58a@exmbdft7.ad.twosigma.com>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
 <CAGZ79ka1rJCks5np9Q__HAHYFDrdGDFLtquhb3fY_iL8q9DEkw@mail.gmail.com> <f0c11de1bd4d414d8a9464e6ccc1d58a@exmbdft7.ad.twosigma.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Oct 2016 16:45:43 +0700
Message-ID: <CACsJy8BAB4sqnv1GBk=K9yUuqVhW4Y=CHdON7mnM9PY08HwdGw@mail.gmail.com>
Subject: Re: Uninitialized submodules as symlinks
To:     David Turner <David.Turner@twosigma.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 8, 2016 at 2:59 AM, David Turner <David.Turner@twosigma.com> wrote:
>
>
>> -----Original Message-----
>> From: Stefan Beller [mailto:sbeller@google.com]
>> Sent: Friday, October 07, 2016 2:56 PM
>> To: David Turner
>> Cc: git@vger.kernel.org
>> Subject: Re: Uninitialized submodules as symlinks
>>
>> On Fri, Oct 7, 2016 at 11:17 AM, David Turner <David.Turner@twosigma.com>
>> wrote:
>> > Presently, uninitialized submodules are materialized in the working tree
>> > as empty directories.
>>
>> Right, there has to be something, to hint at the user that creating a file
>> with that path is probably not what they want.
>>
>> >  We would like to consider having them be symlinks.  Specifically, we'd
>> > like them to be symlinks into a FUSE filesystem which retrieves files on
>> > demand.
>> >
>> > We've actually already got a FUSE filesystem written, but we use a
>> > different (semi-manual) means to connect it to the initialized submodules.
>>
>> So you currently do a
>>
>>     git submodule init <pathspec>
>>     custom-submodule make-symlink <pathspec>
>>
>> ?
>
> We do something like
>
> For each initialized submodule: symlink it into the right place in .../somedir
> For each uninitialized submodule: symlink from the FUSE into the right place in .../somedir
>
> So .../somedir has the structure of the git main repo, but is all symlinks -- some into FUSE, some into the git repo.
>
> This means that when we initialize (or deinitialize) a submodule, we need to re-run the linking script.

Do .git files work? If .git files point to somewhere in fuse, I guess
you still have file retrieval on demand. It depends on what files to
retrieve I guess. If you want worktree files, not object database then
.git files won't work because worktree remains in the same filesystem
as the super repo.
-- 
Duy
