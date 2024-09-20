Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15E2CA5
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815619; cv=none; b=ZLgISQ9wI0WI6w7YkcGFS+O6Lswk6Dh178tU2EDYu3HlanmQrjWhI04s9diZe+HAPDY8Dcs1G5409kNaryv0bhpi5IXxMT1IZmVfeKrRiTOM2W6FLnGsj5p5j5UG/UPijH5L9l0pCKFNzLCyOjPj24JUMK/SgG7HKsJdvjhSJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815619; c=relaxed/simple;
	bh=rScqi4tNK90Jv9bwDHBVQ66jn7ru1OrXglVNxrhJjVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH29XQYdMBWj+u4+CEp7zEXY+CjDknfOrIa2OAf6f0VGvXP/hrTrD8o2R+aqwa7MF9woLtWkkJRyY/7cqk5f6k7VdLRnER2q5pLYzMJEw76/2GFmLl4fGcC+SWcATz3MpVLJAMS8eFBkvzULGuuRq/gOszxVvnQ3kWAZssLvKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ars88a7K; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ars88a7K"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so992755f8f.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726815615; x=1727420415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RjkeQsu30gbdLww1DYh2o1RRWCOw8kFj1SGtg4VdVJ4=;
        b=ars88a7K4i2vvMCVWf5Vnq9+sTXaHpXuyY2df13pV/UDFyrPQHUT0NbPQTt8LxoUP8
         uJlJ8DpLNLajPzGmsLWmXPmhchjxlzUHtm/lGn5jy2lcxmFVjbRt200Fa+zw0Kh0Ceq7
         qG9JcMqLnGrlm6lt9mTfawqI3qPg67CLz/5i67OJ3OrfRezUrR5Uj/je5+xh+nyIBO20
         gY6vAuyJF+uxCyjidA4r/ZFjgNzZbieodyzQcz+C/Ejh215EQGdyBH5ugyvzeeYLxHcw
         hdhK1xdStzoEn6ssVAPzcgSv/yyPmkI5v9ahPik2R19t96FqMmfDrOjOOKSooM+7g8Ct
         u6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726815615; x=1727420415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjkeQsu30gbdLww1DYh2o1RRWCOw8kFj1SGtg4VdVJ4=;
        b=cmoQrhw2PBsbz4emG/kxjSPEdB9odWKIOB4bgurqIG95xDBq+XOCKwJC1TK6fi91eG
         hUf7/K78ssXZbJRdAkPT5itEtoEr6PJxw1xUJGWQFARKMQz8AXtnQa6dzS8kYOprnQXg
         ucKw7vKx6YSfmfuPpJrNt+yAgshjs33lH5faR7patvjhFSmGh9C0rrGG2W6cXTeoyRaT
         xItAreDC/EzjL0H8I5ZUwPeJu5DR3oLAqNXZIJgA4qcE1YvPL/BDh2XHaVIbydjE7WKW
         QGa+YaCWT4JC15Tsy4KPWzyREZWLYlmM6hI4E1LMZblOwpbLFdVBHV4ek6HtPyOpuLyH
         6Wmw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfv3FppG5g6sGeZv3k9oq1dEfOv+wzg59j8McEjgKxX0gSL3L5VG77NhVE/h6KLY9w4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xlAqRIMIygOFmo02e1kJdzj0ZbuqCB1EgTcRFb4o6YlZNKE3
	NxOPoh3TMmjUhiMkSQihv1FzKDrIpznanbWGX/zRIZgpr1sDakht
X-Google-Smtp-Source: AGHT+IGkpgBceo5cazP/4O5vqNBlUfSyhacjHZhDIgNSLk1wicH7xONtOmk25VREf58f4KNWB0kP/g==
X-Received: by 2002:adf:ea46:0:b0:374:c4e2:3ca7 with SMTP id ffacd0b85a97d-37a43129148mr728184f8f.5.1726815615300;
        Fri, 20 Sep 2024 00:00:15 -0700 (PDT)
Received: from void.void ([141.226.14.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99b0sm16856732f8f.60.2024.09.20.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 00:00:15 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:00:12 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Andrew Kreimer via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 00/20] Fix typos
Message-ID: <Zu0dfP4UT7v_Uvmu@void.void>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
 <CAPig+cRhgf4pLycL7u9Zc13TXdN54ccv6xMQ9p6v8pvfRESTLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRhgf4pLycL7u9Zc13TXdN54ccv6xMQ9p6v8pvfRESTLA@mail.gmail.com>

On Thu, Sep 19, 2024 at 03:35:25PM -0400, Eric Sunshine wrote:
> On Thu, Sep 19, 2024 at 2:35 PM Andrew Kreimer via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Fix typos in documentation, comments, etc.
> >
> > Andrew Kreimer (20):
> 
> Thanks. These all look fine.
> 
> Out of curiosity, did you use a tool to discover these mistakes?

Thank you all!

Sure, my secret sauce is codespell:
https://github.com/codespell-project/codespell
