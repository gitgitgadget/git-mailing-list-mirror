Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D538D20964
	for <e@80x24.org>; Tue,  4 Apr 2017 14:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbdDDOHI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 10:07:08 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34984 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbdDDOHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 10:07:07 -0400
Received: by mail-io0-f171.google.com with SMTP id z13so96157296iof.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+7lvsxlBLPEgvJmC1OqENKOFYFBOsyEwV/KthCIr1Fk=;
        b=SSw1CcVOzTgKgU42a74xtDWKfy2jyU/7KsjQcr3b8vLq2CjoXYcdCO1iiadKMISeLY
         UhUhIz6wu0vnTGQ3TENVfPiM9lo4teDFMrPDLtrde7uQAnrOZd+0HesJwdE4mnZiVXQ1
         5giyf091Lbe2eD2xArIWY1mXt5st8H+gApToPvwwhD5d9RSulPtunc4GbXGKDoCnTCui
         MQZbSHXSx9QYX9gGDLttiYfnx97ju6X6ni1qwI1Qb0qj7C0jUPaoVNjmz8DUPSqXVSK5
         boZDkkzFrjcrfTiWr7PIYGiKzGoZv6ZQZEcC57XcYOtHseVV8gzoWljraCPOrIfwn8VQ
         azfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+7lvsxlBLPEgvJmC1OqENKOFYFBOsyEwV/KthCIr1Fk=;
        b=BJjezYa+VoWgMcLhAXQ3ELOFKKk9nnNsqWl9YliRHgP1Rbm+N4WnXwn6l6LxLUQaOx
         9vZUtya8llHAakulf8y3hm1saAhsyEQLnEokf3IbEJSpiy412DyzKhnB2nBs6JLzHdkl
         luLnOiYa/nZubmEw9D7nuL0TLF3vZz1mu6EQbicynfWk5L2bcX1jpINa/pY6pWBFksU9
         nUh9DxVNIKjWA4DrDeaAQojGmabtiS7iocCSOlP85KSEBgc9/tQ+7uGtzXdwWTS3UVfx
         NVRnKpwNJ4bB54yz4IOQBRy/O46qqFoMqEF4VlsdAupGxreiydzWowoAQ6VeU+lOVoZx
         tidA==
X-Gm-Message-State: AFeK/H0Ewrc3qcUVd9fNGWSOpJEllol5bBhXd8t6E3MHi4h2vUwqeEroSMKUJytvwv8WnFOlnRZMOJj9iZvTdg==
X-Received: by 10.107.46.229 with SMTP id u98mr7721880iou.147.1491314826978;
 Tue, 04 Apr 2017 07:07:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 07:06:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704041351350.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net> <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 16:06:46 +0200
Message-ID: <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>, frank@gevaerts.be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 1:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 4 Apr 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I think it's completely fine to include your patch as-is. At some
>> point we need to pass the burden of dealing with these old software
>> versions, saying that you should use a <10 year old library isn't
>> unreasonable. Anyone packaging new git on RHEL5 or derivatives can
>> just package a newer libcurl as well.
>
> But how much maintenance burden is it, really? Is the continued use of
> those #ifdef's really worth this much discussion, let alone applying a
> patch that may break users who have so far been happy?
>
> It would be a different thing if we had to have hacks to support old cURL
> versions, where we need to ship entire >10kB source files that tap into
> internal data structures that may, or may not have changed. Such a hack, =
I
> would be happy to discuss when we could possibly remove it.
>
> But a couple of #ifdef's? C'mon, man, we can carry this *without sweat*
> indefinitely ;-)

I don't really care about applying this patch, but I wouldn't mind
seeing it applied.

I just wanted to clarify the counteractive point that it's not unusual
for some (particularly corporate) environments to be compiling fresh
upstream releases of some software against really ancient versions of
other upstream libraries.

But as Frank Gevaerts's reply (thanks!) which came after your reply
points out, this code has already been broken since v2.12.0, so it's
rarely used enough that nobody's reported being unable to compile git
2.12.0 on e.g. CentOS 5 >2 months since release.

I think this is a stronger argument for removing stuff like this. At
some point we're shipping code nobody's tested in combination with the
rest of our code. This can easily becomes a source of bugs as someone
e.g. compiling a new git on co5 becomes literally the first person to
ever test some new combination of codepaths we've added around mostly
unused ifdefs.
