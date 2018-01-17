Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13451F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeAQA1p (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:27:45 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:38258 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeAQA1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:27:44 -0500
Received: by mail-ot0-f171.google.com with SMTP id v5so4955263oth.5
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rrMgfI50Eg5XKHEVizTx6O8tv2/xGH3VhKUqp7ufSlA=;
        b=O3Bgc5mZK/rzt0W+UsEWnLXNCt7YB0alPtXA7KfrxIzpAUHmflsBR/OKha1M3ODjke
         2EWWD/Mhqv6uxSeSUMsQFntiRiR5f15CaZUUgJqsqNz4e15/Px3tvE867AGujpV9pxE/
         MEFhn9bKwziXYaS2tKErfjS0mKNr20kI6C428ZYmaNzy8Q1caQr4cOs3QVU1+UtvESq6
         rgKg8ypnQaXXj+dcah6tmLG+LMSFGP9RXfCtwwwZH4CwIgk6b75ZJwTLZEaF2JJID8CI
         V2PN9UHRqe0by9EiwCbFeTPaajoQFYNSkkpnEPuUT3iwyAyQT7ASrsC93CFbLuhIapc+
         ruog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rrMgfI50Eg5XKHEVizTx6O8tv2/xGH3VhKUqp7ufSlA=;
        b=Ky3bLLkcNMVoC7ZXttB+bvsmvAvCU93NQp0Pe9GK3ltwEtj3PFefhRNEKlt1FdUMWr
         Xh+6GlxOfiHK/Ap43xEkdfI+xwMhmh/8gISXiRtfFN9LIVkF22Ql+N8I62aNM9JUcEyN
         CKxVAfUeTPb55qTcm9XRh1jPzq6ARfXXYa9+xyNLmcopcOICeA464QIsxXtfnLlqhqE+
         B1oPXnZVyGMV0vkvE9CpyYBlLSSrGXn3f1lWOr3RRYPXrlJZMJkdxCkOTHmqjhBFR6/3
         W5ZoASZuFbsTiGQKeZDAruzwb3g3Z7dO3x1EpudNmDoTvB51uNbLovUmPIWyb781ycoo
         AMsg==
X-Gm-Message-State: AKwxyte2y5HkVXJxbdFMnPt1ZzLDfje6itPUzYPYwNRuAdaX5MuReJag
        7TGC+G4qoSvtfnLjJbUkxyk+DOp7bSl2gfsjL+4=
X-Google-Smtp-Source: ACJfBos5wUm+/c/skB60IspMAlKlxFHx06OMsNumDO/2COmWID1hyJm3cNP9+7jzkfU+lYGiCCruaZCtwx6xG4rNC2o=
X-Received: by 10.157.32.82 with SMTP id n76mr110408ota.301.1516148863752;
 Tue, 16 Jan 2018 16:27:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 16 Jan 2018 16:27:13 -0800 (PST)
In-Reply-To: <xmqq4lnltlia.fsf@gitster.mtv.corp.google.com>
References: <20180116103700.4505-1-pclouds@gmail.com> <20180116103700.4505-2-pclouds@gmail.com>
 <xmqq4lnltlia.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 07:27:13 +0700
Message-ID: <CACsJy8C1-sjeEgFBRx45zHeqNo2ZcgDvoRMs0mKtJLUqmtQsAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: support --git-completion-helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 6:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> This option is designed to be used by git-completion.bash. For many
>> simple cases, what we do in there is usually
>>
>>     __gitcomp "lots of completion options"
>>
>> which has to be manually updated when a new user-visible option is
>> added. With support from parse-options, we can write
>>
>>     __gitcomp "$(git command --git-completion-helper)"
>>
>> and get that list directly from the parser for free. Dangerous/Unpopular
>> options could be hidden with the new "NO_GITCOMP" flag.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  parse-options.c | 37 +++++++++++++++++++++++++++++++++++++
>>  parse-options.h |  6 ++++--
>>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> I do not know if you need PARSE_OPT_NO_INTERNAL_GITCOMP.  The only
> way to trigger this is by passing a rather long option (intended to
> be used only by scripts), so unlike PARSE_OPT_NO_INTERNAL_HELP which
> was an escape hatch to free a short-and-sweet "-h" to be retargetted
> by a selected few commands, there may not be need for it.

It's a copy/paste from internal_help. Because I was asking for
comments, not really aiming to submit these changes to git.git (yet),
I didn't bother to check further.

> Some day when everybody uses parse-options, it would be trivially
> correct to declare that this is the right approach ;-) I am not sure
> how much of the current completion script's hardcoded option list
> can be reduced with this approach with today's code, given that the
> bigger ones (diff and log family) are not using parse-options API at
> all, but for the ones that already do use parse-options, I think
> this makes sense.

Yeah yeah the horrible handle_revision_opt() and diff_opt_parse(). I
think I attempted to convert them two parse-options at some point, not
sure why I dropped it, maybe because target variables are in
dynamically allocated memory ('struct diff_options *' and 'struct
rev_info *') which does not fit well to how we usually initialize
'struct options[]'.
--=20
Duy
