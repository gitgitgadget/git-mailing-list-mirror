Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F270C1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 08:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfICIo6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 04:44:58 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:43806 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICIo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 04:44:57 -0400
Received: by mail-vs1-f50.google.com with SMTP id u21so2446703vsl.10
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oAFg5VgzqU3Fsa6bfXVXQKo5K97cEFxdmeZfiP8+ow=;
        b=ZCaIaj2JWdVttYv0bFbvvvzdW/0V0WNF75f1pqg9V6qoc+uQLqy01x4rVJM1KUDV1/
         BPOFtwLtcstlRD9oPHmuYh4AXfw6DY1CF9vea5WOYIIZWcORg+PXenRH6ICGgO1ZF5dH
         qA/izn9Dx52Kc0uw/SfLGLVcOfb1SQs0C2IzUTjZKMCsqr2nqT56qUN256dsYL8qmZLs
         PHYAGq6HpfQIin+mA048vnIpnbro5q4YF3mCBwa/dWvLiYQFtN85SMw5EkxOJyoDW93T
         pAekaYx+yP4RJ6LuOMZG1ZVkyB6cgX8f5mzz4y/CBSKidSE+8n1Ht30/iEl1yebyqtR3
         MiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oAFg5VgzqU3Fsa6bfXVXQKo5K97cEFxdmeZfiP8+ow=;
        b=mLKjMaRNxz/Vv/Fc5wyxxhmFA+TtMpkUygguhhBD4QywxpHR1FEF0PLtUXAvxp3WYE
         J2GzZCXUk01Je7uOPLG7C8ps/SyAQwKN5nbmruwIXTTINjMXHD3mqt5qLloURF9/U61b
         azdkOdKLCeCz9IF4XnWlXr4jzbvzIbp7Ga6GEDKa+pR9BWJAk51V1BJ0annH6W4h6Gh7
         Uks6KRbVFO0LYYWUozIActjBBQaeNaWrLwXkkNIwpDnP8Cif6Zb0vLia/pn8/tk8AEPK
         kbF+t493E94or56764xsuwAwS2qknvdlGVbv+F+JCvKdEiWEbKqb/PAT8ELDmKZf2LvB
         3b+A==
X-Gm-Message-State: APjAAAVOBYRsu7ohScw7e0KyWuWxYJn4ODywlEb5gIivNvOV4xe0hGZp
        UvJNtU/MtoXZJ8mv4JRwYPbpomks30+tZAKLZ3Gjh7lq
X-Google-Smtp-Source: APXvYqxcM//FMclh/8oWoLf2zL4QBbG2q3CXLFBaYEM/zKbIU7r+HncDkNOWQyATT6reHGc9VWyKRTsL2X6+xnfZhIA=
X-Received: by 2002:a67:2241:: with SMTP id i62mr10381155vsi.85.1567500296618;
 Tue, 03 Sep 2019 01:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com> <CAMPXz=pUWNVkM78UHm4NpFZ_nJQOa0ba07N3gMKFzWUiindZ1Q@mail.gmail.com>
In-Reply-To: <CAMPXz=pUWNVkM78UHm4NpFZ_nJQOa0ba07N3gMKFzWUiindZ1Q@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 3 Sep 2019 10:44:45 +0200
Message-ID: <CAKPyHN3S60U8jODeDaVimstF_GkmCCFqDn-AM=urgqKqUnJmAA@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     David <bouncingcats@gmail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David,

On Tue, Sep 3, 2019 at 3:01 AM David <bouncingcats@gmail.com> wrote:
>
> On Tue, 3 Sep 2019 at 04:11, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > On Mon, Sep 2, 2019 at 6:25 PM Birger Skogeng Pedersen <birger.sp@gmail.com> wrote:
> > > On Sat, Aug 31, 2019 at 12:51 PM Birger Skogeng Pedersen <birger.sp@gmail.com> wrote:
>
> > > > In my pursuit to fully utilize git-gui with only using a keyboard, I
> > > > suggest that there is a hotkey to toggle between selecting "New
> > > > Commit" and "Amend Last Commit".
>
> Hi, thanks for maintaining and contributing to git and git-gui, it's a
> great tool!
>
> > After focusing the commit message widget, you can focus the radio
> > buttons with Tab/Shift+Tab and press Space.
>
> > I think this is short enough, so that wasting a Letter is not
> > justified here.
>
> Ugh, may I express how unhappy I am to read that opinion from
> the maintainer. I strongly disagree, please reconsider :(
>
> And I enthusiastically support this initial request for a single
> hotkey to immediately toggle between "New Commit" and "Amend Last
> Commit". And it should work regardless of wherever the cursor or
> highlight is currently active.
>
> I have used git-gui for many years and I find this is actually the
> most annoying and inconsistent aspect of its user interface. Sometimes
> if one is lucky then "spacebar" will achieve it at startup or after
> refresh, sometimes not. When I test here just now the suggested
> tab/shift-tab/spacebar method, it does toggle but it also changes the
> items in the staged changes list as an unwanted side effect. My
> version says 0.20.0.8.gd000, but I have a few local patches (written
> years ago) so sorry I am not testing with a version that you have, but
> even so I wanted to report what I observed.
>
> If one is often amending commit messages as I do during large
> interactive rebases, it is painful to have to do some kind of
> context-sensitive multi-key dance just to change from "New Commit" to
> "Amend Last Commit". Especially when every other operation has become
> a single keystroke in my muscle memory.
>
> In my world it most definitely would not be "wasting a letter" to
> implement this! It would instead be "OMG at last that got fixed for
> everyone, hooray!" :D

thanks for the input. Though I'm not the maintainer.

Bert
