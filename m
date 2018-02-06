Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D121F404
	for <e@80x24.org>; Tue,  6 Feb 2018 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeBFM4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 07:56:15 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44260 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeBFM4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 07:56:09 -0500
Received: by mail-oi0-f43.google.com with SMTP id b3so1235316oib.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N7wXGCwz/vvSGg/VysiaR7z/nzjkisI/OEUi5l40NfQ=;
        b=ef9ntQz/A4v0QfycwgjbJsJYSHnPGd9E5z98UW0VC6ZzdL1f3rzsbuHgkV285RHhIc
         bo8+AGorXwaBBxHnJVi0PceA+ujrdZWLZ3v2sfFLEQ+vb3Px6ro+2zlnk8HkHiku4Wjo
         0LTOuY2M+WOoHY3kZtfiUVy4hcoQyTfQ88HjgwRQI/JF1Q4z9TF3+xElX7LngcinVy+e
         tFL0Yeew3K/XcFvnLngP9qOh21GgMIpLkh7PiP+zj91LdN8d/iWm4AyvT+6RWkpG4iIh
         /TDtEgrOY3P3EZPmy9AB8D69Zb/XFONj5o8OSUEj2itZK0PnuVm0g0oql57dzRjY0OER
         +akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N7wXGCwz/vvSGg/VysiaR7z/nzjkisI/OEUi5l40NfQ=;
        b=eMsbNT8AMnJIDG1CyQK3w4YFXB0W63u6bao1nZT2jg3baTZuhxXz+9/ZY6EmNCQ0Hl
         2E/G1aWr18mQcBF3XShVvI2j6E67h8t2NuWFNPvFChzImUm9XfBkM9HQk25V+ZANbijC
         IqyHeT3QprUs7CVYLe6sQ8JsxJErGqACrVXJ3V30gc7IfrdIctzP1q6xtPD4W3cYZhcA
         e/zsgh13u7s4OiEZMFJdmswMWLxQ41k5f8C+Cnlv8zr7latpjRRGhz6aIvaMt4/JJjUo
         7H7J3oSrK9DeYCudALgKPnWTKLIqO4D9lmGOg6Zs9mtu8E1WuAdkson08N5Y0IAAcCO4
         HjGQ==
X-Gm-Message-State: APf1xPDVRWxEVc/uuJSZPa2+uw4Z6UEPL3F4o6vdHIidyM7eP4uKExE4
        6Baandergx1wz674rPR0D7wpc/lc3ghg4xwBE4whsw==
X-Google-Smtp-Source: AH8x225DOTu9RKTK386frgSgL/uSEHb1fO56QWf16oU2Om9Gxxz3MnTDQsN4kiEjgv8EYMXz5u2R5YbyvHJDCETzuWA=
X-Received: by 10.202.76.207 with SMTP id z198mr1405711oia.183.1517921769057;
 Tue, 06 Feb 2018 04:56:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 04:55:38 -0800 (PST)
In-Reply-To: <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com> <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 19:55:38 +0700
Message-ID: <CACsJy8C+9Det0zF4+HZ6TL36aCFgboEh4=3yrEk5WvyUD30Drw@mail.gmail.com>
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

On Tue, Feb 6, 2018 at 7:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 8:48 AM, Ben Peart <peartben@gmail.com> wrote:
>> With the new behavior, making a change in dir1/, then calling status would
>> update the dir1/ untracked cache entry but not write it out. On the next
>> status, git would detect the change in dir1/ again and update the untracked
>
> Thing only missing piece here I would add is, this dir1/ detection is
> done by watchman. We have to contact watchman and ask the set of
> changed paths since $TIME where $TIME is the last time we updated
> untracked cache and invalidate those paths in core. Then it should
> work correctly. I checked the watchman query in the fsmonitor hook and
> I think it's correct so far.

No I think I'm wrong. And worse, I think the interaction between FSNM
and UNTR extension is broken. This is partly from me guessing how
fsmonitor works so I may be double-wrong.

UNTR extension is supposed to cover the untracked state at timestamp
$X. Where $X is stored in FSNM extension. Correct?

When fsmonitor is used and read_directory() is executed (at timestamp
$Y), we ask watchman "what's new on worktree since $X?"). We get the
list, we invalidate relevant directories so we can see new untracked
entries (or lack of old untracked entries). We write FSNM with
timestamp $Y down. We may or may not write UNTR down because of this
patch, but let's suppose we do. All is good. UNTR now records the
state at $Y. FSNM says $Y. This is how it works (when there's no bugs)

UNTR extension is only updated when read_directory() is called. It
does not always happen. FSNM is updated all the time (almost at every
git command since most of them needs to read index, many write it
down) with new timestamp. Suppose FSNM now records timestamp $Z, UNTR
still records the state at $Y because in the last index update,
read_directory() is not executed. 4 files have been added between $Y
and $Z. When we ask watchman "what's new since $Z?" we will not see
those files, so we don't invalidate relevant directories and
read_directory() will not see those files.

What am I missing?
-- 
Duy
