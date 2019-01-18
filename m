Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C04F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfARJpq (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:45:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36525 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfARJpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:45:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so3840276wmc.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DFInppZsYk4KMz7o6teRwwxb+TJ3fSd5N1T88dhcjgQ=;
        b=KVM6gc8i2LY/ethuw0KUazUBobCK2rRx3/RlzRZn2R5xYH1cGsa1T4nsmqJKS/Apfz
         M9imFx8lghb6GHMUJjoeVJiVd4Y/XkhzrRwUkHbkHELdyg7ZC3gsh8iXX5CpCq/jDuSV
         JggIyVoxh1PcOJ1SYLSPCua3/JBFb2bqlhiFLoChrLVQa98h0jIZr/tfv+TH8KrT7Uc1
         pXfKi7ShSlHi28l7eg/imWMLmii4tZ/Jx2c95XAbusbxH8s8JDqgQMV1tQRLFjlH22iN
         4FapJWmGEPrOyjtDZSP0zUSO7ABbFMfSqP54/gbCzqDBqkVnCBDqKZN0st/cHFHG4xCY
         8zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DFInppZsYk4KMz7o6teRwwxb+TJ3fSd5N1T88dhcjgQ=;
        b=lkA95hXXLa7DmSYi2RrESCgeeIjdQBpPLOIbbbypHjokG0qsc4+c7nXWHRnwqt+FWn
         rDW3qea44GN/6Q7+TInR0Nr1huyIenE4Onb/3pUNmWqpswTH/gE9tlUOjUVlfsnOHJvF
         JB1tRy2Gt0MJgYmL93Wh/FIn8vUTHgimGY3CRtEYFoU+Og/Th8hwGAb7D22mmn2iz4wW
         fApYuHA82D0xRPkOgN0bkU3vtI1oPSpnDiXBv0eGAz4RlKb7DIx4NZMOYCo+UB1QjG1I
         90Rde53S27f2Lq23NRngtQ4KacLXgmH1F9I++Sqt9bHHJ8LNUndeoj//mYKMOZR+57+S
         kl0A==
X-Gm-Message-State: AJcUukdesw8fvRORjoZwmVhTAZAUfOIUkCONhx37p5YnpLOEXdqh1Yf9
        H5a8ihQe1HAGAoRqYSmDiy4=
X-Google-Smtp-Source: ALg8bN4faqHJRMEmPDVMLa95ufyuHdx39Z2l52PxPsVVfHA3Bjk/4LJPZAoNQB3Zwc98Jg4DvLy5Gw==
X-Received: by 2002:a1c:494:: with SMTP id 142mr527764wme.111.1547804743830;
        Fri, 18 Jan 2019 01:45:43 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 127sm71478666wmm.45.2019.01.18.01.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 01:45:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com> <20190117202919.157326-2-brho@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190117202919.157326-2-brho@google.com>
Date:   Fri, 18 Jan 2019 10:45:41 +0100
Message-ID: <87k1j247ui.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 17 2019, Barret Rhoden wrote:

> -		die("Could not open skip list: %s", path);
> [...]
> +		die("Could not open skip list: %s", path);

You're just moving this around, but now that this has two uses let's say
"Could not open SHA-1 list; %s" or something like that.

> +			die("Invalid SHA-1: %s", sb.buf);

Unlike Johannes I think it's fine to leave this. This file-format is
SHA-1 only now. We can cross the bridge of making it (and others)
SHA-256 somehow when we come to that, whether that'll be allowing
variable width or a different file.
