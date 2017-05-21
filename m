Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E172023D
	for <e@80x24.org>; Sun, 21 May 2017 08:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdEUIXn (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 04:23:43 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34468 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdEUIXm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 04:23:42 -0400
Received: by mail-lf0-f42.google.com with SMTP id 99so17490426lfu.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Iwi7bRD7IrQHAnua66paga0aAW4qa0129QhwvsVVjg=;
        b=VNjaARw2TQqw2klMDCBGLUENf1rjsGyoAIA6D3xX14+Y0/LoDRcDq2zon5T0AZ1DQA
         DPz47GwS7rkufunUMPhsgjNY4G8wVeLIiM8Pm3uSFFWPSJAS15S0XuqWWyGTCKBhbmG0
         VT7pvFVHflusFnFKB6Mvx61SNFAa9nJOCxWS5yrIA78w9aJ9UA/jFWkltE9jOwvHInzN
         4UX/hJ+4yW/7URDs1YIVyBKshBT94DHbpEzOgXc1VtY/zGG5IQ8YpmK0XlJjv8+BqB27
         T4Twr2Eu+/rSxkI3mERjDyel71uYaMk23HpCpNVbYbRnp743SW+l+UwBPx71hIoqNKcJ
         IzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Iwi7bRD7IrQHAnua66paga0aAW4qa0129QhwvsVVjg=;
        b=PeBszQ+5aiZQLHZHC5DlcgeZ9kKGmqt7dtK1aBD1RL1GRVLDzBoQBxWEEMnWgZ6aji
         Ut7y+rxjx5tzMH9NLhGJXPl3esxrqu26F+/tPDa+yj6EwpuHj7WN9ckr9PXcXoZPUpZ+
         /hsDEpSR/GK+OSS4QZMlKmMQL/q5sL2+mH44xqiIwxoHPTV6jCgkMPkrr79FCqSQ0BzW
         4rZIfmptteKbHa2kcH3g13KZFD9QIWum9NHnpUNPCKjSVi8ui4KaeEsJ1RQlmM0t4rE5
         Choqn39gv5sll7ArlYBalp3vp03OppxN0RGtbJ5OeaR5eoPNiIUqDFZW3Ow9K9AloUIv
         P5ww==
X-Gm-Message-State: AODbwcBQOIEe8+rxnKt69TTItS92P0PYE3cvHx75K5UVB9Y+bUQQvmA+
        AumwQe197FJvIocuqSjoqzlCvU1wuw==
X-Received: by 10.46.9.208 with SMTP id 199mr4642830ljj.23.1495355020857; Sun,
 21 May 2017 01:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Sun, 21 May 2017 01:23:20 -0700 (PDT)
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 21 May 2017 01:23:20 -0700
Message-ID: <CA+P7+xpTKWGtoauQ_radvue0SYgS9VEzS=jTghd_+N5xrX8Cwg@mail.gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 4:21 PM, Brandon Williams <bmwill@google.com> wrote:
> This is still very much in a WIP state, though it does pass all tests.  What
> I'm hoping for here is to get a discussion started about the feasibility of a
> change like this and hopefully to get the ball rolling.  Is this a direction we
> want to move in?  Is it worth the pain?
>
> Thanks for taking the time to look at this and entertain my insane ideas :)
>

I haven't had time to read the patches yet, but the goal I think is
worthy, and worth the pain. The ultimate goal allows us to more easily
write submodule features (some of which are quite difficult today, due
to having to pass in all kinds of state to the submodule, and
launching a process is expensive when you have a lot of them).

I can't say much about this particular code yet, but I hope to be able
to look in more detail in the next few days.

Thanks,
Jake
