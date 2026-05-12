Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC933B6CC
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609428; cv=none; b=PltdMlHAbd3kLNHEL0xftm0pSv6TE1kJNTKr1aMXAFDAaYRLeHzyMDghRG4XTHPcuqDb9uiuC2Xh5UcfXJPB+PEac4cVSgg0jxdx7Mj4Rn0JwT8tVIwVeso9FhxG8WcZxD4EVF0exB7+y0q13QuqLQi5x/rEKRZHr9FktDV/3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609428; c=relaxed/simple;
	bh=VyDe1eJe3I4nrxA+ZF2kGWHAQ6Q7lBEbi4X7wmf6a3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lWrmwvFYpPz4jcMVQfGY2UAtIm9MT4/dIqqeye/Q69iqbGTE2QM1b/vHxSoZ4d3siWLs2QQ/XwhzH0bT6EKV7/j+uS7AKodNaJsPTITHn7/brun6Taftoy+iKHJWdBUhAT/FbvzamxIaG3lG8GsAR+TdfUkv4+RtTQGIMCT8K38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMnSvegr; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMnSvegr"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7020a928eso8180752eec.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609425; x=1779214225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TxJS5I68hm4CxfKMSFrh6Z8i/E3yULWof1sDBSkstY=;
        b=kMnSvegrMQdkuGPyemyytBD2NeUk5nvyae5u78tSwr/1pMbKnvU7noNHYkiCOYK+lG
         roUHIpVNylUsaxFUYQf9AOJVBEsH+Hqgy2xdc9QoGjIM6QXrHyv8oQqQGI+9PgE39lG2
         Rmc6r3eMSqsYtKBC85bwr5nLKz04sPdoWO1Vj6vm52DTC6WHXZKFNH/YVEyW6KLnCT02
         VnkIgVqk8u5vDtaTh0kqbPMEENufKrSFVYEij2H/iiKaD/6HEZJrVtqPrF2j3I2VHiDk
         g+V5b8JOTC3z8QbCCZywOzyM3aTEDsMxjsuSqnl2C04TY9bwY1sW5x1jNU/MgNMsJfCR
         xtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609425; x=1779214225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TxJS5I68hm4CxfKMSFrh6Z8i/E3yULWof1sDBSkstY=;
        b=JyG5NC9BfGoLne8t13AdEw1c5PhaUFWxvsOgOW0cJntGrFv/vlYcuci29elQvVX+/C
         Vxov66HLCLMqdjS/djoXpHuXPT+12JKNovkP31TfH3+ZyGV5MDvYpXtJ98zTVqrunNKm
         McHSSrMgIi92cQOqIYdtx101x8PV0euwRYA1FPf6itFQ99spwC7kDPCPpMxjgWgIb3fe
         LzFXj+I3Rbk5iuNhyF5xdVQIqmzJjWOQS0up8opV2ALQon4KIB0QI7Ze/xy8pOQ0M7VQ
         4d4zqlBKpWM7sla9PQ9PZA1facWUdmdGuCMzzeEKfqzKqFEGq+hPPTtmnt5dT3QOiN2m
         iGmg==
X-Gm-Message-State: AOJu0Yzs7yNS/pONTFYC+oAhvfbupcVksc4n2ETQjKPTkAATOlCQp+QM
	tua9nqnvfnAPGN4OPLQVm19nGF7ebgCc9LPK5CQIIDAp5PRIT/+Z6RWcgm3D8g==
X-Gm-Gg: Acq92OEdpz5V4ITtQ4jEsGes3GafOSV0EkWn4Ahqxzd2qmul0wVU1G40JgPQcq/BQMZ
	BxozCnXcDxk+bVdgl5104YDFKESYLpVM6IXK/jirSwAwMAEMYaGgP58cmyczCrER3ZYEWyd/0XS
	uldld2dNzAXYVzks6vuvLS2G9VgpxhKCTZ3kVbfVodBkZ2Z0H9etAogcAPQEKMu5Fdj3iw1yzrm
	jIFr3xwCCt/hKXTt0ZEmn8jlGn0UtSyxDmbI7hbmkMwsIwHoC17mX9zUfGah3Y7HU+qXqaL1fo4
	Qoowml6iuIJQFRhFi2HA6XBcbhKKLxDEewGmqA19344CNzGEX8r2AMNy0XfWH16+bkykm59Hvxb
	1da1724fB0zSGTFerEUBAf9HGJwS5ZMWGgq2ml3CVXcHro90P8GIYFL9RkXzqM3BNeA8UdWbBCQ
	NOfb2mUwoJI9fe63ilQrLvD3h13Yo=
X-Received: by 2002:a05:7301:1698:b0:2d9:5cd9:b8ff with SMTP id 5a478bee46e88-30117b7f066mr98522eec.6.1778609425316;
        Tue, 12 May 2026 11:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm17200816eec.0.2026.05.12.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:10:24 -0700 (PDT)
Message-Id: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 18:10:19 +0000
Subject: [PATCH v2 0/4] diff: reject negative context values
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

Negative values for -U and --inter-hunk-context are silently accepted and
produce structurally invalid diff output.

Malformed hunk headers:

$ wc -l GIT-VERSION-GEN 106 $ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep
'^@@' @@ -503,999- +503,999- @@

Line 503 of a 106-line file, count "999-" is not a valid integer.

Overlapping hunks that cannot be applied:

$ git log -1 -p -U3 --inter-hunk-context=100 791aeddfa2
-- git-compat-util.h | git apply --check --reverse (success)

$ git log -1 -p -U3 --inter-hunk-context=-100 791aeddfa2
-- git-compat-util.h | git apply --check --reverse error: patch failed:
git-compat-util.h:118 error: git-compat-util.h: patch does not apply

Both options were originally parsed via opt_arg() which gated on isdigit(),
making negative values impossible. When they were converted to OPT_INTEGER_F
/ OPT_CALLBACK in d473e2e0e8 (diff.c: convert -U|--unified, 2019-01-27) and
16ed6c97cc (diff-parseopt: convert --inter-hunk-context, 2019-03-24), the
implicit rejection was lost.

This series restores the original invariant with stronger guarantees:

1/4 diff: reject negative values for --inter-hunk-context Change type to
unsigned int, switch to OPT_UNSIGNED.

2/4 diff: reject negative values for -U/--unified Change type to unsigned
int, add range check in callback.

3/4 xdiff: guard against negative context lengths BUG() in xdl_get_hunk() as
defense in depth.

4/4 parse-options: clarify what "negated" means for PARSE_OPT_NONEG.

The config variables diff.context and diff.interHunkContext have always
rejected negative values. This series brings the CLI options in line.

Changes since v1:

Patch 1 and 4: Rewrote commit message to not imply NONEG was related to the
bug.

Patch 4: Trimmed to just clarify what "negated" means, without documenting
what PARSE_OPT_NONEG does not do.

Michael Montalbo (4):
  diff: reject negative values for --inter-hunk-context
  diff: reject negative values for -U/--unified
  xdiff: guard against negative context lengths
  parse-options: clarify what "negated" means for PARSE_OPT_NONEG

 diff.c                             | 25 ++++++++++++++-----------
 diff.h                             |  4 ++--
 parse-options.h                    |  1 +
 t/t4032-diff-inter-hunk-context.sh |  6 ++++++
 t/t4055-diff-context.sh            |  5 +++++
 xdiff/xemit.c                      | 16 ++++++++++++----
 6 files changed, 40 insertions(+), 17 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2105%2Fmmontalbo%2Fmm%2Freject-negative-interhunk-context-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2105/mmontalbo/mm/reject-negative-interhunk-context-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2105

Range-diff vs v1:

 1:  cca75eca0e ! 1:  f2ebb3a72b diff: reject negative values for --inter-hunk-context
     @@ Commit message
          starts at 116 (overlaps both). The resulting patch cannot be applied.
      
          The config variable diff.interHunkContext already rejects negative
     -    values, but the command line option does not. The option currently
     -    uses OPT_INTEGER_F with PARSE_OPT_NONEG, but PARSE_OPT_NONEG only
     -    prevents the "--no-inter-hunk-context" boolean negation form. It does
     -    not reject negative numeric arguments like "--inter-hunk-context=-1".
     +    values, but the command line option does not.
      
          Change the type of diff_options.interhunkcontext and its static
          default from int to unsigned int, and switch the option parser from
 2:  f0478d434c = 2:  fc3d2bc31e diff: reject negative values for -U/--unified
 3:  f9cfa0c55d = 3:  020ca774c0 xdiff: guard against negative context lengths
 4:  05ff821e6f ! 4:  3a656f8c0f parse-options: clarify PARSE_OPT_NONEG does not reject negative numbers
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    parse-options: clarify PARSE_OPT_NONEG does not reject negative numbers
     +    parse-options: clarify what "negated" means for PARSE_OPT_NONEG
      
     -    The name "NONEG" can be misread as "no negative [values]" when it
     -    actually means "no [boolean] negation" (the --no-* form).
     -
     -    When --inter-hunk-context and -U/--unified were converted from a
     -    custom parser to OPT_INTEGER_F with PARSE_OPT_NONEG in d473e2e0e8
     -    and 16ed6c97cc, the implicit rejection of negative values (via
     -    isdigit() in the old opt_arg() parser) was silently lost. The
     -    previous commits in this series fix the resulting bugs.
     -
     -    Add a clarifying note to the flag documentation.
     +    The documentation says the flag prevents an option from being
     +    "negated" without specifying what that means. Add a parenthetical
     +    to clarify that it rejects the "--no-<option>" form.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## parse-options.h ##
      @@ parse-options.h: typedef int parse_opt_subcommand_fn(int argc, const char **argv,
     -  *   mask of parse_opt_option_flags.
        *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
        *   PARSE_OPT_NOARG: says that this option does not take an argument
     -- *   PARSE_OPT_NONEG: says that this option cannot be negated
     -+ *   PARSE_OPT_NONEG: says that this option cannot be negated (i.e.
     -+ *                   prevents --no-<option> boolean form). Does not reject
     -+ *                   negative numeric values like --option=-1. Use
     -+ *                   OPT_UNSIGNED for options that must be non-negative.
     +  *   PARSE_OPT_NONEG: says that this option cannot be negated
     ++ *                   (i.e. rejects "--no-<option>")
        *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
        *                     shown only in the full usage.
        *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default

-- 
gitgitgadget
