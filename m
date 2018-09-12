Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF831F404
	for <e@80x24.org>; Wed, 12 Sep 2018 01:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeILGOM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 02:14:12 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:44784 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILGOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 02:14:11 -0400
Received: by mail-oi0-f49.google.com with SMTP id l82-v6so399705oih.11
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0BXXcnoE6A+EdwYcdoaoebDTyvyUhkIu73KeZXNPas=;
        b=CIUSEVFuaUwXBt1sikmyrhYA2X6tViFaOO9pn8CtivYvYCKssWxcJlCpKMNaKK88Ms
         eCnlUYodK9bd9U5pMaobup8b2rLW87JE3LOdNJEss1Pr4k/zVz//8Oa2DzsbMLA8z/BL
         DDpub7D3RS4qMNvLEZV3xrv52z+su8tYhUgaEtHsbDt5mygX+HjKNBfwsizHeE9iCXYP
         c5PSGlHC+8c+tfWMQ4dwbtP9OBmDIyemAq9XmJg0yGdM6cDIg/gGsJmm6d6Z2NYnMPxG
         hxGXR2S45OfoXKtNE+Ex4eT0r7PsUH/vWFY6AcFlssaP/nsBc17WVTsJRl5LC0JG3mvO
         ohEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0BXXcnoE6A+EdwYcdoaoebDTyvyUhkIu73KeZXNPas=;
        b=Xhu7q35NtEVA9VzyeKMgjhc8WIp8uBtXbwPiX4DW2JvPgNOJUz7xKRX7vJwQm7S/bn
         NeYQvcfZ4ovgJTOQP3JONF9OG4PBgxf9t1YO6tATa1PRQXMskHjc268KLigbW0rftDZM
         tyVel1K9bMFMHU3OsnkfhxSoxQOQDbFWpsfoVaHYuI+ZHimuXsRQryT5guZmWUu3nqoz
         3AIppn5ovxTO8xjBQapl8G130cEmqtN7zVkYue3AR4Vqm/OsLM7M/x4+Zn7K+PDKtNmT
         +78W3rq6+QKFiuVGzYNF0tnkCNOWQSFfEv96rAALSnjHZc4LIiqRbptLt7Y+8R8OO6j5
         KAVQ==
X-Gm-Message-State: APzg51AIaK/Z40X7vwrl7BeqyG3UeFmtI9F4J9cu20w32OPBKEIDQ9YA
        3u5PV+zvWyBlmeIBZRatlW3WbSMjGUy9J9/nOQc9
X-Google-Smtp-Source: ANB0VdaQsybbBkVQR9itQyBSzv4JSjrgLR7qpFaW7TWshOYnrQz3+DCF1Fm1htbygpQHN7bbenooH2mY7dqczrm5a9Q=
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr31191359oia.280.1536714734310;
 Tue, 11 Sep 2018 18:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXrp_fLwL5=K3B5rWjY+imoqtskT8LG-UH8ec3CPwM0iiSzFg@mail.gmail.com>
 <CAGZ79kYK7ish4_DaZN2bCfZz7LNAjxogQH1k6T=hFcxxkXzJQw@mail.gmail.com>
 <CAGf8dgKLz14ijnXwV0Y=M48Rij-scA19E_uXk3pBc0T02oE_0Q@mail.gmail.com>
 <xmqqo9d4orji.fsf@gitster-ct.c.googlers.com> <CAFXrp_emK=k7by5pM5=GpsixJVeeJhT89-Cgq3JYbn5yg14CpQ@mail.gmail.com>
In-Reply-To: <CAFXrp_emK=k7by5pM5=GpsixJVeeJhT89-Cgq3JYbn5yg14CpQ@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 11 Sep 2018 18:12:02 -0700
Message-ID: <CAMfpvhKYN3E+AJdwFM3k9e4awg5sW8dnVnmROA4W10mQMxWB9A@mail.gmail.com>
Subject: Re: Is it possible to git clone --filter= without any objects?
To:     ciro.santilli@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 11:30 AM Ciro Santilli <ciro.santilli@gmail.com> wrote:
> The mentioned --filter=tree:0 would basically do what I want it seems,
> good to hear!. I wonder why not call it tree:none though to match
> blob:none.
There are some plans of making tree: accept positive integers in order
to filter out files greater than that depth. e.g. tree:1 would fetch
all blobs and tree objects directly contained by the tree. tree:2
would fetch every object tree:1 does plus anything referred to
directly by those objects.
