Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FC01F609
	for <e@80x24.org>; Wed, 28 Nov 2018 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeK2CZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 21:25:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55082 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 21:25:09 -0500
Received: by mail-it1-f194.google.com with SMTP id m123-v6so4888340ita.4
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ENBYHvVX1Imf2v38AD1vES8a+Xnk/dncC9rszWdoBQA=;
        b=AoPoLaGOir650NjgchABMboCK4A2+UDqzAhADpqz1YT8sL/qyljwIIL+BkR+IV5MUW
         l+ToNA42JzB4bCCGTJK8G5rDwabepXuAkIHyOX1PjLi5CqCCfPg6DP0E92761uNUfQ/E
         7knlRcBzhNnzAaRabCIvQ/Gx0TCZnCeAH1fsvjivpYyuI3LNYvk56tkQtTMJm+E1Eiqa
         b6pObXFpP3RR/FWSL6GWW3aDF9oriaLoTsVdz/17ZQNv7kfheOy4Cr68c84WVq3NpYrZ
         IxAauKBpT5zS2dZnKkCxzhI/TNZXUzaNfjXiPBy+aoL4WZe7042ht98M1nYu6HwH7HUl
         f2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ENBYHvVX1Imf2v38AD1vES8a+Xnk/dncC9rszWdoBQA=;
        b=Z3rbfgpGNTS518QPSiBrqJNxk3HkFex4Wv4zVnG0JTa8rULCrz1kIFFVZYZ/LqHm9g
         Jp28FyKVTEi2iyHkZd7QxMeq1heSIKw0J2gBEiBGr+3H4peGd6ghTTRBnDhiNSNInBB9
         3+23vyYrzDMOx7pwo2jNclYdWO7qFwWWSzxQCAcqbHY3rUaeFKs8ymUrQeMmi1ksq46A
         j97UslleNTZHjVFIwMcnzD4TJQOmxfwK+VvcM4h7b7C91UYVSMSWBJdAAq117GuCWWRL
         t9WIIBIQv3WpO7HdZcbyS4Ti2ibAi3Ylb6IRg0Y7+k9HUKTP2sbuvH2aDPU56u9k0U5z
         nU0w==
X-Gm-Message-State: AGRZ1gJEf/S1TAQ1Hg68QN+E1fsOWf/coCug683XOdk1D9tZf3j8WJl+
        dyKGdaTeo5woCH7ZZPWZzlipQ4V+aQwaDk5Pvr0=
X-Google-Smtp-Source: AJdET5fzruz4AyyhXEf2lH9dtZDQRXVQd8k6i0oBeg6jk2Juc7OMk3aE/IfwtkWkzWH5YRMhvheFbiwEpE0OAg9omwU=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr33437420jah.130.1543418588167;
 Wed, 28 Nov 2018 07:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-2-pclouds@gmail.com> <CAGZ79kYXYzS6mHJWSkC-gAj_Ts2z8-jCX9tuTenKE+bxTgbtHw@mail.gmail.com>
In-Reply-To: <CAGZ79kYXYzS6mHJWSkC-gAj_Ts2z8-jCX9tuTenKE+bxTgbtHw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 16:22:40 +0100
Message-ID: <CACsJy8BMkQZ=VEGCwKb2q==eqovMnGy+szitpAkn6LTQaFq+=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] parse-options: allow parse_options_concat(NULL, options)
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 8:44 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Nov 27, 2018 at 8:53 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > There is currently no caller that calls this function with "a" being
> > NULL. But it will be introduced shortly. It is used to construct the
> > option array from scratch, e.g.
> >
> >    struct parse_options opts =3D NULL;
> >    opts =3D parse_options_concat(opts, opts_1);
> >    opts =3D parse_options_concat(opts, opts_2);
>
> While this addresses the immediate needs, I'd prefer to think
> about the API exposure of parse_options_concat,
> (related: do we want to have docs in its header file?)
> and I'd recommend to make it symmetrical, i.e.
> allow the second argument to also be NULL?

I'll just drop this patch. There's a better way to do the same without
adding special handling like this.
--=20
Duy
