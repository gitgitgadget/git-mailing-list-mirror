Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB904C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiGGMAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiGGMAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 08:00:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACF5A454
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 04:59:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s27so18048371pga.13
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lj/mvhQqwbsx9zkZtVN5SEdvxkqc9SCxPHyHx52/kwQ=;
        b=mMgnZueDDUMpGCsJbRefBY42twswhPmL8HiWWDcOVfYK9r5ZfPpEakM3dwj3vWa7uD
         RplbTcCpTudbfMzsR17qycayz78TVhxLj4JYyWE9JXIdrKhVw3fiytPkab9Y9nzoTXia
         QOnlAn9po6/Wr+gQippgmCzi9lvybvVbJ4Bu0KmS1gjyXsR+SedGQuXFs0pkPGNZUPJ7
         DayfYmrHSP05Xqd80SJ31sxC97p6yCc8Zc4dzDKack3bvrpi+INfd/343QyB2jXAZhLv
         fMEWE6GvEh3OdCC9ixctIox0FL7E7JkhWVELXfWj0Nr+3aMWdndVnyj6zXiN+7Mb0+DN
         64dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lj/mvhQqwbsx9zkZtVN5SEdvxkqc9SCxPHyHx52/kwQ=;
        b=w6M+0IE/NZMSllLiAkgwxT5MoM/DVrhvrpgibqMs6RbueDDcGbryY9S1OblRiBJKUA
         uKdkxiujUup/yIlZSxIV/pOKR9/1zTV0dZ0MpmxeJ/qFFci9KELKXX7qYOV4Cyh8GOz0
         80yeFYpc2xe2C30Gohm66cArn47JBvorGetGwlFxOfyD/EGukVOoTdHW4xbGS+atsHtN
         ZlyBhWszWsC3RPA+OO5vqBMOppGo9NWW0ltTvfcOiZwImy2sRaSsBoNK4Jty5kaNAIe+
         c9DfPaG37CLiEgUBtgrbrNrjIYozTY1Rgn7l2uKaTH+AhuMxsN/aE0e+p6oeXreRHf6m
         HyAA==
X-Gm-Message-State: AJIora+m4Gzal0emh38shzEVLS1LaA039yd15xnIi/LQET6wbmwzkGWo
        3y0kut9L54gUEOs6CROMAOo=
X-Google-Smtp-Source: AGRyM1twaZ1ar3deSu2S3jKaHg8gXYrxsFpNEpNJ3TC5dlmw4X2wJbpWeGB6GSbaH+dsViz7UPeZ1w==
X-Received: by 2002:a17:902:cf10:b0:16b:aca1:9dbc with SMTP id i16-20020a170902cf1000b0016baca19dbcmr40972509plg.6.1657195159699;
        Thu, 07 Jul 2022 04:59:19 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902c40e00b0016bdeb58609sm9768794plk.238.2022.07.07.04.59.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 04:59:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Thu,  7 Jul 2022 19:59:12 +0800
Message-Id: <20220707115912.75774-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.672.g74cc1aa55f.dirty
In-Reply-To: <xmqqfsjok6g1.fsf@gitster.g>
References: <xmqqfsjok6g1.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Date: Tue, 28 Jun 2022 11:07:26 -0700, Junio C Hamano wrote:


> The verb "retrieve" is puzzling.

I use "retrieve" because I think they should be there but actually missing.
But If it's not appropriate here I will change another word like "add".

> "," -> ", ".

Yes.

> If we were to do this, to avoid burdening translators with double
> work, we probably would want to fix the "C" locale version of the
> string, either as a preliminary clean-up before this step, or as
> part of this step.  From Documentation/CodingGuidelines:

Yes.

Does git have any NOT "C" Locale string?

Another doublt is I found something like in:

    File: ./contrib/completion/git-completion.bash
    923    LANG=C LC_ALL=C git merge -s help 2>&1

I think LC_ALL=C will override LANG=C in these cases, so I think
`LC_ALL=C git merge -s help 2>&1` is OK here.

From: https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html#Locale-Environment-Variables.

> Error Messages
>
>  - Do not end error messages with a full stop.
>
>  - Do not capitalize the first word, only because it is the first word
>    in the message ("unable to open %s", not "Unable to open %s").  But
>    "SHA-3 not supported" is fine, because the reason the first word is
>    capitalized is not because it is at the beginning of the sentence,
>    but because the word would be spelled in capital letters even when
>    it appeared in the middle of the sentence.
>
>  - Say what the error is first ("cannot open %s", not "%s: cannot open")

Helpful, fill in blind spots.

Actually, in tr2 some text are printed as capitalized the first word. Is this
entry appropriate for this situation? Whether we should unify the both?
