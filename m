Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCCA1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 10:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeBGK7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 05:59:45 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46823 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeBGK7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 05:59:44 -0500
Received: by mail-ot0-f176.google.com with SMTP id f56so389674otj.13
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A2nsjZ0gEOCLR+f8K+n7LNYcR9bFfuVu+Yq4a4t7S7I=;
        b=ebGAQZKItSPuMHZ6+mmmoF07amt5qVqQnnpJK4+4qx7RKLhqOuX/1NxqCW97nmtvt/
         KU5LAn7gmd9zOMXytksRT2IWMI05yycgUkds3Ck1Nwq/E3gXVu5h87LUmWLafTVTIqoG
         ALxBnK96ziZ5PGyXa5FHpZv8LfcS58DiRegPTZI8w+t1uMhwOmiv7uUGqcTksAMOHMyK
         nCzpRJY9GUuDeU9u86dP89IJXvIbHD1ATRJAXArzqZHhjSSl4ZN9vCqH7UwF41ChBSoA
         aCtnMNEq4Km7O7pI3vZhyignJ3a0qhUnng85cSrbWs7fmmZumyZDOD2BUs+v3H3a2p1m
         iFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A2nsjZ0gEOCLR+f8K+n7LNYcR9bFfuVu+Yq4a4t7S7I=;
        b=XIQBHyBlBTUKoR5E0Vxu20d/D1HgjD7gmmSP0TqwTtljmcM8+KbdQBNwIZ/4u7iA0j
         HJaK8XNmCqJg3/J4LFkEidZZbA8A42optEVG75btn6BMSIzzExvr+Etr0Fo21gVIrJf4
         4AaneYMy9NRMCnrDTgqr7vW0mEQFk1JjiCUo8dl565/fpQJS4mSfChkaW5WyZ97nvysK
         WaEBlIky0S2vW4ftAzHo41ejkFK+6Bhoj7aK7okLsmOFGqMVjWSW0jR8TzzSSD33h6jp
         8UJYIdLJWA5ftel1BmRjP/CVTHjOmyFsgeuoQdknPpPEYahCOJYZOjJnder7JvGRp38z
         Lolw==
X-Gm-Message-State: APf1xPAQOlSg1Io6CuaMBFpLZvM5m8EFP3VqaPS+hI4wv3WmiXqN4+lr
        npB2IJSobnm02bqarrXx5yp4xcaqh6NXL8eZnj8=
X-Google-Smtp-Source: AH8x225O53SDZO2rmJoJ4h/xlefr9EMYWWOsSYZXwj1Y/ZrFqII6dQE5mLSd/qjI1ci2qG7LYfXrVrFcgbzA/U0IsSo=
X-Received: by 10.157.64.140 with SMTP id n12mr4168357ote.151.1518001183771;
 Wed, 07 Feb 2018 02:59:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 02:59:13 -0800 (PST)
In-Reply-To: <CACsJy8C+9Det0zF4+HZ6TL36aCFgboEh4=3yrEk5WvyUD30Drw@mail.gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com> <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com> <CACsJy8C+9Det0zF4+HZ6TL36aCFgboEh4=3yrEk5WvyUD30Drw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 17:59:13 +0700
Message-ID: <CACsJy8CS6QwAc9=i9JhW3RhLqYsfPM_OWSJ-DCvEAftOKDWs2w@mail.gmail.com>
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 7:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 7:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Feb 6, 2018 at 8:48 AM, Ben Peart <peartben@gmail.com> wrote:
>>> With the new behavior, making a change in dir1/, then calling status would
>>> update the dir1/ untracked cache entry but not write it out. On the next
>>> status, git would detect the change in dir1/ again and update the untracked
>>
>> Thing only missing piece here I would add is, this dir1/ detection is
>> done by watchman. We have to contact watchman and ask the set of
>> changed paths since $TIME where $TIME is the last time we updated
>> untracked cache and invalidate those paths in core. Then it should
>> work correctly. I checked the watchman query in the fsmonitor hook and
>> I think it's correct so far.
>
> No I think I'm wrong. And worse, I think the interaction between FSNM
> and UNTR extension is broken. This is partly from me guessing how
> fsmonitor works so I may be double-wrong.
>
> UNTR extension is supposed to cover the untracked state at timestamp
> $X. Where $X is stored in FSNM extension. Correct?
>
> When fsmonitor is used and read_directory() is executed (at timestamp
> $Y), we ask watchman "what's new on worktree since $X?"). We get the
> list, we invalidate relevant directories so we can see new untracked
> entries (or lack of old untracked entries). We write FSNM with
> timestamp $Y down. We may or may not write UNTR down because of this
> patch, but let's suppose we do. All is good. UNTR now records the
> state at $Y. FSNM says $Y. This is how it works (when there's no bugs)
>
> UNTR extension is only updated when read_directory() is called. It
> does not always happen. FSNM is updated all the time (almost at every

I was indeed doubly wrong. When FSMN is read, it does make calls to
invalidate stuff in untracked cache data structure. If the index is
written down (with updated FSMN extension and timestamp) then the UNTR
extension, which is generated from in-core untracked data structure,
also reflects the damages by the changed paths so next time even if
those changed paths are not reported again (between $Y and $Z below),
it's fine.

All is good in the world again :)

> git command since most of them needs to read index, many write it
> down) with new timestamp. Suppose FSNM now records timestamp $Z, UNTR
> still records the state at $Y because in the last index update,
> read_directory() is not executed. 4 files have been added between $Y
> and $Z. When we ask watchman "what's new since $Z?" we will not see
> those files, so we don't invalidate relevant directories and
> read_directory() will not see those files.
-- 
Duy
