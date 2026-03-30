Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623D3876D5
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877080; cv=none; b=tRk9j83Kk4PN0tut4+ona6si3T9SY6osP7iZ2BAcsur2D5RNs/0+7u4f+MS9uJtrFjiODoEDowCI1BS8i1/qFep0hWTlGK4xAJK461MopDZ60LI0SdHie5J9VatxLDt1a/foyUeEwtZmZbvcu1O/ITUvZEDBF0RSz4JAUjp+7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877080; c=relaxed/simple;
	bh=JXHZGz6L188jbctyaWyIsxCwejbvbR2KZcebSGCizSA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=deN907cvWdcMFCuVGfsFStipETjlTvBxfUcI/zG1zg85VkxpziAAZQr54RaJa7os2eutZ2O05Hw/7j1Z0lVzLyNElkF3CkBVgctNBpCyssRnON2wIp6eHkwvQOdXl79EV8ytqknmG4cTC7wO6f0q6rYk7wV5yWG3mmREjIoF40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej493htN; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej493htN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso3921109a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877078; x=1775481878; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6QCKUEcHg9+A5gYZoy4lEZUbvd+Vy1Y4me1fWeXijk=;
        b=Ej493htNigpWo+Z7kqJYzPc4YUiSw6kP9nK7hOJwjsok/ocPtkCZYSPW1I0yiGS4eC
         6rIV8Zmdj4n/cRj8Wo/kcDCYpmC+Fp2JqWQJqH6WiMUiIV1y5VnyEMf1BZ8wklONBqpo
         rUMHufpzoFjtN3B3v1GYmz6AaIBuxoOtAKier4lwwBoUZvomSc+B2qHH/gANnjF7zRJb
         cjTsmbg8w9LPGkvJOr7DhnTYw1FYnvBn1+FmIHheUM4daM+KXToenFYKaAwCOtI+LZ56
         wW4HOD5oOJV0JvRC5GqkfjVhYb0rP1GqSJ+zQ+sUwi3lf/59gOfZWrGk6X0EDZcVzeG+
         3UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877078; x=1775481878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6QCKUEcHg9+A5gYZoy4lEZUbvd+Vy1Y4me1fWeXijk=;
        b=idAOQsGjI1IP6z2MccCZAz3UA/UtTTfa+/oopWurRaQc/6w3ToanL++jR14AedOUFB
         68gT9qYZHkJgjw6aQc6+LsNU5QwZcGrT/KQ/jrGAnHUZSdZUR/JJR++nvap3+JA46hcg
         4OuaYMPqJg/V4HJCphorxzbHGb55QzcYnk8986zWuYl960oviQdjMOX9vPN+nUgMsSM1
         DjSXRgu2yKR9RUs2lEYLGxOOaW9jxOubsDcWfVqhDAuh1eiTeX3d4tUi9FxZMumJ9dj4
         ozYN8bWK1DG43Y6VaihIOdURd5BzgkRRTIiYhUrOYjbBp1lKYvs8yKVtmwtrYvjT6fgN
         mEaA==
X-Gm-Message-State: AOJu0Yw9BtW2BQ8pPbHVpNf09KLGIFfKmdlpMefOx0MeB+yyWTfaOO5e
	JIp4EE8CRnJCzHcnY5hlVOsPkjzy90Zsq45QRd9y+SgPO36YJewmqwoqqOMJ1A==
X-Gm-Gg: ATEYQzy//GRnJD57j8Ld6zUdTelYq9cfvXgSd7tHnk8lYhAScC97bLEhY2psfW46TBB
	KOxNE2soFZGHeds2tRcPfaiWclhRpxCRyaoAga3GI9RnnkQziJHbc/gfP9+WFzqNQo+FhwcXQG1
	7YgTOrJJr6CW5cZ7kleMw3D/H8W3NR2ZxzOwU1NGj95MloREfNXlJEFPSCdSxizadM48AIv4zeW
	tiQKLL+g318aUwkG8u2qGZH7DCqD+emwkErBJaUPg4NGMZjhAh8YtrgA26vmftbmqoDUFBx1mom
	LvzCXJxNpLCxzOmyLssphkU8WhikTYz50EUXQMClpM7ZefoVZCkybX+pRSI6+5TX0q0PU40lowf
	DAUcZKvej0tIXbaKpb9d11hnOs0iClTIg4qhrt0mTw7CSu5y1y/zAzhqNvdF9H2jK3m0LXbtgwP
	BoWrWtCgCYA9w0md+w5+aTs+udu8w=
X-Received: by 2002:a05:6820:4b8b:b0:67e:ca3:9c25 with SMTP id 006d021491bc7-67e1863e4e3mr6236467eaf.28.1774877077598;
        Mon, 30 Mar 2026 06:24:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.245.160])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e483fsm5261371fac.1.2026.03.30.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:24:36 -0700 (PDT)
Message-Id: <pull.2255.v2.git.git.1774877075694.gitgitgadget@gmail.com>
In-Reply-To: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
From: "Quentin Bernet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 13:24:35 +0000
Subject: [PATCH v2] docs: fix "git stash [push]" documentation
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
Cc: Quentin Bernet <quentin.bernet@bluewin.ch>,
    Quentin Bernet <quentin.bernet@bluewin.ch>

From: Quentin Bernet <quentin.bernet@bluewin.ch>

Both the synopsis and explanation are incorrect and contradict each
other.
The synopsis claims "push" can only be omitted when you do not give any
options and arguments.
The explanation correctly claims that non-option arguments are not
allowed, except pathspec elements preceded by double hyphens.
But it also adds "-p" to the list of exceptions, even though it is an
option argument.

Signed-off-by: Quentin Bernet <quentin.bernet@bluewin.ch>
---
    Fix git stash grammar

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2255%2FSporarum%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2255/Sporarum/patch-1-v2
Pull-Request: https://github.com/git/git/pull/2255

Range-diff vs v1:

 1:  e30696d3c4 ! 1:  927410a49d docs: fix git stash grammar
     @@ Metadata
      Author: Quentin Bernet <quentin.bernet@bluewin.ch>
      
       ## Commit message ##
     -    docs: fix git stash grammar
     +    docs: fix "git stash [push]" documentation
      
     -    Grammar incorrectly did not include `git stash -m`
     -    and other valid `git stash push` flags
     +    Both the synopsis and explanation are incorrect and contradict each
     +    other.
     +    The synopsis claims "push" can only be omitted when you do not give any
     +    options and arguments.
     +    The explanation correctly claims that non-option arguments are not
     +    allowed, except pathspec elements preceded by double hyphens.
     +    But it also adds "-p" to the list of exceptions, even though it is an
     +    option argument.
      
          Signed-off-by: Quentin Bernet <quentin.bernet@bluewin.ch>
      
     @@ Documentation/git-stash.adoc: git stash drop [-q | --quiet] [<stash>]
       git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
                  [-u | --include-untracked] [-a | --all] [<message>]
       git stash clear
     +@@ Documentation/git-stash.adoc: COMMANDS
     + 	the description along with the stashed state.
     + +
     + For quickly making a snapshot, you can omit "push".  In this mode,
     +-non-option arguments are not allowed to prevent a misspelled
     +-subcommand from making an unwanted stash entry.  The two exceptions to this
     +-are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
     +-which are allowed after a double hyphen `--` for disambiguation.
     ++pathspec elements are only allowed after a double hyphen `--`
     ++to prevent a misspelled subcommand from making an unwanted stash entry.
     + 
     + `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
     + 
      
       ## builtin/stash.c ##
      @@


 Documentation/git-stash.adoc | 10 ++++------
 builtin/stash.c              |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..b05c990ecd 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -14,10 +14,10 @@ git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
 git stash apply [--index] [-q | --quiet] [<stash>]
 git stash branch <branchname> [<stash>]
-git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	     [--] [<pathspec>...]]
+	     [--] [<pathspec>...]
 git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
            [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
@@ -60,10 +60,8 @@ COMMANDS
 	the description along with the stashed state.
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
-non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted stash entry.  The two exceptions to this
-are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
-which are allowed after a double hyphen `--` for disambiguation.
+pathspec elements are only allowed after a double hyphen `--`
+to prevent a misspelled subcommand from making an unwanted stash entry.
 
 `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..0d27b2fb1f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -50,10 +50,10 @@
 #define BUILTIN_STASH_STORE_USAGE \
 	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>")
 #define BUILTIN_STASH_PUSH_USAGE \
-	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
+	N_("git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n" \
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n" \
-	   "          [--] [<pathspec>...]]")
+	   "          [--] [<pathspec>...]")
 #define BUILTIN_STASH_SAVE_USAGE \
 	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")

base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
-- 
gitgitgadget
