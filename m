Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACA20327
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX0A1GRV"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19191A8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32deb2809daso122784f8f.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697828497; x=1698433297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpCwUgengU3tSUspjtnetYHCUydCeGYhGPXxAVJpU5k=;
        b=PX0A1GRVfm2Bj2VMVvw2l/x0ggGWGYj5z+6Xz8k3xt6JDyJZjC/azv1unMqB+ROFGs
         4J+grKEKIaqkbHiqyds4ZFu2OBwagJJnHc/o05vW9fiTcJp/BNgWBnBKdtG69uOJjA1L
         lYN1Mer4FITQd09P0/LJA7ZVZRb0a+5USBdRDK6uEYmzkZdfcmT8Wv3xZmz8RSPQVkew
         4po7m9QYnPdp3/ZW8XSMK9x/UUokw0iMgDu6YPQjy88YFVaU+W7MHzhutbEgbb+fXbcw
         OE40stYkKxmFuUjG9uMKuebVp5qQd6N1VY6nN5tCqxotdykFke7WEiLSbN0FzlfP0vcJ
         FGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828497; x=1698433297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpCwUgengU3tSUspjtnetYHCUydCeGYhGPXxAVJpU5k=;
        b=tsU+vREkNDhtb8MZfsnyUBSEuZc19+f/xHPzBNDe8PXp5tZJyTz/6v2LOwbPVHHQNh
         44BeXX1wSqewhgH03uPSpzBIm3UEmYdfdcqpVVxJkN5dTsHemI1RrqPdERBIv+TPYPm4
         B6OCVSHERBsotxOtwQV+7Dlh0EWwJSIEK4S3WB7DUjUClTwCobQwXCduJiMO7iWUzwBN
         xGAYYKEAVXYJY5mmRDMZcUWzZLBy/cPyrygmU00TOdtnFJaasbkUOR1BRdiLitGY+Mhp
         BhFfUhLeQKKy4m6ev+nH3e9/wb8C8MTjrmFRO9Lp1v0xkbxCbqkX/jvNyS/rnJZqgDBV
         H8RA==
X-Gm-Message-State: AOJu0Yygq9opfZZRipHnIbxhlvhb0p9+SW733moypVWGLDYEr2U/7KvY
	T4thoX3Q3ec/knppf/Sahkd9lp2XWSA=
X-Google-Smtp-Source: AGHT+IGfxFOmSmxMXpYjE9TTsMZIy7UPgH253Os/yt9NwU9KI1sDULEvgTPvEARxCReqDd0cEEG0IQ==
X-Received: by 2002:a5d:5252:0:b0:32d:806f:d080 with SMTP id k18-20020a5d5252000000b0032d806fd080mr2139701wrc.50.1697828496557;
        Fri, 20 Oct 2023 12:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm2259846wrq.20.2023.10.20.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:01:36 -0700 (PDT)
Message-ID: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Oct 2023 19:01:32 +0000
Subject: [PATCH v5 0/3] Trailer readability cleanups
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
Cc: Glen Choo <glencbz@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Linus Arver <linusa@google.com>

These patches were created while digging into the trailer code to better
understand how it works, in preparation for making the trailer.{c,h} files
as small as possible to make them available as a library for external users.
This series was originally created as part of [1], but are sent here
separately because the changes here are arguably more subjective in nature.

These patches do not add or change any features. Instead, their goal is to
make the code easier to understand for new contributors (like myself), by
making various cleanups and improvements. Ultimately, my hope is that with
such cleanups, we are better positioned to make larger changes (especially
the broader libification effort, as in "Introduce Git Standard Library"
[2]).


Updates in v5
=============

 * Patch 4 ("trailer: only use trailer_block_* variables if trailers were
   found") has been dropped.
 * Patch 2 returns early if "--no-divider" is true, avoiding unnecessary
   loop iterations (thanks Jonathan).
 * Added missing Reported-by trailer for Patch 3 (it was originally Glen's
   idea to use offsets).
 * Patch 3: Fixed typo in "trailer.h" that referred to an obsolete function
   name ("find_true_end_of_input()", instead of
   "find_end_of_log_message()").


Updates in v4
=============

 * The first 3 patches in v3 were merged into 'master'. Necessarily, those 3
   patches have been dropped.
 * Patch 4 in v3 ("trailer: rename *_DEFAULT enums to *_UNSPECIFIED") has
   been dropped, as well as Patch 9 in v3 ("trailer: make stack variable
   names match field names"). These were dropped to simplify this series for
   what I think is the more immediate, important change (see next bullet
   point).
 * Patches 5-8 in v3 are the only ones remaining in this series. They still
   solely deal with --no-divider and trailer block start/end cleanups.


Updates in v3
=============

 * Patches 4 and 6 (--no-divider and trailer block start/end cleanups) have
   been reorganized to Patches 5-8. This ended up touching commit.c in a
   minor way, but otherwise all of the changes here are cleanups and do not
   change any behavior.


Updates in v2
=============

 * Patch 1: Drop the use of a #define. Instead just use an anonymous struct
   named internal.
 * Patch 2: Don't free info out parameter inside parse_trailers(). Instead
   free it from the caller, process_trailers(). Update comment in
   parse_trailers().
 * Patch 3: Reword commit message.
 * Patch 4: Mention be3d654343 (commit: pass --no-divider to
   interpret-trailers, 2023-06-17) in commit message.
 * Added Patch 6 to make trailer_info use offsets for trailer_start and
   trailer_end (thanks to Glen Choo for the suggestion).

[1]
https://lore.kernel.org/git/pull.1564.git.1691210737.gitgitgadget@gmail.com/T/#mb044012670663d8eb7a548924bbcc933bef116de
[2]
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/
[3]
https://lore.kernel.org/git/pull.1149.git.1677143700.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/6b4cb31b17077181a311ca87e82464a1e2ad67dd.1686797630.git.gitgitgadget@gmail.com/
[5]
https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#m0131f9829c35d8e0103ffa88f07d8e0e43dd732c

Linus Arver (3):
  commit: ignore_non_trailer computes number of bytes to ignore
  trailer: find the end of the log message
  trailer: use offsets for trailer_start/trailer_end

 builtin/commit.c |  2 +-
 builtin/merge.c  |  2 +-
 commit.c         |  2 +-
 commit.h         |  4 +--
 sequencer.c      |  2 +-
 trailer.c        | 85 +++++++++++++++++++++++++++++-------------------
 trailer.h        | 10 +++---
 7 files changed, 62 insertions(+), 45 deletions(-)


base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1563%2Flistx%2Ftrailer-libification-prep-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1563/listx/trailer-libification-prep-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1563

Range-diff vs v4:

 1:  4ce5cf77005 = 1:  4ce5cf77005 commit: ignore_non_trailer computes number of bytes to ignore
 2:  c904caba7e1 ! 2:  ce25420db29 trailer: find the end of the log message
     @@ Commit message
          the starting point which find_trailer_start() needs to start searching
          backward to parse individual trailers (if any).
      
     +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ trailer.c: static ssize_t last_line(const char *buf, size_t len)
      +static size_t find_end_of_log_message(const char *input, int no_divider)
       {
      +	size_t end;
     -+
       	const char *s;
       
      -	for (s = str; *s; s = next_line(s)) {
      +	/* Assume the naive end of the input is already what we want. */
      +	end = strlen(input);
      +
     ++	if (no_divider) {
     ++		return end;
     ++	}
     ++
      +	/* Optionally skip over any patch part ("---" line and below). */
      +	for (s = input; *s; s = next_line(s)) {
       		const char *v;
       
      -		if (skip_prefix(s, "---", &v) && isspace(*v))
      -			return s - str;
     -+		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v)) {
     ++		if (skip_prefix(s, "---", &v) && isspace(*v)) {
      +			end = s - input;
      +			break;
      +		}
 3:  796e47c1e5f ! 3:  e3a7b150241 trailer: use offsets for trailer_start/trailer_end
     @@ Commit message
          more explicit about these offsets (that they are for the entire trailer
          block including other trailers). Ditto for trailer_end.
      
     +    Reported-by: Glen Choo <glencbz@gmail.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## sequencer.c ##
     @@ trailer.h: int trailer_set_if_missing(enum trailer_if_missing *item, const char
      -	 * input string.
      +	 * Offsets to the trailer block start and end positions in the input
      +	 * string. If no trailer block is found, these are both set to the
     -+	 * "true" end of the input, per find_true_end_of_input().
     -+	 *
     -+	 * NOTE: This will be changed so that these point to 0 in the next
     -+	 * patch if no trailers are found.
     ++	 * "true" end of the input (find_end_of_log_message()).
       	 */
      -	const char *trailer_start, *trailer_end;
      +	size_t trailer_block_start, trailer_block_end;
 4:  64e1bd4e4be < -:  ----------- trailer: only use trailer_block_* variables if trailers were found

-- 
gitgitgadget
