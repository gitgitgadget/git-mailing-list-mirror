Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4471F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfGDJUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:20:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40183 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfGDJUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:20:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so4755391eds.7
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jAy2qdY0JenZTRZmDxb2kPKXc2Rc9smXX5uKlDjITew=;
        b=GAX4EWModxhVTSZ9+dFYQUxYUGJDvp19zTMcJuAeWeQfaSz7lPNul2CXb4xld2kSIZ
         5lKIn1ysICUiyml8UfwCCQucxX3DRx+xvuJ+pGI4gTP+/fcr+Jm5sBS1mNTwZRzfXySJ
         k6RdTjskhbuv8tN7YOtJ4r7Q+GzPnyLcpneB97/uWwacXHsl9jJfMvvgzzDT+XgU3uiD
         ofYnC+CikVneYUcqZCP9PhI9e5++Imc6aWnr6b0WwcBo51Yzt3v9HFokGUQOt7NCcrHi
         23R+cyvOWdbCgekUcymhiwRFm7zeOMYgGEeYLSEgN2CNAMqTgOExLlsRRSXK9TdBwBGC
         IP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jAy2qdY0JenZTRZmDxb2kPKXc2Rc9smXX5uKlDjITew=;
        b=OV0s4iHEPd93XHQXNjK4LBwy28OJuBsm+8yohclMGjf60JqaiDLuBzg2VYZdmYr4oU
         hoBeoKZCa7aDgshy+BG6thIRGt0uuM1GQJ/S1UiSwFSWZpfME0o65wMAlCl8x5vsPHBr
         sFNr6jcObxnodrOpCc74CAzcJUNGxbQsuY9/9GElMLHuC/ukVBl3l6pbmwYksXwCjq8H
         Sct5iCJ2LDq0BLj4MxKPe+Bl8N3mVu5iVaQnlEca/08j7oMqefftrUdrgbvleA7N43o2
         8ihpKCrK+O5uoUp7+8lv2JdujIZxs+gV9O//CKGtkv8UPbHjgDIt00UP3r1VX2iga4qO
         BrtQ==
X-Gm-Message-State: APjAAAW00Tsd0yyySdL3uhMnSxtIM8QNS1OSTn8V+UPiJooHe0AvpLC4
        HgSH2XJSV5RKnDBpLv6khQs6i3WO
X-Google-Smtp-Source: APXvYqxc0+223NV9EFu5YO47h+mX388uMlx28kNoa0lGdaYxeUKf6yQYgKzuoxrnwEWYqBKX1ohQ+Q==
X-Received: by 2002:a17:906:948c:: with SMTP id t12mr18498124ejx.222.1562232033048;
        Thu, 04 Jul 2019 02:20:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm944994ejc.16.2019.07.04.02.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 02:20:32 -0700 (PDT)
Date:   Thu, 04 Jul 2019 02:20:32 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jul 2019 09:20:30 GMT
Message-Id: <pull.218.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Give Git a HOME on Windows
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

The environment variable HOME is a well-known concept on Unix/Linux, but not
so much on Windows. In fact, there are competing concepts, and they fulfill
separate roles.

Let's try to map the closest that we can find to HOME so that Git is happy.

Git for Windows carries this patch since 2015, so I think we're pretty sure
that our chosen strategy works.

Karsten Blees (1):
  mingw: initialize HOME on startup

 compat/mingw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-218%2Fdscho%2Fmingw-home-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-218/dscho/mingw-home-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/218
-- 
gitgitgadget
