Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617478;
	b=hWQizvUlyYcRv7yTjbbNY7xb2LEKAAZDVBrbx6YgbuwhD8PGfgvV0YhcXUV/qzsgQowm
	 HJfcoDwYf0C7+GdGSkL5Fgl4AtyPxocopUxwT5OimERszXSjmP/6jfgyNntLVqN/CfN+H
	 xiu+q+MCtBigEZRFvIYw/k1qIphqQ6LzUTUKH0iInIcY8vcfkF9pMUEFwFfEtSS2Z1ye3
	 Kl9wrLIql4WWL9i90xeJfblZc2BEBoMaE01N/NI9XaUkU+fQ14mJjKI6C2On3/5lyhdgF
	 0jXNRCKfM2QrUs63dHVCfMCPHY3xKk8eM4Yr0D0ljJs+VT6M/bgM8dvMe8nkdDbhclg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wWzW6MYlKcTbOnj8GC4hVTG8TEOemy/ifvkTa4qXcB0=;
	b=4R069X/kc2aUKScTo0sgQhf8KAF2WbzBiPkYWRvXBNjTdPeXElvdxj8+Ra3UmhznERte
	 wlvkKb6RxpMjMwLpkk/Q4LimG5NJ3c0nzY20XV8CB7y2S0KYaefLWfMed5iOToDMQQGxM
	 KuEpdNruF3QFELlpE6QqOV29+RB0YnDPmRTxT4TXnsMcC2LEVhzSCffHVtNkPCCOnI5uX
	 ebKs4eQ2lxfK2tuftCeiY5Qvb9y9DQFaVZHJN3UF4J6TCJQTOSPIellXFz8d6oUHgXT5M
	 ob4QqqCGKqviZKqEGPiv0V/n1ic5ezF2rR2lpcMbKJsLFd/itUBMS7v7iuftdps2g/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoIF7TKd;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2E606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B2E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YoIF7TKd
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so52147215e9.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795617476; x=1796222276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wWzW6MYlKcTbOnj8GC4hVTG8TEOemy/ifvkTa4qXcB0=;
        b=YoIF7TKdh3MzWKcNfQq0SiA41thaDhlp3teb2ruM3DXKFCBfsolsLIY+N0j2f4ac9G
         AsmU3xM4H6uv7zKTfci+xhjgtfyDp1v6fAVh9hd3H95gkv6+dNqXN2gPZrSwRYxKYUeu
         Yy4u+ctyviwDeVywz9RywwNkPWW7Ae2LcmuMwskIKydgtkRfK+gDSnCejhMh5k8OXHW5
         zcn+BM25Xp8XUTpy2gRMbVU0oGMQsO8PBJJLTmseVVNAmmuzNcnrZcqztTaJ41IJXeaY
         YTGdNggHQveryHqRC/oii+Cm4n0Lfg10A/fATDwolW9mRgy86Pa52TXH9/Scuhh3sPs6
         fx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617476; x=1796222276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWzW6MYlKcTbOnj8GC4hVTG8TEOemy/ifvkTa4qXcB0=;
        b=OXH3D2MuoutZCcI7mR6rkrdhUDbfNbDIQKDQJJDFqljJJcdnguwZkKJIvQukLzq2kd
         CPy/Ut+y5IROaVFTZSCeXrIPz+sfOl98smuRHLQHLrLR5yIvKmKvlLWLAgzUZF7UQ8fG
         UhhLg4uK2freRvF2bY2bRqPxH4CgvszBdPCCYClu2eAR07jL7V1J9md0BZmEmSuI6muD
         pK0Sjj0e/JVBsu6ibLpAMc/o1ZpRXBc+kKKuMv0+X/kUZ8bNmQ7CJnazdZmx1rXV2M8i
         +NAffJeMhx5ozuVvqKiIR356I2ov3G4EKCibvJn5XaPC7RPe587OptlgvhBGsRZGmux0
         6mGA==
X-Forwarded-Encrypted: i=1; AL+hErFH0ZpqDVr18OxliJXbaj14xmdI5nJO4+L6FGsS44413KTdkOZWrRzOMWcru5SOathCUkY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BKYHsj7kZZv9ynNA3dh7cGeQ9+lIt1s61VxByAHC4cOpEKwfx
	TpHV8F2zxCaAgVTyCnLKNwDEUgTaE6i+i8j4M088DqHrEJ1jeGyQhec/
X-Gm-Gg: AZFdTZd/5VxZ1CNSi9fOBPK6Yo9lc4oIPML1wqcITt9k4e7r/6g4qmYOBhGbWA1eUko
	dURoo74PD0F8K8LVQuH1eTjMaoL/2SlvJagbvWvwgbrwSiuIuTiRJdq6kXUtciwkGn5d1XJW7bN
	t7J6A+YSLgT5tl8Xiwlz3fnZf3Q+6/Co14cbtbb0MFpPN9YVWg66P4wmOPRkLEpkg1fS7AgDYFw
	1lSALbtCvaZufL/vrpNe95mLX515zl0WnbzgeJ4PMD3ZFHevQ4Z2jp/euc7kdGlbI+Bh8rWuxDq
	Q/VoHUmQ689adKLOI1sYyYU48Mex24RiDQxN1m5YPz9UVjWkjKcGLzp0dsuDZ2e4zjooEicuPv4
	ZOzLAn7PxOGvNF+ydUzEmmmpdqm0F1t2dPCq240AbaJfJyznhUowu/JE+hIBIAjpxdCPrJoaonz
	CzvFGPvpkuP/ExRR6cWWkEqGjAAa0iKC6oLAKhf1ZQHNPI9SxZ/rxDv23cqeub5nmpmA+CMa2VY
	QEa63wxPTcatq1wintS9LYN/YkeIts8JHUN9UdUuMO0Go2jcouz3J6KZU1Q50QavvJwHcyXvuQn
	2pDVaZB2ObbVxqmzY40w3Flfrnvu+i4Ir6TZC1YdE3xmnLVGDRo8UdSHkeYVRr91lh+ZBVgnKfk
	MzVt9ufA=
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb8881a2bbmr333037335e9.17.1795617475930;
        Wed, 25 Nov 2026 06:37:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm39640762f8f.24.2026.11.25.06.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:37:55 -0800 (PST)
Message-ID: <bfb8aad3-7cab-4394-a16c-be743562eced@gmail.com>
Date: Wed, 25 Nov 2026 14:37:54 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] commit: allow -m/-F/-c/-C for all --fixup variants
To: Erik Cervin-Edin <erik@cervined.in>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <cover.1790082176.git.erik@cervined.in>
 <cover.1795562078.git.erik@cervined.in>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover.1795562078.git.erik@cervined.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

On 24/11/2026 23:32, Erik Cervin-Edin wrote:
> Changes since v3:
> 
>    * New 1/3 refactors prepare_to_commit() to write the --fixup subject
>      in a block before the message-source chain, as --squash already
>      does.  On v3 1/2 Phillip found it unfortunate that the -m and -F
>      arms had to be guarded with "!fixup_message" while the fixup arm
>      duplicated their work [1] and I agree.
> 
>      Originally, I wanted to avoid a refactor -- but the guards were
>      getting nasty, and a refactor is the proper fix.  It turned out not
>      to be that difficult and I think it makes the series land cleaner.
> 
>      With the subject written up front, the -m and -F arms serve every
>      --fixup variant unchanged, and the fixup arm is left with only the
>      amend case.

This change looks good and makes the second patch much nicer. I'm happy 
with everything apart from

     Plain --fixup never opens an editor, so -c there behaves like -C.

in patch 3. It would be much nicer if we didn't change the meaning of 
"-c" when it is combined with "--fixup". Users who do not want to edit 
the message can use "-C". I've not looked at how easy it would be to fix 
that. If it turns out to be tricky then I'm happy to merge this as is 
and leave it as #leftoverbits.

Thanks

Phillip


>    * 2/3 and 3/3 are rebuilt on top of 1/3, which now carries most of
>      the change to builtin/commit.c.
> 
>    * 3/3 tests: took Phillip's suggestions [2].
> 
>    * Log messages: reworded 2/3's history of why these options were
>      rejected; 3/3 now gives its motivation, with a use case, and
>      explains the "amend!" handling that the v3 cover letter described.
> 
> Background
> ----------
> 
> Today only -m works with plain --fixup, and neither -m nor -F works
> with --fixup=amend: or --fixup=reword:, which makes those modes
> awkward to drive non-interactively.  2/3 lets -m and -F supply the
> message for all --fixup variants.  3/3 does the same for -c/-C, so
> that all four message sources behave consistently across the plain,
> amend, and reword forms.
> 
> As in v3, -c/-C go through prepare_amend_commit(), so if the source
> commit is itself an "amend!" commit, its subject line is dropped and
> only the body is copied.  This is what a no-source
> --fixup=amend:<commit> already does.  The helper only knows about
> "amend!" and not "fixup!" or "squash!"; that is pre-existing and I
> have left it alone here.
> 
> The earlier rounds are described in the v2 [3] and v3 [4] cover
> letters.
> 
> [1] https://lore.kernel.org/git/3354eeb4-3b9d-474e-bf9f-8efd2ca3a512@gmail.com/
> [2] https://lore.kernel.org/git/de12af28-a64e-4472-8bd4-b65200772dbe@gmail.com/
> [3] https://lore.kernel.org/git/cover.1779792311.git.erik@cervined.in/
> [4] https://lore.kernel.org/git/cover.1790082176.git.erik@cervined.in/
> 
> Erik Cervin-Edin (3):
>    commit: write the --fixup subject the way --squash does
>    commit: allow -m/-F for all --fixup variants
>    commit: allow -c/-C for all --fixup variants
> 
>   Documentation/git-commit.adoc             |  22 +++--
>   builtin/commit.c                          |  61 ++++++------
>   t/t7500-commit-template-squash-signoff.sh | 114 +++++++++++++++++++---
>   3 files changed, 138 insertions(+), 59 deletions(-)
> 
> Range-diff against v3:
> -:  ---------- > 1:  ebae1fbe05 commit: write the --fixup subject the way --squash does
> 1:  4a493867bb ! 2:  051b659965 commit: allow -m/-F for all kinds of --fixup
>      @@ Metadata
>       Author: Erik Cervin-Edin <erik@cervined.in>
>       
>        ## Commit message ##
>      -    commit: allow -m/-F for all kinds of --fixup
>      +    commit: allow -m/-F for all --fixup variants
>       
>           The ability to provide a commit message for git commit --fixup and its
>      -    variations is limited:
>      +    variants is limited:
>       
>      -      * Plain --fixup only allows using the -m flag
>      +      * Plain --fixup accepts -m but not -F
>       
>      -      * The amend/reword --fixup variants only allow supplying the message
>      -        using an editor
>      +      * The amend/reword variants accept a message only through an editor
>      +        (or a GIT_EDITOR script standing in for one)
>       
>      -    For amend/reword, the -m and -F flags are rejected: -m is caught by a
>      -    die() in prepare_to_commit(), and -F is caught by
>      -    die_for_incompatible_opt4() which groups -F with --fixup as mutually
>      -    exclusive.  This makes these modes poorly suited for non-interactive
>      +    This makes the amend/reword variants poorly suited for non-interactive
>           workflows -- notably when using AI coding agents.
>       
>      -    When support to use the -m option was introduced in [1] it was noted
>      -    that there could be support for other options but at the time the use
>      -    case was deemed too niche.  Later, when the amend suboption was
>      -    introduced in [2] -m support for amend fixups was discussed but not
>      -    pursued, and -F was already caught by the higher-layer incompatibility
>      -    check grouping it with --fixup.
>      +    When --fixup learned to take -m [1], it was noted that other options
>      +    (-c/-C/-F) could also be supported, but were left out for lack of a
>      +    clear use case.  Later, when the amend suboption was introduced in [2],
>      +    -m was initially supported for amend fixups too, but was dropped for the
>      +    same reason [3].
>       
>      -    The rejections of these options hark back to when --fixup was
>      -    introduced in [3] and as noted in [1] -- there's nothing inherently
>      -    preventing support for them.  The current patchwork of which flags
>      -    work with which --fixup variants has no strong logic to it, and
>      -    allowing all of them simplifies both the code and the interface.
>      +    The rejections of these options hark back to when --fixup was introduced
>      +    in [4], but as [1] noted, nothing inherently prevents supporting them.
>       
>      -    Allow -m and -F to supply the message body for all --fixup variations,
>      -    mirroring the flow of a regular commit.  -c and -C, which are blocked
>      -    by the same incompatibility check, are handled in the next commit.
>      +    The current patchwork of which options work with which --fixup variants
>      +    has no strong logic to it, and allowing all of them simplifies the
>      +    interface.
>      +
>      +    Allow -m and -F to supply the message body for all --fixup variants,
>      +    mirroring the flow of a regular commit.  With --fixup=amend/reword the
>      +    given message replaces the one that would otherwise be copied from the
>      +    target commit.  Options -c and -C are handled in the next commit.
>       
>           1. 30884c9afc (commit: add support for --fixup <commit> -m"<extra
>              message>", 2017-12-22)
>      @@ Commit message
>           2. 494d314a05 (commit: add amend suboption to --fixup to create amend!
>              commit, 2021-03-15)
>       
>      -    3. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
>      +    3. https://lore.kernel.org/git/xmqqft1o80pe.fsf@gitster.g/
>      +
>      +    4. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
>              2010-11-02)
>       
>           Helped-by: Junio C Hamano <gitster@pobox.com>
>      -    Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>      +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>           Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
>       
>        ## Documentation/git-commit.adoc ##
>      @@ Documentation/git-commit.adoc: include::diff-context-options.adoc[]
>       
>        ## builtin/commit.c ##
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
>      - 	if (have_option_m && !fixup_message) {
>      - 		strbuf_addbuf(&sb, &message);
>      - 		hook_arg1 = "message";
>      --	} else if (logfile && !strcmp(logfile, "-")) {
>      -+	} else if (logfile && !fixup_message && !strcmp(logfile, "-")) {
>      - 		if (isatty(0))
>      - 			fprintf(stderr, _("(reading log message from standard input)\n"));
>      - 		if (strbuf_read(&sb, 0, 0) < 0)
>      - 			die_errno(_("could not read log from standard input"));
>      - 		hook_arg1 = "message";
>      --	} else if (logfile) {
>      -+	} else if (logfile && !fixup_message) {
>      - 		if (strbuf_read_file(&sb, logfile, 0) < 0)
>      - 			die_errno(_("could not read log file '%s'"),
>      - 				  logfile);
>      - 		hook_arg1 = "message";
>      --	} else if (use_message) {
>      -+	} else if (use_message && !fixup_message) {
>      - 		const char *buffer;
>      - 		buffer = strstr(use_message_buffer, "\n\n");
>      - 		if (buffer)
>      -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
>      - 		hook_arg1 = "message";
>      -
>      + 		repo_format_commit_message(the_repository, c, fmt, &sb,
>      + 					   &ctx);
>      + 		free(fmt);
>      +-		if (have_option_m && !strcmp(fixup_prefix, "amend"))
>      +-			die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
>      + 	} else if (squash_message) {
>        		/*
>      --		 * Only `-m` commit message option is checked here, as
>      --		 * it supports `--fixup` to append the commit message.
>      --		 *
>      --		 * The other commit message options `-c`/`-C`/`-F` are
>      --		 * incompatible with all the forms of `--fixup` and
>      --		 * have already errored out while parsing the `git commit`
>      --		 * options.
>      -+		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
>      -+		 * incompatible with --fixup and have already errored out
>      -+		 * during option parsing.
>      - 		 */
>      --		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
>      -+		if (have_option_m) {
>      - 			strbuf_addbuf(&sb, &message);
>      --
>      --		if (!strcmp(fixup_prefix, "amend")) {
>      --			if (have_option_m)
>      --				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
>      -+		} else if (logfile && !strcmp(logfile, "-")) {
>      -+			if (isatty(0))
>      -+				fprintf(stderr, _("(reading log message from standard input)\n"));
>      -+			if (strbuf_read(&sb, 0, 0) < 0)
>      -+				die_errno(_("could not read log from standard input"));
>      -+		} else if (logfile) {
>      -+			if (strbuf_read_file(&sb, logfile, 0) < 0)
>      -+				die_errno(_("could not read log file '%s'"), logfile);
>      -+		} else if (!strcmp(fixup_prefix, "amend")) {
>      - 			prepare_amend_commit(commit, &sb, &ctx);
>      - 		}
>      - 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
>      + 		 * Insert the proper subject line before other commit
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>        	}
>        	if (fixup_message && squash_message)
> 2:  13608615d6 ! 3:  159a56c510 commit: allow -c/-C for all kinds of --fixup
>      @@ Metadata
>       Author: Erik Cervin-Edin <erik@cervined.in>
>       
>        ## Commit message ##
>      -    commit: allow -c/-C for all kinds of --fixup
>      +    commit: allow -c/-C for all --fixup variants
>       
>           The fixup code path in prepare_to_commit() only knows how to take a
>           message body from -m or -F.  Now that the previous commit allows -m and
>      -    -F for all --fixup variations, -c/-C are the odd ones out.
>      +    -F for all --fixup variants, -c/-C are the odd ones out.
>       
>      -    Teach the fixup path to look up the ref given to -c/-C and seed its
>      -    message when preparing to amend the commit, mirroring what --fixup=amend
>      -    does when no message source is given.  With this in place, -m/-F/-c/-C
>      -    all behave consistently across the plain, amend, and reword --fixup
>      -    forms.
>      +    Teach the fixup path to take the message body from the commit given to
>      +    -c/-C, using prepare_amend_commit() as --fixup=amend does when no
>      +    message source is given.
>      +
>      +    The main motivation is consistency: with -c/-C allowed, every message
>      +    option works with every --fixup variant, and there's no exception to
>      +    document or remember.  Using -c/-C under --fixup is admittedly niche,
>      +    but not useless; for example, rewording commit Y based on X's message
>      +    after an earlier rebase split X into X' and Y, when Y wasn't reworded at
>      +    the time:
>      +
>      +        git commit --fixup=reword:Y -c X
>      +
>      +    Like --fixup=amend, this copies only the body when the source itself is
>      +    an "amend!" commit.  Under --fixup the subject is always generated, and
>      +    the body of an "amend!" commit is the message intended for its target,
>      +    so copying its "amend!" line would leave it in the final message after
>      +    autosquash.  This also means that "git commit --fixup=amend:X -C X"
>      +    produces the same message as "GIT_EDITOR=: git commit --fixup=amend:X".
>      +
>      +    Plain --fixup never opens an editor, so -c there behaves like -C.
>       
>           The incompatibility check grouping -C, -c, and --fixup can go away
>           entirely, as -C and -c are already rejected together by the check that
>      @@ Documentation/git-commit.adoc: The commit created by `--fixup=amend:<commit>` is
>       
>        ## builtin/commit.c ##
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
>      + 			die_errno(_("could not read log file '%s'"),
>      + 				  logfile);
>        		hook_arg1 = "message";
>      -
>      - 		/*
>      --		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
>      --		 * incompatible with --fixup and have already errored out
>      --		 * during option parsing.
>      -+		 * `-m`, `-F`, `-C`, and `-c` provide the message body.
>      -+		 * If none was given and this is an amend, use the target
>      -+		 * commit's body instead.
>      - 		 */
>      - 		if (have_option_m) {
>      - 			strbuf_addbuf(&sb, &message);
>      +-	} else if (use_message) {
>      ++	} else if (use_message && !fixup_message) {
>      + 		const char *buffer;
>      + 		buffer = strstr(use_message_buffer, "\n\n");
>      + 		if (buffer)
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
>      - 		} else if (logfile) {
>      - 			if (strbuf_read_file(&sb, logfile, 0) < 0)
>      - 				die_errno(_("could not read log file '%s'"), logfile);
>      -+		} else if (use_message) {
>      -+			struct commit *c = lookup_commit_reference_by_name(use_message);
>      -+			if (!c)
>      -+				die(_("could not lookup commit '%s'"), use_message);
>      -+			prepare_amend_commit(c, &sb, &ctx);
>      - 		} else if (!strcmp(fixup_prefix, "amend")) {
>      - 			prepare_amend_commit(commit, &sb, &ctx);
>      + 		hook_arg1 = "commit";
>      + 		hook_arg2 = use_message;
>      + 	} else if (fixup_message) {
>      ++		const char *refname = NULL;
>      ++
>      + 		hook_arg1 = "message";
>      +-		if (!strcmp(fixup_prefix, "amend")) {
>      ++		if (use_message)
>      ++			refname = use_message;
>      ++		else if (!strcmp(fixup_prefix, "amend"))
>      ++			refname = fixup_commit;
>      ++
>      ++		if (refname) {
>      + 			struct pretty_print_context ctx = {0};
>      +-			struct commit *c = lookup_commit_reference_by_name(fixup_commit);
>      ++			struct commit *c = lookup_commit_reference_by_name(refname);
>      ++
>      + 			if (!c)
>      +-				die(_("could not lookup commit '%s'"), fixup_commit);
>      ++				die(_("could not lookup commit '%s'"), refname);
>      + 			ctx.output_encoding = get_commit_output_encoding();
>      + 			prepare_amend_commit(c, &sb, &ctx);
>        		}
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>        	}
>      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup w
>        
>       +test_expect_success 'commit --fixup works with -C' '
>       +	commit_for_rebase_autosquash_setup &&
>      -+	git commit --fixup HEAD~ -C HEAD &&
>      ++	GIT_EDITOR=false git commit --fixup HEAD~ -C HEAD &&
>       +	test_commit_message HEAD <<-EOF
>       +	fixup! $(git log -1 --format=%s HEAD~2)
>       +
>      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup w
>       +
>       +test_expect_success 'commit --fixup=amend: works with -c' '
>       +	commit_for_rebase_autosquash_setup &&
>      -+	test_set_editor : &&
>      -+	git commit --fixup=amend:HEAD -c HEAD~ &&
>      ++	GIT_EDITOR="echo edited >>" git commit --fixup=amend:HEAD -c HEAD~ &&
>       +	test_commit_message HEAD <<-EOF
>       +	amend! intermediate commit
>       +
>      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup w
>       +
>       +	target message body line 1
>       +	target message body line 2
>      ++
>      ++	edited
>       +	EOF
>       +'
>       +
>      @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup w
>       +	git log -1 --pretty=%B >with-c &&
>       +
>       +	git reset --hard "$start" &&
>      -+	test_set_editor : &&
>       +	git commit --fixup=amend:HEAD &&
>       +	git commit --fixup=amend:HEAD &&
>       +	git log -1 --pretty=%B >without-c &&
> 
> base-commit: f7de81456940dd6f3274e461149bba12965de609

