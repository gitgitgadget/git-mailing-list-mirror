Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355724;
	b=CILdOK1ohXTIe/8ooV+2xPFsFt9ozDP46/6KOzyt+cALJF2siSset8sTzvauW2cqCjHo
	 kvpXpVtLSPdwJ9QqZAhvrAtBKklP89V4i6dbJDgSYVbgRGl4dgIr9NKYPYeppaSlQR2OJ
	 blk5rx/mUl1NkTojjoU7i/cpioFI6ii0opoeD5CxAFZOzI/NYHNbn7Yek5d1SZQxGZAMU
	 kAFa28ueC1lQ4R9ppU3TQlmajEo52yOyxQoINFXSCo+Y/mkPbVlHrwjpFJ8Q3OABFxzj9
	 Hl4qNXzI2EIsby8AduEwKYSGLW7mpy4hsj9SKZpjEMmu7Nf+mXdFn2CUfM33hZx6+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ssx/+Th8H3196BrT2q5JnA9MBsgS/w2RMrYeEvqkwrQ=;
	b=MR37DI4NyvvF75iC6iH2xboQck0GGZp3U6uXGYdTA0NLvAu3VNrTDaAbWMBVKDIC5yrM
	 QN0zT879K87X5DxTYQK4ASZpafscel5eARIPmNaqYbmqxMCkPQLCDmPyhwlmWiqVrIFbK
	 tkd75e5hnginuaZo8WQ0gDY3cnG8Wp3PRmC4tQxe2B7FJnTEFI3RdBIcR/icQXQULDcM5
	 VelBX7tCrO9Dzu6Vxs9IVrXLVWHhsN806XqnaRtWCAoiUD4SbswkUQMmyWv49CFOinI6m
	 z7EjJ51Sj+cYQLrK94xHBQ7Eux4skpFZ36+WUeP+kRiLHXKOTMEXNRFE0AmjG/bi57A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnBwf2an;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B343606A31F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B343606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnBwf2an
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1adbf62dd31so136378c88.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355723; x=1793960523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssx/+Th8H3196BrT2q5JnA9MBsgS/w2RMrYeEvqkwrQ=;
        b=vnBwf2an/7PldVRW6aF76vaCWtF4LTkfoPLt5Fi25lBRWokyPY85NoEoMYx8ld5vQv
         K6795tbkxr+EltxcvX/oARhyOUa/nBHCdOkWTUX5f/WfkkIws/LaD6TwEw3OA1ZYUxg/
         3rWqHTdCaksYV+Sr8JaqD9lhXwZ29pcNjLLm51qQP9+DMPiFHzSBgalc8KM/X/6KsVNN
         0FTOwgVd+m1ISWwRuLnbf7ZCY75jq2LUi0vm9KtV67g1Q+G0sNuDCljJDiNyA4I6Lh+R
         rh45O/CtZbLH19ZLpwxJrM2wBRXL7xl/Q3FrqZVT/Rx1hzhen7/+hoHCETKD/Q6crXxG
         Thxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355723; x=1793960523;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssx/+Th8H3196BrT2q5JnA9MBsgS/w2RMrYeEvqkwrQ=;
        b=BFoAiNEGXT8fz2UwX6GubOEEvs0IpqQuFhujqHKK1MPNXVNAm+kkRmJum4HToOqHSM
         FhwssKBQvkuDW7ChwuW/84zpqyDcmhSPZM5zNiRZI7mbBj9ggdYVm6NWuxL83RHqTrqa
         nGHzTftwkXpd1COUKjJbGmXEHOWoVByZZQc7SouUwlTHlJ+Y3bSuD7eCALZM8vzn5B/i
         IfKIcQfTqxVseIq8gEM0mx66di6K09of9JoVOjx3GIoLlJlPtb1J5zE7hH5KqtLXQNDu
         3TVn4wkuBhz9HvTbTyShtA/c4c/DFzx72B5a/jZmrYVjoLoUFj/g+/XvgEYM7PxbhLXg
         eayQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0FK8IQLQbIJbQqlYTfG6+oCFP8iOzCWydyA0/G2+FiEOO3xaG0g2/v42K/uH4NNQzmv0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBSk16B+8A+XmXMyIYkGzKuZfbM7nM1SUW4a3+AB/brmmNJrfG
	hAlVkyKKuD9k4niTqby5c8eAN2G177ghORCvtoHgdcGrwXi2mVV4TtIX
X-Gm-Gg: AYBFou11AattnwhwfVFdlkwxalGy0VTLD5jEVSYl92OnBf7gOHQtKG9u8aSEBq35VCk
	HT3oyUGTnna94navJtYhj/8oPDrHOF+1YeQyZeiSEP+7cHWpPqMtoCvrWk4gyvbIMH9ZBKXB79u
	E/wa65k6gkS52nOcwd54ZcmbXrw1nImtuBnyqyBhGT32ThVqYfv+H/vS94F7km0k90L/8ikeNMS
	HVywYrsxkTGNoa0pWyfyacqRZlrVAvaLv2ezIo+lmfuODZEklMDTPvDoKwAkN5dO0Zwz3sW23Zj
	JUDlsrOtdInEYE4/vG/418iMzDAllIJrsYhw3T0dHTMlAKd+Ocf7Gidg+povofM9WCzBQBM3oFT
	/trA7pIMiuFqpAspZ1nV8evhRQRzVdXYiW5EI3QVT/tcqj58QEL3LfJRuXWxt6mVoRxWJPOhJnd
	umImvEGNdb3vZN9jTpBSi58cLInwf3+6Zi3H/BFkPVoQM2B5d48OWatQ3IJ0I3GBC3zzl7UHKHo
	J07q6bByAIo+0bfljr+qF2qcMyK7a/x1CjX2TUGjW71qQpgKQegi2Y+BbTaWv+00isuSDw6cUlF
	SZt90wzECoLndhivRmvwzS1xDmUs0mQ0oCXItubj
X-Received: by 2002:a05:7022:3f04:b0:19f:527d:96da with SMTP id a92af1059eb24-1ac5da7b145mr2590491c88.33.1793355722196;
        Fri, 30 Oct 2026 03:22:02 -0700 (PDT)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm9745156c88.10.2026.10.30.03.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:22:01 -0700 (PDT)
Message-ID: <d026d6a0-5b1b-4bbf-bd1f-5f41c9c2a4e4@gmail.com>
Date: Fri, 30 Oct 2026 15:51:57 +0530
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
Subject: Re: [Outreachy PATCH v3 2/2] git.c: drop NO_PARSEOPT from builtins
 that use parse-options
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: l.s.r@web.de, gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com, usmanakinyemi202@gmail.com
References: <20261029012616.139783-1-tangajoris@gmail.com>
 <20261029231621.48958-1-tangajoris@gmail.com>
 <20261029231621.48958-2-tangajoris@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261029231621.48958-2-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 04:46, Tanga Joris wrote:
> diff --git a/git.c b/git.c
> index d7b5f88e52..2d27ad4175 100644
> --- a/git.c
> +++ b/git.c
> @@ -571,11 +571,11 @@ static struct cmd_struct commands[] = {
>   	{ "diff", cmd_diff, NO_PARSEOPT },
>   	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>   	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
> -	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
> +	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP },
>   	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
>   	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
>   	{ "fast-export", cmd_fast_export, RUN_SETUP },
> -	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
> +	{ "fast-import", cmd_fast_import, RUN_SETUP },
>   	{ "fetch", cmd_fetch, RUN_SETUP },
>   	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
>   	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
> @@ -626,7 +626,7 @@ static struct cmd_struct commands[] = {
>   	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
>   #endif
>   	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
> -	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY },
>   	{ "pickaxe", cmd_blame, RUN_SETUP },
>   	{ "prune", cmd_prune, RUN_SETUP },
>   	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
> @@ -676,7 +676,7 @@ static struct cmd_struct commands[] = {
>   	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
>   	{ "upload-pack", cmd_upload_pack },
>   	{ "url-parse", cmd_url_parse },
> -	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +	{ "var", cmd_var, RUN_SETUP_GENTLY },
>   	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
>   	{ "verify-pack", cmd_verify_pack },
>   	{ "verify-tag", cmd_verify_tag, RUN_SETUP },

This looks good to me. I was wondering if it would be valuable to also 
add a test so that any future commands that start using parse_options() 
could be caught if the corresponding change does not also remove 
NO_PARSEOPT from the command?

For instance, something like so:
         '
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index b0a3fdbbbc..cb147f30ef 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -267,4 +267,29 @@ do
  	'
  done <builtins

+test_expect_success 'generate list of builtins marked NO_PARSEOPT' '
+	git --list-cmds=parseopt | tr " " "\n" >parseopt &&
+	sort builtins >sorted-builtins &&
+	sort parseopt >sorted-parseopt &&
+	false &&
+	comm -23 sorted-builtins sorted-parseopt >no-parseopt
+'
+
+while read builtin
+do
+	case "$builtin" in
+	# these parse their own options by hand, but pass the diff
+	# options through parse-options, which answers the helper
+	diff|diff-files|diff-index|diff-tree|rev-list)
+		continue ;;
+	esac
+
+	test_expect_success "$builtin is not using parse-options" '
+		test_might_fail git $builtin --git-completion-helper \
+			</dev/null >output 2>/dev/null &&
+		# rev-parse echoes unknown arguments back
+		! grep -v "^--git-completion-helper\$" output | grep "^--"
+	'
+done <no-parseopt
+
  test_done

-- 
Sivaraam

