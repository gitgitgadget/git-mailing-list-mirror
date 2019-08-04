Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D771D1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 20:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfHDUWh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 16:22:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfHDUWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 16:22:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so5745579pgp.4
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fV43OGnSW75buhef5Zb7N5kIG+kriotREtBLnwhsydc=;
        b=k+oCnwMucsQqrLDRepOAEVaSileLVLBYQBaHXH94oKDypwtpIOWZzNjSvObKUtmqnw
         Hq0379yEE7bd5vII6Sf8Dwq662v1CmwqeYcFyo3hQ7afQ7EBt6J/hfjVlV8hpdzuKuci
         4PRiF12wbywS9VcwlyPLUaXVgjAJsR3vApf6+oYGx/eQD9hDIp8NEWA8WVNP258uOxXF
         LiCfdG1vqPyhFdY2j1l1oMiqyvyIt2ZrlpQyjsRTwSvrIDYUvDi4WfhxuaRWp/AjnuT8
         GO75bbcSylOXXMhiIXyebrBRy0QIHgrKkMz3Yu6BGnSPRQ7SIktw4CoztCn2aqepQe3y
         Dvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fV43OGnSW75buhef5Zb7N5kIG+kriotREtBLnwhsydc=;
        b=bw3MPPzLUX+1PmqzWLglJgj2EZ63X5A3K1DfPJoXG+6YqzUDlsnsR4Fm0POpRr8ANS
         zIatxgKeVuK8pCQkKVA09lV5SBBRdBDqNSNjYDU8qj3lQcIP+dt0wijtm6nsDad25VSJ
         87qit5/uG6b8CFoZW0W8m3vuQ8ICMOEhXgKbfApAObVv6Kw4HGpKVsXo/bTLSIxiH/rP
         93kAciLX1Nzm25TeL8B1MLX2oNwFX4AYNnrgiT5PIpatvbzqzitzyKoc/El4W++gFRCM
         i2aWiE24rcxww+HdENIq2KrguT9SkperKErWv+3lx4QcU4k5dRp3mcFcRmrOEJYDtYHc
         Ydiw==
X-Gm-Message-State: APjAAAWyO7mnrzbsR83vRNXughF0ItP8ce0Wf5fQfwo9VHCOSVJtS+ff
        5HwodvdqI0otETIRLuRIx3s=
X-Google-Smtp-Source: APXvYqwmgUH7ZXcEfAfy9yOfRjGxUFXJykSP/5B8w3U5Wq475BWWGc0FSrjf0RHDJ7u20F1/DY2KGw==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr14035127pjb.141.1564950156025;
        Sun, 04 Aug 2019 13:22:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id h26sm86282575pfq.64.2019.08.04.13.22.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 13:22:35 -0700 (PDT)
Date:   Sun, 4 Aug 2019 13:22:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyohei Kadota <lufia@lufia.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Port git to Plan 9
Message-ID: <20190804202233.GB258325@google.com>
References: <pull.305.git.gitgitgadget@gmail.com>
 <20190804003816.GE118825@genre.crustytoothpaste.net>
 <CAFMepcm6QVH+5H6on2hoWiMXd=Zoyi5MYP1GAt0WwixZN9oE_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMepcm6QVH+5H6on2hoWiMXd=Zoyi5MYP1GAt0WwixZN9oE_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kyohei Kadota wrote:

> I think it is possible to replace rc with ape/sh, ape/sh is POSIX
> shell in Plan 9.
>
> However Plan 9 don't have recent versions of Unix tools,
> such as gcc, g++, autotools, gmake or perl,
> so it is VERY hard to use Makefile instead of mkfile.

The default Git build doesn't use autotools.  See INSTALL for more
details.

What version of gmake is available for Plan 9?  I wouldn't expect
Git's build system to be super demanding as far as recent "make"
features go.

So I wonder whether it would make sense to do something like the
following:

- add entries to config.mak.uname to set the compiler e.g. to 6c
  when appropriate

- make appropriate compatibility fixes in git-compat-util.h

- add any necessary helpers to the compat/ directory

- use gmake to build

Would that work?

Thanks,
Jonathan
