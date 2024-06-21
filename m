Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070D16B390
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954295; cv=none; b=X3dDJErnQOXJC9jKBoW9380CUWnbSYwfEdnmgrKYNenLo95O+hyE2kFylnGzVLFXUiS8Ui8GXngqOCQ88jK8RskhtI7cvkaDUsqCrzxckT0yweAZSYFYulS9OxXT+1kFegioYVNSaM5iFVEWCaQIFqqjlmxIJX9Hl1EMCwINYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954295; c=relaxed/simple;
	bh=s83ozpW2kJB4ClhVPaIH7+q/BSwdOBoxlRgNcOjLBjQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZD1dBkVluO89qkAluW9uAPe6NsMgLPr70/NtjIlk7sQPk8X4jwhgMcZO9t/VF6O1Xi++9gCXm4XfcZ02xGVk/iuBmyYrpWCUpiuLZdDSTBKoX/tnrgcGg6HdXrD1RSYMs9/f6+bKiOBY7T1Zk/PuRNVScW5O/vI+Em1T2zQ32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ73nZat; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ73nZat"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc335e49aso1901386e87.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954291; x=1719559091; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqgmo02e46buEmQhnF6Cxc783/PlYcjvklxjkmKkLLI=;
        b=dZ73nZateU7OuMpTGDX99V62js0iLVNGBmAdURSuRaeWdnQNMTmOtYwNsdwtoW5O3Q
         5op3zh/OS79XFpsX7U4L5z7VQiUNkuOGCShzR4DfXfDSmaNZ6+/HKvmr2bah9BNwlhSb
         G+SpEu1Wl/xeNdfRJoq1r0KOdZaxHr9kBtN3VjUIBTrDDCNMmKgjEX9fM0ODgiErUsHt
         qn8891MtAnj5QJOWgyKS8qvidayuIV+S7Zh6voSUBdntGgyv8ugZEavTyf8eV5d5oxK8
         lphSy5OMbhH5YyMagwHh7+ciTwYCvzdZTzGd2fqlpBlanIiiKYhg1oDqDEjjCDybrwDJ
         5x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954292; x=1719559092;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqgmo02e46buEmQhnF6Cxc783/PlYcjvklxjkmKkLLI=;
        b=cr6z9HKQvblGA6Dr7mQXztl+NhHROVcqhUZ+dyo01JePFnMUVWSseu8P6Z+ib88kG2
         miKq9eHaRoRMQE40rlFmITwmC6ZdbxzwGeesqvmjZANjytJbO7GQ3ODUf4G1FlcllMv5
         /MKddUywjI0NqhmR61/rNfrbxZs5P91div0PvG8b1RWKLAXFQafX2ui+xo9EPDU70+dW
         14+Sb6zAv/ZQhgX6NLbG0A0maYTjUMJ4BXG8+WkvnwfiKj+Kl/KTDmpddkzWNOB7omoR
         Hqau3tUg7GRXmjxR50Nd5TsfflNzsmLbGZlkx8vNW+GU3KmnRe5RprCzOwNzKvIOkATo
         Lr4g==
X-Gm-Message-State: AOJu0YxwhJW2jPlLyl+GopvYH7OEE6XjSjLkpbMoP4KJXf7eyR6ob5SR
	wro+eZnN7iesGlxxyB4dBsfGtxOUSNpEmMkngCbCPyiZDq6yOWoF6WlPcrV1
X-Google-Smtp-Source: AGHT+IFqBGobIBYpBPXJfoLs6/cvQZfarGdS+5GRjqvmNZi0WhDHn9LevVNPpPQdDYgC2yMGzkc6aQ==
X-Received: by 2002:a05:6512:e98:b0:52c:cb97:ebba with SMTP id 2adb3069b0e04-52ccb97ec44mr5568524e87.24.1718954291271;
        Fri, 21 Jun 2024 00:18:11 -0700 (PDT)
Received: from [192.168.1.66] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd641f7f5sm116535e87.132.2024.06.21.00.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:18:10 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:18:03 +0300
From: Serhii Tereshchenko <serg.partizan@gmail.com>
Subject: Re: [PATCH] Fix default font scaling
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <3M5FFS.HXL15VW2HPOG1@gmail.com>
In-Reply-To: <0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
	<5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
	<Q1B6FS.FVKOG950Y3UN@gmail.com>
	<abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
	<N75EFS.1X38FZPYSV94@gmail.com>
	<0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Fri, Jun 21 2024 at 00:04:50 +02:00:00, Johannes Sixt <j6t@kdbg.org> 
wrote:
> Am 20.06.24 um 20:11 schrieb Serhii Tereshchenko:
>>  Yeah, I'm also testing this way.
>> 
>>  No, fonts should not be independent from DPI, but now some fonts are
>>  scaling just like the others.
>> 
>>  To clearly see the result, set comfortable DPI, so fonts are 
>> reasonably
>>  sized (if this value is close to 96, better use something larger, 
>> like
>>  130 or 200 to see the effect).
>> 
>>  When you run "git-gui" from the master branch, look at the fonts 
>> for:
>> 
>>  - menubar and menu (explicitly set, scaled with DPI - our baseline)
>>  - buttons in the lower part (Commit, Rescan, etc), labels like 
>> "Current
>>  branch" - (unscaled, visibly smaller than menubar)
>>  - you can also open "Edit -> Options", and everything there will be
>>  smaller size as well.
>> 
>>  After applying patch, all fonts are scaled equally (e.q. - small 
>> DPI -
>>  everything small, large DPI - everything big).
>> 
>>  If, however - you see second behavior on both cases, I'm really
>>  interested to get more details:
> 
> I see the second behavior regardless of the patch, i.e. with small DPI
> all fonts are small, with large DPI all fonts are large.
> 
> The label "Current branch" is the same size as other fonts except 
> when I
> select a different font size in Edit->Options as "Main Font".
> 
> 
>>  - What OS and Tcl/Tk are you using?
>> 
>>  I remember few years ago it worked fine on my ArchLinux, so if other
>>  distros aren't updated something yet, it may still work.
>> 
>>  On Arch we have Tcl/Tk 8.6.14.
>> 
>>  And to go even deeper, we may compare results from `wish`:
>> 
>>>  package require Tk 8.5
>>  8.6.14
>>>  font configure TkDefaultFont
>>  -family sans-serif -size -12 -weight normal -slant roman -underline 
>> 0
>>  -overstrike 0
>>>  font actual TkDefaultFont
>>  -family {Nokia Sans S60} -size 9 -weight normal -slant roman 
>> -underline
>>  0 -overstrike 0
> 
> I have this:
> 
> % package require Tk 8.5
> 8.6.12
> % font configure TkDefaultFont
> -family sans-serif -size -12 -weight normal -slant roman -underline 0
> -overstrike 0
> %
> % font actual TkDefaultFont
> -family Arial -size 9 -weight normal -slant roman -underline 0 
> -overstrike 0
> %
> 
> I am using openSUSE Leap 15.5 under KDE Frameworks 5.103.0
> 
> -- Hannes
> 

Thanks! I tried booting into Fedora/37 with the same Tk version, and it 
indeed does not have this scaling problem.

Then, I downgraded packages on Arch to 8.6.12 and 8.6.13 - also no 
problem.

The only version affected is 8.6.14.

That's probably a bug in Tk (and there's quite a few reported, mostly 
about "tk scaling" https://core.tcl-lang.org/tk/info/1de3a48312, we 
don't use it explicitly in git-gui but on my system it is set to 1.3)


