Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F57E1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGIQfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 12:35:23 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34861 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfGIQfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 12:35:22 -0400
Received: by mail-ua1-f67.google.com with SMTP id j21so6649836uap.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=16vb7Y5G7WBAE7kSwB2SbQtfmuq1zayTIQK8QwVPU80=;
        b=cTsr7Snib4+R2z8oP7uJtZF2OfxBaKw0rsHGlcF+drwKj6f1qCx3zytq6B62VAGQuz
         yEHuYoRnXQOSklK5H+As8I1SvwXtb0vyVD2fDFvBTgInHBULAmtt0OGsE61wG8NDmQbc
         xj8NrYXZABwa5RFjN3mDOHdk2mvefSunthwowUM6hDqQItuYzSVsdRkf0u1dc+Doalma
         dEifKl82t+M51A7mlnD5P7Jnu2IB5W6qYxmDODRLJOSMdvUwNZR778yma7FEu3brcM9V
         msIiPU3pgRUXswkzbZq/u/Fi4YQaTsGZhnSiHZc/UZlpe9cwrOM6A6MaYEfPiivRryiJ
         Z/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=16vb7Y5G7WBAE7kSwB2SbQtfmuq1zayTIQK8QwVPU80=;
        b=Aiv78R+PcwsCBw7lgy7yu4h/7A60lO4q2sOlQlb556WGKrFxe0boN0hjmcZXjhUx/h
         bSRWxbn08qobTYerIemZRulIEdedHslWPYsT4+QejrZwwupEDNwMaX0c44+syPq5RK9h
         OPBdJHsyFXWakhrYoiQEHNCcZbHTr87lKy7c9bdHOcpCNq9xyPsvdE1w/OCub/fxIRyX
         3mlyKzkTJaib4OV2jtJ7ucMCjeIb7D7e9rvRRE12shmD2dVLkTBw2qkg5hcr2RoSTAlP
         LOzS0v7Pth02SbYqDu4rUv1uNL/W+gLqxeac/jAq+oVUQzb6uBug71HTkAiZL3KZFgeK
         ahhA==
X-Gm-Message-State: APjAAAWee5nniJJch+rV4HHinagRA0BA43wnHVmIru10HbHTqh5fnL+Y
        YX6JjgD3OdnkCfRbGPJACNqL2WXzu8IwvRGfd8o=
X-Google-Smtp-Source: APXvYqxCclt/ZK0igFvlM9Ugcocfe7PcyNOzTYPfWwCuEea02X66oLbwrnDvsywt2XSA4tkkzJCxk5KHC/1vrBaLyz0=
X-Received: by 2002:ab0:74c9:: with SMTP id f9mr5861733uaq.18.1562690121777;
 Tue, 09 Jul 2019 09:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com> <1152121968.7459.1562688927235@office.mailbox.org>
In-Reply-To: <1152121968.7459.1562688927235@office.mailbox.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jul 2019 09:35:09 -0700
Message-ID: <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
To:     =?UTF-8?Q?Roland_J=C3=A4ger?= <eyenseo@mailbox.org>
Cc:     Junio C Hamano <gitster@pobox.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roland,

On Tue, Jul 9, 2019 at 9:17 AM Roland J=C3=A4ger <eyenseo@mailbox.org> wrot=
e:
>
> Thanks for answering Junio.
>
> I get what git does. But I believe that either the documentation ist wron=
g/ambiguous or --no-ff and --ff-only should be able to be combined and eith=
er should be fixed - preferably the later. What I want to say to git is "I =
never accept a real merge; please make a merge commit, even if it is redund=
ant/empty". And I believe that github and gitlab allow to configure somethi=
ng like that.

Please don't top-post on this list.

I agree, the documentation is wrong or misleading and there is a
wording change we could make to improve it.  But, in particular,
--no-ff and -ff-only are completely incompatible.  A fast forward
implies no commits of any kind are created, while --no-ff explicitly
requires one to be created.  More on that below...

> My manpage tells me the following:
>
> --ff When the merge resolves as a fast-forward, only update the branch po=
inter, without creating a merge commit. This is the default behavior.
> =3D> Allow either

Yes.

> --no-ff Create a merge commit even when the merge resolves as a fast-forw=
ard. This is the default behaviour when merging an annotated (and possibly =
signed) tag that is not stored in its natural place in refs/tags/ hierarchy=
.
> =3D> Always create a commit, even when FF

Not quite; I'd instead say:

=3D> Always create a merge commit, even if FF is instead possible.

In particular, FF means there is no commit creation.  I agree the
documentation needs correction here, it should be:

"--no-ff: Create a merge commit even when the merge could instead
resolve as a fast-forward..."

Would you like to try your hand at submitting a patch with this change?

> --ff-only Refuse to merge and exit with a non-zero status unless the curr=
ent HEAD is already up to date or the merge can be resolved as a fast-forwa=
rd.
> =3D> Fail if FF is not possible

Yes.


Hope that helps,
Elijah
