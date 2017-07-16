Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6602027C
	for <e@80x24.org>; Sun, 16 Jul 2017 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdGPVMa (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 17:12:30 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34346 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdGPVM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 17:12:29 -0400
Received: by mail-ua0-f170.google.com with SMTP id z22so76787888uah.1
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xBcTOqb391/Axjuk6tyxESLVRBz6mEukLjfE9jypCOs=;
        b=UPfQdUwhTVQszZcq3EttEMLdnIa59+N1/QkjpawrhA++wlJOhzzayI/9nb5NNzsM4G
         cVANlFdRpROO1uetc13SqYYJCxMpY40RQhatzP9xEogF8I2x4PBhlK4e19VjgSJyfwqD
         nS1qitbBeYjLNj5q6uYujQRpEUGtmnlFktE5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBcTOqb391/Axjuk6tyxESLVRBz6mEukLjfE9jypCOs=;
        b=aU75UdSlKi57V05PGxqyA3Wx1bkvMJWfU94l2grbCXN+mGoKr/8QJHWPPTxLgPcjd4
         UWpA/GqE/M6O2WwM3AvwzUfWavaUyCOQfNZuqwaTFU+cZqMBrQr5MELDfT1iAiwC1Lcb
         Na/6AQRrTn42tIzhdJX+4D+QnZT/OLCKCM4BYKZpLwTtaX6hP+8KKkFtngjNhg1YCEu2
         8HKSRGpKXPIYcOS/eWdhPTCCgy+UWvZ8hQ4F5QBnpIYKMoAQz00ALLW+Sj5wrP1In2K1
         rG2ekpWmUkbSX1sE5Cr70OI7mWrAaLO0VBeKQF1qw9hRnQZU644eh2Y6psyhUpZXdXkX
         JHug==
X-Gm-Message-State: AIVw113jhzNmvDV2OPMoCCXCk2BnDk3S07fL+EYf8PN8oTvdkMfI+BJj
        psoSzhREY6C1OhS9KKMYNVqeYNW+xW8NPP+d0Q==
X-Received: by 10.31.142.74 with SMTP id q71mr8956000vkd.67.1500239548605;
 Sun, 16 Jul 2017 14:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 16 Jul 2017 14:12:07 -0700 (PDT)
In-Reply-To: <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com> <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 16 Jul 2017 14:12:07 -0700
Message-ID: <CAJo=hJuOOuv_TFtqXSWUqrrGc2BT01mKj39_Jepv2cyUYF4Z4A@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 12:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, Jul 16, 2017 at 10:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> * The tuning parameter number_of_restarts currently trades off space
>> (for the full refnames and the restart_offsets) against the need to
>> read and parse more ref_records to get the full refnames. ISTM that
>> this tradeoff could be made less painful by defining a blockwide
>> prefix that is omitted from the refnames as used in the restarts. So
>> the full refname would change from
>>
>>       this_name = prior_name[0..prefix_length] + suffix
>>
>>   to
>>
>>       this_name = block_prefix + prior_name[0..prefix_length] + suffix
>>
>>   I would expect this to allow more frequent restarts at lower space
>> cost.
>
> I've been on the fence about the value of this. It makes the search
> with restarts more difficult to implement, but does allow shrinking a
> handful of very popular prefixes like "refs/" and "refs/pulls/" in
> some blocks.
>
> An older format of reftable used only a block_prefix, and could not
> get nearly as good compression as too many blocks contained references
> with different prefixes.


I ran an experiment on my 866k ref data set. Using a block_prefix gets
less compression, and doesn't improve packing in the file. Given the
additional code complexity, it really isn't worth it:

format           |  size    |  blocks |  avg ref/blk
------------------|----------|-----------|----------------
original          | 28 M   |   443    |  1955
block_prefix  |  29 M  |   464    | 1867

:-(
