Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C96C7EE30
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCAU1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAU1b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 15:27:31 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8337B6A
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 12:27:30 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536b7ffdd34so386840627b3.6
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VoKV1bjHpt+9LnD1B4v8BAt8ujfnfdPCW1OI/qXATE=;
        b=G7Ss0LK+pYifBMODW9PfWewvZ7g6u+spJoLW81KL0KbK3ECUkjBsta0cziVKLqCRMk
         jrZkF9/Ntsq5ORpdX7j6r3+BDUgXAkZ3nmGL15155ZUXAHljjUn/+iN9llqMRXnqcEFr
         nbhUY9/Hi/aH1ITWylZVHjzR8zaJp4Uz9p+Dx3J5wP+Nfw3BEBGkMzk9V4sBDXZuT6bV
         ffhyE5e9YLCRW1LsnRxqAEj1zh9F3PFB+L/Gu1Oig9csN6vdcTL56tvpLEBevvawB2ta
         N42sfJgZXCKs2+oGnyt10EeQHjuzgOl58GmgevgSxRwOZBE+QLw/FzZFXL+L0ODisbV9
         go8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VoKV1bjHpt+9LnD1B4v8BAt8ujfnfdPCW1OI/qXATE=;
        b=U9TBituzT4TZjpSbkdWj4zg1h8fwLYf4jNOB63+O6IyV0C5o90K0lX3SMutCEpE3r7
         +reRV2FMc/fukjvZjsAVl2EUX+A+4Z4NXNdqlty1g5ZmkS1eANFfLsbVhlTxs3tIY/j7
         frFD+D4FtoJnQb4xcqrgKPyO/HXQCsFsO2Ug+0V0ahiFwDPx/wlD3gGQ9MRn/jTXLUWf
         Vy1SyN+CHbpVQA0Vm2Io9zmWlJYMrXhCWYUWEMZd5XYK6MCCzOnP/XkfpkL6SRmSIHnk
         j9uurzmQOqKEQVXwU0i2UTAFFGY6sqBvrOdyDA+akYtuUQpYmKh/a192Ro0p11ocdTMm
         fyAA==
X-Gm-Message-State: AO0yUKWDsS/voZLiKYMY8xRGmOFsmwXoYXphh5Rcz7zWm77K/k7t2lak
        DsyUwji/P6GHHngd0i35UNJIV13RVBvHwk83AwiTJMhzEPg=
X-Google-Smtp-Source: AK7set8Xb4I1Op/UAgN9NyGZeSQfRyX/KgWTMnsUstgkhzKSzp0V6et5WDO3EPL5yNLP3lvdgNtxSEXYKK6eaqcAfr4=
X-Received: by 2002:a81:ae61:0:b0:53c:7095:595a with SMTP id
 g33-20020a81ae61000000b0053c7095595amr1859472ywk.7.1677702449630; Wed, 01 Mar
 2023 12:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20230228145934.4182166-1-felipe.contreras@gmail.com> <xmqq4jr4nu3u.fsf@gitster.g>
In-Reply-To: <xmqq4jr4nu3u.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 1 Mar 2023 14:27:18 -0600
Message-ID: <CAMP44s23cvp-YWDN7vzsKQCcWoc43PgURq+J6pwtx0rxOpZLBg@mail.gmail.com>
Subject: Re: [PATCH try2] completion: prompt: use generic colors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Joakim Petersen <joak-pet@online.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2023 at 1:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > We don't need bash to do this conversion, we can use \001 \002
> > ourselves, and then the prompt command mode is not necessary to display
> > colors.

> Comments from those who use colored prompt and who are familiar with
> the mechansim used to implement this?  As I do not use the feature
> at all and haven't been following it, seeing independent support
> would help the topic.

At least in try1 Justin Donnelly reported success [1].

And you don't need to use the feature to check that this patch
obviously works, it's easy to test. All you need to see the original
problem is a short (as in width) terminal, or a long enough typed line
(I type a lot of d's until surpassing the width).

This prompt should easily show the original problem:

PS1=3D'\w (\e[31mfooooooooooooooooooooooooooooooooooooooooooooooooooooooooo=
ooooooooooooooooooooooo\e[m)
> '

With the marks proposed by the patch, the problem is gone:

PS1=3D'\w (\001\e[31m\002fooooooooooooooooooooooooooooooooooooooooooooooooo=
ooooooooooooooooooooooooooooooo\001\e[m\002)
> '

Of course, in order to test, PROMPT_COMMAND shouldn't override PS1.

Cheers.

[1] https://lore.kernel.org/git/CAGTqyRzZ-cOp1C4f30fGFhjH1hh5U137=3D77pEHp_=
bmBzNcmTCw@mail.gmail.com/

--=20
Felipe Contreras
