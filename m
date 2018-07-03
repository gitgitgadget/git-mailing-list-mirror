Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81EC1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeGIWiu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:38:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38845 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeGIWil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:38:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id x13-v6so4714629pfh.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=resent-from:resent-date:resent-message-id:resent-to:date:from:to:cc
         :subject:message-id:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=s185+mPgeGH/5zOWTyKx2vDX0Aq87EsjjvwNzhBcKfQ=;
        b=SveUL+e/WkGmJeAttf38lHxOWiPtyzSlmkC8sklvhv9+lwTwAMLtjEHKWyP1ltfg2A
         K5OAhDyYFLt3Y7M1slKKvWIzvkcbabuEVYaRpERIGRtzJkV/MZDI2oxqfVqD/xJYgh61
         Dta//Dg9eU95WAHI1f5Bfwfc8cJtoO8FDi+1rRtYXEb+v9EcycY6zx6sJvwz1IImnr4o
         MXJFUia+bQRaNCB0rLoyLSeJ4SHv4kU47VoShcnVJnLWixo2ZCsZEwVu+4Dl6Xp91UAW
         qKOtifYYk8+oEplkXDQAtNDltMD8btnw5k08FgQafdVLxdupLCIfSdRmkBXeXcHSx3Br
         uBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s185+mPgeGH/5zOWTyKx2vDX0Aq87EsjjvwNzhBcKfQ=;
        b=iRRGOSEisXKrFYlM8TQHYzZGvoz1zskZLLs3k5+tiAY4fT8RLQ+qObGmoSNeB9b2tj
         +o7ILHsNT3appArm+K3K909oJ/8WmAM/Lx4gHyrSb2XFTYUTM5FptMyOqpTNd6ywlriH
         Yjr69YEC6nT97NOKadErPrqJt7yXi3Ack2qkLanUcbPynTvEZbRhSaRPbud3duNqngR+
         m96PBCcHVC8PNSbS/Kyi7bJBCds+F5LmlZlLjaVJvbl5qIFLpsdl97mfiB5V1w8Bqtwy
         ycwepKsfBUAj+4DC6FIQs+bsuYRnL0jCGhGNV5WFw3ZCQrElxrX+++1AzdxYPXWY1jOJ
         l4AQ==
X-Gm-Message-State: APt69E1MKB1hiOEFUe1VK2ZYf66yyipbX27HVKmsaT3+yOtTGUXWOiPM
        LtMAtejLYgrCxNE2Mcvkx5E2cB0M
X-Google-Smtp-Source: AAOMgpe2uNhWbLrMV5sktUsaN7wjJZSm05aDhxSxsdGG9ZjTVRmyRFmiTUo1D3RKY7vFfJ446MXyqQ==
X-Received: by 2002:a65:620b:: with SMTP id d11-v6mr20631874pgv.429.1531175920529;
        Mon, 09 Jul 2018 15:38:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c128-v6sm29185101pfb.18.2018.07.09.15.38.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:38:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o26-v6sm3987659pfi.167.2018.07.03.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:48:18 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:48:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Akilsrin <Akilsrin@apple.com>,
        Christian Couder <christian@gitlab.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180703154814.GA51821@aiede.svl.corp.google.com>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
 <20180702195016.GA17102@sigill.intra.peff.net>
 <91A9F3A0-5F3F-4137-9A40-CB42EDE4F243@apple.com>
 <20180703133645.GA20316@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703133645.GA20316@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Administrivia: do you mind if I bounce these messages to some archived
list, either git@vger.kernel.org or git-security?  Or if we'd prefer
to avoid the noise from that, do you mind if I work with Eric Wong to
get them injected in the https://public-inbox.org/ archive?

Hi,

Jeff King wrote:
> On Mon, Jul 02, 2018 at 01:15:19PM -0700, Jeremy Huddleston Sequoia wrote:

>> I'm very very interested in having reduced differences between what we
>> ship in Xcode and what is upstream.
[...]
> Thanks for sharing. Skimming over it, I see:
>
>  - several of the changes look related to run-time relocation. There was
>    a series that shipped in v2.18.0 related to this, so that may reduce
>    your diff once you rebase.
>
>  - The xcode_gitattributes() bits aren't likely to go upstream as-is.
>    But possibly these could ship as a default $sysconfdir/gitattributes?
>
>  - the rest look like assorted little fixes that probably could go
>    upstream

I agree with Peff's assessment.  I'd also like to emphasize that
upstream is happy to see an [FYI/PATCH] when you have a divergence,
which would provide a thread to reply to to figure out whether there's
some generalization that is suitable for upstream.  (For example,
maybe we want some Makefile knob to allow setting some baked-in
attributes.)

Thanks,
Jonathan
