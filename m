Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F201F42D
	for <e@80x24.org>; Wed, 18 Apr 2018 08:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeDRIcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 04:32:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46012 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeDRIcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 04:32:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id u11-v6so2370745wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=SVWMy8ILhpuund0HWjI6T/cs4R6jiLEUIqCkbWxsDkY=;
        b=fdGcDFQ0RkGZ4h0mxoejUqTdmlrv/EQapVsmS3RVG7xNJ1ZnPMq8TXUTfCtSoSVMtz
         5xaE3GByx9uyenDAwCRY3iDHetldjSt0sTwemKZGscdANUwUJG4nFUSBnJcNR70bDufc
         xpsbFrgY/27TvOd143dh4j63hm6xZcGsKY+qKsMYgoSwDDjxzi6bEOc8uojoA+Q9+e0/
         +MGBlgMwMDNvTQnG6MhUDHyoEqDbKsUX2Z3XyjKa4k33CEEslRwWcpkt/t0UAzsKpc5O
         5Kyh1jEq8PLMMqCHl00bHdR999ZRSAt/x9VwI3dxVs1LPSWWQT8k8Su3jCvssik18ztU
         yw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=SVWMy8ILhpuund0HWjI6T/cs4R6jiLEUIqCkbWxsDkY=;
        b=pz9CiK8471XBDFSPUsqP5MhU9+m6NGJksnfcDp01voHMnwwQP0EqrzvUpsakBdlEjd
         Grxlv/vX3cwfAFlDBazDYTmkQPSKBjuhUCeIbYSPFbU88GE2tAVj3VGww9y76gidQmg/
         vHDby/mlHNzYVwiuj+3uEvnk+OQYsryawLmfJa13Kx5l2dUbYJRQzRg3DSOgAagR+mki
         uo9i6opUoA3rbk6ANiYCTeNQjPbvWJzo0V73rt3awNsDY0akWDF1gr8IgtgbXjPkWI2E
         tVhhq94bYlOd7Bleswbox8xgw3U8x0CSCC0RFuXUvavuQIzwjTjqfHPBvpHHy5jjMD5K
         b84w==
X-Gm-Message-State: ALQs6tD2JNuXH3HnIMpvb8FKLef9KGUm1pDqKDFloQt2I4e4Rddbw2tX
        Wmsj5l+zQ+Tj1VwAWyTL5t4=
X-Google-Smtp-Source: AIpwx49kxhN2Ts78Rwn59oAORveLVongN6OIaj6aTDh0/j0nqcHbFovPoZGH4cnIYdXw/vb5HYRmAA==
X-Received: by 2002:adf:8822:: with SMTP id d31-v6mr902373wrd.18.1524040370824;
        Wed, 18 Apr 2018 01:32:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 6-v6sm483110wrn.81.2018.04.18.01.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 01:32:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] completion: improvements for git stash
References: <20180417212945.24002-1-t.gummerer@gmail.com>
Date:   Wed, 18 Apr 2018 17:32:49 +0900
Message-ID: <xmqqh8o8j4ni.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> In this series we stop completing the 'git stash save' subcommand in
> git-completion.bash.  The command has been deprecated for a while,...

Anything deprecated in Oct 2017 is still too young in Git's
timescale, but this is the right thing to do in the longer term.

Regarding [2/3], I think 

 - It is perfectly fine to stop offering "save" among the choices
   when "git stash <TAB>" is given, so that we AVOID actively
   suggesting "save" to those who do not know (or do not want to
   learn) about it.  Instead we would knudge them towards "push".
   After all, that is what "deprecation" is all about.

 - It also is OK to limit the offering to "show" against "git stash
   s<TAB>", even though the user _could_ have meant "save" than the
   above case with totally empty subcommand name.

 - It is questionable to stop offering "save" to "git stash
   sav<TAB>" it is clear that the user wants to say "save" in this
   case, as there is no other subcommand the user could have meant.

 - It is outright hostile to the end user if we stop completing "git
   stash save --q<TAB>" with "--quiet".  At that point, we _know_
   that the user wants "save", and getting in the way of those who
   know what they are using does not feel quite right.

Of course, being more accomodating to existing users by taking the
last two points above seriously would raise a separate issue of when
we stop doing so, and if we should start doing something else.  If
there is a way to implement a "reluctant completion" that gives
"save" as a completion choice while giving a deprecation warning to
let the user know of the plan for removal of "save", that would be
good, for example.

Thanks.
