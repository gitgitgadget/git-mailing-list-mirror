Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5215282F24
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113443; cv=none; b=gDBbQjgrHHPJCLylaDUyrt/jGqptY7+Odvv1x0aan7MTyB/uL7MaINzY9NiwdCaFG7gWPX3joD7gDNhzM6TBBNTE5ZeDibKrZ7fqy3/o0YVk1zY66riA+uA7kvKkm9bU/pMZTCCluDadJq+Oo0pYZwbL11PbLNGmAX2MoIwZaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113443; c=relaxed/simple;
	bh=1FiZtSnBSF9UbMDaX3O+H4gWDSmbV9HoBeScR7+5+Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MofYUcxRzYu1hs4EakO0SOoSHeXk/BKo31ydUyxACOx9LYK0CrUz6SZ638KE7Cmah1+w1wnRYIPyTFYF4VCFDXqcrrb2fJF3pwWQZrWMx+phDeYj8jtzX/f5vpGuaa44GSDzk7h3ka0k2uuAX1YkezJ1ccH/bJNzWX0+1b99v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9kZPEsn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9kZPEsn"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e50a650a0so187432285a.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113440; x=1786718240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7tQgsbwLhvEjHEweTHIGp3/niVAN6meTEqUOemFSwes=;
        b=T9kZPEsn8JmIA9paQ+aVC5YuLTgFGKi6loLdtWLE++ibis0KjUNkGw+G+lGuUQOqIO
         smTQiYYytp1RA58MSzPFdySW/mV82ICfnaQea8CPrkTG/RMJDOfDMYKfLgV90LvDnQoO
         Pnk3Xf2h5nIM6g9PKrmPBxXBitH6e4fB5/BVtQvqixuxle8jv52mKaa6xhxfWRkIskly
         b1mbWeenYJZHOQHh41StEg/8twhZodSyxIEWm1qlRCn6GiJcgIEgn+AtL14VYdS4CBFl
         TGKsPprgmB/P2srmbSsT39EGhAFPC2b6q3fOj2IyWXnYtseSZlv4KNW2kWgBPctxfh8Y
         kEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113440; x=1786718240;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tQgsbwLhvEjHEweTHIGp3/niVAN6meTEqUOemFSwes=;
        b=O1WOwf210DSaMKJ6vO4cOEkGpZWzZzTkA3wFx0YU+3IUcZrTbUJ347qW0OIub/vUBJ
         BK8BCe4W3DG/yyYiaEy4otgpdEUJJkDmdFYMmHlKxirwZBmTGjIfA+LzaLTx9WIWhOTb
         z7tsRlQw0z49lNdkATen4tSF8Oz+3StAduN2BjLDQvxt8zxlhFnqGHjzjLuYQ5KSqA3Q
         mLe7YhR5+2Jk00Cdz0brBrsRFRKQO2yG7YQitbo832G8ymPEcQZGqa4MxR4t1Fmra4N9
         homzybPmemnFdd2Id93+NEdrzELISajN0qdTkKGlYSiQKKNOotuVQxUmmr0C5BmIfPXE
         qN/A==
X-Forwarded-Encrypted: i=1; AHgh+RpfcwM2TWZoaGcNVhHKTh7OlciHwqgi9s1Gopf7T0gerfNOdv0ItX4SrIkAeqi1rHkTUqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2vuRqEm2UJTq+KjQ/KLFyaG9m/Z6EhQWpnUbtS6RtY+M4952
	zRP6MBBtPGvMBdgSY+m4Jf0qyVi1lG/IAQP8xFsjJ3tLun7knlRaOnZc
X-Gm-Gg: AR+sD13yJzW9CWD+m8+LyyNZL4PQjcogx24c+MkgczP/rLFb/ASIzo3OYPnFBZzHQOz
	cpshVJc9YhScoXTdNS/6cBKhPK82CO4jthRj82Mxndb2OSeCl9Fr0aSJjFeL9CPFPqH8KD4NY2B
	pK9FP/ybhxE/Vjha8QehDtdb0X75OE9rb6LaPvpJFnJlnmZy5SbR772dDdyQC1CbAbEyp8jMnE0
	9Mr9272gQAxayCKoc85soi7leHe6jkrxNaGsTqb/bBfGRpRcWCf1C7YC63mzBFyOKakOml7tKR5
	ItAqLy0PwM1/LicE+CjXgNRFTUotvPteY0c67y0RdHxe3Lqe3PJ6GazyagL6WXBaX2vc7okGSFG
	urbsGkNYhklgYAwiYg6g+ocgcyQAzqI3+3yxYH54c8ZzIC8uRzU/CFJ/Ek6OWHWEHEhvbDivSE0
	J15MFxyvTAJ9gn6SRmd43hPhDbVHppwfATwAMXSjMkpH6Sp4iHIj695SkCsKbC5SfCEFieqMiBf
	3qFjQa5Jq1z03qtGm5/VIaY/2H9UpOrGIp4
X-Received: by 2002:a05:620a:2804:b0:92b:5408:b6be with SMTP id af79cd13be357-9364922a4a8mr2269214285a.23.1786113440358;
        Fri, 07 Aug 2026 07:37:20 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e2c211csm160892085a.47.2026.08.07.07.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 07:37:20 -0700 (PDT)
Message-ID: <eff19bf1-a8a8-4de0-9fc1-cea4b3d0f1a6@gmail.com>
Date: Fri, 7 Aug 2026 10:37:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] gitk: show color preferences on the button instead of
 the label
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <0428a92efc4657d2da1e968ebe45038cd186b055.1785998419.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: mark <mlevedahl@gmail.com>
In-Reply-To: <0428a92efc4657d2da1e968ebe45038cd186b055.1785998419.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 2:40 AM, Johannes Sixt via GitGitGadget wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> When the user goes to the color preferences, the eye is automatically
> drawn to the color samples. However, clicking on the sample with the
> intent to change it does nothing. Instead, the text label also acts as
> a button and must be clicked to change the color.
> 
> Turn the color samples into clickable buttons and the text labels into
> static text. Use non-themed buttons because their color can be changed
> by simply specifying the color properties. (Themed buttons would need
> a lot more elaboration.)
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk-git/gitk | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 137940defb..877b2ad27f 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11867,10 +11867,10 @@ proc prefspage_colors {notebook} {
>      ]
>  
>      foreach {uielem colorvar idx label title} $coloruielems {
> -        label $page.$uielem -padx 40 -relief sunk
> -        ttk::button $page.${uielem}btn -text $label \
> +        ttk::label $page.$uielem -text $label
> +        button $page.${uielem}btn -padx 40 -pady 0 \
>              -command [list choosecolor $colorvar $idx $page $title]
> -        grid x $page.${uielem}btn $page.$uielem -sticky w
> +        grid x $page.$uielem $page.${uielem}btn -sticky w
>      }
>  
>      grid columnconfigure $page 2 -weight 1
> @@ -11896,7 +11896,7 @@ proc prefspage_set_colorswatches {page} {
>          linkfg    $linkfgcolor \
>      ]
>      foreach {uielem color} $coloruielems {
> -        $page.$uielem configure -background $color
> +        $page.${uielem}btn configure -background $color -activebackground $color
>      }
>  }
>  

The original approach has unthemed labels, allowing easy specification of color, and
themed buttons. With this change, the roles reverse, so swapping themed / unthemed makes
sense. Good.

But, the colored buttons do not stand out to my eye as much as in the prior approach.
Perhaps use -borderwidth 2? This is totally subjective, I'm ok if you leave this as-is.
