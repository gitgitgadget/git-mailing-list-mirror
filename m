Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2782C20248
	for <e@80x24.org>; Fri, 22 Mar 2019 06:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCVGBx (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 02:01:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38992 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCVGBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 02:01:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so906217wma.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b5ExJEoNx/qPs+7J6gZnyjGeNmtZMegVg0Z9HtoJhcU=;
        b=TwsJvCVz2nGwgF/z0mkl25S/9zCkb/RaQgF55ErZ9ZGS/rZZP4DWX6ntQ4LXvO3eAy
         Wxx/x3WH8wImwaiQSVTtv8Lyb+0zDe3d2jm3PSeGEt8VsDyc8k8VGhpgnuqszopb5Pnt
         w4HucGpVGekBJBF+9+OcVrCQ1feI5bojYzHhqnis6h6t9H0yiRosBGxxYwQF/crpcTbu
         PQ6LZ8dfqrhoDT1DV8YplLQuHQ8PtGWzmRaiBKfG85HJJ3dGdCg3cyGID+3T98aNevmB
         DI+YgSFyTzuxFMpwihB7yE99psGbXlk9T1KZx3Jl34vXT4AI/FDIK1PoIJAAuVqvlVKG
         5BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b5ExJEoNx/qPs+7J6gZnyjGeNmtZMegVg0Z9HtoJhcU=;
        b=jLD9HC8Pqqc9EbhgCrMpVbBd7MUri3Y/CFdzUSEXQijBzmgyYoAFtFw6yJ0g8PwQYb
         aJKzPYVtC23gNLiwhdeJhoAZOKMlQE2JlJQJyaQ/MJQ1NWYm57HTdkgbcW6kBJnNCJEX
         uDTa/DsXF1HPOIrFCwU+h/5ePb18RnmHMlDy2Ncn2Donq7xvKShs9ULzZpbT2gp+6oBB
         ZTl25iZYgMfDVMivfgv+pFRiJ7qVN/VW+QS1flkP7/q4SkLxjHDxQVX31dVoapVJjG2x
         Rv/gDUasBiDQ+Yz1TIWNmsffE/qkIY+UpiPLPazz64HuMKnITqZkOmWUroxpZyTXIrGd
         xdxw==
X-Gm-Message-State: APjAAAUD9OXe2nGsdiN4enTqBruEM/NTOiZgQr2eHfLc3prM3TnKypig
        +yojLOHUUuHstrFVho1UHw8=
X-Google-Smtp-Source: APXvYqwbmMcyLe2wOqTB8ZEpEYHttUX333/28P5JWaJQ7Ahe6dTlrjyzrCkBKWaVU7C+wU23EojjUA==
X-Received: by 2002:a1c:1f49:: with SMTP id f70mr1623736wmf.147.1553234510925;
        Thu, 21 Mar 2019 23:01:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f20sm15735927wrg.91.2019.03.21.23.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 23:01:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 01/10] gc docs: modernize the advice for manually running "gc"
References: <20190318161502.7979-1-avarab@gmail.com>
        <20190321205054.17109-2-avarab@gmail.com>
Date:   Fri, 22 Mar 2019 15:01:49 +0900
In-Reply-To: <20190321205054.17109-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Mar 2019 21:50:45 +0100")
Message-ID: <xmqqtvfvphv6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +When common porcelain operations that creates objects are run, they

"operations that create objects are run"?

> +will check whether the repository has grown substantially since the
> +last maintenance, and if so run `git gc` automatically. See `gc.auto`
> +below for how to disable this behavior.
> +
> +Running `git gc` manually should only be needed when adding objects to
> +a repository without regularly running such porcelain commands, to do
> +a one-off repository optimization, or e.g. to clean up a suboptimal
> +mass-import. See the "PACKFILE OPTIMIZATION" section in
> +linkgit:git-fast-import[1] for more details on the import case.
>  
>  OPTIONS
>  -------
