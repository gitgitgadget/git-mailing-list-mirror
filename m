Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A78623
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296859; cv=none; b=RNyOySTXTBUCUrrgIfQI4OOm1TBHaWJCuC4yv7QZosuJ4F4t9+UsglqTGP+SXf5/wx+napKaC8xvuf97JSS6KX+PdV/OuuMLNu6rKkjX/cjS43CmrnERMoSdW0o3laeP1Ptl3w/ou4TWXJh1wIvtJWFA34xmAWF8MS8VfLH1vIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296859; c=relaxed/simple;
	bh=zbxvuQ0bKz55iAhgmXaL/omEhjrVRozJz9gvvErAgj8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jwzW4aw5lz+iS3qoXGfYvHkUPgWib2eftHESZM1xXboI1Pa9LugA8O0+xvOSbTFDgOgeIBkqEBnrc/wcQ4+944IBdoRzoDRGFR4mtTCvo3qylCXEcPhpt+X5KXBhExTtHShLWEjax9/EqAnWVlnf/VVVLiaNkuXSwGJmEGtXqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8znc6sc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8znc6sc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d58377339so2805958f8f.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729296855; x=1729901655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Th1+K0XpVOjJxLwI+sFxsFtO0rYXH1qm0YwBOBziI=;
        b=D8znc6scZVyiwVdbio33d2HrQ+nxUa8FAkt4Uu9/nJ3Jyb2UvD0exuwBQUCN0nCZLf
         20XDUC0EOif2LQO6QKFiAojY5M9HBUKWqUFSLFoepMg9frnyZ9B0KrfzJK6WH5WGkSQ/
         FLusaQWnPTvrVQBZlU/GaNLuSaRr8XNREIUL4SfWo++H0nTeMCIzWqnrX3YgdIz6VXNM
         nwlv5cHIpZUlhpQiE8rO4K7AnlAbBFiYyuyTeCP+4pKwAgAi34VnXJ1viaFsA5ZJ9qtQ
         j5EiHM63eelezMXEmpAPYlFNS6UNn5IOpxpKIt2kt4lZY/rphYVLnUPA/OgxuIqyKv/6
         HMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729296855; x=1729901655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Th1+K0XpVOjJxLwI+sFxsFtO0rYXH1qm0YwBOBziI=;
        b=peZRPFYBtjFYvFKmVrjUdHvN+Uw0TfS0A5Z8uLgBRQzlsexQFg3qNI5aVgJIey3RO6
         Lzluc+qXcj6Cs7bAVGyyRCR0HdVmS0siydWRy7WO2XA/tFiY16BJTw+BiHclz3WS/i0G
         dVUBHGtV8MdA2p+kU6xMW5Kdutr69A+lD6Mx0u85xjpgPgfBBWZbtG8UtxnWfJTgooME
         Q8oydAvYqNE16yvhM1QzrC/BlgChtdokvb0Et2orZCHc2uvgdV2wluR5VkuWJpbn9THa
         lL/Cp0/QHi1fJCWTBjTra3UyAAmO8/7aKI/YsST88IY54938GriqPuKCKECmYVDZzbTU
         fNaQ==
X-Gm-Message-State: AOJu0YyBfiXsHpWu6vm/jyLgncPb5fvT4sTAENb2DBMqjAaDsbJ5qgLu
	qKpYSUB50zndKuZaE8wO5vMKuanbstrSl15xK8sAAgVc7Th0E55x0fWpEQ==
X-Google-Smtp-Source: AGHT+IHrHLBf/0nEL3YdlVloMR1TdTMLvBZJsfWbaO1/mWlLElFXdy4xzey0v4GPIDplf/BLG4GY7A==
X-Received: by 2002:a05:6000:114b:b0:374:c658:706e with SMTP id ffacd0b85a97d-37eab755b4fmr4186920f8f.39.1729296854904;
        Fri, 18 Oct 2024 17:14:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c2c51csm150602166b.218.2024.10.18.17.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 17:14:14 -0700 (PDT)
Message-Id: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Oct 2024 00:14:13 +0000
Subject: [PATCH] notes: teach the -e option to edit messages in editor
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Notes can be added to a commit using the -m (message),
-C (copy a note from a blob object) or
-F (read the note from a file) options.
When these options are used, Git does not open an editor,
it simply takes the content provided via these options and
attaches it to the commit as a note.

Improve flexibility to fine-tune the note before finalizing it
by allowing the messages to be prefilled in the editor and editted
after the messages have been provided through -[mF].

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
    [Outreachy][RFC/PATCH] notes: teach the -e option to edit messages in
    editor
    
    Notes can be added to a commit using the -m (message), -C (copy a note
    from a blob object) or -F (read the note from a file) options. When
    these options are used, Git does not open an editor, it simply takes the
    content provided via these options and attaches it to the commit as a
    note.
    
    Improve flexibility to fine-tune the note before finalizing it by
    allowing the messages to be prefilled in the editor and edited after
    they have been provided through -[mF].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1817%2Fdevdekunle%2Fnotes_add_e_option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1817/devdekunle/notes_add_e_option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1817

 builtin/notes.c  |  4 ++++
 t/t3301-notes.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8c26e455269..02cdfdf1c9d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg),
+		OPT_BOOL('e', "edit", &d.use_editor,
+			N_("edit note message in editor")),
 		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg),
@@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg),
+		OPT_BOOL('e', "edit", &d.use_editor,
+			N_("edit note message in editor")),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT_CALLBACK_F(0, "separator", &separator,
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 99137fb2357..7f45a324faa 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1567,4 +1567,33 @@ test_expect_success 'empty notes do not invoke the editor' '
 	git notes remove HEAD
 '
 
+test_expect_success '"git notes add" with -m/-F invokes the editor with -e' '
+	test_commit 19th &&
+	GIT_EDITOR="true" git notes add -m "note message" -e &&
+	git notes remove HEAD &&
+	echo "message from file" >file_1 &&
+	GIT_EDITOR="true" git notes add -F file_1 -e &&
+	git notes remove HEAD
+'
+
+test_expect_success 'git notes append with -m/-F invokes editor with -e' '
+	test_commit 20th &&
+	GIT_EDITOR="true" git notes add -m "initial note" -e &&
+	GIT_EDITOR="true" git notes append -m "appended note" -e &&
+	git notes remove HEAD &&
+	echo  "initial note" >note_a &&
+	echo "appended note" >note_b &&
+	GIT_EDITOR="true" git notes add -F note_a -e &&
+	GIT_EDITOR="true" git notes append -F note_b -e &&
+	git notes remove HEAD
+'
+
+test_expect_success 'append note with multiple combinations of -m, -F and -e, invokes editor' '
+	test_commit 21st &&
+	echo "foo-file-1" >note_1 &&
+	echo "foo-file-2" >note_2 &&
+	GIT_EDITOR="true" git notes append -F note_1 -m "message-1" -F note_2 -m "message-2" -e &&
+	git notes remove HEAD
+'
+
 test_done

base-commit: 15030f9556f545b167b1879b877a5d780252dc16
-- 
gitgitgadget
