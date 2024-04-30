Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630B770EB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488119; cv=none; b=YOK/ZCb+aA/GBRVY6dAJlf/D084VkNw6mCxtRBZt/7fe4HvqYv9rEArw1w9fNMcFaxL/4HFys8nesqHn1tr3KbG3e3tKMamNiDflGOWiSg0HBjbWxL5Uu0DRhc+YToMouQI+AlxxzKoqQe0q48rhOv+m8J44yYEYuXA+d7jh8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488119; c=relaxed/simple;
	bh=QZG7qlkIjp6Th8v3ThNR6GNF5GRZgHABr9jVQRcQXYc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H7u236vXaqsgWbepBCPxwQ46KK6YWm73cDcqiYujRuW0jSTlMBSJlrsTl1aQz/olu6at0tppa2svhZMBZwALYmj4u8nUQFBpgnIiY78A+pHPlNPd6KwAPS3aBqc+iWXYVzyDk75oT7gGTpt0vuShDrH43v+2s7g5uSI3mPhPBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f33bf/Zq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f33bf/Zq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34db6a29998so57186f8f.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488115; x=1715092915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwrn1wcdVto/saZtIwgtXER1PaoWvNf9w18wtBVg0TA=;
        b=f33bf/ZqVEmSwHbe11zznzs6K/DlCxyDuRGo3Wtbf7c2olbEeeeN6TwPEqY6Rdnrxq
         w/Q7rImLjblelUBuzzkgithsNPqAcwNQ7bOuG3U4TGz1IxjaSzhfQMFtRzMyrwTRIwzA
         +/HVQnz5k/lC/i6UaRHOEV6KYAndhWtKp2hSNJVf1sZpV6cYEtDvZkaKVcyDY+khDIfM
         WymPohjJaq0QaIi9TNGt/dLaKl/5esUFcLrafRIhxEJq9iYRnmWGo3T1HZKBgKftiXTq
         6+zQAbdbLpCOJqxWfNAhpLlfNjnwOUHFYRh1CS734oCO8hYsngDj2HnsXJSuoQSS3J88
         XumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488115; x=1715092915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwrn1wcdVto/saZtIwgtXER1PaoWvNf9w18wtBVg0TA=;
        b=orgpt752alHeVgGdLIqOaHyTBYjZj6kq7KF35q8/bej6zUKr2T6ocvF2QWt+KyjgNz
         kazf4L5roarRITwFdsOqgQAPzD7sS0OlMUqCpcETexVEQJ34KbGeMx+I9ZrJGZsRBLYG
         s2SONQKb/fQhth/kfbJ1vGte+dG2MEsoZz/q/LWKK21aZ5Fj0L5j5NwliuYggRQS67dQ
         ExkFa8oK2KoSwHs+58K19REKsCHCKbpSxLWw1RswYsln5m7YSlf/12LdcRdYqney5ymF
         z79niJtCXbXZVMFYf4RsTxdhFFJYxYDtpigaX99r96ByRdsEnoQsWSUyVGaFO4QUZ39W
         pUJg==
X-Gm-Message-State: AOJu0YzRI5eTlJ11Y++FlDcwmjDcsyLbNfwTJ/jlnyuqNURBdVKes5Nj
	8AYC1SJIus8CjJ1j2uX9PjGIRg7K2nstgsd812olovXrUSRHdLAkKzAiPQ==
X-Google-Smtp-Source: AGHT+IF3ubkd+ER21ElrcEyfRWYsXMxv4DjyZKz3IydyVxCKvE7az89y6zk1EPgBiiBQy89Qvpi1tg==
X-Received: by 2002:adf:fe8d:0:b0:34c:f31f:906f with SMTP id l13-20020adffe8d000000b0034cf31f906fmr4996150wrr.55.1714488115488;
        Tue, 30 Apr 2024 07:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d610c000000b0034ca96ecd1dsm8663794wrt.12.2024.04.30.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:41:55 -0700 (PDT)
Message-Id: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 14:41:48 +0000
Subject: [PATCH v4 0/3] builtin/tag.c: add --trailer option
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

4th follow-up patch taking welcome feedback from Patrick and JCH. Net new
changes include separating from a 2-patch series to 3.

Since git-tag --list --format="%(trailers)" can interpret trailers from
annotated tag messages, it seems natural to support --trailer when writing a
new tag message.

git-commit accomplishes this by taking --trailer arguments and passing them
to git-interpret-trailer. This patch series refactors that logic and uses it
to implement --trailer on git-tag.

John Passaro (3):
  builtin/commit.c: remove bespoke option callback
  builtin/commit.c: refactor --trailer logic
  builtin/tag.c: add --trailer option

 Documentation/git-tag.txt |  18 +++++-
 builtin/commit.c          |  20 +------
 builtin/tag.c             |  41 +++++++++++---
 t/t7004-tag.sh            | 114 ++++++++++++++++++++++++++++++++++++++
 trailer.c                 |  11 ++++
 trailer.h                 |   9 +++
 6 files changed, 185 insertions(+), 28 deletions(-)


base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1723%2Fjpassaro%2Fjp%2Ftag-trailer-arg-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1723/jpassaro/jp/tag-trailer-arg-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1723

Range-diff vs v3:

 -:  ----------- > 1:  ce047c58aa8 builtin/commit.c: remove bespoke option callback
 1:  0c9517f434a ! 2:  8f53a54bbfe builtin/commit.c: refactor --trailer logic
     @@ Commit message
          Let's move this logic from git-commit to a new function in the trailer
          API, so that it can be re-used in other commands.
      
     -    Additionally, replace git-commit's bespoke callback for --trailer with
     -    the standard OPT_PASSTHRU_ARGV macro. This bespoke callback was only
     -    adding its values to a strvec and sanity-checking that `unset` is always
     -    false; both of these are already implemented in the parse-option API.
     -
     -    Signed-off-by: John Passaro <john.a.passaro@gmail.com>
          Helped-by: Patrick Steinhardt <ps@pks.im>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: John Passaro <john.a.passaro@gmail.com>
      
       ## builtin/commit.c ##
      @@
     @@ builtin/commit.c
       
       static const char * const builtin_commit_usage[] = {
       	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
     -@@ builtin/commit.c: static struct strbuf message = STRBUF_INIT;
     - 
     - static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
     - 
     --static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
     --{
     --	BUG_ON_OPT_NEG(unset);
     --
     --	strvec_pushl(opt->value, "--trailer", arg, NULL);
     --	return 0;
     --}
     --
     - static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
     - {
     - 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
      @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
       	fclose(s->fp);
       
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       			die(_("unable to pass trailers to --trailers"));
       		strvec_clear(&trailer_args);
       	}
     -@@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
     - 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
     - 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
     - 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
     --		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
     -+		OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG),
     - 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
     - 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
     - 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
      
       ## trailer.c ##
     -@@
     - #include "commit.h"
     - #include "trailer.h"
     - #include "list.h"
     -+#include "run-command.h"
     - /*
     -  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
     -  */
      @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
       	strbuf_release(&iter->val);
       	strbuf_release(&iter->key);
       }
      +
     -+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
     ++int amend_file_with_trailers(const char *path, const struct strvec *trailer_args) {
      +	struct child_process run_trailer = CHILD_PROCESS_INIT;
      +
      +	run_trailer.git_cmd = 1;
     @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
      
       ## trailer.h ##
      @@
     - 
       #include "list.h"
       #include "strbuf.h"
     -+#include "strvec.h"
       
     ++struct strvec;
     ++
       enum trailer_where {
       	WHERE_DEFAULT,
     + 	WHERE_END,
      @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
        */
       void trailer_iterator_release(struct trailer_iterator *iter);
     @@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
      + * This calls run_command() and its return value is the same (i.e. 0 for
      + * success, various non-zero for other errors). See run-command.h.
      + */
     -+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args);
     ++int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
      +
       #endif /* TRAILER_H */
 2:  5b6239167b8 ! 3:  f1d68337eda builtin/tag.c: add --trailer arg
     @@ Metadata
      Author: John Passaro <john.a.passaro@gmail.com>
      
       ## Commit message ##
     -    builtin/tag.c: add --trailer arg
     +    builtin/tag.c: add --trailer option
      
          git-tag currently supports interpreting trailers from an annotated tag
     -    message, using --list --format="%(trailers)". There is no ergonomic way
     -    to add trailers to an annotated tag message.
     +    message, using --list --format="%(trailers)". However, to add a trailer
     +    to a tag message, you must do so using `-F` or by editing the message.
      
     -    In a previous patch, we refactored git-commit's implementation of its
     -    --trailer arg to the trailer.h API. Let's use that new function to teach
     -    git-tag the same --trailer argument, emulating as much of git-commit's
     -    behavior as much as possible.
     +    In a previous patch, we moved git-commit's implementation of its
     +    --trailer option to the trailer.h API. Let's use that new function to
     +    teach git-tag the same --trailer option, emulating as much of
     +    git-commit's behavior as much as possible.
      
     -    Signed-off-by: John Passaro <john.a.passaro@gmail.com>
          Helped-by: Patrick Steinhardt <ps@pks.im>
     +    Signed-off-by: John Passaro <john.a.passaro@gmail.com>
      
       ## Documentation/git-tag.txt ##
      @@ Documentation/git-tag.txt: SYNOPSIS
 3:  d5335e30b0b < -:  ----------- po: update git-tag translations

-- 
gitgitgadget
