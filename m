Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03B01F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406435AbfHBTnl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:43:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46502 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405999AbfHBTnl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:43:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so78292211wru.13
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c85TBnjIM0p27lt9FQJ1NeFqKN+HP09Gd+GNLxegOdI=;
        b=BgP3mhNn4eYWg0WSEYTW2w5RiqbWGVeigOyeuxpJxLxFzs8/00O5lqxRjUKoEfQJRl
         TnAodNAvxD0Idmxb+wIS0OKPtj5uVgaQSmocNKB72nHcyrU6SIOIYItIJd+HEOGcJoS+
         /LWR45pLpoaXNkd9gEFAPN0Ruc8gfaj+mlScVZghaAs37NAzmlcP03Kqa1mtkzc53CfY
         W7kFTuTQgJXCQRTVUFbST5TyPUliKltVb2RZiZxndGWKvrUzrsZih5Qrz/5poSUhqiyl
         Aeif0ugxF3jGubFMyumhTOgmnCkr9ew5lW9q+DyuhcYSNu7djShxHsx9LqH+odC3cbDQ
         5nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c85TBnjIM0p27lt9FQJ1NeFqKN+HP09Gd+GNLxegOdI=;
        b=LRMumzdHD6dQHELiSzjFY+tAL6YmHz+NL7gsUUiSERTKI6ATEt/hR7Mh603GY+KEhT
         QB1jgmRVRMjW7s0nsp4f+JI4aHZfXM94I7dyKAOr5iRAsmrX9jYKmmjHEpi8CgIxl10X
         Aus3+QmhEO7y1BEunDHftUWJ2nY8MVU7uC6LJODgtlG34y826dGJ7Z/+JEkXm1GRpkrE
         Rbro3YJTzVO6mQhDmVugDiNeqB8otoouY6IZFlDR3YwGnpyQE0bK6ZC+QXIhjL+OdZDx
         mH8SOnYiheXHZNWdnv0sX8JUKNewQ1moavaOymxuHHgmCxDMG6gdMR0GkMELnOxslVrI
         oDyw==
X-Gm-Message-State: APjAAAUMQmOrpMKs3mHTk/KRLTm9u+1RQTcVfa7C8vyqNyAmpu+nm1SS
        UebTHw6bt3d9CS7UoHplk2JtuxKk
X-Google-Smtp-Source: APXvYqzAjYnFG5N4j/Kscs61mZXaqH3XSBl6Xb/83aHfboMvW20VxQ+q4jL95h3XVBvCfr2SlsF70g==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr145026739wrn.54.1564775018603;
        Fri, 02 Aug 2019 12:43:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm54186995wmf.48.2019.08.02.12.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:43:37 -0700 (PDT)
Date:   Fri, 02 Aug 2019 12:43:37 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Aug 2019 19:43:35 GMT
Message-Id: <pull.303.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.303.git.gitgitgadget@gmail.com>
References: <pull.303.git.gitgitgadget@gmail.com>
From:   "Philip McGraw via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] git-p4: auto-delete named temporary file
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

Take new approach using the NamedTemporaryFile() file-like object as input
to the ZipFile() which auto-deletes after implicit close leaving with scope.

Original code produced double-open problems on Windows platform from using
already open NamedTemporaryFile() generated filename instead of object.

Thanks to Andrey for patiently suggesting several iterations on this change
for avoiding exceptions!

Also print error details after resulting IOError to make debugging cause of
exception less mysterious when it has nothing to do with "git version recent
enough."

Signed-off-by: Philip.McGraw Philip.McGraw@bentley.com
[Philip.McGraw@bentley.com]

Philip.McGraw (1):
  git-p4: auto-delete named temporary file

 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)


base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-303%2Fphilip-mcgraw%2Fgit-p4-auto-delete-named-temporary-file-v3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-303/philip-mcgraw/git-p4-auto-delete-named-temporary-file-v3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/303

Range-diff vs v1:

 1:  1b270ef9a6 ! 1:  7e59b5cec2 git-p4: auto-delete named temporary file
     @@ -2,13 +2,17 @@
      
          git-p4: auto-delete named temporary file
      
     +    Avoid double-open exceptions on Windows platform when
     +    calculating for lfs compressed size threshold
     +    (git-p4.largeFileCompressedThreshold) comparisons.
     +
          Take new approach using the NamedTemporaryFile()
          file-like object as input to the ZipFile() which
          auto-deletes after implicit close leaving with scope.
      
     -    Original code produced double-open problems on Windows
     -    platform from using already open NamedTemporaryFile()
     -    generated filename instead of object.
     +    Original code had double-open exception on Windows
     +    platform because file still open from NamedTemporaryFile()
     +    using generated filename instead of object.
      
          Thanks to Andrey for patiently suggesting several
          iterations on this change for avoiding exceptions!
     @@ -18,6 +22,7 @@
          nothing to do with "git version recent enough."
      
          Signed-off-by: Philip.McGraw <Philip.McGraw@bentley.com>
     +    Reviewed-by: Andrey Mazo <ahippo@yandex.com>
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py

-- 
gitgitgadget
