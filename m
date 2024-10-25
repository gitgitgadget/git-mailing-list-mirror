Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99601D27AD
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848021; cv=none; b=JZg0bMTH1aRr1HTaawlBy8QW9jrrzLLJLSOp1gX3DLGcsnTxJLFfzZiHF8wetda5ib7z5SmAlKa+9z1oPKdfefv/9V8p6Vx2xWw6+MnX6/5Zux5SmnDsFhcB5QH7OYEHbQK9RHJfYjnMOGq5e74uTB3C1QkC/KHp4ZLnKBU4MT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848021; c=relaxed/simple;
	bh=ayPieC9tg9XC10HL0qXfKbhKhvl8hSNeC5iOwymyDRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvnlDUXu6DDFwBTnArmUnYq8EkkKzSM/lDcl7L6z7wzqSxVJcsCvqzW5Huw1oIuysrQU9b5cyWX4BVrLP+swRFKayw77FmoR3NPvzgBlqSqXjHp1rFl5m7wD4Au5++pT19KrPh4T3a+vBvCnYMmCiTiBmSp4fsOGEcKPzG8yUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMO5jVOW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMO5jVOW"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4fd00574so1126490f8f.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729848018; x=1730452818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hx1Tqc4joiALWooIM4ehSGEQIlv0XKyTDrSYDb1E6QA=;
        b=IMO5jVOWt60ZNPw0sSLTnTMiq+zAD/gSw1KN7TGoDUy39imEequZYVk4pyzAmo4Pmq
         VqWVU0Ys09syJHWzqF3PEL73oZm0y6TbcAgsEzPaxN+mqej4bbaA3zZwpXejXgfY8pu4
         1tNudElnBmDblYEyxMOv6LZGTuNKO7ZRs8nkamDG2lWR0Dgd551z9H4q4sA/oWPz1JLG
         Z1AjavgJxAfvyQQ5kcF2cT0dYR4kwQ8xjWFcWSpxYovZEc79OsMmEG4srCTfaNUiQtdd
         F/u/6AO+dvYy80bOWfOBscBFyZUdY0yxTY1JRNmL2xMKIpf4M6fyxJWEXLxZzTJgVQdR
         x4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729848018; x=1730452818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx1Tqc4joiALWooIM4ehSGEQIlv0XKyTDrSYDb1E6QA=;
        b=LsmaPQ8TMGmNOXytsxlVmCbZXlBWM1m3JuTdxJSTWmmwPZOILze4fhKLhy3OXT/hqh
         peGGA+0mGCs/mz7y3k9ILVq5uIYNui27Cv7o7ZnQxac8qoMY8kWpKSIkbzQ62bHBMhTC
         mPWiqx1YvTLntTzMa43da1ehdxtHpqbGZOxl/pfr9gNXHbQdDIqiA51eMvpS9T52AXtJ
         gL7t7stfREbJjLSz2sQFXZKYRoHfB872VKu6Njj0p7Bkst/2s1tOdIh21EYkA963JGah
         y+ePrR5iGo8VfpGj3zblSWaDdvNBybfwK9f3aSTCehRiBNLWMv28aXZqC9Vm8RexvXTN
         Ozvg==
X-Gm-Message-State: AOJu0YxWcX0U8B6xXVsEljV67CJaVbIwsx5OgvHnuVZCmO0Bhd5zA+1G
	tiNIwfZ7E6pT74yXCw2r0ElcVCKeSModmXJDqdzZ+7Xpq4kxv5ES
X-Google-Smtp-Source: AGHT+IExkEn/TTpCAfbatv50zTrVRqb7Vyr/yC/cCiCQH0Y3JnX9InTBW/ZkySVCYGjgDtdDtn1/EQ==
X-Received: by 2002:a05:6000:1:b0:37c:cce8:4acc with SMTP id ffacd0b85a97d-3803ac49e49mr3437161f8f.13.1729848017926;
        Fri, 25 Oct 2024 02:20:17 -0700 (PDT)
Received: from void.void ([141.226.162.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1028873f8f.49.2024.10.25.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:20:17 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:20:15 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t: fix typos
Message-ID: <Zxtiz-h7m5YF4Q2N@void.void>
References: <20241023170111.6638-1-algonell@gmail.com>
 <20241024114721.14270-1-algonell@gmail.com>
 <35e4259a-d442-4b8f-a986-412e04a64770@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e4259a-d442-4b8f-a986-412e04a64770@app.fastmail.com>

On Thu, Oct 24, 2024 at 07:07:00PM +0200, Kristoffer Haugsbakk wrote:
> Just for future series, I think crediting people in the commit message
> for minor review work is overkill.  “Reported-by” in particular is often
> used for something more substantial like finding a bug.
> 
> That’s my impression anyway, mainly from reading this list.
> 
> -- 
> Kristoffer Haugsbakk

Noted, thank you.
