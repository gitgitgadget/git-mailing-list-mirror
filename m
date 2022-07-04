Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A997C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiGDSvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 14:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGDSva (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 14:51:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A262C1C
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 11:51:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so12724311eda.2
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/8+AStPXlK6sfO955lvuBgjfpC1TSVXPzjqygBUO3nI=;
        b=XfyzSb3+CakW4hJs5NzZxOqg8KLogLbA9BT0hAMr8YCmiLnp7mTJHDlaq6qVGbiM3R
         PjuPX93TrtpCSoClQHsHBYfWi3joc4psIPZsvpC7oHp09O5lTQMPeI6BVbILn1a4MkO0
         DU2Pbn8+kPaKZ44X30gDhDMLNCDiC1s6BUYRP6+/zZmFbfJKTw/eQN6kMqik0KK38/Ya
         AA0KYW26b3O97rH8fbiraqDBonc34DN7hZiiKcfxkk7plGnA50LpQiVBi5jXctXboey3
         RaKjZiOgJZE+JIpuYpyAVYFJJVEfqKdm4/tWzyJX13VZ18mWxrai+3KmTkHJYMh/X+H/
         n8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/8+AStPXlK6sfO955lvuBgjfpC1TSVXPzjqygBUO3nI=;
        b=4ahteiXS9X70G8ikjFLEY2y8K35pr7sxiP52C+Qtf8cGRb5LMPU0/ycdciA0Qc2yJX
         yGQ/GRfLpjrCwGC1BvZ/DuSd5lZcUj5stlsSCsDodjQIzYHxXd7VI09L/AiV4BKCodDu
         RiF5rP4GguW/5Ii5oYQ1S6r6+5kZvrK7WvVgw3xvqv6et/27fOTYm8LWunbgcqkDt63b
         8s301GbaIOyrzQqM7P2qBhfYXNZva0qAeisKiIivJNwUN3NXDDBhkeL/siFs55lr2oj9
         DfQOTlFGXg/yOAck82bPenK84LY2xBalpJrMf89dQEP5KgQBIxQg2Xx2ETl6WhDUVSPv
         icow==
X-Gm-Message-State: AJIora+7YjGeC+mzU2WVgKJZUvkC3T+8eoHA4Y3k1lBGb1cFi6xTpN8h
        alOlTXiJfL0lqExRUNVWpLtWL/rULGPA7i6dMc4=
X-Google-Smtp-Source: AGRyM1vgoht41tXI6p/2EnTWlkjtb5ldy8rv7q1D1eeVLig6lLTKVqyQJ7L4cyfPmtzMiyvKAzohHv8NgRHo8qv8R+I=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr40640314ede.323.1656960688467; Mon, 04
 Jul 2022 11:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <9817efb01cf644e19d53ad89712093fc@thalesgroup.com>
In-Reply-To: <9817efb01cf644e19d53ad89712093fc@thalesgroup.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Jul 2022 11:51:17 -0700
Message-ID: <CABPp-BEJoMcQSF4EyO0VJJVDY5CZtSEgzyK3_2vOMLSBv4HLeQ@mail.gmail.com>
Subject: Re: sparse-checkout --no-cone deprecation {TGO}
To:     ALEPINS Etienne <Etienne.ALEPINS@thalesgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 4, 2022 at 10:04 AM ALEPINS Etienne
<Etienne.ALEPINS@thalesgroup.com> wrote:
>
> Classification: OPEN {TGO}
> Hi,
>
> Git 2.37.0 sparse-checkout documentation says the non-cone mode will be d=
eprecated.

Could you point out where?  This is an error; it is deprecated, it
should not state that it "will be" deprecated.

> I think this is a bad idea: I don't see other means than the non-cone mod=
e to only keep some of the files inside a directory. The cone mode allows t=
o select/hide whole directories without giving control to select/hide speci=
fic files inside selected directories. I understand --no-cone mode may disa=
ble other features (e.g. sparse index), but that is ok with me.
> I have people in my team coming from SVN which offered the option to incl=
ude only some files of a repo. Git submodule + sparse-checkout --no-cone is=
 a near equivalent that should be kept available. My goal is that on disk, =
the submodule contains only some of its files.

From wikipedia:
"""
In several fields, especially computing, deprecation is the
discouragement of use of some terminology, feature, design, or
practice, typically because it has been superseded or is no longer
considered efficient or safe, without completely removing it or
prohibiting its use. Typically, deprecated materials are not
completely removed to ensure legacy compatibility or back up practice
in case new methods are not functional in an odd scenario.

It can also imply that a feature, design, or practice will be removed
or discontinued entirely in the future.[1]
"""

You seem to be assuming removal is planned and arguing against that,
but there is no such plan; the deprecation is effectively just
discouragement of use.  If you've read the "INTERNALS -- NON-CONE
PROBLEMS" section of the git-sparse-checkout manual, and have decided
you're willing to accept those issues, then by all means keep using
it.  Don't expect new features targetting it, but Stolee, Victoria,
and I (perhaps the three folks doing the most with sparse checkout
contributions to Git) have all individually stated an opinion on this
list that --no-cone mode should continue to exist and that we plan to
make sure it keeps working.

If you find someone somewhere claiming that non-cone mode is planned
to be removed, feel free to point them at this email.  I was the one
who created the patches to change the default to cone mode and put the
deprecation notice in the manual.
