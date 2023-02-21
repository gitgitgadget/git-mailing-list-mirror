Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FA7C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 19:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBUTtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBUTtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 14:49:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CD1E5EA
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:49:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h16so21959874edz.10
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09IG7z0IQCr/iba4n+4WfgnhJN5vYrCNMMglg20F2FU=;
        b=i1u2HaIhfgg4Eopepe6yxjCApni8qJASHCWp7FJbOMvhR3gxDtvXzHbEAeF8pR+9UG
         e6A/gcJtT/qEbcBZS+5UhQmeowQbRfrz7U4g/YsmK0Y/0rENufS4ZnhbGQ5nq7j2v6Yq
         WlIHad+SCUz5lyMFSv1XgbTYKXe8Cjy9KvbxlTx8BLYWtzwYUknwEdhZWzdGg/bLID3/
         aDiuUsjMTNpNBZykiUJgWAlk4VZS93jmeClc8HJfkU0mF4WeCekrBKB20WozAamVefLx
         jZkEW7XdyO26+r0ZXbRg5FhFapQfevfygUQczNyIwaLTlEg6d8Vu9OWF7GNxNSYMQ4sz
         uoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09IG7z0IQCr/iba4n+4WfgnhJN5vYrCNMMglg20F2FU=;
        b=ck/OuNSb2k4yVr/YK9FB1udOyRwYZgFKAq6F8//A70Rc5UXrOPzxHgRrf4jaqIt6Hb
         vsdIthjTwLB2LM9wLKEwqnhFjHxClU57W1L37cRu6GQDXecOU46iIbapSpr3kik84BMf
         DCGiphtryjM116I6BKy0OnVYp5KIk0bmzsYGfxLJQaVaBtszvh8YsyC6LNbzKW8Qs14K
         X/iZTibWaprFaXEw4rOkGr2jE256NO6mngSvBKeviFQrtbZtoDIZshKWR0cdFuyqMQFF
         5Iqsey5Nq28+PALvQ/aEed7/iMqZMNvuriRTPmB+I5d6z/ifXMdHZ3GLfhpebJ6fauwK
         WINg==
X-Gm-Message-State: AO0yUKVcC+NDFmdSY/zkuFoEpLGEgnlAUylJPDY1POhIdKnlAeY9hE7J
        KLh6pZPh2kZTm4ThgTCjaGRsLlc/3WtScwnKfCs=
X-Google-Smtp-Source: AK7set/eA6+FXWPmu93NnnjbBBzPLHfB7bnBNaEyKLupMb8Rx9T8bxGCYrvnbjNrhzH9fhP231seZEntYItQvDvKRgY=
X-Received: by 2002:a50:d701:0:b0:4ad:7265:82db with SMTP id
 t1-20020a50d701000000b004ad726582dbmr2590744edi.1.1677008945516; Tue, 21 Feb
 2023 11:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20230220235121.34375-1-gvivan6@gmail.com> <38cb184d-e47a-2129-a93e-16ffd2afe67a@github.com>
In-Reply-To: <38cb184d-e47a-2129-a93e-16ffd2afe67a@github.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Tue, 21 Feb 2023 12:48:54 -0700
Message-ID: <CADupsJNPVm13iSv84SXpqtP8Dhm_-htPTr59yPs_J=aQzs2FwQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH] t4121: modernize test style
To:     Victoria Dye <vdye@github.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 10:27 AM Victoria Dye <vdye@github.com> wrote:
>
> nit: period at the end of the sentence (s/lines/lines.)
>
> Also, this commit message explains *why* you're making the change, but not
> what the commit actually does (that is, update the tests to adhere to the
> new style). Would you mind adding a note about that to the message?

For sure! Is it correct that I will need to amend the commit message
and send out a v2 of the patch?
> >
> > -test_expect_success \
> > -     'check if contextually independent diffs for the same file apply' \
> > -     '( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
> > +test_expect_success 'check if contextually independent diffs for the same file apply' '
> > +     ( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
> > +'
>
> As for this one, the test is correctly updated to the new style (per the
> microproject prompt). However, the spacing around the '|' is a little weird
> - I think there should be a space after ')'. On your next re-roll, could you
> fix that spacing (in this patch is fine - it's not a substantial enough
> change to warrant its own commit)?

I'm not sure what you mean by "next re-roll," are you referring to v2? But
then you said it was fine in this patch, so I'm confused. If I am going to be
sending a v2, couldn't I just revert the last commit and add this change to the
same commit?
