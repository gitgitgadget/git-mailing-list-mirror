Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36225569
	for <git@vger.kernel.org>; Sun,  5 May 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934956; cv=none; b=lC880cVkNDndtUL0nL/JRWLK5Cc4ULI+w2V+27OOzmUqwovfCy2DfLVlKk+6tgTd1/C9MvQs8P3lr3cesSA0fXD20Eyyh8UZlhVTf3MUWgW8PDToxXn3B8xaiCEuVmayjWZDmt3wJBgFiHKwbJV56SlZH4VAdNb2Uwgo2DfG45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934956; c=relaxed/simple;
	bh=T5Z78ylavmh9oPD/gYteNwLQGtdWd/+BqUJMU57tVTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K0u/omJklHSv5D7ybenzYGlZyP9a/82BN7KJOyir6Ksqkk/gYplu9Ae2cCu2lASGIdfQz5jFEyKYaubntj9b6M9yQSPQYwQIa1r8D8+5/2iKsJS9DgDuXN7QYqxLwqNT2lAkjERmFa1sdCNQZcRYW90AWCKqvxI4c1XFkmNHR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enCS585F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enCS585F"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34db6a29998so750196f8f.0
        for <git@vger.kernel.org>; Sun, 05 May 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714934953; x=1715539753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzJGEnXS5zY9LiTmz3eg6e1J8C/Yfg1HVCZZ5O3gWCs=;
        b=enCS585FId6aGfCE4lbHqrwo/8rvgVAAlK73NKIHlO3ppjM9yAp9zs2KBdK/7WFUv2
         F6Uvan+iZZrP33VtZ3Huovz4CoRmFetpTAfVm+ECe/DqZlMGxHWGRFJrzNGZHyGZFBiu
         tv+9MvT8kTa+9ZpCA6Lm41DeOX+EiBE4n8D78vn9MJljIjzoj/vtx3H9yeeu73O8Zhcy
         1r1LTQgCw6ZABOt0j1SymoxWbdpqBJP26f8aNAl7dFAKLf0t3pVO/ZlPGz/EbywUdH1o
         sANa9UuQaFVjts4YkdoUnXleIt9cuWHdS4Or5Luj2WAM5PeeIOl6d7MssejG9BNiTudl
         hNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934953; x=1715539753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzJGEnXS5zY9LiTmz3eg6e1J8C/Yfg1HVCZZ5O3gWCs=;
        b=CXr99I0zhe+rDRiiFl9HoKDOlhDLq8F6pkvZbCv91gejFck8rUWMo2bQbJ9wx8kegc
         WYTfctuMA5au98u4jePxbSHddmocpesH4FEsym/W6vDv+Ykv4O0sqjKznkKqqG5SDXbu
         QErz97wC88PoanQhxFgbvwDC3vorWgMpaCOeJy7DkWISrrXB8XNJGaKy7+TjUsv38dlv
         J4X5+Qkzq7a078262id1PR9yBenhPZyP3YCZ3ZaD0jn7z5UKNGkaaz/lNBysK19zUk78
         8m5iEdnT0ygVkeXGvVlS6+zJyh7hhXF7wvl1P4ouZ1pg0+6v/2WoX19ZXacSLfOHN6FJ
         4CuQ==
X-Gm-Message-State: AOJu0YzuljgEylZeSc/Z2QsDAsUKJj+JwwuSv1hT5Qkf4Hxqx6jNUk+A
	FsXWw4KOUPDIpcB6XUzs6zdp8HrNIltBSDO1EtAlpnfjplPxGjx6vp+Xrw==
X-Google-Smtp-Source: AGHT+IEP/GMhCu9EbWgi9WXb73lE9SkdtgK9oIm6gKkBU/w4x+YNOEdIyVLO91GD0eOh43oMnnRLwQ==
X-Received: by 2002:adf:ed48:0:b0:343:a098:f41 with SMTP id u8-20020adfed48000000b00343a0980f41mr5241405wro.28.1714934952775;
        Sun, 05 May 2024 11:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020adfa3d2000000b0034dfede0071sm8866926wrb.46.2024.05.05.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:49:12 -0700 (PDT)
Message-Id: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 May 2024 18:49:07 +0000
Subject: [PATCH v5 0/3] builtin/tag.c: add --trailer option
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

5th follow-up patch taking welcome feedback from Patrick and JCH. Net new
changes include suggested tweaks in documentation, error messaging, code
formatting, and patch description.

Since git-tag --list --format="%(trailers)" can interpret trailers from
annotated tag messages, it seems natural to support --trailer when writing a
new tag message.

git-commit accomplishes this by taking --trailer arguments and passing them
to git-interpret-trailer. This patch series refactors that logic and uses it
to implement --trailer on git-tag.

John Passaro (3):
  builtin/commit: use ARGV macro to collect trailers
  builtin/commit: refactor --trailer logic
  builtin/tag: add --trailer option

 Documentation/git-tag.txt |  16 +++++-
 builtin/commit.c          |  20 +------
 builtin/tag.c             |  38 ++++++++++---
 t/t7004-tag.sh            | 114 ++++++++++++++++++++++++++++++++++++++
 trailer.c                 |  12 ++++
 trailer.h                 |   9 +++
 6 files changed, 181 insertions(+), 28 deletions(-)


base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1723%2Fjpassaro%2Fjp%2Ftag-trailer-arg-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1723/jpassaro/jp/tag-trailer-arg-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1723

Range-diff vs v4:

 1:  ce047c58aa8 ! 1:  85f45a57f35 builtin/commit.c: remove bespoke option callback
     @@ Metadata
      Author: John Passaro <john.a.passaro@gmail.com>
      
       ## Commit message ##
     -    builtin/commit.c: remove bespoke option callback
     +    builtin/commit: use ARGV macro to collect trailers
      
     -    Replace git-commit's bespoke callback for --trailer with the standard
     -    OPT_PASSTHRU_ARGV macro. The bespoke callback was only adding its values
     -    to a strvec and sanity-checking that `unset` is always false; both of
     -    these are already implemented in the parse-option API.
     +    Replace git-commit's callback for --trailer with the standard
     +    OPT_PASSTHRU_ARGV macro. The callback only adds its values to a strvec
     +    and sanity-checking that `unset` is always false; both of these are
     +    already implemented in the parse-option API.
      
          Signed-off-by: John Passaro <john.a.passaro@gmail.com>
      
 2:  8f53a54bbfe ! 2:  75bb5cc0e8a builtin/commit.c: refactor --trailer logic
     @@ Metadata
      Author: John Passaro <john.a.passaro@gmail.com>
      
       ## Commit message ##
     -    builtin/commit.c: refactor --trailer logic
     +    builtin/commit: refactor --trailer logic
      
          git-commit adds user trailers to the commit message by passing its
          `--trailer` arguments to a child process running `git-interpret-trailers
     @@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
       	strbuf_release(&iter->key);
       }
      +
     -+int amend_file_with_trailers(const char *path, const struct strvec *trailer_args) {
     ++int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
     ++{
      +	struct child_process run_trailer = CHILD_PROCESS_INIT;
      +
      +	run_trailer.git_cmd = 1;
 3:  f1d68337eda ! 3:  d8b3f6229bc builtin/tag.c: add --trailer option
     @@ Metadata
      Author: John Passaro <john.a.passaro@gmail.com>
      
       ## Commit message ##
     -    builtin/tag.c: add --trailer option
     +    builtin/tag: add --trailer option
      
     -    git-tag currently supports interpreting trailers from an annotated tag
     -    message, using --list --format="%(trailers)". However, to add a trailer
     -    to a tag message, you must do so using `-F` or by editing the message.
     +    git-tag supports interpreting trailers from an annotated tag message,
     +    using --list --format="%(trailers)". However, the available methods to
     +    add a trailer to a tag message (namely -F or --editor) are not as
     +    ergonomic.
      
          In a previous patch, we moved git-commit's implementation of its
          --trailer option to the trailer.h API. Let's use that new function to
     @@ Documentation/git-tag.txt: This option is only applicable when listing tags with
       
      +--trailer <token>[(=|:)<value>]::
      +	Specify a (<token>, <value>) pair that should be applied as a
     -+	trailer. (e.g. `git tag --trailer "Signed-off-by:T A Ger \
     -+	<tagger@example.com>" --trailer "Helped-by:C O Mitter \
     -+	<committer@example.com>"` will add the "Signed-off-by" trailer
     -+	and the "Helped-by" trailer to the tag message.)
     ++	trailer. (e.g. `git tag --trailer "Custom-Key: value"`
     ++	will add a "Custom-Key" trailer to the tag message.)
      +	The `trailer.*` configuration variables
      +	(linkgit:git-interpret-trailers[1]) can be used to define if
      +	a duplicated trailer is omitted, where in the run of trailers
      +	each trailer would appear, and other details.
     -+	The trailers can be seen in `git tag --list` using
     ++	The trailers can be extracted in `git tag --list`, using
      +	`--format="%(trailers)"` placeholder.
      +
       -e::
     @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
      +			}
      +		} else if (trailer_args->nr) {
      +			strbuf_reset(buf);
     -+			if (strbuf_read_file(buf, path, 0) < 0) {
     -+				fprintf(stderr,
     -+					_("Please supply the message using either -m or -F option.\n"));
     -+				exit(1);
     -+			}
     ++			if (strbuf_read_file(buf, path, 0) < 0)
     ++				die_errno(_("failed to read '%s'"), path);
       		}
       	}
       

-- 
gitgitgadget
