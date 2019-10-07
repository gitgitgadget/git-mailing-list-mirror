Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D4D1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJGR35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:29:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGR35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:29:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so367315wmg.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eb9BP9NFjFPXr1sp3/pgry3j6GlpP9qusYAbxe0loRI=;
        b=ezE+PGbQPHRT3g4+i5+lcHZGyvV31EK9C8u7URO9q1ONGyzbYZC+Ut3/qsEs96tZKr
         CiGKREn6vf/a4aV76mzA14hPeE/7oW8Cu8JXJB3bJXmj9LPRwRKA4e/AZF3D+B0j9fBP
         7Qau1rOPpCex4nj38Dww/ACw4l5RBL+qHRKT8/LF8+4rvXVjD7ZL2xX2IvhDqR6SFGJU
         Qg48xmPqhhj3gAAXMv9FqMVbP2JVaBT0pDMk4yN4+U0aICbTzIZ3NfoeqXZGpkJrmj44
         7pV4CDOh5hjEqwx9BfvcCf7NRvJ+w36C7fBvdT32ReP3MUVd+D8wUscT2Z/vbNgpZHPv
         9p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eb9BP9NFjFPXr1sp3/pgry3j6GlpP9qusYAbxe0loRI=;
        b=UaHkdPDpYho4R1inwXXptaMhB6/MzBNbEjH2A9EmtWjWahVpOR3mKxB/ujIcRSH413
         /SGMdIkf7/3yJ/pDmCu2ns9obMHCBQ92OxD8gX39o6cusi2kjoL3QMptyxlv+a+oiPTA
         O+GHtirYf6mYr7lujiHuRskFlCnLr5f9+XuhtYnoLen2zXOezSA+GF6up/OQsIujU5g9
         gXdpao8X/rGoKSS486paf2w7T0Hdyva4o36ip02gH9mox+oL/0tshTeXD9z6kXo0d96C
         WaaJ0jX91lEcYA3oXiWOIV4/sV4eNytG4XTfn0dQws9VLuGkE8y5paCW+BST3Ooav1XO
         ihig==
X-Gm-Message-State: APjAAAVSL8wQDh8JKHDDIa7iqNnHqx0AMQDuhlKzOthlMi/fRortU3Ej
        eZeC4YMmnx1WUVkfJeDIOHY=
X-Google-Smtp-Source: APXvYqw/E1w+bDxNic8tXE7C0EQKlzRc0Dxfd9V93TozJ9k0ZwhIiyav2sNempXA7h9+jl0oCZXavQ==
X-Received: by 2002:a05:600c:48e:: with SMTP id d14mr287765wme.175.1570469394677;
        Mon, 07 Oct 2019 10:29:54 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id y186sm405560wmd.26.2019.10.07.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:29:53 -0700 (PDT)
Date:   Mon, 7 Oct 2019 19:29:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
Message-ID: <20191007172951.GC11529@szeder.dev>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 28, 2019 at 12:40:52PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Fri, Sep 20, 2019 at 09:53:48AM -0700, William Baker via GitGitGadget wrote:
> >> diff --git a/midx.h b/midx.h
> >> index f0ae656b5d..e6fa356b5c 100644
> >> --- a/midx.h
> >> +++ b/midx.h
> >> @@ -37,6 +37,8 @@ struct multi_pack_index {
> >>  	char object_dir[FLEX_ARRAY];
> >>  };
> >>  
> >> +#define MIDX_PROGRESS     (1 << 0)
> >
> > Please consider using an enum.
> 
> If they are used by assiging one of their values, definitely a good
> idea to use an enum.  Are debuggers clever enough that they can
> tell, when they see something like this:
> 
> 	enum gress {
> 		PROGRESS = 1,
> 		REGRESS = 2,
> 	};
> 
> 	void func(enum gress v);
> 
> 	...
> 
>         void caller(void)
> 	{
> 		func(PROGRESS | REGRESS);
> 		func(PROGRESS + REGRESS);
> 		func(PROGRESS * 3);
> 	}
> 
> how caller came about to give 3?

No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
do.  If the enum has only constants with power-of-two values, then that
is the right way to write it, and the other two are asking for trouble
(e.g. after someone changes the value of REGRESS from 2 to 8,
'PROGRESS * 3' will mean something different).

