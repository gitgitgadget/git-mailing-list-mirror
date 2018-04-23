Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB461F404
	for <e@80x24.org>; Mon, 23 Apr 2018 09:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeDWJ7h (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 05:59:37 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36051 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeDWJ7g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 05:59:36 -0400
Received: by mail-wr0-f178.google.com with SMTP id u18-v6so12233374wrg.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LzoFw2pNx6M3GafzlH3q7JS4NoFT2cnBwhYcNZiUh3o=;
        b=WZXxOyXZs9nEmduSY/rnaiztHli4TH8Gi2OKhaLw5FAae3rxrDpzAF989vcwwvlx/4
         oBtgxDXNgXW1BNl3DswNVrXRyFrVVD8SedtdbXVDJ4vagpU28Q0zX3Tu2cqjsZexwGx0
         FylOa9aRlNPgT2o1drW342XcHADhuWb0ZnZvdr60rnW9+VVttWm10T+GfFiKGN6VdupQ
         ehxPiUuoHSroPghr+kOaewEAOJlmwWxK1MZyqA3xKXZIwjGC9Gp+4jkZ02Z1zUXfek6/
         GIzpqb1XnNSmyuugdHwwxeYQA0v8Mkl64JZmBagVfOD8P0M3KRAFqLbP++x9c60e9eSa
         lSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LzoFw2pNx6M3GafzlH3q7JS4NoFT2cnBwhYcNZiUh3o=;
        b=Y4ldnQ7pp1RQQz1qqALfdN3U17oWrILBufQSrDVIGSvT2rKvQhbP7aB8Q2lhzORtu9
         o0S54L8ABYZHDjFbLl+AWuk8F9ozAfoB4Ot87Ho399KHnw+HmOCK3XBEt2RpmHN0EMIj
         2KYNVkiS8Q4YHeiBIHFHOWm1dGWngknR/shlvCGqYfER/UMLmF4kaGNi4UFE6zvMzv24
         EoNCa/3Ux5+aSZmQnKzqq1DhWdq5SP2waQ2HPAYFrSF9bVVqOd3ym9S9YON6hBR0ATax
         8uxtBf/NjpMQWMNQ0wIHSBNVnCL6eR/T7QUM3CZ3k/ICiJQ/LRgAh/qrbn+pFZNnaq83
         leng==
X-Gm-Message-State: ALQs6tBGCu7C1+F6RlmLhH/ex0ji3xxTmlqYPqZwXGNLGVjhTudGi3z6
        BNF4GRC/HpNWUWUCwtXGyWk=
X-Google-Smtp-Source: AIpwx4/3vEwMMEZvtL0WNVAzGKRcuUufEURQ783BRrHSuqVY9Gwjr8Q4FZpbxBI3YfOsrcitSR3U5g==
X-Received: by 10.28.7.76 with SMTP id 73mr9589960wmh.128.1524477574942;
        Mon, 23 Apr 2018 02:59:34 -0700 (PDT)
Received: from localhost.localdomain (x590d1687.dyn.telefonica.de. [89.13.22.135])
        by smtp.gmail.com with ESMTPSA id e64sm7828803wmg.22.2018.04.23.02.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Apr 2018 02:59:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
Date:   Mon, 23 Apr 2018 11:59:27 +0200
Message-Id: <20180423095927.2077-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e
In-Reply-To: <20180423082318.27314-1-oystwa@gmail.com>
References: <xmqqr2nfyix9.fsf@gitster-ct.c.googlers.com> <20180423082318.27314-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> > 
> > > +category_list () {
> > > +	command_list "$1" | awk '{print $2;}' | sort | uniq
> > > +}
> > 
> > Piping output of awk to sort/uniq, instead of processing all inside
> > awk within the END block of the script, means that we are wasting
> > two processes---I do not think we care too much about it, but some
> > people might.
> > 
> 
> Can be written as:
> 
>     command_list "$1" | awk '!seen[$2]++ {print $2}'
> 
> This doesn't actually sort it, though, which I'm not sure whether is a
> good thing or a bad thing in this case. But it is less work, and being fast is
> nice for completion scripts.

This script is run during the build process, not during completion.

(The order wouldn't matter for completion, because the shell would
sort possible completion words anyway.)

