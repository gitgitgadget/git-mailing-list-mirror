Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95C13AD32
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440405; cv=none; b=St1zU35W4WJ5uQuxhhrN7JQUEP3uoOdmwy2RokwdZN4VHOkVENpvJAHzvN0xgWcfbt12pYuy2vC7nNFARVsPAAhmlE8REqaqHqKcra6QVKzEpBf/CdsJ7LT8W3CRB6j0U7thW14r9wws/FM6xhTQzOtYnji+527599TA+WMai10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440405; c=relaxed/simple;
	bh=Hf8iWnX84LgmhGhbhbW/etnkadHxkCwpe/my2QR7ofo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXueY/PN4vNHlIC8cGexTfF1LjKOy6oaAEcU4M4cpqiHj+v7t5ECQWLUpRCEiw8AbZASgWDdvIEGOlZ1EUCQUeBQoC8ZSp2UIZ9tHTyVxyzhLEO6BqEzt+apFilmSIwOaYaexpjUGLmSGW9TgtG/adg4dJaEO5Q63NjMmZ2b1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxXcWLVm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxXcWLVm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso20055275ad.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720440403; x=1721045203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWm0q4vg0Q1TFYMIwbGOJClhSVkKdoB+CKaiPTaiNPY=;
        b=fxXcWLVm1fQd85IJtDTMoUagqnbpItY00FlYm9p3FPN7Jm4nBWQpD2R+BLlL5BVOkB
         QMXfOHiZ8yk8bEWU1jMrv2AlO84RLWvuIk83IyLodnas52W4XKfGQ82ph7jwV5i6q18p
         iQX8dlulbcrEVsNxLkd+8K5wRdrs0U6dnwx+cFmarDqK29b2o5riYF2L7Sd00RB7rJVC
         x1T1nREpaAJvBKXEOC57frgURn852NBnm63olWffVHPJTpenJhCoim1/Fx96LSy0k4Vy
         l3p19TB1nuPqrknusGy2ow+C7RTD4hzlWBeG17IEpkt6SrwvTSS+xBOcbRJWTWXPizvQ
         zi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440403; x=1721045203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWm0q4vg0Q1TFYMIwbGOJClhSVkKdoB+CKaiPTaiNPY=;
        b=t9HLwaFadL8JTysprvtsM6aIZVV99aIW+p0089BwfQQ1RUP6BzyHPg47potcLZJTWO
         JzE27VHxnnBoX4nYm3T7wgFH0U/MibKycZN+V7yIx6Q83GI91sPVAaFgLJ+RhXihOONb
         kY5DDCwnJQFD7ogNSLEtDi0KdsmxuTdRAO3K21rOTu8hqjkVIFyvTcOuI1gQYBOawhGp
         pLM0rACAKQmw/6vAm5OfY+B4BVXHLlneU14KmXPxxnlL2n12n3NqXYp1V49HdML/mg88
         qzjVbr8UIjD3JeOl+FclPhalalGBtFzGrUBcONJWFfWuSvQea8s9jTg0+bw2pZ7rEHnM
         DQuA==
X-Gm-Message-State: AOJu0YyxrwTVZLKL2lsD7Gsqv7G3VB36oGI+k+7SZR1a32pg+siC8rWd
	kQ3VtPPREU5xuf00CPu2AAzSJkEyTh2jl1vMoR39A7FP5VEqbGKO
X-Google-Smtp-Source: AGHT+IHKO2V753USDdXaBxWnO4iuXrHYEBf/6yxWwG4aJV7JUDQ23lT1coxouKL4idjF0GF9qQpEwQ==
X-Received: by 2002:a17:902:db03:b0:1fb:35c1:3680 with SMTP id d9443c01a7336-1fb35c14265mr64143275ad.62.1720440402879;
        Mon, 08 Jul 2024 05:06:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb44752cf2sm61543515ad.268.2024.07.08.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:06:42 -0700 (PDT)
Date: Mon, 8 Jul 2024 20:06:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v7 1/9] fsck: rename "skiplist" to "oid_skiplist"
Message-ID: <ZovWUa8JvzXooqwL@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
 <ZoVYjrfCFO0_K4Ry@ArchLinux>
 <ysrjjyksfwto35ug7o6xbgbu53vvjso6nov3u2q6vvdprolqwh@vjhcc4x45j7t>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ysrjjyksfwto35ug7o6xbgbu53vvjso6nov3u2q6vvdprolqwh@vjhcc4x45j7t>

On Fri, Jul 05, 2024 at 05:07:29PM -0500, Justin Tobler wrote:
> On 24/07/03 09:56PM, shejialuo wrote:
> > Because we introduce ref consistency check. The original "skiplist" is a
> > common option which is set up during handling user configs. To avoid
> > causing ambiguity, rename "skiplist" to "oid_skiplist".
> 
> I think the commit message could be expanded on to provide additional
> context and reasoning for the change. From reading this alone, it sounds
> like we have already introduced the ref consistency check and are now
> looking to rename a variable. When really this is a preparatory change.
> Without reading ahead, I'm also left wondering why this name change
> reduces ambiguity.
> 

Yes, I will add more information to show the context. "skiplist" is
initialized using "git_fsck_config" to parse the user-specific config.
In this series, we introduce ref-specific check. "skiplist" is a general
name which may make the caller think "skiplist" is related to both the
refs and objects.

For later implementation, we may also introduce "skiplist" for refs, but
for refs, we concern about the name not the "oidset". I will add more
information to explain how this change reduces ambiguity.

Thanks,
Jialuo
