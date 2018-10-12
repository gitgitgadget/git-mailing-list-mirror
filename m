Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809451F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeJLVRn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:17:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeJLVRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:17:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so13513031wrt.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VM45nSXQWSDIOGYSUBVX2GJIbW8fjriKk8xMMn+d0/s=;
        b=NLWFkFiXCzru8UGnni9GQkMs7+//VGigBvbN42eGS98/vdYZtKOOdTGqH7hOLj8/S3
         /gyTPVrktF5W9tEAxG4t1S2Ji6tdsGXfI/Q+t6cdAH9tw0TVJBTD9VNO6YpZzEqoxBiY
         HEenGl/Pi2zarZmDYV0Rlm4EsfPXMZGtSATaFaJfozO0L29o5LSjms+vs+DcIZu+a0de
         z97jkiOxG48sC5sQzCRDvRybKlWufmDNBcyfeFuQ027uT6qOOiOwOex1cuCaWTuDweCo
         IhejB89+cFWu1y17RCgdZQNWOVgLPE8uzeAVdPfza1ZPEcWKJlJGyACPSkI/B9Jk48zA
         0bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VM45nSXQWSDIOGYSUBVX2GJIbW8fjriKk8xMMn+d0/s=;
        b=PuScOSKS5t+ctMe/WPgTPoVzigCSeJQ+cTWo5+WKcFcla1fqnbkzNF4oF3qk/0t22r
         bBlgv6/zDVSbkjfOqzI1lXmoWB3HuSMA9s6hWmKz46RFz2AeWmR/xGXyruVeYABUS2fg
         Vi1Bxdi9DtJ6Kc2e2Oih1dEI8OvfJFNYr/0qpNLUgbSsD9NVZH5bwnR0SkWiAVB5r+71
         nQi1/C9ky3gEzi3fkcWA6Qc8fOBe+W5Iyq+ysa0Fc3eHNkaVLWTQ+HgsKyTh4KAOpyal
         cRz/3z24nZtPV+2rh1/Rz2ljD/5xtkd1r+wID71KlgbNb7hg5iHyFZ67H3+sSU0JWkb5
         v58g==
X-Gm-Message-State: ABuFfohNoUVjjqR+3f8RuHMgXNq6mig2issrfyfGU91MNr9hoskSKUjF
        gw5x5S/Z67UJ/UeBReK1EzJYkC+7+CQ=
X-Google-Smtp-Source: ACcGV62O5Q5bna+6jYaJ1pQNCl10TQnjz3iUtUM2zcVWDg4QFBsGt2GNljaH5j0Gft1DIvustEm9ag==
X-Received: by 2002:a5d:52ce:: with SMTP id r14-v6mr5227223wrv.123.1539351910098;
        Fri, 12 Oct 2018 06:45:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 195-v6sm1624193wmx.21.2018.10.12.06.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:45:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv1 2/3] git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
References: <20181012052833.6945-1-luke@diamand.org>
        <20181012052833.6945-3-luke@diamand.org>
Date:   Fri, 12 Oct 2018 22:45:08 +0900
In-Reply-To: <20181012052833.6945-3-luke@diamand.org> (Luke Diamand's message
        of "Fri, 12 Oct 2018 06:28:32 +0100")
Message-ID: <xmqq7einb7ob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> The branch detection code looks for branches under refs/remotes/p4/...
> and can end up getting confused if there are unshelved changes in
> there as well. This happens in the function p4BranchesInGit().
>
> Instead, put the unshelved changes into refs/remotes/p4-unshelved/<N>.

I am not a p4 user (and not a git-p4 user), so it is a bit hard for
me to assess if this is a backward incompatibile change and if so
how serious potential breakage to existing users would be.

>  
> -If the target branch in refs/remotes/p4/unshelved already exists, the old one will
> +If the target branch in refs/remotes/p4-unshelved already exists, the old one will
>  be renamed.
>  
>  ----
>  $ git p4 sync
>  $ git p4 unshelve 12345
> -$ git show refs/remotes/p4/unshelved/12345
> +$ git show p4/unshelved/12345

Isn't this "p4-unshelved/12345" now?

