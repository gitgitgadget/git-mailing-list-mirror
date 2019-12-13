Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E1C352A5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41624747
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfLMRZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:25:00 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:37558 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMRZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:25:00 -0500
Received: by mail-io1-f50.google.com with SMTP id k24so410300ioc.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew8TN2WwcGZMBjwClmCpn9EJSR2scNz+Pf4QHVYpeR4=;
        b=H6xYfClqs1Nd38LeCCc6ESM3DiYbXiJXUNLT9xeqhOEtjySMZdkdS8Cd1OTLTAmFHD
         sPUmehAwWlxoXKFicxvKhuzTvc8QJ1IFgb3po+PGT+9PF3pWGtktu8R+utL5Yz7ql79l
         aM8H8ndnNHq8NlFAGoKwuTvTLqMo0Yx5+Om8uj+RbKDGdhLZDY8qer1aBLc3SblDa4Jz
         Xkfwj7I0FxKBNjLJKpZT03IenoI3C42fawat1NYjwt184M6/CgDQK4aPSrP/J3RdTQpQ
         RsQ6ypUTM3HD9yJ+ISd5r6nvODA9SBT0XhGu3QwQww3C90kKF+plxoGutc3TStOpLj0Y
         Fbkw==
X-Gm-Message-State: APjAAAUT3xnA7B0ueMer1BpnJKsH/fGh1161XyDKAKj7eIHQCPyJnc1k
        XNMQVxgGFXWc8Gz1Y1t7McP4OBll28m2iRNYW+0=
X-Google-Smtp-Source: APXvYqxkIWwGrAdn2Tb5IEJ2rmIN9eZWIINO3rq5+pzaDh9kBiIT2+QnOYNyvfnT0qVdWYE3klKD3A8lSilGlfEk4F0=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr490900jao.106.1576257899296;
 Fri, 13 Dec 2019 09:24:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 13 Dec 2019 08:38:35 -0500
Message-ID: <CAPyFy2At-OjdKusxr9FaZmncjrBKWrVjs5REV0PeHtQFcYy8Ew@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2 Dec 2019 at 09:16, Junio C Hamano <gitster@pobox.com> wrote:
>
> * ln/userdiff-elixir (2019-11-10) 1 commit
>   (merged to 'next' on 2019-11-19 at 6318918ba8)
>  + userdiff: add Elixir to supported userdiff languages

t4018-diff-funcname.sh is failing on FreeBSD with this change,
fatal: invalid regular expression:
|[@:]?[a-zA-Z0-9@_?!]+|[-+]?0[xob][0-9a-fA-F]+|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?|:?(\+\+|--|\.\.|~~~|<>|\^\^\^|<?\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\|\|\|?|=>|<-|\\\\|->)|:?%[A-Za-z0-9_.]\{\}?|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+
