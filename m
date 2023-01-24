Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A4C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjAXP0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjAXP0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:26:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAC823DB4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:26:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k16so11720672wms.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRhAaaaRJDz612l73C3qJEaghjAAJ22uGsXNmwsmus=;
        b=cdxWoZOtzzOMG88FqgxY/EA4rT9fer1HCTMhDi3q0DifVrXXwI3efTDUE4JpcrJ7e9
         YELeeJqVSWRRypETBUHWZAcwrRUlGb3ohBBrRaWb6pSs6mxXj5Yl8WxvCyNQmIgRzEKx
         SEDL5lCH5zsASR7rEBLiV8curVsRzLR8Ux+fZrfsB/XdtWDI6EuT8SDXIklekVMnRMFO
         K+nDSJMLIEuFpf++itwybZFZUaEq7qdeL9x8boTBfWTkEJQf6TKhBHCyyW2naXb6y6qj
         3ZKDn1MwhEkZ6kj9DSv955+6JbBdMWibtNEtMtItnBd8m9KaRYTL5uh9AnLWGg03jwjn
         pYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRhAaaaRJDz612l73C3qJEaghjAAJ22uGsXNmwsmus=;
        b=RSpUIinalw0IZN+Wdy+SHRnOo/sdPvTVCMbVibqcNGOJaTwdBTd2OfZrGcqA8btoTN
         SWLEEpw7Bg6JeFxamWpHRcjIzM2liyRiC/Pab2go2nF54k+UFI/SI+lHATl3adhb65Df
         BRAYWkHcvsemESeDvRSz7E3QTSH70uDDwu5OixOhEO7S6/QDGLAeNu9mI5GV6pTQMNCg
         pM81FRX3uQfmSD0dfguRAyWce/V+rjj+RzSriXrDac0gPXAajn5DXwfaaeTKR8tRZfUa
         kA2+laDATXPS+YliG9iib4B+vKyxsVyeNQVuqZ/4JmfIIEN6NW7P6jMwhZf7RYm7aK4x
         9oWQ==
X-Gm-Message-State: AFqh2kpFamtaBf+xK+g1ntqDAYJk132FUWNE7StWL1BobrfZFSqgWmWk
        nU/I7Vr5tHJsnZSHN7W9emdn4DfbGoA=
X-Google-Smtp-Source: AMrXdXupE6EpHOfgtfaQUH/1bVJgzeXWUgKZ0HGAN77vrpA7B1aVEi8OBr2EdWKCXLcpfL1+KxeU7Q==
X-Received: by 2002:a05:600c:1695:b0:3db:12b:5103 with SMTP id k21-20020a05600c169500b003db012b5103mr29416320wmn.5.1674573973287;
        Tue, 24 Jan 2023 07:26:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c230500b003d04e4ed873sm13415075wmo.22.2023.01.24.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:26:13 -0800 (PST)
Message-Id: <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
In-Reply-To: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
From:   "Adam Szkoda via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 15:26:11 +0000
Subject: [PATCH v2] ssh signing: better error message when key not in agent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Adam Szkoda <adaszko@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda <adaszko@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Szkoda <adaszko@gmail.com>

When signing a commit with a SSH key, with the private key missing from
ssh-agent, a confusing error message is produced:

    error: Load key
    "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7":
    invalid format? fatal: failed to write commit object

The temporary file .git_signing_key_tmpkArSj7 created by git contains a
valid *public* key.  The error message comes from `ssh-keygen -Y sign' and
is caused by a fallback mechanism in ssh-keygen whereby it tries to
interpret .git_signing_key_tmpkArSj7 as a *private* key if it can't find in
the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All that
needs to be done is to pass an additional backward-compatible option -U to
'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets the file
as public key and expects to find the private key in the agent.

As a result, when the private key is missing from the agent, a more accurate
error message gets produced:

    error: Couldn't find key in agent

[1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429

Signed-off-by: Adam Szkoda <adaszko@gmail.com>
---
    ssh signing: better error message when key not in agent
    
    When signing a commit with a SSH key, with the private key missing from
    ssh-agent, a confusing error message is produced:
    
    error: Load key "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7": invalid format?
    fatal: failed to write commit object
    
    
    The temporary file .git_signing_key_tmpkArSj7 created by git contains a
    valid public key. The error message comes from `ssh-keygen -Y sign' and
    is caused by a fallback mechanism in ssh-keygen whereby it tries to
    interpret .git_signing_key_tmpkArSj7 as a private key if it can't find
    in the agent [1]. A fix is scheduled to be released in OpenSSH 9.1. All
    that needs to be done is to pass an additional backward-compatible
    option -U to 'ssh-keygen -Y sign' call. With '-U', ssh-keygen always
    interprets the file as public key and expects to find the private key in
    the agent.
    
    As a result, when the private key is missing from the agent, a more
    accurate error message gets produced:
    
    error: Couldn't find key in agent
    
    
    [1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1270%2Fradicle-dev%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v2
Pull-Request: https://github.com/git/git/pull/1270

Range-diff vs v1:

 1:  0ce06076242 < -:  ----------- ssh signing: better error message when key not in agent
 -:  ----------- > 1:  03dfca79387 ssh signing: better error message when key not in agent


 gpg-interface.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index f877a1ea564..33899a450eb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -998,6 +998,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	char *ssh_signing_key_file = NULL;
 	struct strbuf ssh_signature_filename = STRBUF_INIT;
 	const char *literal_key = NULL;
+	int literal_ssh_key = 0;
 
 	if (!signing_key || signing_key[0] == '\0')
 		return error(
@@ -1005,6 +1006,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 
 	if (is_literal_ssh_key(signing_key, &literal_key)) {
 		/* A literal ssh key */
+		literal_ssh_key = 1;
 		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
 		if (!key_file)
 			return error_errno(
@@ -1036,11 +1038,14 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	}
 
 	strvec_pushl(&signer.args, use_format->program,
-		     "-Y", "sign",
-		     "-n", "git",
-		     "-f", ssh_signing_key_file,
-		     buffer_file->filename.buf,
-		     NULL);
+			"-Y", "sign",
+			"-n", "git",
+			"-f", ssh_signing_key_file,
+			NULL);
+	if (literal_ssh_key) {
+		strvec_push(&signer.args, "-U");
+	}
+	strvec_push(&signer.args, buffer_file->filename.buf);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);

base-commit: 844ede312b4e988881b6e27e352f469d8ab80b2a
-- 
gitgitgadget
