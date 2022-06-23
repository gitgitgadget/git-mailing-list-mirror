Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F64EC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 04:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiFWErr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 00:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347523AbiFWEh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 00:37:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182231533
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 21:37:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z7so26739690edm.13
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 21:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh+mMaNzDwbHu0ZMLgYhDHfoAZGCLF93bJHnTSgaS1E=;
        b=Pt/dCjW4U/CNNV5g3tpWIj9mvqVhjsfcEbLJNUgZMerf3mHNCxHpb7kRoOKY6bvgxj
         pAoKLtf5qkR0RJl5QFuZKVi11///raCQu/g4akwE5Rp63TYO7NPjf6Cf2TsIXrOGqZPd
         zcd5LTFIETqGaseAEofl008nem4iKVruNrGik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh+mMaNzDwbHu0ZMLgYhDHfoAZGCLF93bJHnTSgaS1E=;
        b=Zmw+2oMxu7HuSZgsJq6t1zgfIiirCwqgaNypCpvqUWRGMsi6Extd6eJ5mPs6ksLxAQ
         gUgiz5W22FOGFKd449CxlFDQJrCPO53hWg703kl+maYn9vSevyEFx+9TB3LLHnwrIBYq
         ScDPGl34ppWuhJD/iAJvFaF/pMbCT5ptCkEIoJE0HZqPcgpO9QnCI9t9qRPouMmoERip
         nl0DPDqBEDJXiJ0HOGQ50lH+qmDhAZxeUvswxTU6G/yl09DLz93znBH3aVM+ZtWzdlHZ
         qFNodYaudfV7YCxX1F7yYE9kIf+XS2cgliUn2FHRIRjVLC2gJAvCBE5cvJX3sQXPD2mm
         9DDg==
X-Gm-Message-State: AJIora9yJiuljUWF+hcL7uXHGo4U5X8fN8uP+E2nOmqWIAeNTyTkRTet
        ZjDOXuqY6ihS/21oYFHxM3QRBbjEVNxDIRZbTQyXxoqdDAeMTTEQpB0=
X-Google-Smtp-Source: AGRyM1vtIWTZIWEQwNU0UONo+NziIyDhHao4AFQtyqc6WtTdo1hrbULhrGi2rx8ty6nf6nlwfLEot6YoKQTxTFCHXRA=
X-Received: by 2002:a05:6402:e87:b0:435:5dda:9428 with SMTP id
 h7-20020a0564020e8700b004355dda9428mr8350455eda.6.1655959044186; Wed, 22 Jun
 2022 21:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1265.git.1655697671724.gitgitgadget@gmail.com> <xmqqbkumhtur.fsf@gitster.g>
In-Reply-To: <xmqqbkumhtur.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 23 Jun 2022 06:37:13 +0200
Message-ID: <CAPMMpojn3BfwJJ_CqtM=PXaXvErV11ZGcopmGdbiKMDymZ=DVA@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: documentation adjustment - mention remote
 tracking with @{u}
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ... As `branch.<name>.merge` is the branch path on the
> > +  remote, it is first converted to a local tracking branch (i.e., something in
> > +  `refs/remotes/`).
>
> Let's correct it to "remote-tracking branch".
>
> But more importantly, the order of explanation feels a bit
> backwards. Something like...
>
>     A branch B may be set up to build on top of a branch X
>     (configured with `branch.<name>.merge`) at a remote R
>     (configured with `branch.<name>.remote`).  B@{u} refers to the
>     remote-tracking branch for the branch X taken from remote R,
>     typically found at `refs/remotes/R/X`.
>
> ... to cover both of the above, perhaps, may flow more naturally?
>

Looks great, thanks! I feel like a bit of a fraud signing my name to
it now, but the important thing is that's a much better improvement
than I proposed. Patch v2 coming.
