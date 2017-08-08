Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1247F20899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdHHUIS (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:08:18 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34362 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdHHUIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:08:17 -0400
Received: by mail-lf0-f53.google.com with SMTP id g25so19568905lfh.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n7jpr2VARJyTAsc1kfU8CNKrC9CJJMBT+Tu3XB8YPPU=;
        b=l41HfgiiXaOobNtMCB+6CmgUL1Wgdu3/CNZLjI/WAGELLH+PPJZkHcHDOSrQ83jSzU
         2cAO9411OxXDOL9eM7096huLGJ1QffkJG0rnkcwMEUV3GZWPNCD/oGTO4e9g7ciBr0EO
         Tw00qjKfz1uZdBk9GHUH6cPJm6TjZft6p/sHSf8i24ykTZvqxbugHkZR1VlGfDCHMi5k
         zAL9D7sxskNMr0/2j7uPyeX4YqHuuKCBnkawAbFh7rPndB2krQKqTx45N4UMM2kNv6I9
         BXrEW2CQto4uT/FziZE++nHBpwWtiauGv69RVrpTS8HqMjamH9Am4pbRdH/s0sc48yC6
         4Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n7jpr2VARJyTAsc1kfU8CNKrC9CJJMBT+Tu3XB8YPPU=;
        b=Fb3fJ1HUClE4C2pzenRa0hW/oe8q8OQP6PExi/L/RAZEWeqMeNbJDmGFiEIqmmRSrW
         f6X5W76WLiCzOFXYTsK0FlYFy906rGMHwHJb2ncoN/+HnYs0OhAgxWvCXgdxnngTG/Ff
         YAdwiu/HOyIvxrnnUPxikLis2ccBbGF/TmG5h0ppWECRwqvgeICCGqeoau7trU/Vor3W
         37v+YoDHWC9uNQJX7KzOEVWHPrVfKcZwI+Oivqy1dvEnVX2m11i4Yw9US2zKnRGd+OOC
         ORQzr0q9acYlpVs8g43vdVox7H0yaV/SBLLS0YbMPIdBVMZefljXV7nw0d6v0d7L5JNB
         kcIw==
X-Gm-Message-State: AHYfb5iONFOChd7VSOIHDBfcCXIHPadcwy9LFwLI0JRsNf5qaXwvqfE/
        /wCRalUlIgMzzKm8Y3WGRHqtb7iuMsms
X-Received: by 10.25.15.221 with SMTP id 90mr1937831lfp.220.1502222895853;
 Tue, 08 Aug 2017 13:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 8 Aug 2017 13:08:15 -0700 (PDT)
In-Reply-To: <xmqqh8xhc0c0.fsf@gitster.mtv.corp.google.com>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com> <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <20170808171136.31168-2-kaarticsivaraam91196@gmail.com> <CAGZ79ka779gwmLKuSumRdFj3PqXkUe8SfG2ri+qmf_9Z3gsckg@mail.gmail.com>
 <xmqqh8xhc0c0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 Aug 2017 13:08:15 -0700
Message-ID: <CAGZ79kbn4Ew1g4oUhukOF9Qny6OW2wGBRv9QQr3M4E_sWD0ZMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2 / RFC] branch: quote branch/ref names to improve readability
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> (Though wondering for non-submodule users, if they perceive it as
>> inconsistency as other parts of the code may not follow the rigorous quoting)
>
> Do you mean that we may instead want to remove the excessive quoting
> of branch names and stuff from submodule.c code, because they are
> newer ones that broke the consistency existed before them (i.e. not
> quoting)?

No, I do not. I was just wondering if a non-submodule user
may see differences between different commands now.

For example "checkout -b" already quotes 'external data', which
would be inline with this proposal, but there may be others.
My question was rather an encouragement to check the code base
if there are other occurrences left that do not quote.

In an ideal code base we could just grep for any %s that has no
surrounding quotes, but of course it is not as easy in the real world:
* some outputs use %s construction for non-human consumption
  in e.g. the diff machinery
* sometimes we play sentence lego, stringing words together
  which also is using %s unquoted correctly.

> That certainly is tempting, but I personally find it easier to read
> a message that marks parts that holds "external data" differently
> from the message's text, so I think this patch 2/2 goes in the right
> direction.

Yes. I like the direction this patch is going.

A note on 'external data':
For branchs, paths, submodule names a single quote seems
to be best (my opinion), whereas in e.g. git-status:

    Submodule 'sm1' 0000000...1beffeb (new submodule)

parens seem to do a better job as they describe the state,
not reproducing external data. (This is also the place
where I was reminded of potential sentence lego)
