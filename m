Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34633C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJDKBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDKBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 06:01:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B6205C8
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 03:01:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r6-20020a1c4406000000b003bcde03bd44so200786wma.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=9/mLGl47hm8kw5rVxu3doWt3cAaqTvBl/0mPQ8C+pos=;
        b=eeSrDPQN9G9pfy0xpp1lcgH3skFhwNnf/IX2X5OVZP+K8vXVNm8xdqbZRZy9H8EYqI
         HYG1Sfql9kX3kSUtYulSO7lNsGTPY4Bw9/TDPzXgrBGrPnbJ3um2rv2FFda63z02Pbla
         R6hdcoQ28RcomHgjaBXayXjCxV0cTq6AtFKVthXiE3sxLp7yTY81qJzsQ0n/P+r9eVUz
         qN99hR8lcjBC3vWGxA4ylvMlFVuN1pawuUfGtuudx1s4c+ZZC5v7Qii29wdF1KDnVX4J
         r9MNOJZ1b29jHWvRG5CJ9SXsSh1139FU2YsalpHjJ/NhoBWvH08BlNdpPrY4LTwOxP59
         cEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9/mLGl47hm8kw5rVxu3doWt3cAaqTvBl/0mPQ8C+pos=;
        b=FgEERvnQnscj4yQdxs6rMy0TrqhqGmzreFomT7/+VhLdNmbmw1bP+TJphyjFRh/Nvg
         ecF7ZGWMq95E7jOUCazX7+Iz0KlyhWZGupUFn2scrU7tYMk5eOkl1EvCQ+0ULXAo9AWU
         p9ZDKLeTrKraEWY9rGXhU+ZCurRjmv6YzsrBE86lgZGOtWRT5iydy/z8cziRlAqMWGpV
         Zi362xJ4vUDA7pT9ceOpLhmr4LLgaSQjbQne12Jf7JXGoX7MxHgecW91zt0oioGsjP55
         AWUUPATCsw7E8oyWUsCGpkMzb9NtNpfl133IoRryBwPFjXyts6a8tyMC+ZKvD9VKx+y0
         mA2A==
X-Gm-Message-State: ACrzQf0co6oydO0uXuzyBpDZAyS2IVrOyppWEZubeysHiA/2dArHxrB3
        GbUg9O56hHKkNloFPamqbYVus01aR3Q=
X-Google-Smtp-Source: AMsMyM6XdDNk9XTChmLTnWqGH2qFbfngRSqPU7Kdj5jPVpuq8v01BW1qtfCpAyzHZ0MNGCF4+xgAwQ==
X-Received: by 2002:a05:600c:4856:b0:3b4:9aa3:cb57 with SMTP id j22-20020a05600c485600b003b49aa3cb57mr9901663wmo.116.1664877695783;
        Tue, 04 Oct 2022 03:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b0022ac672654dsm12415346wre.58.2022.10.04.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:01:35 -0700 (PDT)
Message-Id: <pull.1371.v2.git.1664877694430.gitgitgadget@gmail.com>
In-Reply-To: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
References: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 10:01:34 +0000
Subject: [PATCH v2] ssh signing: return an error when signature cannot be read
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the signature file cannot be read we print an error message but do
not return an error to the caller. In practice it seems unlikely that
the file would be unreadable if the call to ssh-keygen succeeds.

The unlink_or_warn() call is moved to the end of the function so that
we always try and remove the signature file. This isn't strictly
necessary at the moment but it protects us against any extra code
being added between trying to read the signature file and the cleanup
at the end of the function in the future. unlink_or_warn() only prints
a warning if it exists and cannot be removed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    ssh signing: return an error when signature cannot be read
    
    Thanks to Junio for his comments. I've updated the patch to always use
    unlink_or_warn() to remove the signature file as it does not warn on
    missing files.
    
    V1 cover letter
    
    This patch is based on maint. In the longer term the code could be
    simplified by using pipes rather than tempfiles as we do for gpg.
    ssh-keygen has supported reading the data to be signed from stdin and
    writing the signature to stdout since it introduced signing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1371%2Fphillipwood%2Fssh-signing-return-error-on-missing-signature-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1371/phillipwood/ssh-signing-return-error-on-missing-signature-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1371

Range-diff vs v1:

 1:  6f569ac0f48 ! 1:  1db8af68fce ssh signing: return an error when signature cannot be read
     @@ Commit message
      
          If the signature file cannot be read we print an error message but do
          not return an error to the caller. In practice it seems unlikely that
     -    the file would be unreadable if the call to ssh-keygen succeeds. If we
     -    cannot read the file it may be missing so ignore any errors from
     -    unlink() when we try to remove it.
     +    the file would be unreadable if the call to ssh-keygen succeeds.
     +
     +    The unlink_or_warn() call is moved to the end of the function so that
     +    we always try and remove the signature file. This isn't strictly
     +    necessary at the moment but it protects us against any extra code
     +    being added between trying to read the signature file and the cleanup
     +    at the end of the function in the future. unlink_or_warn() only prints
     +    a warning if it exists and cannot be removed.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf
      +		ret = error_errno(
       			_("failed reading ssh signing data buffer from '%s'"),
       			ssh_signature_filename.buf);
     -+		unlink(ssh_signature_filename.buf);
      +		goto out;
       	}
     - 	unlink_or_warn(ssh_signature_filename.buf);
     +-	unlink_or_warn(ssh_signature_filename.buf);
     +-
     + 	/* Strip CR from the line endings, in case we are on Windows. */
     + 	remove_cr_after(signature, bottom);
       
     +@@ gpg-interface.c: out:
     + 		delete_tempfile(&key_file);
     + 	if (buffer_file)
     + 		delete_tempfile(&buffer_file);
     ++	if (ssh_signature_filename.len)
     ++		unlink_or_warn(ssh_signature_filename.buf);
     + 	strbuf_release(&signer_stderr);
     + 	strbuf_release(&ssh_signature_filename);
     + 	FREE_AND_NULL(ssh_signing_key_file);


 gpg-interface.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 947b58ad4da..b5c2bbb3b91 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1043,12 +1043,11 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
 	strbuf_addstr(&ssh_signature_filename, ".sig");
 	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
-		error_errno(
+		ret = error_errno(
 			_("failed reading ssh signing data buffer from '%s'"),
 			ssh_signature_filename.buf);
+		goto out;
 	}
-	unlink_or_warn(ssh_signature_filename.buf);
-
 	/* Strip CR from the line endings, in case we are on Windows. */
 	remove_cr_after(signature, bottom);
 
@@ -1057,6 +1056,8 @@ out:
 		delete_tempfile(&key_file);
 	if (buffer_file)
 		delete_tempfile(&buffer_file);
+	if (ssh_signature_filename.len)
+		unlink_or_warn(ssh_signature_filename.buf);
 	strbuf_release(&signer_stderr);
 	strbuf_release(&ssh_signature_filename);
 	FREE_AND_NULL(ssh_signing_key_file);

base-commit: a0feb8611d4c0b2b5d954efe4e98207f62223436
-- 
gitgitgadget
