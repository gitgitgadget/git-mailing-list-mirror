Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002851F462
	for <e@80x24.org>; Mon, 29 Jul 2019 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfG2Inz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 04:43:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44879 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfG2Iny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 04:43:54 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so118073700iob.11
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QkHfYKp4no/aKdvgdDD46q5cFxj4U68n9wN6sJAKfIo=;
        b=iILICJKP1/PoniUCAH7kvuntnxhsy3ujM7cxQo4lf9plDhEuwS7Frg28/7BYV0NLXY
         AYTjrQBYpxdZVNOpfYFMFFuA2pLLLAdausibAl03Zp0sciv+BB8fgW8X0ZpkBzz8Wk8N
         lzUBOWmEUrWr2yPJs7+NYj5WxF1rr9kYbHaYggpfXzeYCZCtdAmr1AxwST9QvhnVs2RJ
         RWJb3LP/rWjzTfXANs7H9/hOoeQ/cyYYkYaSR7M0T252oY6kQoAMfZ/oLk4Ej9WlfCpR
         SdWafhEzrt/0JmDK9tutayOlkxPu+fKj5UHTWRByvlW3KyhalFCrGy5FnJY6i3HxfA5T
         jSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QkHfYKp4no/aKdvgdDD46q5cFxj4U68n9wN6sJAKfIo=;
        b=qr1h0fmPLYiw+LLobA6/cOYP0gJBw/ss5gEPCs31Qk6B76qRCobngso2IY/nL9kr/u
         m2XVzvXdzqnVGJJJ8Joa8EyRb1VE0Sj8O3d6t1h7/JMXPkV8ZcyS7v9Ov8mN+npx2aKX
         ID3RNka0CP6z29A+P7WEm1kIgRXvUEmv7GM527Z9eNbPi44+SKh9+tkAqMjYJqvBpSMR
         WYWlGFOoOE95EBcdAR9wQXX42OYFTods+sFEBx1yZP3xLfKAahVUWm0snFt7LGxp89wc
         ipZ6CbMTO/kPqLOf1aYZ5zEacNk+Np9CmsDWMkqylLSvasW/mygyAOoeSpc4EKIr/hH6
         oQvg==
X-Gm-Message-State: APjAAAVmXVimW3tQQekBsDLQsDU1UWjSafwRcqphIg1ET0KqG5vlSwXW
        FiSrGFuGYqwNoT7qa9V7wFZal22lAX5ACChW0gQ8bPNaVm8=
X-Google-Smtp-Source: APXvYqx83nY9AofNDZWH3XX+oPJ6uVUv/nc76ExdLAN5qimGDsIak7ljBqCBQnAzIOLzdxvQWU+pg+21kRkGx+ehSx0=
X-Received: by 2002:a02:b016:: with SMTP id p22mr26780646jah.121.1564389834058;
 Mon, 29 Jul 2019 01:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190722181923.21572-1-dev+git@drbeat.li> <nycvar.QRO.7.76.6.1907232118460.21907@tvgsbejvaqbjf.bet>
 <c85bcde8-2bef-3345-ec43-9ab44e587e39@drbeat.li> <nycvar.QRO.7.76.6.1907251111140.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907251111140.21907@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 29 Jul 2019 01:43:43 -0700
Message-ID: <CAPUEspjS7wpp=XVJpxzyEoKq-27C72hiVRynwERwZsmpEcLJkQ@mail.gmail.com>
Subject: Re: [PATCH] grep: print the pcre2_jit_on value
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 5:50 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 24 Jul 2019, Beat Bolli wrote:
> > Do you mean something like this?
>
> Yes!

Ideally, though, you want to print those values closing to the match
function (pcre_exec for PCRE1
or pcre2_[jit_]match for PCRE2 as they might change after they are
extracted from the PCRE configuration
with pcre[2]-config()

> > If so, I'll wait a bit until it's clear whether =C3=86var's series [1] =
or my
> > patch is going to be applied.
>
> Sounds fair

FWIW they are both applied (yours all the way to next), but =C3=86var's
changes now in pu (but likely to be rerolled soon) will most likely
remove your code (as explained on Junio's emails)

> However, my reading of those patches is that they still keep support for
> JIT'ed and non-JIT'ed PCRE2 invocations (preferring the former if
> available, without any UI to change Git's behavior in that respect), so
> I would be surprised if this patch wasn't applicable after =C3=86var's
> patches.

the PCRE1 changes are significant enough that would break the current
check and might
need a more convoluted check to figure out if JIT was actually used by
pcre_exec.

more details in the configuration[1]

Carlo

[1] https://www.pcre.org/original/doc/html/pcrejit.html
