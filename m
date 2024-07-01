Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4712F365
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834557; cv=none; b=Xmrq2QZacNcTFWl+y5/d+33IWlnPKuuBRNrKviGcFCGUsti8P3aX0QL9VbkdGvF8/MuMd0tJ9OliOHPgG62Au+HdbKZzkClJfekUIIqLIhpfb08dfj1yvDneqGUFb7cEQjF6O2GagmRLz4Pf/FYtn7XDFt0zNbNv4iI2iYXWaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834557; c=relaxed/simple;
	bh=oQFWno2vr92na37NJZBim0Bahy6OC2yF+jiBrl6sfs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plZd59GQ4tvcodTks8GRz+TmL0sTLMRyX8ExEc1QDbnmP+tMb8tbEcYRzCTZdHh9F0usA7Ac2kSfSL2QdOQTwxQybTRbryw2TzoDBEXyhTD4xnxquK5dtUtgEvhaIGnb+ZKkBJlhcxyks7u7IUV7tySVZifTqVeL6b4Ce55Xx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTkb6DH2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTkb6DH2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d0dso21780915ad.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719834555; x=1720439355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbPI4eaP59YMOiIa4XRxbEDWvEXMEB509WORqUFac5M=;
        b=HTkb6DH2oVRutNPqg8Ty75aJzgccBfH04OKdH62cNUEH0fiJ8VcRhbnJLu/9TE3fbf
         wEiJ5ilckEZhjgJYxfrPOmCXttiDF9bEy4ca6CH9QIxXdcdzmpe24taj8LwR+Kznaqny
         N5OxJi3nSHx2+nYAGDllb8tHqQ4wvD6okVt2oTeZGQ8vDVKXfNOWb3litHfBuylBd1Vj
         SAYERchxLWFn43rCn2vt2HAZDhV3Q9wx1bwyhL67Dw6QMbl32vy69YXUsodNQHTZybvA
         byTK9PZwVb11UlWfyfaHnyeFJpvYF9pWWBYnP9AGadmlONfEtE7D/j9NjDqgcTzkqfSa
         s2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834555; x=1720439355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbPI4eaP59YMOiIa4XRxbEDWvEXMEB509WORqUFac5M=;
        b=ROOt3zpX21WEALGHpPXdjZtrjh9I5LF6IJe/sWj1LY2UZnKpMEBKp25SydJY2pf7A9
         XpIDKSUKNsnjiCUwxgS7rk/2lKmovx2WgBS6SvHASTeKhxmjq2euSY5ud/ZUteX4vDK5
         B/87gBrwyzaH7XnFI3h2ZF/XOG6gaYQlkBIArAjLDO8zCJH+mpTzJ8Tp9eUIP35Pa4g+
         elRjpw0vuDRCeHp7dfsMFuYlzJ1Nw397aUnehQX33PgLzvo8kOgVxLY+azDgb9pCaYbU
         zp0w0c8+DR/YS46ckPl/OVX6gMoqmmFXelgptsDD9iIo9g4G7ATbbyy/4k9UrmM1qhlt
         yCBw==
X-Gm-Message-State: AOJu0YzNI+gvSACL1z7vOVCAgZH0qLd78k/iz+VanQtCW+B/KT4Cu7lm
	vqhbeLfcu7g46sbQmNnNY+ZhtsLKjdRdUFd4gD4SmZw1quuwmZL+oi6Roc0w
X-Google-Smtp-Source: AGHT+IEtZF1KiEllgoQ3aG1bIw2h+c5vfuppNPDlreuNSHggMeBAbcQKQ2z072XsJGfUXi8XhFKXyQ==
X-Received: by 2002:a17:902:bb10:b0:1f7:13b1:7530 with SMTP id d9443c01a7336-1fadbb4c3damr41040635ad.0.1719834554138;
        Mon, 01 Jul 2024 04:49:14 -0700 (PDT)
Received: from google.com (202.168.16.34.bc.googleusercontent.com. [34.16.168.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac157a212sm62640065ad.241.2024.07.01.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:49:13 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:49:11 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: Determining if a merge was produced automatically
Message-ID: <ZoKXt0jPphoM5nmJ@google.com>
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>

Hi Pavel,

Pavel Rappo wrote:

> However, this bit means that I shouldn't entirely trust its output:
>
>> The output emitted when this option is used is subject to change, and so is its interaction with other options (unless explicitly documented).
>
> What is my best course of action?

I'd encourage proposing a patch to make the documentation say what you
wish it said.  What guarantees would you like it to make?  That will
help with others in the project being able to decide what it should
guarantee and what it shouldn't, and regardless of the outcome of
discussion it would make the documentation more helpful for the next
person.

See Documentation/MyFirstContribution for some more details on how
proposing a patch works.

Thanks and hope that helps,
Jonathan
