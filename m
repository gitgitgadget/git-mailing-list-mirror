Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CF61F770
	for <e@80x24.org>; Wed,  2 Jan 2019 19:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfABTd3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 14:33:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37969 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfABTd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 14:33:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so28640420wml.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C7txfBlQ27ywXdjlJ4HY5n6bKJs6nxG5Xh6Jfa7uVlM=;
        b=cet4kUJFOaKlRkSFecv8apEqX8dfNM0A01G8y4Cxbi1Qf5QuiHIUWET/n37ZwGZRJa
         tn4yucUAxsnDy3y/kUh8BA6EDAGT1v4xDvdjIyFExb8igEtBNQ85UELMIAFtKoN6HUJ4
         C5FGPdqYIDkvukQGrZ1mR78e3GDUWLbTF8g1AGHA8WZmRJcojA5YMbLuXKsIA84GKkNv
         ttdIILpBvglKi58OnauT5mDogsyXZMWC5Am9zKgREIYwgdfvohNExjwIiTcWM+nghj89
         e30JYmfHzusB85kZ0oPmFBG+lZMXlpTs475TyJCSSXDiHcA0aEewok5HcpSKrp0aWGL6
         BZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C7txfBlQ27ywXdjlJ4HY5n6bKJs6nxG5Xh6Jfa7uVlM=;
        b=JRCKkgZW2IEzfWrGkC+Dl/NoC+na4hiXmnt6Ubr4kGXay8d8Daf13pNFShi2W5pbzJ
         gQ3qAWxL2DUteyrYCG5lADbhCLszP/Df4zswz+nmRlq90rN+FKZ6e9GSR/jE8ve+G5vb
         wBl2wNbyThKY8aX26yjQ9MeEkjo2cNn07jeIMdRFewZ1Emt4mT59jOx0fjQWSsQWEFEz
         zlFmJIrmLRsaSNmv5+akmBO/1HsyEAUKVhp8S+kqiFFMx/EmiXNdKaXNZI5JEy1DZhq7
         qC+wuQ1hvBTLiUoIE0tBtnZceNBgFNQ7dhjiNrOO1lavNR0va62lbLv4vVyYlsyJCejl
         1xKA==
X-Gm-Message-State: AA+aEWY4J64Hz2TY5XjaGpWciD1R07JJbSJZjqFAmOcTi45dG/Xb1zmD
        LRcf+Ta2LaHcjFM7l2FKbhg=
X-Google-Smtp-Source: ALg8bN6Mlje7i0vp8zrvPeP6fvg+LEO6OOj0EF5O25tGAYpesPUd4z9n7+Xj5EPPK2eoXIb2ISxn3A==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr35265799wmd.112.1546457607142;
        Wed, 02 Jan 2019 11:33:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k15sm74406359wru.8.2019.01.02.11.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 11:33:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     issac.trotts@gmail.com
Cc:     git@vger.kernel.org, noemi@sourcegraph.com,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <20181231045335.12883-1-issac.trotts@gmail.com>
Date:   Wed, 02 Jan 2019 11:33:26 -0800
In-Reply-To: <20181231045335.12883-1-issac.trotts@gmail.com> (issac trotts's
        message of "Mon, 31 Dec 2018 15:53:35 +1100")
Message-ID: <xmqqmuoikg6x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

issac.trotts@gmail.com writes:

> From: Issac Trotts <issac.trotts@gmail.com>

I think you want to have 

	From: Issac Trotts <issactrotts@google.com>

instead, so that the authorship actually matches your sign-off.

> -	if (source) {
> +	if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {

I am not sure why the above is not simply

	if (source || w.source) {

but needs to check pretty-given etc.  Care to explain why?

Thanks.
