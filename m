Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ABB7DA7F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896319; cv=none; b=AFfLQdwABNRSSabu+BwUVIIq9rK4rAD1ntlJqU8BQl4flmdwBRIUwMq8OTmrTGnu9hz2SFLW+LGVY+EiSYWZg4cqWAamhZ9metIj7Ban0hXBvtzpWu5ldIXZ7kbcAokDY9D8sTEEgqhZbsSUXx3aOi4vu0j4mgceQGekHftiz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896319; c=relaxed/simple;
	bh=SGQN+hMJnyPG5XwsycIK3hdevdYXYa9x4hIOj2tAzDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao1TnzHQJggssa2lidC9vGAz9peOBsqji4wmOpy/bn0td1MNt2RPsrl6n3AbiiOzrNiOPj1dmm/Zri7jOvtityGxwx1BfSaGalsBbZnk9D3MlG2UrGQvzN6mlkQ5NYgANEMtTIuNyOWiFMKOFmZcLyJDXO6ze04xc0McbSLtSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha9/FgzK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha9/FgzK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so63482545ad.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730896317; x=1731501117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jgSoMCNQDWLMg6HOHmLKXowyF5P3sggxhVg88I9398=;
        b=Ha9/FgzKwO/FnTyF8LOd6OrWMenfxxj2EobCxDx53OJdsfbSThH4rYCgcnjSDR8FCE
         Tc7jZ2xveN60O/fQxqW2tJze5+M8wlTSrsE3cSuHPp2rKXcsJ+ZMgP/RgPyoPiEUEkJW
         XezPwNHrNe92QE/terYJnjJxSzD/2IZKAvBFAeJLabLNIjf38BW+HGgOSB2LZY8sWyQs
         GBTqCchIGEQmC6pQ4DbI3ZpAtWGycAk6i4BzRUHWwHlL5L3qQrG338THxjNaBqhp78Et
         gdBkEITa6EmmLupt7bPrE/Ro3pgHMfUyfAI15VJ+uHaV+TOcKDp7i6Lp6O3UgoUpF9ME
         +sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730896317; x=1731501117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jgSoMCNQDWLMg6HOHmLKXowyF5P3sggxhVg88I9398=;
        b=a+IXCmdNrlIxY9XLpLhjie6Rfa7RouYpFDNm5Smz3GC1o1+1WGc2XF76ybZqpCRuKk
         6tM801TcoOIy7mRYmsxJHGbvQ6gCy8w8qQIuUx44BJJHF1qSxm2MBQXWxeFxFYUPCupL
         qJhp3c3jlOu7rQo8ZOjZQuV5Be/9bQ7bnUJKIEG4etZf1xlvmIKkVk0Zkzz5ERm4MWP1
         31KU14wHoGS+UMP/H/heBiyirVMKk7SeLOsCdhlsRM5aYhaNbO2L44HTKWjQlPlv9BRC
         AMRatIM3z8sS2R27MS9anNvyF4Qd8IYSNHIN9bqT8ihvdoFVx9mMCLMOtuLeHp7DqWqv
         /+rA==
X-Gm-Message-State: AOJu0YzAkFW0rNtLt3r4vnTziYmzDXOSVcHQqEoBP+MdDEK3+MONMna0
	AAkgV+IqKukGs5t37aGQvSzkZfQZNOE6pCQ/VHmvDiiuJ7aP1g+F
X-Google-Smtp-Source: AGHT+IGe7yJlR7DTIFNCbDA5X5NUyDyUiWwfFdhUYf1G0zL+pmRx8LXYO/Ao3XHbqvmZMn/bB7s7QA==
X-Received: by 2002:a17:903:18f:b0:20c:62f4:41c with SMTP id d9443c01a7336-21103aaa033mr312010915ad.3.1730896317261;
        Wed, 06 Nov 2024 04:31:57 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570891esm94353265ad.104.2024.11.06.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:31:56 -0800 (PST)
Date: Wed, 6 Nov 2024 20:32:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/9] ref: initialize target name outside of check
 functions
Message-ID: <Zyth0-rUAj83Rz6F@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYZy-9deyT6I9a@ArchLinux>
 <ZynFMnYgpCbYwQOs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZynFMnYgpCbYwQOs@pks.im>

On Tue, Nov 05, 2024 at 08:11:46AM +0100, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 09:34:31PM +0800, shejialuo wrote:
> > We passes "refs_check_dir" to the "files_fsck_refs_name" function which
> > allows it to create the checked ref name later. However, when we
> > introduce a new check function, we have to re-calculate the target name.
> > It's bad for us to do repeat calculation. Instead, we should calculate
> > it only once and pass the target name to the check functions.
> 
> It would be nice to clarify what exactly is bad about it. Does it create
> extra memory churn? Or is this about not duplicating logic?
> 

Thanks, I will improve this in the next version.

> > In order not to do repeat calculation, rename "refs_check_dir" to
> > "target_name". And in "files_fsck_refs_dir", create a new strbuf
> > "target_name", thus whenever we handle a new target, calculate the
> > name and call the check functions one by one.
> 
> "target_name" is somewhat of a weird name. I'd expect that this is
> either the path to the reference, in which case I'd call this "path", or
> the name of the reference that is to be checked, in which case I'd call
> this "refname".
> 

I felt quite hard to name this variable when I wrote the code. "refname"
is not suitable due to we may check the reflog later by calling
"files_fsck_refs_dir" function.

So, we should use "path" here.

Thanks,
Jialuo
