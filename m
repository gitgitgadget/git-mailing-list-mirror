Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D52A201A7
	for <e@80x24.org>; Tue, 16 May 2017 06:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdEPGG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 02:06:59 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33032 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdEPGG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 02:06:58 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so71087623pgb.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qCZVhAxpiwqLMJtk8spFg4SNQAb1DpgxHV6gIgptdM=;
        b=rcEoKTjWFwTP9viyovQu4UmuXOq5Vf01SD4n9r7FdI4++mL/49LPFovFov2qOUHdDd
         ZRfW9kZBf4dLjN4dVnbISjeDFdKiRmFZPxlrXuOETNBaocTn3lHgbqJIj/xeBjIZmkMy
         L7p9mxDGvSqONTbynvpq908QdGQAqiv4n+gwJ+suk3NyRGRMdtHqUqK38oklch8tkV31
         t5ifgAc01TE4A0cS5uELFFifZrN0D2gyFLhZj7pxDZx54rkK3WflPGuB6bmQRzrzthtJ
         P1JVcjTyhBp7TY3UXmvrSyRJGNkakbGUgj3+x/B2aLZYamFd/m7wMtGmzhjj38M/B04y
         0GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qCZVhAxpiwqLMJtk8spFg4SNQAb1DpgxHV6gIgptdM=;
        b=mnmeJfe6o1QDv7ypk6AXeY1OIgSU24qOemTyQvj2JNZNbpAMUSQKiDm0XQyRu/jiwy
         gjfpblYphPqTfJKr88vReEtodAQHh8CjFgRVGV1XjD8Kw7DKJ8Kil8qOCCL7Dx20chj3
         3mHmm1pWBBBasC57kRK3mneU3oAnx2x01VrNfGkt9Vy9ndMRTAEON5F4O3yiKngb400f
         qUTf+h7tEH6OuUsDD8opysxO1ay4cQjrj9WBpwTb7SCxXQ8EOUoH35ggHXRnrovuPZ46
         xwWggQKVwiCnDRjTFncHxoohdvTlGC9G/zSAQfJDtctcLAM1qZifMjIfG0h+M2R0PfyQ
         /eRw==
X-Gm-Message-State: AODbwcDx56klNOjc7B48fCptELoU10Lb3ZjRbzzxuVP5DXi6XsqRUzXV
        wq8g56gcS/z+mQ==
X-Received: by 10.84.140.164 with SMTP id 33mr13494217plt.142.1494914817347;
        Mon, 15 May 2017 23:06:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:3967:8bec:86da:f675])
        by smtp.gmail.com with ESMTPSA id z68sm21587736pgz.14.2017.05.15.23.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 23:06:55 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     gitster@pobox.com
Cc:     bmalehorn@gmail.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
Date:   Mon, 15 May 2017 23:06:48 -0700
Message-Id: <20170516060649.29110-1-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <xmqq7f1iwxxd.fsf@gitster.mtv.corp.google.com>
References: <xmqq7f1iwxxd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Alright, I've made a new patch based on this feedback:

* make indentation consistent with rest of test file again
* rename function to wt_status_locate_end()
* rephrase commit message; add paragraph about wt_status_locate_end()
* s/scissors/cut line/
* Signed-off-by: me

> The mention of "'commit -v -s' works that way, too" was my attempt
> to justify why it is OK to make this change unconditionally to
> intepret-trailers, but I am still not 100% convinced with that
> reasoning (or your original log message) that it is a safe thing to
> do.  It is not like its sole purpose is to serve as GIT_EDITOR for
> the "git commit" command.

Yup, this is a heuristic and it will sometimes hit false.  But a far
more grievous heuristic is ignoring all lines that begin with '#', yet
we do that anyway for its convenience in editing commit messages.  Since
we already *partially* honor commit message syntax in
interpret-trailers, we might as well *completely* honor it by parsing
cut lines as well.  At least, that's my reasoning.
