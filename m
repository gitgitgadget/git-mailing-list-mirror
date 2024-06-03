Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805B20ED
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446941; cv=none; b=ODE1iHsXkQWkz6aoPpS1w2jnfAQbkptx8gImbUDsMbRNMCdYKUbIdxp0W4+KJ/gaXZq7HU5ykg2ET4scOZ9OXE9RDwsFmC05Io0rOx4VMSJIJczoCxRssOb8ldl0Gf0UGnocE2iVehIlVnTzjSXRNOYVKW+Dk7bON8JnexkDM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446941; c=relaxed/simple;
	bh=sWzdwxlKkg1GYDEyGXc16JUffso992WFFkFX09jDw3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FAgsDun3ELz5Pnn4BuxyoMbuMDGoYLVX63MaVI4eOMC6TaJ0Au4CB11wqlinsZLiu5sm+xvHjSoXre42kWDPg1eh/3goDWXRmBvelf7DnBmIt2jm5AnC8awnA9mU7OX7ICitGEg+hcMo1ewcdZkZXeHVirqsQH58pg6CmOYfaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nELs6EYo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nELs6EYo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42121d28664so41842355e9.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717446938; x=1718051738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xlde0YGWDzkGiONJ73we8qyEzTxn1IEt/OtqP1kgz5c=;
        b=nELs6EYoFtmBQevSHS3BjyOyiAWrLEa1CwDTb5c0HMtabTxMjnWqWMvoWhHmycGSeJ
         gVpYry8nQbfHA1HMAYrUyIvsen0MHg6aXt4XB1S6oOwSD7ugilUMYmAydsZmQA0u6myw
         bfbhyFWZ3ydhX0Ql0jVSJW/UaVITVOhiOSruPU3qHC3OqEEzWbIbGPkOSH01BI+UPKN/
         sI1neZtRcUM7R7QhA5PkHeLPPjayB8HH5tjSvjVrx0tzFNQ1QzpSkHG98jEQp/shmPZ2
         Qcs2GPIkKsLxHgz0iKEMfQGCK2Q5L7C4slhxQqQ7p5CaM4L6uvABvToZEouXp/6Kuqk9
         6fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446938; x=1718051738;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlde0YGWDzkGiONJ73we8qyEzTxn1IEt/OtqP1kgz5c=;
        b=WYkWEFpEXm9seQetDrG0OOocxtdTtKFXLaUAM93Rtn8d/U7vJWcvwX3/IRuvBXF8OQ
         AEezd2e/j3jHQUWWFgsrumKeXvIN0Xtr39btbHI2zEcvF8nAQz3Ekzz/9/LhnbRobCqN
         YKd/kAVKENTe7YGF7ucGTxN8vyUgT8D6VzbMmbQwWbsoLkHzNKz4/CpbofglVsJn8ijS
         PEQ/Lcm5yyifB1kVCcq2xm8Yhpd7BQs0nL5rTabflV0TtJ9SHZYvq7qEiW4x9DMtnz9H
         wAQXUty/JTglg7KAthlI8hIWS6vAvuuwqNrz/k9HmIVgg2TxEUnAMOCDyzXZRiGLmxKr
         peOQ==
X-Gm-Message-State: AOJu0Yw2JIIDGjq49uAhmGI2qc4S5p3ESjw3eIILOCgkRrxGA6v5BOSA
	64VWP2IkG9Cucf+9aQxciJAdRVqzka13PU/btfYM4uaf1cXpGk6pxyJblg==
X-Google-Smtp-Source: AGHT+IGP9fSnwSksjn4Y9exf39/7R+POE/qBTl5fZ+wlRfGPkxQP+e4txjHMpS42xgfXvu9N/w/jUQ==
X-Received: by 2002:a05:600c:45c3:b0:420:171c:3d70 with SMTP id 5b1f17b1804b1-4212e05daa7mr90323115e9.16.1717446937727;
        Mon, 03 Jun 2024 13:35:37 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213860126fsm82395235e9.40.2024.06.03.13.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:35:37 -0700 (PDT)
Message-ID: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Date: Mon, 3 Jun 2024 22:35:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/6] use the pager in 'add -p'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This iteration is a quick reroll to address the interactive.singleKey
option in the new '|' interactive command.

I've also used the improved wording for the help text, suggested by
Dragan.

The rest of the series remains the same.  Here is the range-diff from
v3:

Range-diff against v3:
-:  ---------- > 1:  49481da8a7 add-patch: test for 'p' command
-:  ---------- > 2:  865bb68508 pager: do not close fd 2 unnecessarily
-:  ---------- > 3:  9fcf244dac pager: introduce wait_for_pager
-:  ---------- > 4:  1e817a9ec0 pager: introduce setup_custom_pager
-:  ---------- > 5:  87dd368346 test-terminal: introduce --no-stdin-pty
1:  9fa538478d ! 6:  b691764a17 add-patch: introduce the command '|'
    @@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
         "s - split the current hunk into smaller hunks\n"
         "e - manually edit the current hunk\n"
         "p - print the current hunk\n"
    -+   "| - pipe the current hunk to the pager, or |<program> to use a program'\n"
    ++   "| - use pager to show the current hunk, or use |<program> to customize\n"
         "? - print help\n");
      
      static int patch_update_file(struct add_p_state *s,
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      		} else if (s->answer.buf[0] == 'p') {
      			rendered_hunk_index = -1;
     +		} else if (ch == '|') {
    ++			strbuf_remove(&s->answer, 0, 1);
    ++			if (s->s.use_single_key && s->answer.len == 0) {
    ++				printf("%s", _("program? "));
    ++				fflush(stdout);
    ++				strbuf_getline(&s->answer, stdin);
    ++				strbuf_trim_trailing_newline(&s->answer);
    ++			}
    ++			strbuf_trim(&s->answer);
    ++			pager = s->answer.buf;
     +			rendered_hunk_index = -1;
    -+			pager = s->answer.buf + 1;
      		} else if (s->answer.buf[0] == '?') {
      			const char *p = _(help_patch_remainder), *eol = p;
      

base-commit: d3f616a4e56f359d84a9d439aa03dca1fe9ac280
-- 
2.45.0.97.gb691764a17

