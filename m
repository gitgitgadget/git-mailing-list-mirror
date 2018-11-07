Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379BF1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeKGXEU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:04:20 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37357 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGXEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:04:20 -0500
Received: by mail-pf1-f177.google.com with SMTP id u13-v6so7715820pfm.4
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TkPB109YkFj6PynYfbl8tppBm2Kxf0sD6tu2jC7q9u0=;
        b=iB/3WPzWTEjz/mJZlcIcO/RNVrF6PjJx7GvYv7OHcwpI7zPv6h07lSPtEhp5ZnCAan
         q9ZOcj3lK3tHKiHgX42z1CKc34kxnblWXceEYh7zgDRHiAkWU1rm6uywSgN+93Zp4CgP
         IijAqtWp6CsvnDM75XMliU5ql5AdWKYY3JII6VwxWdROYsbKwiVehW5iNKse/mN3ytft
         kDBE2fmFW6a0CJO61YHih9lOD4Fj3ImW+2aS8D+aGca6XtPCtam8wxbFtOcZ19hhBv9Q
         IOlHRV4DvTpAIJtNNYsPrOa7dwp/NMa75nOp0FdIpnt9I4d+orL4x69ac8a9HO6THuEu
         ++Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TkPB109YkFj6PynYfbl8tppBm2Kxf0sD6tu2jC7q9u0=;
        b=DK0z5YzFmfGDcr1/rg/TmBWYbYGSdAY269wBbEJ8ck8ev04q4uHcgpiXGycWJ8dmhe
         c0lpV9ZVXf3IG/uQExRYnuhVlweXA6xVSuRZ7Xmlm90KAYLcSPf9ZyyUXKwuC6DoN9+p
         yym/AU+aNBgOHHjA9xXlrgIc9qJ+wv0HFMnqU7xWkXr8PvHusTg+KFwFvsjfsU4jLkw5
         1NPXoW07n7WrxKiEKBL6sAqSggj/eOiBR05rGyBJw583TQafnXWUuCcoCLJmUmP3lWl/
         /MXO+68sSnwU72WeL805hfU9YKz26GnMiXkYqTFYzpu9Gg+E5gmNGzgq5KzqIS0WTY3K
         GFCA==
X-Gm-Message-State: AGRZ1gJKhq/FPWErhMKGHu+zUQ3IiQODiwy9DylrCmDnvkRNifriTW7J
        4/aGWyvlqkV55Av/S/T8iRNmRCMQlzU=
X-Google-Smtp-Source: AJdET5eU1r7OLtcCYdvRJvMUJewr/PoPgifz8FwV2uGCZBfRbuJJUEuH0+uLk8MrXbLXJlfqZUoLbg==
X-Received: by 2002:a62:380e:: with SMTP id f14-v6mr214719pfa.203.1541597635528;
        Wed, 07 Nov 2018 05:33:55 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id u12-v6sm765005pfi.83.2018.11.07.05.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:33:54 -0800 (PST)
Date:   Wed, 07 Nov 2018 05:33:54 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 13:33:51 GMT
Message-Id: <pull.69.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] http: add support selecting http version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally, git doesn't need to set curl to select the HTTP version, it works
fine without HTTP2. Adding HTTP2 support is a icing on the cake.

When http.version=20 is set, git will attempt to request the server using
HTTP2. If the remote server does not support HTTP2, it is no different.
Currently bitbucket supports HTTP2 and is available for testing.

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=20 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (1):
  http: add support selecting http version

 http.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/69
-- 
gitgitgadget
