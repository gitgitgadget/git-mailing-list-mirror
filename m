Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68CA1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 19:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbdLSTj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 14:39:56 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45450 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdLSTju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 14:39:50 -0500
Received: by mail-qt0-f178.google.com with SMTP id g10so25568247qtj.12
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 11:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TCWRHQjWjEuSanfl90qw8nTj1i3CQu36zcwOKD2cHF4=;
        b=Y7cx4fv0ulnn30qJxue0v5yK9Ek9/RINpcyl+tF5Q9qCvOffVKcc6cJaiixlEDkktH
         Yls5T91AcUenaj+S/NUE04OhdNszmS42+7TXwWasg1C/qGwyVloQt5gGIqrnKTZbmDmf
         AmIbvpLthRleIl4nxAVbcpJLaF4nE2LTuSQvQbKqGAMxwT5E+RJhifJvu51WeQ38CK37
         HHJNMFpOuxQR+ez5ZZbxo+cVhewPwHpV/STYi5Z6cWIR1pYXP8Z8MvUs7SbpBzZi654i
         eS6p2dHI0d36rgxF0+dobMyznv2VnhAF+hgSzJQJpjbmr7wpFIB/B2GZ6o9l3L3GAN2o
         UK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TCWRHQjWjEuSanfl90qw8nTj1i3CQu36zcwOKD2cHF4=;
        b=MFse4pMGnWwxLnp19bC90K3x1k8dd+GmFjDKZSCNDdsLFISlzyNdLWPmfH4dWvOc/X
         MqYwu9jLzPHwuBoD4c2EfouOOxkwp8R4kT2TYW4irPU89YiEGSiTw22tu+efLuco3ZbU
         jozQkkyuS6h0LAY0hE6dCkIA3x1XA8dEpicFnVBOQf3vi7OCcXEI/4ovQQnZ+Ea6hct5
         DmWf28RkFPKCV3e0wH6+8c5r+P9byOZLZDnM6hKbI+ftrk2r3MiTqFbchQRjgqk1O7+i
         gdnPM1ehVJYSmZ9PwRTWiZn6/CCEEUdxTLCevKYlKTH6fkniKN5H/CE9U0MbIq7oDGwg
         72PQ==
X-Gm-Message-State: AKGB3mKTf9M+csNYmhSFVAsJ6S6++FyZXSohdHxh2tTQPXyFbg6X0rUF
        NJVLAncu3dP87nKqvzhjpD2L4nKjY4p+Ne4muAqVCQ==
X-Google-Smtp-Source: ACJfBovvKzyeiAS9URd4aPYLQ2TC0R2ybhyLirn9du9T3cDJ0zgqK9UbqZwdPseMtlMp/eDPFAJNtFoZ6XDG93yicnE=
X-Received: by 10.200.35.215 with SMTP id r23mr6272188qtr.174.1513712388524;
 Tue, 19 Dec 2017 11:39:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 19 Dec 2017 11:39:47 -0800 (PST)
In-Reply-To: <xmqqy3lyv7yt.fsf@gitster.mtv.corp.google.com>
References: <20171116020039.17810-1-sbeller@google.com> <20171116020039.17810-8-sbeller@google.com>
 <xmqqy3lyv7yt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Dec 2017 11:39:47 -0800
Message-ID: <CAGZ79ka8PRbiHggTADNDwwO_=8rysK3sDP7tV4qerbc8C5yaSQ@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I had to squash in the following to make 'pu' pass under
> gettext-poison build.  Is this ready for 'next' otherwise?

I saw that in pu, thanks for squashing. I should have spoken
up earlier confirming it.

> With the "log --find-object" thing, it may be that this no longer is
> needed, but then again we haven't done anything with the other
> Jonathan's idea to unify the --find-object thing into the --pickaxe
> framework.

I'll look into that after I finish looking at a submodule related bug.

> It seems that we tend to open and then abandon new interests without
> seeing them through completion, leaving too many loose ends untied.
> This has to stop.

I'll try to find my balance again.

When working on too few topics at the same time, sometimes I get stalled
waiting for the mailing list (or internal reviewers) to respond, so I start many
topics, which then overwhelm me after a while once reviews catch up.

In this specific case it was not clear what the best way is, i.e. the
interest was
rather broad: "Hey I have this blob sha1, how do I get more information?",
which can be solved in many different ways, so I tried some of them.
(Another alternative just now considered: I could have wrapped that
script from stackoverflow into a new command and called it a day, though that
has very poor benefits for the rest of ecosystem, an addition to an established
powerful command gives more benefits IMHO)

Thanks,
Stefan
