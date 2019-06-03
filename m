Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB591F462
	for <e@80x24.org>; Mon,  3 Jun 2019 15:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfFCPGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 11:06:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38182 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFCPGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 11:06:35 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so12897056itk.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UwvwVXlz0dIi+qx7yUh2GgWLLdPM0TCP7rgd2CYx71E=;
        b=HwzRG9TcJcFzLH1k4G7bkB97I/5SLkkxYzpXrTs9qD2qst1rh/MWid4oQoRwFk0/SF
         4M1Upn9ucfz2FnuMavsnxRGbw3pZCnBsw/2z6bPK/7yo0D12346TFXtBr6UXMtnFnuHB
         DgT+CqGD4EVMWx3K3unYxraF/ENjn8wTgCiiENhdvB9lUh8ESPq+m0tnz/LQ6I92xQGl
         mVtNLO6sEkcgs0fW6HyG0uMlgQo9w5tkwOiNopPRRTwDqaFojQFKybsnuKwR2en1WXsb
         xQsdhsahnErL1VQ/0nGE7OSQ+JIi7LHO8u+4pJYTrrLQWAgUAeLlJ1LJZZf56d7nmBH0
         VJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UwvwVXlz0dIi+qx7yUh2GgWLLdPM0TCP7rgd2CYx71E=;
        b=YH8+VdBT1kktSiyLqFMSnrhaGKdEhuXOOaJlf/ycjQLMV1vxv5e3aBp+gx3Qsh20pk
         1LMLaiLv4kg8SakVOC0HKEXqACvCxykGN0aPhPtHjgrcIvVYt/dJC3iiSadhZULEUXmB
         D7uw91AQguf+YKlah9JYTJg3lDO8K6ewMwogahA/at1ylcGC7QlN82yTj1GVk3YnaMxX
         Udn+OWUU9WAdhLSqF+sfTy+jRhb8yr0dnbZQKH0HUj3y4fs2nisyLbCt4zCpWkAEYG8x
         RG/IN8YLy3hHme0zZjnBLos6b013AuEue94HnPQnqZ/mbOc8Hl4vpWLH/WVkdw846Hb5
         fdLQ==
X-Gm-Message-State: APjAAAX8hsh37s/b2+jXonYQlYhUL5Azp4r9teEh7jkuQoBpYDj++45k
        S60h4MCr4Jjt0i+hZbxo+4D7wY/g59JhrivcRhez9dbXjOA=
X-Google-Smtp-Source: APXvYqwRrjwerdsSWtm3Uzaf/xWQE9vS5DdFx36H4ZphcELNxLMifJH6YvrfvFELDwstTM8BocufyPNAy9ZtiVTBrfE=
X-Received: by 2002:a24:2483:: with SMTP id f125mr6313775ita.123.1559574394004;
 Mon, 03 Jun 2019 08:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com>
 <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com>
 <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com> <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet> <CAKO26MtvBRo76TenubyeVNkeA6e5yrS4DZFSLG1ByztP7mMVXw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906031614020.48@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906031614020.48@tvgsbejvaqbjf.bet>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Mon, 3 Jun 2019 23:06:22 +0800
Message-ID: <CAKO26MugSimxd+fiXR7CjT1uRsWXZ=s_a=ebtZmpSDyGg3HTgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thank you for your kind and detailed explanation. I really appreciate
that. By the way, I just saw it passed all the Azure Pipeline checks.
Please consider merging it into nd/switch-and-restore. Thank you.

Best,
John Lin

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=B9=B46=
=E6=9C=883=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:17=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi John Lin,
>
> On Sat, 1 Jun 2019, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=B9=
=B45=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89
> > =E4=B8=8B=E5=8D=887:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > You could already rebase it on top of
> > > https://github.com/gitgitgadget/git/tree/nd/switch-and-restore, say s=
o in
> > > your cover letter, and send a new iteration.
> >
> > Thanks for the suggestion. I already rebase on your
> > nd/switch-and-restore: https://github.com/gitgitgadget/git/pull/196
> > However, it seems to have some conflict with the master branch and
> > gitgitgadget refused to submit the patch. So I guess I still have to
> > wait for the nd/switch-and-restore to resolve the conflict.
>
> I am so sorry for being so sloppy. I should have said explicitly what I
> had in mind: target the nd/switch-and-restore branch.
>
> The GitGitGadget fork mirrors not only maint, master, next and pu, but
> also the individual branches that Junio merges into pu (which are
> published at https://github.com/gitster/git). That is, you can click the
> Edit button next to your PR description, and instead of editing the PR
> description, choose a different target branch from the drop-down box belo=
w
> it.
>
> Since it was totally my mistake for not telling you this explicitly, I
> allowed myself to do exactly this for you. The Azure Pipeline is running
> as we speak.
>
> Thanks & my apologies,
> Johannes
