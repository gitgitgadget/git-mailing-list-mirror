Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A607B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 05:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeCNFGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 01:06:10 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:41371 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeCNFGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 01:06:09 -0400
Received: by mail-pf0-f176.google.com with SMTP id f80so934311pfa.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cLWkdksLmosqTDwtNchRnHukm6KqrTvWBiHk1y+KmjA=;
        b=ird2D7hVAIYUGpMhtokiJaEOK5s+8N2MpqItyLTdD0RCDTI2IrRmjlg9tyUH9cxAdC
         UFD7qFjOPlbJKKju4lgHhi1FQttIjHu8/H7bZUgOSZdQnGwzQF3UekeltArHyj1o5u4n
         nH7abbhe9DYwN3oPBX4haNtimkpIiYKtnAne6vVCG8kbekGmrjOO1TquOisHZIPhOjwN
         AvsbjRDD10abFZfnNBHfjRrcKQ0XBTFmvO0Kp+O5x4y8vx/wEGxetrATFornEjPQPY+5
         mQE0FroeQAv/QsnGSnU3R4h2T1bTdnO2JY+c3WWyNgpYieKSIKsmsp0CdrdY4uoPyeey
         rMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cLWkdksLmosqTDwtNchRnHukm6KqrTvWBiHk1y+KmjA=;
        b=H3ihTn98AwdttTy4g0KB6Fxs3ZsXCpocR8DKgmC1Xz5uS573dVmel06G3Qrze1Bcyb
         GQP49ETC8JB9qp21TKVuQe1XF6sUQZ3yUMWpkBaN9lsaiDiDa9ZU2gZOL1R54h2hplBQ
         rDPdw65BAHSEewgMdJ219u11Vb9IcY9m8ECpU9e/ufYXi8ZhQRwnmyoM+gKW4sfTn7fB
         Un4ifdeHZhhJERULYGFbNJyMYocuaD9QAd0q8/rwjFxJCTvY1UnYV7Ob6uhSkpKSJRpl
         dFfdQmIcOVQpIRTS38z4hDMYvI3mhfTieSAEHGwHu7ZyLRwBP+XF3S5r+BqGqCreO/Du
         TsSw==
X-Gm-Message-State: AElRT7EbwKUTSrly0MDPWOHRrEPUlNG/f8ABMBW8b0jZOc7C/cC8xx58
        Pvzb/pox7HGURW0AkullCKbBgegcF0T+NQVQtPA=
X-Google-Smtp-Source: AG47ELu6eHTfAHNaGsMmT9OrmlOZE9+aNiY9G9LojZ4ntb/rWTD27Tcj3sWH4MRPxMfkLy/KgQj2O1WsvozLyeXY8+Y=
X-Received: by 10.99.167.2 with SMTP id d2mr2554324pgf.408.1521003969057; Tue,
 13 Mar 2018 22:06:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 22:06:08 -0700 (PDT)
In-Reply-To: <xmqqo9jr1we3.fsf@gitster-ct.c.googlers.com>
References: <cover.1520680894.git.martin.agren@gmail.com> <78669e644b64fc10c34adb59717d2039f81cb092.1520680894.git.martin.agren@gmail.com>
 <xmqqo9jr1we3.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 14 Mar 2018 06:06:08 +0100
Message-ID: <CAN0heSoDSf+3VmRowHmiTPDDzfdvUjQi+tjpPF6RW172ZE5BWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] shortlog: do not accept revisions when run outside repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 22:46, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> in order to decide whether we should read from stdin. (So yes, after
>> this patch, we will still silently ignore stdin for confused usage such
>> as `git log v2.15.0.. | git shortlog v2.16.0..`. But at least that does
>> not crash.)
>
>     $ git log -p | git shortlog Documentation/
>
> is also a nonsense request.  When outside a repository, i.e.
>
>     $ git -C $path_to_repo | git shortlog Documentation/
>
> is not giving any revisions, so the error message should not say "no
> revisions can be given"---a nitpicky bug reporter would say "I gave
> no revisions, why are you complaining to me?"

Good point. I will see if I can make this similar to other places. Maybe
something like "too many arguments given outside repository". Thanks.

Martin
