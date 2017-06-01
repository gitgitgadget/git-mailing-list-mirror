Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5A420D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFAS2s (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:28:48 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35824 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFAS2r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:28:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so34324305pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iU/imj7BA1MASRZXrzNo0HlADH08ijZfWndAiU6a0Vg=;
        b=v9GNjHz2DZo6/ZAd7RSzVv8jEMdDjiIee74CcXcdEli1sgiLidrCXbbztkFPGGDlvD
         iD6pnjxrJ45sHdBdPWsT1WOQBwtcVxBJ+60ekIwmCkdkwe8PM7nZWY5FiP8SkdR8YoSy
         d/WKOXuRWg9Cm3+5Olmg9H/LPYs5EYu30CbbpJRmKiN0PXFUr0ACM4mC9u/sP1LASLAv
         0y06zdWQ1xVq3nTCPtzOR3km6qkmoRvfxWxBVCaqbyC/54QfsmUZx1Fsi4/cbHUkdskg
         zlTBmgYHER2kpm5N8VFyovsZRZ79HxFVfRVtUMl3M/LEZH0q7qvcEveraKLdLkmzvGJ+
         84EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iU/imj7BA1MASRZXrzNo0HlADH08ijZfWndAiU6a0Vg=;
        b=ehnJTzOuRW6dNp9bnD3iL8ror8PksOBOQC5ZO6LLlx/Bavv/NcY+yh3U3ftVaiKyyz
         7784jxTWZn5Yl9Z0/yQ57BabpMiRYXpZhoJVicIXFo7tQrZXwk0rA8vT6X2C4DHW0vEJ
         7FTaoxE+e4z+OvEdbgTyohq7XN97xQ/EXo1eU+CFQSgwt54hnUkwIQLEm9xjFsTdpA7/
         KJVPrlZ5pEPHL15itwyNlCc/7BSMJO0TMUebaJwgOjqR1FLn4U9MTT1GY0LBlVPJfEFr
         Vmy6sDew02WJjoA2n8wdFwkY9VI0NXXVuQMu3Uod/OmKdqKvk6SBuEj9UpgIPzZ/3Zg4
         t5Qw==
X-Gm-Message-State: AODbwcBX66k8s6xREaPmUfkXqVYi4Py3Ern5cIY4t/j6KL7NIbyV1ceJ
        KlHBvwXtd86zVrUmGJ9RvFPa10HZex7V
X-Received: by 10.98.91.5 with SMTP id p5mr2323802pfb.94.1496341727067; Thu,
 01 Jun 2017 11:28:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 11:28:46 -0700 (PDT)
In-Reply-To: <20170601181059.GB127481@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170601181059.GB127481@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 11:28:46 -0700
Message-ID: <CAGZ79kZJF9iDsVgyi-hSKb6N8w0uhVCU4W-r89F0eRJPXe_4Og@mail.gmail.com>
Subject: Re: [PATCH 00/31] repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:10 AM, Brandon Williams <bmwill@google.com> wrote:
>
> For those who don't like reviewing patches in email form, you can find
> this series at:
> https://github.com/bmwill/git/tree/repository-object

I was just asking Brandon for a remote to pull these patches from.

As I was looking at the very first patch, I'd like to lobby for trying out
origin/sb/diff-color-moved, as it will tell you about code movements. :)

Thanks,
Stefan
