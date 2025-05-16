Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9476278143
	for <git@vger.kernel.org>; Fri, 16 May 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418025; cv=none; b=ntFD434z0RBLiRu640+IehMxZ69BT34kAjsloJ6TmtrydKKMuRolUXs5VcrPf8T5a5Zg6NbmwYhinaho2S+6FONgoKEKvTHLd63mPB3rEtTvcY0Lh+M+LvP6O5yJCHxnMavBQJ/+7KSDCaxIMU4ecySSQMGnxGDWbDaV3I7ZIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418025; c=relaxed/simple;
	bh=Zaf7IJi62tefcDDFJqfBNGRzSADF2ZnkFNHKUlBSUPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViUoFMf8YYbPfH9y5JtlP8SHLj3rJuTEhvd6p4OtBW8cyM43xcRt4LyOjNvIBeOI2kyEKtEMSE8UrH8N/T3xB7pWA3QBdqfOPKHOEUJfuoGApfdo3I5rNs/NaiBBXu8Z+KVXft1fB4wle5H0mODoPdjh4JILY8XajYaz5I1Dxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2cQQEom; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2cQQEom"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476af5479feso26463411cf.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747418020; x=1748022820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zaf7IJi62tefcDDFJqfBNGRzSADF2ZnkFNHKUlBSUPU=;
        b=f2cQQEomcl5doiC+9HTTHg+SQdnTkC5g2ZVJ+oL6wOqJXSbMnV8gueThwkMPLTu7kj
         5krPLsnIqg8kUeCu7rdvvOTDDkew8qbexmEaSSqIzvjQ6wqineDrxzLupS8cRhEGe390
         q23Zhvyw4H2rtQb/TXSr9EBni6/655F/mPIRsUFn7OfRxtFjAfc6lT+OjZiLE52emO8i
         Wnp5PjEmc8cwe6HoQsH+/y64fd/oDc4opyM5CpGL6w0MN8jZucjCb/iWu7oe5TFo/Kkr
         PmZz5ALRY0/0h8O7psqAQ6qjztlHZPBjla4c+jOfzaY5scyMnTI0RQYUm3NUqmRvULjK
         3MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418020; x=1748022820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zaf7IJi62tefcDDFJqfBNGRzSADF2ZnkFNHKUlBSUPU=;
        b=N+ajJgWsv1Dz258MWBoynFxAF/TRbZ3c5TmXxWGmh7B0H66dsO1M3Ai7EKIEPlHF6R
         ShASs8KcYjASTUv2OocviWyCaFNEhma0FKXK1y1sU7pUfO0ZBdLEsNT8mI8yN9ZnP3Jr
         bnH9dexctm2X02dG08BrCGRKE8pHmEiEWi1zsT9Uv+14i02WyT+3T1hhpMja4OkmaUQd
         Qf+bXtJiLLDG74mhm0sAJzNni/Z1UHxFviwDDkTfGVzDorT5IK5rKJgYz5+xfv1b4chE
         KaKlhRo7BXX6qKNclPSxVBaliWhDCxTcwmzA+PY/yH0lbRfVvha6d0woFm/2tX3EUr+w
         jMYA==
X-Gm-Message-State: AOJu0YxZe99BI3537QPQubSJ2qVSr1La9oj6ldDJEO29ue6w5YOdBwcB
	vV46v974x4+ah5Gwz+d8ADGDabfS+6BSMCJoBl7DBs6XoazZSK4+nPaM6eRd+7PsODbY39uFPwG
	bb/FEeBOQ4owU+X1QDlffSyigSvOtOxg=
X-Gm-Gg: ASbGncua3RJLPHnskBEkUYYf6hPXnAXzr41Ntw6WcV2458gNnyA0MR51XgzCypD7qDR
	LljiZnhL6tN+PTIIifL35/bSho6YI8AF6mYRtTqT+nRym0IClYImaPkyLJwq42c2gZX6xDXjmK1
	rtrMinif3Nh4m3DGxcXuJjVinWTmuPRL6cGJMRJqR2RkyFzk8uajFEI6BXgAG7nXKn
X-Google-Smtp-Source: AGHT+IHJzn6HvTiVWftOiK1yJs4wsfcq05lhAycjiJ9zD7daJYDoWW7AMOwjl6rCE0Yn4yDfZfVhzRYpJn1wZHdR58I=
X-Received: by 2002:a05:622a:1e0b:b0:476:7eca:57e7 with SMTP id
 d75a77b69052e-494b07dcd9emr59814351cf.26.1747418020562; Fri, 16 May 2025
 10:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfYLcx+tM6nif7E5vZDce7PeGyGJkTRraT7kF3ACAzBfA@mail.gmail.com>
 <20250516174934.45008-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250516174934.45008-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 16 May 2025 23:23:27 +0530
X-Gm-Features: AX0GCFvcPuj_3eHZdOCIXtAUYhfgplK_B1ElKHcSTXC_THfmJn1EjCHNTunu69g
Message-ID: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: prevent overwriting .gitmodules entry on
 path reuse
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, Moritz <mlell08@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I think the logic is almost similar as the helper function in this patch,

But I tried to wrap it within the if else block

Reason why this is needed is
I initially thought that this was just a path issue
Turned out tests like
t4137 and t7413 failed

These failed tests were because I didn't take
submodule active into consideration

And at the end since this is the only place where the helper is needed
I just wrapped it up for this specific thing

Maybe if someone might need it in future or someone builds an helper
function then using that might make sense
but for now I think this is the middle ground approach we could find.

-Jayatheerth
