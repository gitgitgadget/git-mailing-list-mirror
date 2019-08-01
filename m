Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4A81F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfHARlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:41:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbfHARlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:41:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so74461333wre.12
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y/2VoIsSh5OqSRmJI0wepqkpaGbfYCUXEaXBgtBxZZk=;
        b=pBYoWzGCpH+yp5b1hMOVdGre1zXU5WIw/Zwc/1fCgLdieZtcoZKnVZ0F6Mu1C4lMOY
         OjS4HaOr6dbvdu4ZOS4gRzA5OkCxxC1NCVbLS2K1qfRrCYVeuawyZbrYV1PSTiXEjhsi
         uxUk2uoJ5Mc0Hb1KPe4UWm3tSmCUQHCHMnD7EbMt8bPwp95NqBe6GsR2SY+HAl1yQqJ8
         K8cKrNlOyENeyol2nezzU8HdMqUnIP2DJk7DKxTR9UC0I+Ru8NCXiBOf7njx9WrqtItT
         +NJANllMF+wJj0xG3v/aeG/BTU/xbfijUqO5SjTSlVzJrgWmNfeNi8wVjIDgVRPwgGan
         zEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y/2VoIsSh5OqSRmJI0wepqkpaGbfYCUXEaXBgtBxZZk=;
        b=qXD7/K1wvKybsSX56rA10qLaMZD1sfIKeqh8UAuPESutTp1D3fXX/3zGVuj2ajdtdN
         +ajcLG1Reao87g9yubpCfqphmmd/uzYv1BfKvaxQL0o/PCp93l6+SkKS/It/luQh+NHF
         0rSE6NUcWNAob0qp6lgaJeTWq8vgqhoN3wRJPYdIEU8RgxpParbRHPbkdfN+xD6Aa7ZL
         Ar33KrQK8V446n47AOrjww4p4gdlgVWLITA8bcMNo32/3YES7oy+OfUFF4r7Tr7UfYT+
         rQ8ZRQFuJRbsJUsF5+FwLj3NezrfHRKrcWAe9JsRldrjT5D91VphtveYdEeCPyDVV9i1
         an3g==
X-Gm-Message-State: APjAAAX2iaZyE/lCGc6irRP3L4Uiq9QaDD9oVnPiVpnDWiU7gZL4VRsP
        bKzWfa+eSX0x5+yzfxLYaA8=
X-Google-Smtp-Source: APXvYqwpp7jdrOzC3QI5FOdOnDMaKcfxYIOqSriTbMKYt4ZlE/r/a3UH2U9rjfIeaBJ8xCMCGkEDYA==
X-Received: by 2002:adf:afe2:: with SMTP id y34mr138341599wrd.250.1564681289629;
        Thu, 01 Aug 2019 10:41:29 -0700 (PDT)
Received: from szeder.dev (x4dbd0ed1.dyn.telefonica.de. [77.189.14.209])
        by smtp.gmail.com with ESMTPSA id f12sm78045904wrg.5.2019.08.01.10.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:41:28 -0700 (PDT)
Date:   Thu, 1 Aug 2019 19:41:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific
 tests at the end
Message-ID: <20190801174126.GU20404@szeder.dev>
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
 <20190801155309.15276-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801155309.15276-4-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 05:53:09PM +0200, SZEDER Gábor wrote:
> Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific
>  tests at the end

This subject line kind of sucks, doesn't it?!

Alas I had a bit of a hard time coming up with something better.  So
far the best (well, least bad) I could think of is:

  t: warn against adding non-httpd-specific tests after sourcing 'lib-httpd'


> We have a couple of test scripts that are not completely
> httpd-specific, but do run a few httpd-specific tests at the end.
> These test scripts source 'lib-httpd.sh' somewhere mid-script, which
> then skips all the rest of the test script if the dependencies for
> running httpd tests are not fulfilled.
> 
> As the previous two patches in this series show, already on two
> occasions non-httpd-specific tests were appended at the end of such
> test scripts, and, consequently, they were skipped as well when httpd
> tests couldn't be run.
> 
> Add a comment at the end of these test scripts to warn against adding
> non-httpd-specific tests at the end, in the hope that they will help
> prevent similar issues in the future.
