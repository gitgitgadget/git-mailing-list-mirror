Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD97C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CFD20757
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+zaZGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgCaUQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:16:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34848 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgCaUQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 16:16:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so18908063oto.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNJERUQeefI0iORiV7i8xIvdhQU548eeSq33NlBq4Lo=;
        b=L0+zaZGXo+z5e4NYcfV2NIwUdcY6SD1aAA7tOpw38t22x08vWjq+Keumdgzt+JR5q6
         e9EkP4aI311YGnmmCc2RnCsns54mSFauviJjoz39xr571lO3qqN86ZNU7EMbXd3WVF6I
         XXIZBS+iWbpi76uSoDqWzJVTm7FJmw44ESkT8EcSer0KnhGWk1N6uD1V4+EZ79z4pJ0X
         9fA5SbfqA2TIIiSpdxcgiUz2PEkIXvqYcsNx98n7nZwlMO2ICXE9vMwirXe3yovGQs3Z
         suuCXs046sxWeiRFmbMcQbcpmes2r/f3mnWWKwiR8V5jUDK75wLMKvIrThqdCOkq66tu
         29MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNJERUQeefI0iORiV7i8xIvdhQU548eeSq33NlBq4Lo=;
        b=ql3UYa4Fis5UxMBCM6XQ9I8SH1jGuyofumIvEPOjsmro63uqyzwseN4wVPUJiEfs/w
         aOreA9tnlUgKuAjrGb424oQoRCZNVQrWtFlAbwDuQd9hcOpWm2/qgi5mGIoKG3zBo0t3
         zs3Kjq2YVljrVdHf8p+iqav7b5U2pMutdXsBLuTvugYLaNqtwc/vJcoctwCyb4hls5nb
         cVkL+hQPBi6ae0I67J5LbdawDq3/UeRH4Lcle1npXrcLHdQCeze5gN7pqmtaE+K1j8uk
         FalnpId5POqxeUStqATR/bneWJVYLFGiz9pkps2J4xPdgOGOfoZ0jMdKlp28LNjlAmsb
         2GyQ==
X-Gm-Message-State: ANhLgQ3RfA0yl8Lov0xV/Uua/P5jt7NiNuiYolar1qe7ymaxJhj1fwFZ
        Aw3J3zW8fgRWLbQ6lq8a+mnTuSjW8V0ybVCjamI=
X-Google-Smtp-Source: ADFU+vs9/ztPYN5IAQBgTnBDXytkX4dtbnQkcdzQmHVPEX7HbKA4P5MollQJUnGFX51pBgaVVPWUoppHFKKH5u+YeKY=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr10214974ots.345.1585685760907;
 Tue, 31 Mar 2020 13:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
 <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com> <752403e339bae098104f41c541c2b0e684586c1f.1585258061.git.gitgitgadget@gmail.com>
 <ffec2a50-e746-370c-1957-3615950bb6fb@gmail.com> <xmqq369raut5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq369raut5.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Mar 2020 13:15:49 -0700
Message-ID: <CABPp-BHQB=cfRtS+xCAZEpk7Y32X=nVr1heAeo+np60054snWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] t7063: more thorough status checking
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> +# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
> >> +# compare commands side-by-side, e.g.
> >> +#    iuc status --porcelain >expect &&
> >> +#    git status --porcelain >actual &&
> >> +#    test_cmp expect actual
>
> ;-)
>
> >> +iuc() {
>
> Missing SP after "iuc".

Will fix.

> >> +    git ls-files -s >../current-index-entries
> >> +    git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries
>
> When you see yourself piping grep output to sed, think twice to see
> if you can lose one of them.  sed -ne 's/^S.//p' perhaps?

Ooh, thanks.  I have to admit that I don't know sed very well.  In
fact, 'sed -e s/pattern/replacement/' was the _only_ piece of sed I
knew.  But the -n flag and p modifier look handy; I think I ran across
them in perl before as well.

> >> +
> >> +    GIT_INDEX_FILE=.git/tmp_index
> >> +    export GIT_INDEX_FILE
> >> +    git update-index --index-info <../current-index-entries
> >> +    git update-index --skip-worktree $(cat ../current-sparse-entries)
>
> Are the dances with ls-files and update-index to prepare us for a
> possible future in which we do not use .git/index as the index file,
> or something?  IOW, would
>
>         export GIT_INDEX_FILE=.git/tmp_index &&
>         cp .git/index "$GIT_INDEX_FILE &&
>
> be insufficient?

I guess it's a matter of perspective.  Do we want to compare to how
git behaves when there is no untracked cache (as I was trying to
implement), or compare to how git behaves when there is an untracked
cache and git is told to remove it?  (The documentation for
core.untrackedCache doesn't actually say when
core.untrackedCache=false that git will ignore it, just that it will
delete the untracked cache when that option is set.  Perhaps if we do
go the route with your alternative, we at least need to update the
documentation as well and perhaps also audit the code to make sure it
ignores the untracked cache as I'd expect?  Or maybe we just need to
run two operations, one to delete the untracked cache, and then the
second that we are actually comparing to?)

> >> +
> >> +    git -c core.untrackedCache=false "$@"
> >> +    ret=$?
> >> +
> >> +    rm ../current-index-entries
> >> +    rm $GIT_INDEX_FILE
> >> +    unset GIT_INDEX_FILE
> >> +
> >> +    return $ret
> >> +}
> >
> > This is a clever way to get around the untracked cache deletion.
> >
> > Thanks for adding these extra comparisons! It really does help guarantee
> > that we are doing the right thing in each case.
>
> Yes, I think it is a great idea to see tested commands behave the
> same way with or without the untracked cache.

Thanks.
