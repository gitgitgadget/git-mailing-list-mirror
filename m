Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF151F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIHSgz (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:36:55 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36071 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHSgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:36:55 -0400
Received: by mail-io1-f51.google.com with SMTP id q5-v6so3645373iop.3
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XlTEHNRLcx6zTArmhBidqeUXa/S1wroXGJZNRxdc8Js=;
        b=FXJINhXceSTydrb2oYgIQ7J/95kTP8S0uY55AonzQJ4jKJneD6S5xjoS4I7odTX9oL
         T9+noqbwMkYP3RuJMpMosmiXrSoaB2GZplVR2MZka+8kBZUtJYI9JMiKmz07iBb8q7dR
         cJJrAETtBZvEoHE2e/pRkUdCGzayZyIQzy/W3lE15UyMi30IYcK9v9NQZj6BjIJ9C49e
         JKrK4fIABJnZUTyzHdJaDZqr7UhUBTPVWRDRF/qf2peUHDGvSo74n7P/UBdxe5N95v5o
         O9zy3rrjRl+fOEgGM6Krq4VcA9jg+c1DFoKUMUEbBi6X6lyRCvdJ0XxixeUQxVPXv1iV
         Pzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XlTEHNRLcx6zTArmhBidqeUXa/S1wroXGJZNRxdc8Js=;
        b=J4qwqwRihWJ25f/DFn/t3Y9KxTvQLAwkLfHZndD5M8TTCu+q1uPNBmB07MwKrus12g
         R7Qjx82+IZjG7VTxmdIj3BcVBDWo57LFz/klcxI5Waa9Kg5u7OLTMfmGI2gb2JF1KfeB
         LfKvTy6GroKVWD3NMeJjB5lpYs5SUuOYSjN9V+wVxQ/9DPyvT4bAqoWXQfbHfOVHulWt
         IxkvYKkrHj/qnrh1mU7H8dZefgqrdD8gsLOefpZTAnxXwnFcAUxTU5mKwKM+6BMaPCAR
         BEUjvyJSTdwIoDqqSnT+YZqYGHNUXRaNPYnZKdarOnxkNuw1U9UU/FV3P5QB7x+u1ZDc
         VYhg==
X-Gm-Message-State: APzg51CqUSeh/XPEleEC+NlD3b38dfDZLwfUhCaTDtvRMA1qglhMPee3
        Sh2MkNR1cN42r1nxnxMoKbOcs2PokCiBRXVC+Sg/yw==
X-Google-Smtp-Source: ANB0VdbblR9ovqzPbUwn2mW+le36qJ2NQCBuYJVrBMwtm+6KBz1tmbMibpElSKBGayaeRA0UHWJimrfo/4ynDvFwnDY=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr9370851iok.236.1536414663247;
 Sat, 08 Sep 2018 06:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-2-szeder.dev@gmail.com>
In-Reply-To: <20180906024810.8074-2-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:50:37 +0200
Message-ID: <CACsJy8DKOvFj-V81HJQ+0Nx9QkeZ9MqrTPWJ4kDvJmbt+E4o_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] t1700-split-index: drop unnecessary 'grep'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 4:48 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> The test 'disable split index' in 't1700-split-index.sh' runs the
> following pipeline:
>
>   cmd | grep <pattern> | sed s///
>
> Drop that 'grep' from the pipeline, and let 'sed' take over its
> duties.

Years of using sed and I never realized -n could simplify this
pattern. Thank you.
--=20
Duy
