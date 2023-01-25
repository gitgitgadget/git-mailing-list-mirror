Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC47C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 12:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjAYMk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 07:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjAYMkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 07:40:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF444AD
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 04:40:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z5so16907207wrt.6
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 04:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym2nLUBCOWws8f5JRwmpnwqiT3opQZUoCku0FbnfO0Q=;
        b=AoL3JaxSGPKLjQSDWyGjeAXaMzyTzC22CbQxEdEAFY8ye3EGuzE1GTba/qJAcjkQKD
         DdadbY/jgDBGWXnQppjMHTi+RYhKCGeCjmWCCSFJHd8cJV/bGNqny1k8DHJ59/B6AnJD
         wRrma2O2dWU68NOrfspsjRNtAL8IsV2UAimk02RgAFmm/PW3MbMQzaT068/LqxRQVejO
         /We4KFgYq1jAmeuGeyAY0/stIT8Xfe6YX0gkmf60giNo78HPOCYhU2Mjk6IB6H/btJ0f
         6n70zLLA8uNz4eVIEVPZs8CYYPOihqAhleL80SF2iusNSBQsKAUk48Z2XnzMXWzaCFLq
         J8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym2nLUBCOWws8f5JRwmpnwqiT3opQZUoCku0FbnfO0Q=;
        b=G+smAGcj3e+DL+Bm7JI8I515Z29zzVcz4S1gZiZgXW72WWkQAVdO6st00n0zv1XlgZ
         0OC8QR7Rx+Iy6j2Wvz4Rkkg6skqT5xiZF1e7+jXxohpkXx/1BwW3nN4r4dhPFvgiG5dS
         G+cEg1YkqqSvLt2A85kPFUF0+NYByySlPUoY1b0cRnLevcLxRB6g12VP2R21KHk371e1
         CsdBR873/aB2AJj1ewtpRnpZMtvtqK33ZcnBISdHvaoawn6kCGahqB/jHXxCZfoa1omr
         Zgu3iuZ7/RwwzWXX4AnqUJHUmMRtG2AgHGhlTqaqegclB2XEMvPk//b/MfSDMqnzUlWY
         AnOQ==
X-Gm-Message-State: AO0yUKVpot4lyuX+QZjKkRR/rc9ynQVLlh5PF5Gv8+175sJMHlfQWWT6
        fYe0IoeURXgobTFNBCWZdQn9Md3Jdv4=
X-Google-Smtp-Source: AK7set+YkewCfXk0CkzYS9VVIUV/lmhqc9oF1lNXSNg9/TtxrRNkR3i0n8qw9PbpyfGdnViELOb1sA==
X-Received: by 2002:adf:fa09:0:b0:2bf:ac2c:4489 with SMTP id m9-20020adffa09000000b002bfac2c4489mr5756974wrr.54.1674650451649;
        Wed, 25 Jan 2023 04:40:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020adfa489000000b002b065272da2sm4494466wrb.13.2023.01.25.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 04:40:51 -0800 (PST)
Message-Id: <pull.1270.v3.git.git.1674650450662.gitgitgadget@gmail.com>
In-Reply-To: <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
References: <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
From:   "Adam Szkoda via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 12:40:50 +0000
Subject: [PATCH v3] ssh signing: better error message when key not in agent
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1270%2Fradicle-dev%2Fmaint-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v3
Pull-Request: https://github.com/git/git/pull/1270

Range-diff vs v2:

 1:  03dfca79387 ! 1:  dc7acff3b95 ssh signing: better error message when key not in agent
     @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf
       		if (!key_file)
       			return error_errno(
      @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
     - 	}
     - 
     - 	strvec_pushl(&signer.args, use_format->program,
     --		     "-Y", "sign",
     --		     "-n", "git",
     --		     "-f", ssh_signing_key_file,
     + 		     "-Y", "sign",
     + 		     "-n", "git",
     + 		     "-f", ssh_signing_key_file,
      -		     buffer_file->filename.buf,
     --		     NULL);
     -+			"-Y", "sign",
     -+			"-n", "git",
     -+			"-f", ssh_signing_key_file,
     -+			NULL);
     -+	if (literal_ssh_key) {
     + 		     NULL);
     ++	if (literal_ssh_key)
      +		strvec_push(&signer.args, "-U");
     -+	}
      +	strvec_push(&signer.args, buffer_file->filename.buf);
       
       	sigchain_push(SIGPIPE, SIG_IGN);


 gpg-interface.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index f877a1ea564..687236430bf 100644
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
@@ -1039,8 +1041,10 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 		     "-Y", "sign",
 		     "-n", "git",
 		     "-f", ssh_signing_key_file,
-		     buffer_file->filename.buf,
 		     NULL);
+	if (literal_ssh_key)
+		strvec_push(&signer.args, "-U");
+	strvec_push(&signer.args, buffer_file->filename.buf);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);

base-commit: 844ede312b4e988881b6e27e352f469d8ab80b2a
-- 
gitgitgadget
