Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D827715
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718541432; cv=none; b=X9+9jRYJSuO4D0aGG0aIBTZQO8lX9xjjdPibApA0Z4qoJGL8idpZoPvSne8E95Ec2cmgE9IBP9rHsGSi7IihRQtuTIrG92m3pLfYh51OzyJ+RKt6Ti9qrjcDAvMnaF0kEPdys+qI0HtWI6ah0O+mAwxt0/FOhZB7zLmXNM5I8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718541432; c=relaxed/simple;
	bh=xBpNvfC2Q+KJlupmM74b26xeUalWBuBJhjooqUAawmw=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR5YQnrz1qi+UozfqSPluc4esTA63NPM3a1Vq1jdK7TqB9jHqfWLccT6p0zydCydDSDqy1pHjF7Rs/NuEdpj4DXsknmdqR+u3qnG4axHZFvfj5UbXZJyJf9pGZeilOEJbzdsevxPsbWkf6M2oEkmxLoPyODw3SlLzsffuXEhBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvKkJHHg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvKkJHHg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaaa6so538119366b.2
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718541429; x=1719146229; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CM/OqTJlmgTzr334pWIzweSkEebuf9R9C/FE1LIHlUw=;
        b=HvKkJHHgKZg8cvJi6dH/gbyjEP6ELqE6IN8MOY72oJghuzzwJnT+bLNfl31yS66RpB
         1Y15NAtiIOSL+AbbrvtD4DCPQfX0fAg0L4RDbjH3NBa5zx4sJx2XMb18zkazvwy9XCCm
         B4BixQoCjC/AxcqiXvkpHsad3uxQ6Z90aZ9FzfxDLM/NsDKn8RTJ2j46ixC3WosLaPQd
         uu1K5xzTOoFhhk9fxwnbr0ucwTyvpo6ZbVYDl7sUgIJn6hX/hSh6hM/WJigMMwse4DLo
         SfocGXkFaDsk8N6LjRBUZHLlFWj2lJWScE6Ds3mF4lfErfTXwFdC3uWdPu5WYyhpNIxz
         157g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718541429; x=1719146229;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM/OqTJlmgTzr334pWIzweSkEebuf9R9C/FE1LIHlUw=;
        b=Vky3mVule0laVLpRrQpQn88oQIC7DE3ZJobuDvCOoNj4Lk9nM5D/Re3fX2bEKo2Vnb
         zC8laKUPIb68EtEfVXN1E0l0sZp2EWGxMDDkXuUwT8moUCeKVQG8czh/sTFqkEmorRFn
         h2adPU20k/l27rsCuM79Vocn6x2j2iJmLMhVt48a8gOZMdtlmQCvaZuxkfwP5G7So9vU
         +pvWePPYpMhFvcODqebDQI/DDDYdHp2fDcLSsybD1zvSSzAs4vXaHkV3+9TbxG5NGY/R
         wGc7pCuZaMu538f8fCTF8VtXWpPWA9YQHg0biy639ksXPY5F6VFwbqlONHVyocnUu3td
         GF3A==
X-Gm-Message-State: AOJu0Yx9LtqLFbZRnWrhdhy2bIwSKVp1r4zK7UvKWEQIpaQjRPe6o55p
	oqjFLy7ng2AvQJLJNw3tGSYDAZWx8nSB5+gFvAgmDJGai1Z/qpKD
X-Google-Smtp-Source: AGHT+IFqhnbnAO0dZB01xVGtJe6sutD4j/z1BvBQIWH/ftBNm4mD66HRqW6w98NguwpxSX0IQwczGQ==
X-Received: by 2002:a17:906:7631:b0:a6f:1662:3eb4 with SMTP id a640c23a62f3a-a6f60d2c9a1mr335753166b.26.1718541428810;
        Sun, 16 Jun 2024 05:37:08 -0700 (PDT)
Received: from [192.168.1.66] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41a91sm410562766b.172.2024.06.16.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 05:37:08 -0700 (PDT)
Date: Sun, 16 Jun 2024 15:37:02 +0300
From: Serhii Tereshchenko <serg.partizan@gmail.com>
Subject: Re: [PATCH] Fix default font scaling
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <Q1B6FS.FVKOG950Y3UN@gmail.com>
In-Reply-To: <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
	<5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Sun, Jun 16 2024 at 12:30:51 +02:00:00, Johannes Sixt <j6t@kdbg.org> 
wrote:
> Am 15.06.24 um 10:53 schrieb Serhii Tereshchenko:
>>  This fixes font scaling for default fonts, where we don't set font
>>  sizes explicitly.
>> 
>>  Without this, on 4k monitor with text-scaling-factor configured in 
>> Gnome,
>>  labels, buttons and settings are using very small font sizes. 
>> (Probably,
>>  not just Gnome but anything that sets custom DPI).
>> 
>>  Screenshots here: 
>> https://twiukraine.com/@partizan/112619567918546426
>> 
>>  Signed-off-by: Serhii Tereshchenko <serg.partizan@gmail.com>
> 
> Thank you. I have adjusted the title to read
> 
>   git-gui: fix scaled default fonts
> 
> to follow the convention.
> 
>>  ---
>>   git-gui.sh | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> 
>>  diff --git a/git-gui.sh b/git-gui.sh
>>  index 8bc8892..23dd82d 100755
>>  --- a/git-gui.sh
>>  +++ b/git-gui.sh
>>  @@ -810,6 +810,16 @@ if {[is_Windows]} {
>>   ## config defaults
>> 
>>   set cursor_ptr arrow
>>  +
>>  +# For whatever reason, Tk does not apply font scaling to default 
>> fonts,
>>  +# but applies font scaling when setting size explicitly.
>>  +# Default -size 10 is still 10, when you look at it with `font 
>> actual ...`,
>>  +# but explicitl -size 10 becomes 10 * scale factor.
> 
> I fixed this typo: s/explicitl/explict/
> 
Thanks!

>>  +# So, we need to configure fonts to use their default font sizes, 
>> but scaled.
>>  +foreach font_name [font names] {
>>  +	font configure $font_name -size [font actual $font_name -size]
>>  +}
> 
> Have you seen https://wiki.tcl-lang.org/page/font+scaling where [font
> configure ...] instead of [font actual ...] is suggested as a 
> preferable
> solution? I am not so much into Tcl/Tk that I can judge what is best.
> 

No, I haven't seen this, but suggested preferable solution doesn't work.

`font configure $font -size` returns negative numbers for me.

According to this
https://tkdocs.com/shipman/fonts.html

it means "size in pixels". And size in pixels does not scale. So, if we 
want fonts to scale with DPI, we should use "points" - and that's what 
`font actual ...` returns (i just hope it returns points, because it 
works for me and scales like points).

I'm also no expert in Tcl/Tk, this just my second time writing patches 
for git-gui :)

Probably, after all this we should change comment to:

# Default Tk fonts are defined in pixels, and they
# does not scale with DPI, here we're converting them
# into points, allowing them to scale just like
# explicitly defined fonts.


>>  +
>>   font create font_ui
>>   if {[lsearch -exact [font names] TkDefaultFont] != -1} {
>>   	eval [linsert [font actual TkDefaultFont] 0 font configure 
>> font_ui]
> 
> My setup does not have a 4k monitor, I run KDE and I do not know if I
> have changed a DPI setting. For the test, I have removed the [gui]
> sections from my configurations to ensure that the defaults are used.
> 
> Under these conditions, this change does not make a difference in how
> Git GUI appears. I assume this is the expected outcome, so I take it 
> as
> a good sign.
> 

You can test it, by changing DPI in `~/.Xresources`

`xrdb -query` to see your current DPI, then increase it a little.

```
Xft.dpi: 154
```

`xrdb -merge ~/.Xresources` to apply new scaling.


> The patch is available as
> 
> https://github.com/j6t/git-gui.git st/font-scaling-fix
> 
> for others to test. I'd appreciate your feedback.
> 
> 
> -- Hannes
> 


