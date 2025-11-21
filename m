Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92A341042
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742047; cv=none; b=S/8PoLX3yc6aWN5tpAJImhjSIabta6TC1Tvqc+wh5YMblSeNSnZQrs+dO3XeYaX8GOyuMSSlixSjchuq2IQG3/VixFhfWOdo/5/NwwE+l32yNxdJj4dqxg5x/xSbon2oJwLx3jN+n0TTwNxBRUjgnY1wWYr8bcU5YWpPgxrQHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742047; c=relaxed/simple;
	bh=By3vfG2vUh0oKaSu0jEucrHqh3e4yPDK9cZGXA5SmIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0CPwh5FVqGIWa4YzVo0LhAg+kH9C9Nrf7tOtVNR+iOD5+SIClv5BkAUZP7v7MYv0rvenkZrnGhWuS6ViBmFAV7bCVGK2v1nzoj29OL8yf7AsXtHkM/YFkNIE254yYdMwyk+JJDXAShSfBq3zNAqO7TNdn5f9HHT1NtMmRkxgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAXCXp/u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAXCXp/u"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47774d3536dso17779325e9.0
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763742044; x=1764346844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pfmXCqLrN6ym6PR7jvLjn/N5CZjq5wt3kJoqBjo5rvg=;
        b=KAXCXp/uWU6PE6mtruWNXyK/bmA2+dnruEAxToc5V7WVq2A0IsChUiYeuXKJAMmvPN
         TdSNfzDP04PowxU345pGI5KnMMp1IUpwJSLPStxDiyrvU1y8TBxeyO2hVNFRU/IAYOoA
         1KkyOlpVIuozC8n9+WSg47WRcSNK/5XYhhcve53XrBKQ4ERFaCPSQ+YbpB4+v9kmnnZ1
         oopefcEreYGZmBcTGF9GfUofvjOAcrqIG0aajqgQpHwcEXLdNFY4OtNEPc2jfpdOKoHz
         z738AXzfvR327zARxYJEZp4Hp7vlzVVxi3KXac9Q6wwLqvvVOZZJQyp46BBIfUSJmptK
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742044; x=1764346844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfmXCqLrN6ym6PR7jvLjn/N5CZjq5wt3kJoqBjo5rvg=;
        b=cV7fFmFxVrN8UF7A1m+iUvsVgzeeme7bBw/azjleG+/jQivMRWyt7eLeQ8Ie1z0ArH
         DgblOuS7ZB0PVrkkaTCHaJDNgrcJZNcLkv7cK0dMbXapWOcuhz6KEhDSPlEUpm6DruMd
         CDNHEkfTj+OzR8PyfLapux/R0j/xpGlAARH6e1oNMysA4HOM32mTYx3kX1kuzhZUWmKw
         QvBI6Iev3rUBXIUukTC2rn+cPbuR57HYOgKwePWZIicGZdyFQyXWxtVjZ8v9uOjR2rj0
         2458TLBcV7fgX3R08cFG5/9rjX74pdXLlf9depOf2wm4hRKiiA9HEthO1QcflaWKZUsm
         uMew==
X-Gm-Message-State: AOJu0Yyjva4khsSfbVbgl9iem9DIaZjarCztPX9Zuecp8w7DwbumW5q+
	4P9StE9ZPh5//a2+LgCzMslVuceL6xcmFmqOvrTWXPLC3kGQHSqIysGE
X-Gm-Gg: ASbGncsTBonUwb242dfiXhaQPcxuttaJVrjynsqCpn/9wZr9CRiCJl2QF4txRpskXd+
	5aw2mGq80QYxd00EI0X/8GxDerxnyehTM2H/p7a5bjvwKjJxXkAnGnxnzzVhRxjNwQ2cy1nxSoC
	QAcqTHVBHvc092PuabIKwhU4Z81QrZeRkrFTZgo5VU7+qD5KdrNcfq3gNGPTHPoYPLh+lgl0nMu
	9e9hhcxiARjDGLf2oxHRYREuFA9DlVdor1mCkI+8Fc29JfvYYtJuMUeMvveryYfPzVKBeaTQxgj
	fnCJCDL8Ie/QlUFJUKcF71squ9X8YNZ13nfYoFDaFKyRxzdLXeyaoKYZ6CCaOPtf+Swm8p7ZsBF
	pVVq0atGektygm9dcLX2JrNEP5FgtiPOOQ6RvXCMT69gygKoOmE1zd+X7nM2APf+Ye7fGhhWToa
	T8pbzlKhaI1NWaxIrlX/k0VjaZSARaZztOPPFSNU6D9CiuGcBlmsiRJJwTf7Gw978=
X-Google-Smtp-Source: AGHT+IH9SndtBPamo3eNRQUFc8nplUGIi4okoB9GlW2ZkIXw7jRon0fJXX/brdJXkGgvrKCiCrwuqg==
X-Received: by 2002:a05:600c:4685:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477c052f04bmr30216335e9.13.1763742043892;
        Fri, 21 Nov 2025 08:20:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf216ddasm51104445e9.0.2025.11.21.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:20:43 -0800 (PST)
Message-ID: <7583e2aa-ccd4-4316-b5ff-bcba0fc84898@gmail.com>
Date: Fri, 21 Nov 2025 16:20:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] worktree list: quote paths
To: Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
 <b42d0f668b4a5ba0ec00fed1377cad5488f62197.1763482051.git.phillip.wood@dunelm.org.uk>
 <CAPig+cSptp+a7jnUp3Tg=7D8WYKFNz4xWU2eaH+X5uy2mWjvgg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cSptp+a7jnUp3Tg=7D8WYKFNz4xWU2eaH+X5uy2mWjvgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric

On 19/11/2025 07:09, Eric Sunshine wrote:
> On Tue, Nov 18, 2025 at 11:07 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> If a worktree path contains newlines or other control characters
>> it messes up the output of "git worktree list". Fix this by using
>> quote_path() to display the worktree path. The output of "git worktree
>> list" is designed for human consumption, scripts should be using the
>> "--porcelain" option so this change should not break them.
> 
> I believe that it would be more accurate to say "--porcelain -z" since
> that is the safe combination. Without -z, the output of --porcelain
> will be gobbledygook if names contain newlines or other control
> characters, but that's a long-standing problem[*] outside the scope of
> this series. Anyhow, probably not worth a reroll.

I agree that scripts should be using "-z" as well but I was just trying 
to make the point that the changes here wont affect sensibly written 
scripts.

> [*]: There has been talk about correcting the oversight that
> --porcelain alone (without -z) fails to call quote_path(), but such a
> fix never materialized due to backward-compatibility concerns. We
> would probably need to introduce --porcelain=v2 to finally fix the
> case when -z isn't used with --porcelain.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -1028,11 +1029,14 @@ static void measure_widths(struct worktree **wt, int *abbrev,
>>          struct worktree_display *display = NULL;
>> +       struct strbuf buf = STRBUF_INIT;
>>
>>          for (i = 0; wt[i]; i++) {
>>                  int sha1_len;
>>                  ALLOC_GROW(display, i + 1, display_alloc);
>> -               display[i].width = utf8_strwidth(wt[i]->path);
>> +               quote_path(wt[i]->path, NULL, &buf, 0);
>> +               display[i].width = utf8_strwidth(buf.buf);
>> +               display[i].path = strbuf_detach(&buf, NULL);
> 
> The strbuf is unconditionally detached on each iteration.
> 
>>                  if (display[i].width > *maxwidth)
>>                          *maxwidth = display[i].width;
>> @@ -1104,6 +1108,8 @@ static int list(int ac, const char **av, const char *prefix,
>>                                  show_worktree(worktrees[i],
>>                                                &display[i], path_maxwidth, abbrev);
>>                  }
>> +               for (i = 0; display && worktrees[i]; i++)
>> +                       free(display[i].path);
> 
> And the detached buffers are correctly freed.
> 
>>                  free(display);
>>                  free_worktrees(worktrees);
> 
> Although not technically required because the strbuf is
> unconditionally detached each time through the loop, I wonder if it
> would reduce the cognitive load slightly for future readers to also
> strbuf_release(&buf) here at the end of the function. Probably not
> worth a reroll, though.

I think the counterargument is that it adds cognitive load for anyone 
who wonders why we're calling strbuf_release() after strbuf_detach() so 
I'm inclined to leave it as is.

Thanks for the thorough review

Phillip

