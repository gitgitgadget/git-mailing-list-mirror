Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910A520282
	for <e@80x24.org>; Tue, 20 Jun 2017 13:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdFTNss (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 09:48:48 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33923 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFTNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 09:48:46 -0400
Received: by mail-io0-f180.google.com with SMTP id i7so84918670ioe.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LGjr2NjIYpQNraLJBHW/hm6qf3W+IHYri1HPEXBTBB8=;
        b=M7Lk+LJMVAh+8VA6zbSj1bmZBqviUPxiqzgNv4/mAM/5i7m4qWJoZS9m0y1x8bCQex
         OXNqh4ooqKMyTznrapxqxk6XDa/+MIt158DWLK/4CLf2rkulbLsySyb9qqwnYLL3CRnS
         9R07u+YB3dNm9gHS4UOW4mMnA7lte9foKFFsuwuJg1zSv+WtqTA31Q33nQfOelEF8S2B
         7KUN/gYMthNTiHWq8Jvi14e0s8PBj1uMWAzq8jGSbOpMNF9XdbRpMlSYjM3+mq0QtslY
         VDTfpRDzeUuHVWtnLASo/tq4LznafWMQXWhFZoc8HcMVpcW5wdc2PxiPYlVFkaQIbRdE
         3LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LGjr2NjIYpQNraLJBHW/hm6qf3W+IHYri1HPEXBTBB8=;
        b=EjzBb4SLQuEpNzzDlEOGJMOdvcA4x7BbAXuffMWAW1jGKbVmls+dyPVUbqBOgRktNs
         ltv+WRLTKtkiTLutPOLVgLbWEwH4JM0Czx+xGEOxEeIh6AhPuaj2kCPQpcCm+yytQXy3
         tjXyyYrj3L1zIBzccAnFMT6JIynIzmSyOpjL8kgd5yOpbzr88OoWttGNRizuLRyyzXVB
         6j5XCDUQULaRiyONez8BW8yQ4fpS7kJUf06nJg8I7ovMAPLh/BFodq+BQ5cQp31Mcpaa
         9RGAUlXKCc9EoFHDBM6tpWrYEsErB9Volob7vl4hezu9vWOtssXtRwuxgWw0FRNGdrN5
         nDwg==
X-Gm-Message-State: AKS2vOw24ixqTnqXwx4R0B9JEZLCPRN1HiwKzAbZdiNW0GVZm0C/EYWG
        97VErDH0cauv6EMNzQ4jh45TSHO8MeXz
X-Received: by 10.107.145.86 with SMTP id t83mr30782914iod.129.1497966525114;
 Tue, 20 Jun 2017 06:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Tue, 20 Jun 2017 06:48:44 -0700 (PDT)
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Jun 2017 15:48:44 +0200
Message-ID: <CAP8UFD2S21er8U8KA6MBfu5uES5iNd8zV0=wcVNtAbKv5wVpuQ@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 9:54 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Future work
> ~~~~~~~~~~~
>
> First sorry about the state of this patch series, it is not as clean
> as I would have liked, butI think it is interesting to get feedback
> from the mailing list at this point, because the previous RFC was sent
> a long time ago and a lot of things changed.
>
> So a big part of the future work will be about cleaning this patch series.
>
> Other things I think I am going to do:
>
>   -

Ooops, I had not save my emacs buffer where I wrote this when I sent
the patch series.

This should have been:

Other things I think I may work on:

  - Remove the "odb.<odbname>.scriptMode" and "odb.<odbname>.command"
    options and instead have just "odb.<odbname>.scriptCommand" and
    "odb.<odbname>.subprocessCommand".

  - Use capabilities instead of "odb.<odbname>.fetchKind" to decide
    which kind of "get" will be used.

  - Better test all the combinations of the above modes with and
    without "have" and "put" instructions.

  - Maybe also have different kinds of "put" so that Git could pass
    either a git object a plain object or ask the helper to retreive
    it directly from Git's object database.

  - Maybe add an "init" instruction as the script mode has something
    like this called "get_cap" and it would help the sub-process mode
    too, as it makes it possible for Git to know the capabilities
    before trying to send any instruction (that might not be supported
    by the helper). The "init" instruction would be the only required
    instruction for any helper to implement.

  - Add more long running tests and improve tests in general.
