Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3141FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755185AbcK3VBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:01:48 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33747 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbcK3VA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:00:28 -0500
Received: by mail-qt0-f180.google.com with SMTP id p16so200381406qta.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=axdxgzrvbKbjDJQnJsDctOtmkGDMtguHrn8NqHTdivI=;
        b=JS9sgThyiVitMHsrAZsbg5OM9BS9nfKcSQvJ2Lyc+aaeD9VImlCl2wSpCdZ3NmEzww
         KYQjt2WWTf1SCDa1lqLiDVWgbvl06ZtOceuwttmKGxrwevE8msQi97sdva9uMUzt/xgU
         85pXtnjAtjegTb6xaPScoVOHXjzXzysT5oWHtlO8hoSJU7XNZwQ/RDoDTk1/TdHYUCr2
         1wkTm4P4HWNZAyn7/gODxTAoLLf/JZU1xqeXv6jQ5pslPa9JBQT39+8dpGb4r/8Y/846
         r0fEm8LSrG78G6yAqvgZWLqmSM/zyys/Ze9GAaH13OhCOn5Bw8Xu3rCVMH810wUdHb7L
         ja5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=axdxgzrvbKbjDJQnJsDctOtmkGDMtguHrn8NqHTdivI=;
        b=TQeDXdJjK0AhZq/+p/Cd7Ft2tMRLBZrAu9TTasrXhtZNUkhxDGiOkeNJXnkKMjVmf0
         wQkwisfILvVgT501uU7Odl9vPC2+T95IkPQQT4oVRv/Yc90aK3zaPA5lyjBZETMTULU7
         DIHfUcY6ygiYuHxuqngIsqKdkGuMV2takVKTQUVaRCe38k9vB9IizsofoN/pWGSMSmA7
         URuGRQTfKanWi7RnVxzBDITufpnAIhiiGy/vPfIOjLrNcBpytyOopwFDYHkp8ISBFGLj
         XZv/wluUFS0Zx4N3uEDW0t6XK9dd2n8ObegqBScSRUsdOHGYnNN2CzxMcwu6+dYgbOmS
         iBbA==
X-Gm-Message-State: AKaTC03ZHbX5kvqwPZiMN2qz1Br6pV8u4MMsrmny+XX/U3eCa8iv49ieBoUJ82KsvOIit0ne9BWLh6BiNGyElKf7
X-Received: by 10.200.50.53 with SMTP id x50mr30705617qta.207.1480539627125;
 Wed, 30 Nov 2016 13:00:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 13:00:26 -0800 (PST)
In-Reply-To: <xmqqpolcd73b.fsf@gitster.mtv.corp.google.com>
References: <20161122192235.6055-1-sbeller@google.com> <20161122192235.6055-5-sbeller@google.com>
 <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com> <xmqqpolcd73b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 13:00:26 -0800
Message-ID: <CAGZ79kar0F7x5U2yZ30ZnWZ9b=EJA=1nT8rxTMRVJPggyFS_XA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Nov 23, 2016 at 2:22 AM, Stefan Beller <sbeller@google.com> wrote:
>>> +/*
>>> + * Migrate the given submodule (and all its submodules recursively) from
>>> + * having its git directory within the working tree to the git dir nested
>>> + * in its superprojects git dir under modules/.
>>> + */
>>> +void migrate_submodule_gitdir(const char *prefix, const char *path,
>>> +                             int recursive)
>>
>> Submodules and worktrees seem to have many things in common. The first
>> one is this. "git worktree move" on a worktree that contains
>> submodules .git also benefits from something like this [1]. I suggest
>> you move this function to some neutral place and maybe rename it to
>> relocate_gitdir() or something.
>
> Yeah, good suggestion (including name; first round used "intern" I
> had trouble with, then "embed" which was OK-ish, but probably
> "relocate" is better choice.  If anything, what Stefan's series adds
> is a command to un-embed embedded one).

Heh, good counter perspective. I thought about embedding it
"into the superprojects git directory" whereas your un-embed sounds
like you'd assume embedding is targetd towards the working dir.

relocate as a fancy name for move sounds like it expects 2 arguments
(source and destination), but maybe we could go with:

    git relocate-git-dir (--into-workingtree|--into-gitdir) \
      [--recurse-submodules] \
      [--only-fix-gitfile-links-and-core-setting-as-I-moved-it-myself-already] \
      [--dryrun] [--verbose] [--unsafe-move]

No need to have a pathspec here IMHO. Later it could have another flag
to specify the "main" worktree or such as well.
