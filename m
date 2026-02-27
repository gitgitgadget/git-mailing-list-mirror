Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675372D94B0
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229151; cv=none; b=sDIeUdFj4Uv7rHrNNWstHqgZoHWCaCXrGLIa0Dk+dgk87wKNiPhjggtJWk2Cvy9NGVTGuQAnOe4FqTbcibyPAqZa8QqRDGyESeR+pwlDHiVmjpUJcZ607dEwy0edH7wxBsNa21QWzfdORgSaVkx7VZpwkEB8B0vBPZLHMROq1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229151; c=relaxed/simple;
	bh=eoP8vzMi2b9pTTQtoTPHzKOuEeJE7Tv6EncgnR/Nenc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p9kQJCB0iTiSPXaK+lbLMNniAMveQWLpuFylNA6r8/9MMeVMlpDE0YjfOviJjXU40k/FEkzlJ11Lw7Z2AeRLxphQo07dKCfWXux+fH7ratHH+SheaG0XhKMtRDtKhdzZANPb42LAGeOFxHJfoEmRXHvjJuND5sC5ttUbv+gUEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGD63KhJ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGD63KhJ"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ff0f61abd7so729738137.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772229149; x=1772833949; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYm4F5eGp/EZHcY+jcs+VWqP2RoDD4elqHVGLbSX28s=;
        b=fGD63KhJzzj7iszS1rTxU7AxVWrFiHcsPIaSXtXWrB4W2n11ATMHdIK3yW7kvfMgVW
         etwrHGy7K+HAl/6IJqe0DoGrB6NksEc6r7HPQvJ1zVWqJ9atrjKNztpvShB1BAIdoksw
         aWVAnUg/uirrxsQ23VqnPKSBt6Doss8oOcOrD5zgxDTpyAve9KXVUWEO6PzvV9RT65vw
         pozF3uyoWXn0WtjkRp61rShBIheLk0i3lU0BtE/l7iVxOXyktkuxKU17t452qfkgzg3O
         SHpVgzFhmijZAf3r2BzxkMkzBLi89ZKk3lXajc7/md9npCET7oSXCBM2dDEI14jE3pOq
         x2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772229149; x=1772833949;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYm4F5eGp/EZHcY+jcs+VWqP2RoDD4elqHVGLbSX28s=;
        b=GC0uMh1ffGjQ0OjujDshqfNuAHu2sAuKSljeTtB8dVJEEFL2DAnDl3gpZ3SgoTgw6e
         6rAdrNJaz1sw0QKg9G8Y+agSvoWzg0cMbwhkhU7qMg8oT4BweDGxl1UgtD/eqJj7PxZ2
         /TqNedHSFNugfgrqV9fVv3PxCBuXwhz9fR/SNn5/UcFDRda8w/b8ARt5hcKYoVdcA01n
         PCCBSatgJ/6BR/bDwRdh0B4dakxmxMidBw2IThdHnnzlhpvbiPacQNZLXhIiWrjHwHrz
         tzCwZUAIMZcS5PCWVvpQ3d0CtBXWkFndl2wQ1oC4KYeYiFE4VicgX4kkaHLYfGm+qwdb
         343Q==
X-Gm-Message-State: AOJu0YxvbuNOxM7xcKmV4japBurVHn64/pla4qlWxH3S0Vc3hchoMeo4
	WCobmJMRYPu7QRSE2FUVWuuyca6yH2sJf988Dr4xXMvpAV7L9Jk9k/Va
X-Gm-Gg: ATEYQzyyQc0+/eQ4rocr4BFhHJigNuBJRXT6vIqTk7eqPeevVsQecUu+g4m6d2yYSiA
	NY3tMq20/NTox6zrF8By9DTGBuKYRiIp2kaRA8ADZ3/oZoPnjVjNCDlx6FAkdij75AkU2kM6c0n
	ccthuXkB57XLDI9cWAmG3uohUAOPFRcjj4Hvc2ft50RRRu4wTTn2ZUl0e3cjQYTZ3DSbX8rRBft
	7ovECUFJ/OS0Tyc8CYWKxUFWGzoQLHt9LqbK3gtQkOrM8wHWmyCcu4L//zKrM6VairUI5I3zIAf
	0sLfJ3MAaVE7KdI+V9Mfihpw29FEeF1O1D1+Dd4l8CE9aFS9lemw0MOS9tgOPsEtf+1eFm1o3jv
	/0ibbaB1oR106W21BMCYk9nRH2M9/mzA9h2tD/rVXg6OmUsleb3LaeDd6DxMlj0WwCAeH7D+vj5
	j9i00Sr2/n/Y+Gzhvr5e2QmS8p/zVDWWCJYZou/62lH9QB7c2E8W/BHw==
X-Received: by 2002:a05:6102:3907:b0:5f5:25a4:c6a9 with SMTP id ada2fe7eead31-5ff324c0658mr1910443137.20.1772229149290;
        Fri, 27 Feb 2026 13:52:29 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea1596asm6827955137.9.2026.02.27.13.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 13:52:28 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 00/11] repo info: add category/path keys and
 --path-format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 18:52:14 -0300
Cc: git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 eslam reda <eslam.reda.div@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <31BA8EEA-9C2C-4485-9066-B342D847807B@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
 <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
To: eslam reda via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> * No git repo structure feature changes.

Patch 4/11 changes git repo structure

> * No t1901 structure test changes.

Patch 8/11 changes t1901

> * No structure metrics/docs additions.

Patch 9/11 changes git-repo.adoc

> Commit structure
> ================
> 
> * repo: teach info context and category keys
> * repo: add path keys to repo info
> * repo: add --path-format for info path output
> * t1900: cover repo info path keys and path-format
> * docs: describe repo info path keys

Only 5 commits are described here, while you sent 11 patches in this series.
