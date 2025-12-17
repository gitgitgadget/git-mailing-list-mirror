Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3233B6F8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981428; cv=none; b=s2yUhueVa/s6D4vmvnPbegn+oHXLBm0qZTIlK9n+kITN/yxwXLbW1llkCf+Bta2im5sOWxLlvZCMYinPJi0Rrck5w/f1BSL0COeAmYgibvJ7O1vDUz/Ar6o1Eri5VVC09yb4YXd+KhnzyZ7EhE438DlUkeiPgNOtpvewut7dxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981428; c=relaxed/simple;
	bh=6PzTJmj6A6lo1jIYMQE4WYAbI+pjt7UTAzZW9D5fAsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cZWgVVWQW0Gx/ceqXA64BSpoYoSryqBHOUMtKaqmZRmw1Yu/Gs0medqfiIzveyjFRKat3V6bIA8yjibCHjH+3NMV6UhYVWz6PWeaZhL4jqm491UoPxK9qxep69GnAWW3R7c+WSr0lYP05p6mArsRsMwrXyaMrM+nMYSaBEETgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDEr+Uyo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDEr+Uyo"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2ec756de0so638241185a.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981425; x=1766586225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N34ipN4nQbRD6osBR9wR6a8278ZIWq1elVsx5wO03cc=;
        b=IDEr+Uyotmnt8JCD1SxGOVAyxiqdLSD49xJFod+pAvz2XaC5KryQeAq6uEPLuWUN+3
         k2OHTopJEQMeY+LwGi1d6VBNtmLu/gi1z9OIkzjPa0+7GPX0qJoU8nRNT3Ibr/pZSF9B
         IdjJQ0XwzCCSKZzFe6lH9XNgf1+ovlkrZ+2HYWtLFHyNa/J1ZjXBnkPSgwfS5MjB6734
         yvgx/VqZChWuwdT0mGFBtVLRaK3YONsOOjdKMm/GHTDKdOh636q5Dt3Clnzn8mY+5OWo
         2hDLXuTWMIXQLf0fhskzGo5px1P6tN+PwvYi9W0S/ArZqTMD6EPCgGhH9YAJJbqTBWT5
         ILmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981425; x=1766586225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N34ipN4nQbRD6osBR9wR6a8278ZIWq1elVsx5wO03cc=;
        b=Q009+fzTGWMeRNb7lurxMgJXmOxLgWI3MnLjh03jATEye64TauI23yIYrZe7aa5lOy
         kWe+Py8z4MKm2Gu0xxrPCN8/BpSEvI4wOyISwnzi4S8zCZeBuaasWrlXBbf0jkOHdjI1
         4ja1uvYY5XDP9DTZNhVJPZAXwQpjTFifPkng6MU3IexCMENPmt6MXS9I/k7J9NKpsMA4
         1UtKalNMo15aLEkGtGQBNH8J1LB7PZ2G2k4D0ZUar5atz+ojdJhuVqsVQ1qzO+2KUuEH
         94gceiC3+sjmbLg/r8KefrUc7kgpWYmodx7FxuY6P8lo1gA6bh6Pg4lYkaRKWR8391Ii
         ZJ3A==
X-Gm-Message-State: AOJu0Yx9+Z3caLI9jEVec4dC8HcCQv3QBr2VO4B5oyN7lz2qLMPzETVR
	cw/LhCu8BfXHcayQ+9nLeWv8M3mo7GkOOpMHivnKmTDKC0rhmNWJbuL9Lys9LzcSnKQ=
X-Gm-Gg: AY/fxX6uv2wguJPw36JxC8eMUMR/FUjnOJwVZiIVJ6bct/cpRLUMNlH+H4Gefx13enU
	RtWLAhs/f2q9SM6XUC8QLuv6YfNyHZnLxG4na/9i4/EoS2eqaOdCa1AO3qtubpacvB7jdiZGjkd
	R4s/8uY1BfuNgUViIMqUP5XWIvf1dGOLWS/J87clNd4ShwlWKt6gNoovkft7cgpEszKn2H+pQvh
	kAWLec/HAnXmPm+AAr8vHGXzjGE577XM8LQjZS+rHUm3rFc/PBmE+M49ZuRZ4uOdwhSlP2ST2WC
	1acnTAcgyW1rM3ZNbN/Ta2H5DGusN0khTg+34wyTPXzCBAH9khe8qM2TsDVaWfQH3/XC2s/OyqG
	LASN3IkYBfq998VPIP/ygFIRHe9yZk6ef6P2sk3j+z0mqefJLC9F3PA1L4lH8IsdBVC7COtPzxJ
	uyskE38X4F2hxxWQ==
X-Google-Smtp-Source: AGHT+IFLT2M9de8yplorWDK1d8QputKIzEcditeqfX2F5JAF748DEB7GLRElKHxX0/yMjb4FrnvyOw==
X-Received: by 2002:a05:620a:40ca:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8bb399d8ee4mr2579733085a.5.1765981424815;
        Wed, 17 Dec 2025 06:23:44 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b676besm419678085a.45.2025.12.17.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:23:43 -0800 (PST)
Message-Id: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:23:38 +0000
Subject: [PATCH v2 0/4] Sanitize sideband channel messages
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git's sideband channel passes server output directly to the client terminal
without sanitization. This includes progress messages, error output, and
diagnostics from remote hooks during clone, fetch, and push operations.

This creates an ANSI escape sequence injection vulnerability (CWE-150
[https://cwe.mitre.org/data/definitions/150.html]). A malicious or
compromised server can corrupt terminal state, obscure information, or
inject characters into the terminal's input buffer. The client has no
mechanism to distinguish between legitimate output and attack sequences.

This series fixes the vulnerability by sanitizing control characters in the
sideband output. ANSI color sequences (SGR codes) pass through by default,
since server-side hooks exist that use these for visibility (e.g.
https://github.com/kikeonline/githook-explode). By default, all other
control characters are rendered in caret notation (e.g., ESC becomes ^[).

Users who need different behavior get configuration options:
sideband.allowControlCharacters provides an escape hatch for environments
that require raw passthrough. The defaults are secure.

Note: This series applies cleanly on v2.47.3.

Changes since v1:

 * Applied the suggestions by Phillip and brian.
 * Rebased onto v2.47.3.
 * Added more categories of ANSI Escape sequences that can be enabled (but
   that are off by default because they could be used to hide information).

Johannes Schindelin (4):
  sideband: mask control characters
  sideband: introduce an "escape hatch" to allow control characters
  sideband: do allow ANSI color sequences by default
  sideband: add options to allow more control sequences to be passed
    through

 Documentation/config.txt            |   2 +
 Documentation/config/sideband.txt   |  24 +++++
 sideband.c                          | 148 +++++++++++++++++++++++++++-
 t/t5409-colorize-remote-messages.sh |  68 +++++++++++++
 4 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/sideband.txt


base-commit: a52a24e03c8c711f1d5e252fba78f9276908129b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsanitize-sideband-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1853/dscho/sanitize-sideband-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1853

Range-diff vs v1:

 1:  f7fb7a3833 ! 1:  8d70476559 sideband: mask control characters
     @@ Commit message
          There is likely a need for more fine-grained controls instead of using a
          "heavy hammer" like this, which will be introduced subsequently.
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## sideband.c ##
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
      +			strbuf_addch(dest, *src);
      +		else {
      +			strbuf_addch(dest, '^');
     -+			strbuf_addch(dest, 0x40 + *src);
     ++			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
      +		}
      +	}
      +}
     @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'fallback to color.ui'
      +	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
      +	exec "$@"
      +	EOF
     -+	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
     ++	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
      +	test_commit need-at-least-one-commit &&
      +	git clone --no-local . throw-away 2>stderr &&
      +	test_decode_color <stderr >decoded &&
 2:  14c612c69a ! 2:  2615abd8c5 sideband: introduce an "escape hatch" to allow control characters
     @@ Commit message
          To help with those use cases, give users a way to opt-out of the
          protections: `sideband.allowControlCharacters`.
      
     +    Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/config.txt ##
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
       ## t/t5409-colorize-remote-messages.sh ##
      @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'disallow (color) control sequences in sideband' '
       	EOF
     - 	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
     + 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
       	test_commit need-at-least-one-commit &&
      +
       	git clone --no-local . throw-away 2>stderr &&
 3:  a26c4ed6ce ! 3:  44585ba1f4 sideband: do allow ANSI color sequences by default
     @@ Commit message
          to the terminal, and `sideband.allowControlCharacters` to override that
          behavior.
      
     -    However, some `pre-receive` hooks that are actively used in practice
     -    want to color their messages and therefore rely on the fact that Git
     -    passes them through to the terminal.
     +    However, as reported by brian m. carlson, some `pre-receive` hooks that
     +    are actively used in practice want to color their messages and therefore
     +    rely on the fact that Git passes them through to the terminal, even
     +    though they have no way to determine whether the receiving side can
     +    actually handle Escape sequences (think e.g. about the practice
     +    recommended by Git that third-party applications wishing to use Git
     +    functionality parse the output of Git commands).
      
          In contrast to other ANSI escape sequences, it is highly unlikely that
          coloring sequences can be essential tools in attack vectors that mislead
          Git users e.g. by hiding crucial information.
      
          Therefore we can have both: Continue to allow ANSI coloring sequences to
     -    be passed to the terminal, and neutralize all other ANSI escape
     -    sequences.
     +    be passed to the terminal by default, and neutralize all other ANSI
     +    Escape sequences.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ Documentation/config/sideband.txt
      +	this config setting to override this behavior:
      ++
      +--
     ++	default::
      +	color::
      +		Allow ANSI color sequences, line feeds and horizontal tabs,
      +		but mask all other control characters. This is the default.
     @@ sideband.c: static struct keyword_entry keywords[] = {
      -static int allow_control_characters;
      +static enum {
      +	ALLOW_NO_CONTROL_CHARACTERS = 0,
     -+	ALLOW_ALL_CONTROL_CHARACTERS = 1,
     -+	ALLOW_ANSI_COLOR_SEQUENCES = 2
     ++	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
     ++	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
     ++	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
      +} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
       
       /* Returns a color setting (GIT_COLOR_NEVER, etc). */
     @@ sideband.c: static int use_sideband_colors(void)
      +		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
      +					      &value))
      +			; /* huh? `get_maybe_bool()` returned -1 */
     ++		else if (!strcmp(value, "default"))
     ++			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
      +		else if (!strcmp(value, "color"))
      +			allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
      +		else
     @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
      +	 * Valid ANSI color sequences are of the form
      +	 *
      +	 * ESC [ [<n> [; <n>]*] m
     ++	 *
     ++	 * These are part of the Select Graphic Rendition sequences which
     ++	 * contain more than just color sequences, for more details see
     ++	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
      +	 */
      +
      +	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
     @@ sideband.c: static void strbuf_add_sanitized(struct strbuf *dest, const char *sr
      +			n -= i;
      +		} else {
       			strbuf_addch(dest, '^');
     - 			strbuf_addch(dest, 0x40 + *src);
     + 			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
       		}
      
       ## t/t5409-colorize-remote-messages.sh ##
     @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'fallback to color.ui'
      +	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
       	exec "$@"
       	EOF
     - 	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
     + 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
      @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'disallow (color) control sequences in sideband' '
       
       	git clone --no-local . throw-away 2>stderr &&
 -:  ---------- > 4:  fe109cd331 sideband: add options to allow more control sequences to be passed through

-- 
gitgitgadget
