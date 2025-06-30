Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29D23E352
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272719; cv=none; b=Le8153FisuGIMCOvgdLKirRxgTkAlB987Eu++lGEAVQJcK6DREzuQ+55STr+apupER0/2ebYeAtSMjBO65cGIfrreoHWPmtmu5PtuUJyHDFudZ/s3bOEr9s/7XSXRtFjXrEw4ZPINLoILW59QVO7LX5eDUXyah9l6ARObeNbn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272719; c=relaxed/simple;
	bh=EaGLL5tZsyvXnVRypbR4JVxNjLPEV0kd7NJeC+G6Haw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=UqLzCYGLr9iHMX2fXF085rQNSu36WrEewIKcU+o3BejnxFof1MQrUGb2uofDVY1leIMJQkFtMD8iHDhW8aI2PJ2pXPhFSwSQoJXfjJrmWRvRMbdFHmx+xa0aV8XJuwvytn+Y0oUvbZPESXecGc0DOkMZ1fBsGDO16RgR7yz0lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrRX85GZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrRX85GZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3738453a12.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272716; x=1751877516; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg2B/J7It7dViI3eYLFgWAG3eE7IyEs1HCFHBRFLZwM=;
        b=XrRX85GZyUAlCPIzSsr+vpLhGAuVdVgLORaMvt4u1+dXS15zL6RjxOhhaTKW7rTZun
         0fYBY6ErH96eTPhj4P5twWPQRFoIQ9MzY5TaiYSSbqLpln19Hbeqk9ezAaREPyl/tvGt
         vRVPtrSuC9KhOEE5YpSl8/txnEev+Kj6rtt6uYQ04R1arfug3gMYb+TRsk6Nl1Rty6LM
         7MIAql7LKLvePQj08DUvVHNfnuhByAzEodfPfcwELj/EEPf6RvrOGFOVhvEMetjp08WX
         PGDjnCD7PMkEw/CWCTwlI5cxpRoXZ5jGVOibbA7WOgkW2Wz1SrtAUKpK2AvjPyw6bVMd
         87Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272716; x=1751877516;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cg2B/J7It7dViI3eYLFgWAG3eE7IyEs1HCFHBRFLZwM=;
        b=uuwdkRsnRMAs9YetTUaSdSPrS5YBWOP3RNnW/eQtmk/vMD1TH/CAwCii4tUpRmdbLn
         STEKxI6yvrU7oawLM/ISFu/itCpwAFdxu8/4IqNyduJbxpB3C0K1hgCTFY6fPInz7dLA
         WKiJ18Aj3UFMCt1yM9BcW7wQ2YHGF6+bUW3gO79wu4qcDcNSFnCQ72IlU1E7hn7k0WtT
         vovFKEu9KYnVnyUtSJ7pMcjaoU+ykaXri/NMJboqhEgQe+eYm3HqA4Gv8K+PQssQB7RU
         sfBrwBj6jSEGyLgkOS2bUyhC9L1OJBVNSaUZsKfRR6UWsmZTkfSABs/2yxwhx3zw4e/d
         IS8A==
X-Gm-Message-State: AOJu0YyWBJRv5WMWXadaVr+WJKLvGGXxGubz2QHc8ezAnSd/RibuJHWG
	rmYwNQ9MZoZlaBGj3jEEP4tQ7EoHMf5y6jI1VDn2YHVqI9KaO7Akwc53
X-Gm-Gg: ASbGncuiK5y4uufDI+6ObZbKHCtbrWqm2qv8FuutAbOklgFWIClW0bUQoZ0PI7FfiSO
	RvNk1nMFzMTfhnxFn6A0tPfp/oCDJb7jTj53Vl7TzgjGD0M/hG1boRG3DwZMkXhuPf73oZc08nI
	pGkWh77uNIFIwd6w9XBW4G6wteDCa0Ed1UkOm5AZ+BPcWx90UQL9GkwXxMVtqmfTd9NTkm1UHiu
	j74tfLJ8fGJlDiqbdznrSITTJNG/JYGlAZxDeBkWv5+Axqg26RkK50hzIzZFDqBwezJtwIG6kJF
	9XK2KzeQMmYZ+PAL9Cy4r9PmVAE4BPuEhf5FgU2gd4GnIQ==
X-Google-Smtp-Source: AGHT+IFscjamgVQxUYnrV1LudKrizquayAXp6hjaQCqOSCoeVQY4uVtPzspUHgRvMiCqeUABf0p/SA==
X-Received: by 2002:a05:6402:274e:b0:606:df70:7aa2 with SMTP id 4fb4d7f45d1cf-60c88e46d49mr10867153a12.31.1751272715399;
        Mon, 30 Jun 2025 01:38:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:cab2:9615:a476:665f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ca83610a1sm3413749a12.12.2025.06.30.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:38:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/3] clang-format: modify rules to reduce
 false-positives
Date: Mon, 30 Jun 2025 10:38:19 +0200
Message-Id: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtMYmgC/5WNQQ6CMBBFr0Jm7Rja2GpdeQ/DopQBGik1U2w0h
 LtbuYGLv3j/J++vkIg9JbhWKzBln3ycC8hDBW6080Dou8Iga6lqLRWqkmAfhG4qM/aRg10wRCb
 k2L7SgkZfhNTOGNEaKJ4nU+/f+8e9KTz6tET+7JdZ/Np/7FlgjfpsT4ack32nbkOwfjq6GKDZt
 u0LjaU5fNIAAAA=
X-Change-ID: 20250625-525-make-clang-format-more-robust-968126c991b9
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5913; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=EaGLL5tZsyvXnVRypbR4JVxNjLPEV0kd7NJeC+G6Haw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhiTQkbMYMtgJjD1xgWZfyyE+a0sH3Mv0sf7
 G2AYEZ+I97/LIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoYk0JAAoJED7VnySO
 Rox/0nQL/A2dZPHayi8EqvLdw55smLwr8E0DKJ9am6+DibI/Y41o0MbaIFJFsY8Cmz/fbC7/gF/
 Ij5gEVoGhHtMb0E5IxX9sd7VJc0R3JlzyWAGFZ6WjRe8jCalSCpjzjDmZjjaTLGlN/zE7NtUTvF
 PTLScrS6j0DMPC8bxF1EjEbp1xSyeV+5zU2nzmaG9d8W9A2oXz9M5w0dVcQX3oMyte5KRBb8B/b
 JhWTf7m0xgNMRplKRAKH7iPr56K4bgySarOg1ih6pU2SJHw4/wfzrbATkv2ZVmet02tNPXaAEmd
 D4AUTF/JBGWiVQbOOrgbhSkiKuYVD598m0zN88hnzDa7ZKf9iQOEBwZurfB2ESjxV2mbw0rmQ/+
 unjnQ9aWvTpB84Vomu3QawrCDwRjVgFVfCY/gZ/2LDFT8r4HndGFDIdq/vqX+9hZ6HHg456pvDE
 O30GZr253WsVR+v3GuGcaj2/Zo9gQrgqVpE2AQ8dxmf6gCLcXKxIst+bP1Kc3SLq2xPuz26j8g7
 UE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series is in response to an email thread [1] around the usage of
'.clang-format' and its effectiveness.

The goal of the series is to improve the usage of 'clang-format' in the
repository. To do this we:
1. Reduce the number of false positives. Majority of which is due to
   line-wrapping. We remove the 'ColumnLimit' from 'clang-format'. This
   removes the responsibility of line-wrapping from 'clang-format' and puts
   it into the hands of the user.
2. Add a rule to 'meson' to run 'git clang-format' by running 'meson
   compile style'.
3. Make the 'RemoveBracesLLVM' permanent by moving it to
   '.clang-format'.

With this, running `git clang-format` for the last 25 commits in master,
seems to produce much less false positives.

  diff --git a/builtin/diff.c b/builtin/diff.c
  index c6231edce4..246b81caa2 100644
  --- a/builtin/diff.c
  +++ b/builtin/diff.c
  @@ -30,14 +30,13 @@
   #define DIFF_NO_INDEX_IMPLICIT 2

   static const char builtin_diff_usage[] =
  -"git diff [<options>] [<commit>] [--] [<path>...]\n"
  -"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
  -"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
  -"   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
  -"   or: git diff [<options>] <blob> <blob>\n"
  -"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
  -"\n"
  -COMMON_DIFF_OPTIONS_HELP;
  +	"git diff [<options>] [<commit>] [--] [<path>...]\n"
  +	"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
  +	"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
  +	"   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
  +	"   or: git diff [<options>] <blob> <blob>\n"
  +	"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
  +	"\n" COMMON_DIFF_OPTIONS_HELP;

   static const char *blob_path(struct object_array_entry *entry)
   {
  diff --git a/builtin/stash.c b/builtin/stash.c
  index 7cd3ad8aa4..90e441a6e5 100644
  --- a/builtin/stash.c
  +++ b/builtin/stash.c
  @@ -1802,7 +1802,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,

 		  argc = parse_options(argc, argv, prefix, options,
 				       push_assumed ? git_stash_usage :
  -				     git_stash_push_usage, flags);
  +						    git_stash_push_usage,
  +				     flags);
 		  force_assume |= patch_mode;
 	  }

  diff --git a/bundle-uri.c b/bundle-uri.c
  index c9d65aa0ce..89f59aafe8 100644
  --- a/bundle-uri.c
  +++ b/bundle-uri.c
  @@ -123,7 +123,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 		  for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 			  if (heuristics[i].heuristic == list->heuristic) {
 				  fprintf(fp, "\theuristic = %s\n",
  -				       heuristics[list->heuristic].name);
  +					heuristics[list->heuristic].name);
 				  break;
 			  }
 		  }
  diff --git a/diff-no-index.c b/diff-no-index.c
  index 4aeeb98cfa..a3892a9ccc 100644
  --- a/diff-no-index.c
  +++ b/diff-no-index.c
  @@ -325,7 +325,7 @@ static int fixup_paths(const char **path, struct strbuf *replacement)
 	  return 0;
   }

  -static const char * const diff_no_index_usage[] = {
  +static const char *const diff_no_index_usage[] = {
 	  N_("git diff --no-index [<options>] <path> <path> [<pathspec>...]"),
 	  NULL
   };
  diff --git a/pathspec.h b/pathspec.h
  index 5e3a6f1fe7..601b9ca201 100644
  --- a/pathspec.h
  +++ b/pathspec.h
  @@ -80,7 +80,7 @@ struct pathspec {
    * For git diff --no-index, indicate that we are operating without
    * a repository or index.
    */
  -#define PATHSPEC_NO_REPOSITORY (1<<7)
  +#define PATHSPEC_NO_REPOSITORY (1 << 7)

   /**
    * Given command line arguments and a prefix, convert the input to

While now I'm tempted to mark the 'check-style' CI job as required. I
think we should do that in the future.

[1]: https://lore.kernel.org/git/xmqqmsa3adpw.fsf@gitster.g/

---
Changes in v2:
- Drop the patch to add 120 column length to editorconfig. This way, we
  will continue to use the default of 80 columns. Adding a higher column
  length makes editorconfig combine smaller lines during block
  formatting. This is not desirable.
- Ensure that meson specifically checks for 'git-clang-format' and not
  just 'clang-format'.
- Link to v1: https://lore.kernel.org/r/20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com

---
 .clang-format         | 27 +++++++++++++++------------
 ci/run-style-check.sh | 18 +-----------------
 meson.build           | 12 ++++++++++++
 3 files changed, 28 insertions(+), 29 deletions(-)

Karthik Nayak (3):
      clang-format: set 'ColumnLimit' to 0
      clang-format: add 'RemoveBracesLLVM' to the main config
      meson: add rule to run 'git clang-format'

Range-diff versus v1:

1:  a62b4b7fe8 < -:  ---------- editorconfig: set maximum line length to 120 characters
2:  4b4d49273e = 1:  5479d22f80 clang-format: set 'ColumnLimit' to 0
3:  b9abb50adf = 2:  dacc7cc2b3 clang-format: add 'RemoveBracesLLVM' to the main config
4:  03cc722f8f ! 3:  b13832ed57 meson: add rule to run 'git clang-format'
    @@ meson.build: if headers_to_check.length() != 0 and compiler.get_argument_syntax(
        alias_target('check-headers', hdr_check)
      endif
      
    -+clang_format = find_program('clang-format', required: false)
    -+if clang_format.found()
    ++git_clang_format = find_program('git-clang-format', required: false)
    ++if git_clang_format.found()
     +  run_target('style',
     +    command: [
     +      'git', 'clang-format',


base-commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
change-id: 20250625-525-make-clang-format-more-robust-968126c991b9

Thanks
- Karthik

