Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588451F404
	for <e@80x24.org>; Tue,  6 Feb 2018 22:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeBFWYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 17:24:12 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:45769 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeBFWYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 17:24:11 -0500
Received: by mail-yw0-f176.google.com with SMTP id b16so2511832ywh.12
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wAVhFdnWAbkCrATVhROQDfW7PtVgnYreIgVn4T27Pdg=;
        b=bj9uF4/BGf/LKoFKmv899CdJ9FBq5O6HZ+1AUIinhoLVwK0wtkfEoWZnN1uHGuKsFX
         qyD11xR+amlZiy/rLATQpwpqn4uUDYRJqO1cVowHjvKgJH34jkjYPgr9lrdw6js3cA4X
         zGh9ltDvc0zqEvrPzyR11YqJcQSWOJLtuyaT822TEsQo1y8ojnYqNPCOe2tSdC0NOOQ2
         BiCT8y46EUEUInex2dSim+v+kon50xMj2U3OOYssmuj59RwP5uxutaAB1JKy2bf3JFmN
         KjMi2nNN0AKjNToQuGsRmu31wLrmDPv3TiNVpyDP6nnSwHEP9cmX5w+LoMMBJkuAaXuM
         VDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wAVhFdnWAbkCrATVhROQDfW7PtVgnYreIgVn4T27Pdg=;
        b=YPaGCv6ZYQsuyAiTeqKIj10EkoHpDqsGf0igDZ6znyYJKmmyRLUJ9OT2oMa+cYq/Mb
         g1OsfPC2hHG5wQ8CkVQ3XH3lxAfhfNT93NpzBS1bnDkRyp1vZRvqQf/CAU31ajevWA+K
         p2iDnAnh35Hsk18N4Bby/8iQGsQvFi/BpnxPLsi7uvhnGoIGg4lG+80Kaib1qNImYLAO
         zkT2l81RFglhQlsuMrhoCOMMEPSR4gUdMjV2L08q1IeJEzeR9dGkuSe0K6kRGBJ1QyrU
         MdUydF1NINZ6Wmvv1oYxnG3k8yINPiRgjjdT7ri7CdpsebUnL3kjatdB9ySCmyfzCM63
         IT0w==
X-Gm-Message-State: APf1xPAj+Nf3Lmoy38OXYjkgWcyyq5mW2FMpsBO1Tz6pj9raHt2D/wir
        bVxT8Lj36bEsfMfUzzLf/Od50Q+ddQEAi4xEfQZt0w==
X-Google-Smtp-Source: AH8x225yFputVapB/oJuI1zXCyMk7G2DZe80YcaUTwhIQqE7VHYl83u748PLp4/oSVIKr2SxKVUiEc2xS8OSP26fr9E=
X-Received: by 10.37.101.11 with SMTP id z11mr1948734ybb.201.1517955850581;
 Tue, 06 Feb 2018 14:24:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 14:24:09 -0800 (PST)
In-Reply-To: <CAHd499A26paeZ=WgpdEkU233XbMrfVhgPGB3FHwaFObRKVqQDg@mail.gmail.com>
References: <CAHd499A26paeZ=WgpdEkU233XbMrfVhgPGB3FHwaFObRKVqQDg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 14:24:09 -0800
Message-ID: <CAGZ79kZaYiOpp9pu2dY+W-Y2zq-d4HBp=hAbE3UrLKhn8-cXSA@mail.gmail.com>
Subject: Re: An option to ignore submodules in stash push?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 7:56 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I haven't seen such an option, but I think it would be nice to be able
> to ignore submodules when creating a stash. When I stash changes in a
> directory, almost always I intend to only stash real files, not
> modified submodules. When I pop the stash later, it gets disrupted due
> to submodule conflicts. To avoid getting the conflicts in the first
> place, it would be nice to somehow specify:
>
> $ git stash push --no-submodules -- MyDirectory/
>
> Would this make sense?

What kind of submodule conflicts arise?

I remember a recent bugfix with apparent submodules, which
were not touched.

https://public-inbox.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com

https://github.com/git/git/commit/c641ca67072946f95f87e7b21f13f3d4e73701e3
which is included in 2.16.1

But this is me taking a wild guess, can you say more about your use case
and what the actual problem is (and what the expected behavior is, favorably
as a script) ?

Thanks,
Stefan
