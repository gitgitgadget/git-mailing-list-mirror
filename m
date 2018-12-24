Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41F520A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbeLXWeI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 17:34:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35608 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeLXWeI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 17:34:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so10805946edx.2
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HfXWOBqKm8D8eNfvw6LYdi95O9VAwNLlwFBmQtWBCLs=;
        b=DxKwMUN1uQXTgnydoYGT6tKsWHl0NWDXLoic2yFLDYBKuvTx6oKf4JRxn9GgSUN8cG
         ZrTi/r3t9V+/y9YXOGrkKqizk8HJ3nfuXE2vCsQTi+QEv/W/raN07fpi7AZCrf7usvHw
         4xOGqXWajjB/kwtTWzETtrMB14FYVQ1l1kQapisIXZdGaH4RfRslCVbycb4kgvsXLbXE
         sQlU/i9Dzme9XaPrxiRD6fXU/yNUU/08a7Bv6PiTmar59VGtM0cGJ1aGrTtGAEFF/UJn
         XlLCaPUoIP6Qk5l0xTui3l1OcEDytvvBZ8xXWLWzKOE/kZ2eTCAha4sm3lYpqRCYawbx
         RhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HfXWOBqKm8D8eNfvw6LYdi95O9VAwNLlwFBmQtWBCLs=;
        b=Iv7A+VfnoMPzfKGniOKoexOFcNU5AjxzsbMRx4tjoHXiHJrAGhUjKmjdYitBa9Zgsa
         Z58ComHINTMWd9PYCSvNw8ojnVlrSMpGB3wdr7gV97pH4lQTFesuwV0TV7UMbkun8iW2
         IH+41PFuoGeB94D9nUa+dct5/UP2EhoUH4UCindhfccYxSr3TMf+Jo011dEMokChjd0/
         /eFABKAYqAuCKlSVKWJEYVieeZhqbyoCoZOqVF4t4W5VvztOXR85GzXlP2x5hLO5nfZ6
         hX9ZjjldJYPPwtdxYtDBgXqGw9jhqlqeHfNm/nsN/upDHPGax6eigq/Wa7wtIFDDFSeN
         cXRg==
X-Gm-Message-State: AA+aEWYR5F0Vu1I23ao3nX4Ym1nbA/oCwyFAUY6NgMaEDHQxSTDav2m5
        fArw8+CFoNbstGRgZtgnZ8aPLBXV
X-Google-Smtp-Source: AFSGD/Vj1aJFHOjOnl4rIv215M00XrWlmPqbUVv1+n3CoUwd4aAGYKkQM0JLVajbZMc2XH8181Iozg==
X-Received: by 2002:a17:906:5d10:: with SMTP id g16-v6mr9622515ejt.212.1545690846465;
        Mon, 24 Dec 2018 14:34:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e51sm7814764edd.35.2018.12.24.14.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 14:34:05 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:34:05 -0800 (PST)
X-Google-Original-Date: Mon, 24 Dec 2018 22:34:03 GMT
Message-Id: <pull.104.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.git.gitgitgadget@gmail.com>
References: <pull.104.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Make abspath() aware of case-insensitive filesystems
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

It is completely legitimate these days to call git add with absolute paths.
Of course, on a case-insensitive file system, users rightfully expect the
argument to be handled case-insensitively, too. This patch makes it so.

Git for Windows carried this patch for over one and a half years already, I
think it is time to get it into git.git.

Change since v1:

 * Replaced MINGW prerequisite in the test by CASE_INSENSITIVE_FS.

Johannes Schindelin (1):
  abspath_part_inside_repo: respect core.fileMode

 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-104%2Fdscho%2Fcase-insensitive-abspath-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-104/dscho/case-insensitive-abspath-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/104

Range-diff vs v1:

 1:  4fb5de504e = 1:  3eaec10c46 abspath_part_inside_repo: respect core.fileMode

-- 
gitgitgadget
