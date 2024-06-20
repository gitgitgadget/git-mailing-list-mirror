Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D262CCA3
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907118; cv=none; b=MtaPv8+E95AQ84GhCs8s4noKQcMwz//wGFwdSi6x/OjaFH4YMS9uKzxpz7Cy7PTO7JBZL2mDSoQWkQ0vgXur77sNE9zZuPy/V6kS7Q2q0Jyo7+nailcC62mn3StjJ49WeL1DfOxcIu65Iu2B1IZnuCgfNaf6+rQgVamDGkSavQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907118; c=relaxed/simple;
	bh=5Z1HD0NvMe2NWiGq9ZLERcgNK/oB1Qto7Jb9yQgQjgM=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2lTPTrSp4T9FsBei96WMfVXBlEmlpbSHOVRb2ta79l+jPHYeOncrY2lybq+NuYNvB8QPd1nxdcs4hvLLD6fjC7rmwyOEbzcAL557h4UB0YtIJIJ/opcXIH5LJV0IGRw37ZDZkFDyC7zPb6MWIdMdi6c+2jyRG17MVdhFBlC7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1FHM4aI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1FHM4aI"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cc148159dso1294391e87.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907115; x=1719511915; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq1b7uSl1P2gxk6RJfxOkVHpz1TnMtNRjw1PXRj/Ahs=;
        b=c1FHM4aI5/FZxzp+C+HXmJs8LYKVz2v63xmw/EZ9hdQP5jG2Ht4uoJy57B8672wthP
         0BSS+rQFu4Fnuo9ZUvN0c23N92Rwbgbio4JVNnpBreMnCSGizGUS8MaaYUwCR3e6BZ+X
         67+402d3g28G2SyXdo2pvGdhLVnEXLXXnWag2GZCxAOKXUeQgjOpKLNu/c4xGfKXzOIw
         qEGhE9j9m6xDWL7VRMQ59lS5V2BQ2MSTbXCcXopLW+8B488EwscppEfZOMzsl1ebJAtG
         U5HRvwWCt+vnBQi6KL26sdKyaTSRzBcZ1n+lIxDliVw0jtK4PdkcWtgbyZmD33ZKbsuO
         rNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907115; x=1719511915;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq1b7uSl1P2gxk6RJfxOkVHpz1TnMtNRjw1PXRj/Ahs=;
        b=K6vtwPLkUCxDQjVmOLc6qgrtpWCnEz8lGDo+cywxpKqQ+nRBWFoa5ShPQ9DePT3Yfq
         pfZUeov8/ocCCIQRM0gMvWgrKOeaij0AWX34BlUW/fMAoHjB6KKFwjP1GAs3Y3QL13Oj
         eafeTsM15a9IfogTA27/fxhEFn5o8KDD8tGhFveIa7VGZ4Z9xdePVS3hw72jkw+xb64Q
         bIyM2ONBA9tprlWuJLVVcIF5aicTkg2XQBO1A34PDP7UBLIOqknNSsWgREqZxMtMbXw0
         P9QpOKOXy3XZZC7wJc6YzTCm6bC1GLPw1gXg14d0lQOooTCnjgstScg4/00HMi+aDtTF
         6LGw==
X-Gm-Message-State: AOJu0YztRODJ8iKDyxS6y2fFJmX1lihqytYMC6WWTtLCsgkzSk9aRyOn
	8KTf28d4wdWdeVYnuHeer7qpHOBIWi3ssolqgwo3Vt69Hh340KTmHn25xTRZ
X-Google-Smtp-Source: AGHT+IF5C415P9m657v1nDOSoNET/rXDCaQT8J+SVy2T0CwPTyGUaH4mYgTUS9IIMUergUDj8ZTrOg==
X-Received: by 2002:a05:6512:3d10:b0:52c:ccb4:ec70 with SMTP id 2adb3069b0e04-52cccb4ed42mr4305278e87.22.1718907114386;
        Thu, 20 Jun 2024 11:11:54 -0700 (PDT)
Received: from [192.168.1.66] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cc1d80b1esm924812e87.240.2024.06.20.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:11:53 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:11:47 +0300
From: Serhii Tereshchenko <serg.partizan@gmail.com>
Subject: Re: [PATCH] Fix default font scaling
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <N75EFS.1X38FZPYSV94@gmail.com>
In-Reply-To: <abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
References: <20240615085345.47278-1-serg.partizan@gmail.com>
	<5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
	<Q1B6FS.FVKOG950Y3UN@gmail.com>
	<abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Yeah, I'm also testing this way.

No, fonts should not be independent from DPI, but now some fonts are 
scaling just like the others.

To clearly see the result, set comfortable DPI, so fonts are reasonably 
sized (if this value is close to 96, better use something larger, like 
130 or 200 to see the effect).

When you run "git-gui" from the master branch, look at the fonts for:

- menubar and menu (explicitly set, scaled with DPI - our baseline)
- buttons in the lower part (Commit, Rescan, etc), labels like "Current 
branch" - (unscaled, visibly smaller than menubar)
- you can also open "Edit -> Options", and everything there will be 
smaller size as well.

After applying patch, all fonts are scaled equally (e.q. - small DPI - 
everything small, large DPI - everything big).

If, however - you see second behavior on both cases, I'm really 
interested to get more details:

- What OS and Tcl/Tk are you using?

I remember few years ago it worked fine on my ArchLinux, so if other 
distros aren't updated something yet, it may still work.

On Arch we have Tcl/Tk 8.6.14.

And to go even deeper, we may compare results from `wish`:

 > package require Tk 8.5
8.6.14
 > font configure TkDefaultFont
-family sans-serif -size -12 -weight normal -slant roman -underline 0 
-overstrike 0
 > font actual TkDefaultFont
-family {Nokia Sans S60} -size 9 -weight normal -slant roman -underline 
0 -overstrike 0

On Thu, Jun 20 2024 at 19:24:03 +02:00:00, Johannes Sixt <j6t@kdbg.org> 
wrote:
> Am 16.06.24 um 14:37 schrieb Serhii Tereshchenko:
>>  On Sun, Jun 16 2024 at 12:30:51 +02:00:00, Johannes Sixt 
>> <j6t@kdbg.org>
>>  wrote:
>>>  Am 15.06.24 um 10:53 schrieb Serhii Tereshchenko:
>>>>    font create font_ui
>>>>    if {[lsearch -exact [font names] TkDefaultFont] != -1} {
>>>>        eval [linsert [font actual TkDefaultFont] 0 font configure
>>>>  font_ui]
>>> 
>>>  My setup does not have a 4k monitor, I run KDE and I do not know 
>>> if I
>>>  have changed a DPI setting. For the test, I have removed the [gui]
>>>  sections from my configurations to ensure that the defaults are 
>>> used.
>>> 
>>>  Under these conditions, this change does not make a difference in 
>>> how
>>>  Git GUI appears. I assume this is the expected outcome, so I take 
>>> it as
>>>  a good sign.
>>> 
>> 
>>  You can test it, by changing DPI in `~/.Xresources`
>> 
>>  `xrdb -query` to see your current DPI, then increase it a little.
>> 
>>  ```
>>  Xft.dpi: 154
>>  ```
>> 
>>  `xrdb -merge ~/.Xresources` to apply new scaling.
> 
> Thank you for this recipe. What is the expected result on the font 
> size
> with small and with large DPI values, with and without this patch?
> 
> - When I set Xft.dpi 100, I get tiny fonts.
> - When I set it to 200, I get huge fonts.
> 
> And that is the case with and without this patch. I expected that the
> font size is independent from the DPI with the patch. (I run ./git-gui
> after `make`, but without installing.)
> 
> I also see the change in font size after modifying Xft.dpi in gitk, 
> BTW.
> 
> At a minimum, the patch does not make things worse.
> 
> -- Hannes
> 


