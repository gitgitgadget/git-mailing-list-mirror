Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E7AD39
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932202; cv=none; b=kCqo0n3tOAwSJ/qBmg8ui46gFU7czSpx3+7rroyl9PWhTTxXUI4B+GkS76QbJDWSKr2kiYHk7pX1xhQXn9AbknIDD7RENNLX7zxjkFBqCJf02yazX7gn5nMeNjgPQFPu2DioR7vy49wFax5cEQ/RGCd2gQfUBqkS1Y0ePPIV8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932202; c=relaxed/simple;
	bh=+FIXkqMQ07oBcpu1eOy883u04fPwgvwYpcjlsZDWqfM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jkxsF+TxPBVTTM8GWZbfV+dO5I5LBTBCeoy4s1qFrwu0rxF4iAgYsfq6J3q002wkBG07ehWTjSvxzB7RBvsudsGO70te503OpWpgumUEFYxI67NAYsWpAFP3RFcLL0S70eR7naNmrtYwLUVF36CuWn79S+5nCjkzSSMrWShRkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8fCdE0P; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8fCdE0P"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2235189adaeso54992635ad.0
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740932200; x=1741537000; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FIXkqMQ07oBcpu1eOy883u04fPwgvwYpcjlsZDWqfM=;
        b=V8fCdE0P4D2gz67kVzxkIpjhTEi9r9mGJMDl487AKrxSdIz7mEcy25gcbMTYBfAeLI
         fpT3I33YwtvsS/fIxGXVJ13SFBwXBYFopznhQTrJ5CO6UdZWO1vnZhnzNXdQjAEY9kym
         eHa3xK6aHJjx+W6IzciGuhU/9X5MA+Dl+toDdoF3hel5YXbUsZnfz6HlEAvy0Ir77bHP
         4ia8zPJSiMbyIWVDkrwOUcebyJTrm+XksAFv7ZwSd85THru4EF9cG0vZZSKsy30NMiAx
         da/fXOj1VUR89xoH8g2/TAocaDkOe9jsCOmU046elx7b0UT7gA2A7Vb6ssQa43/Zo2Zh
         F0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932200; x=1741537000;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FIXkqMQ07oBcpu1eOy883u04fPwgvwYpcjlsZDWqfM=;
        b=aCAKShrs3gxyor35WbZUQINjFqxSdQbedmsonb0z3qKhyEVHO8Y2kdWoAUe33fWdpe
         0XCh66ZdvpgfDPtPGFXexOdOb4Who49mo/3Ry6ujPHKEM58eehgs5Z9hQb0sAfhXXfX5
         rWHZeO6Q9B++BB90pb8RzDSyAe8M50XQpBUA2mndCp4HKe8gwU7ej3IppxWmK5ioLY6j
         U7RGGD4/d2GKqPEKpmDj5Zdp6hlxpb2potiTQKkeyiiYwF/ba4e2wVZI79PiMIowsbYp
         PiW/EBNwLh/WvNpklQNoNqt/ISzcFzSlq6LSsQbUFNSeZcJjrvqPN608oJ7KndNoJX3F
         P1dw==
X-Gm-Message-State: AOJu0Yzx+7aQiJLrOxWnaxJ8uj3CLhBECqh/mXx4TsrY8KvpGbMouSsE
	FdrsnEhA+eZ65cCzuvMVl/BZCu+XrheV9t3Yp/QnFonOl8aLJoZ74lM5Fw==
X-Gm-Gg: ASbGnctTxmOAah4WxaOya7jjWZbMuzDBTFsXEwVkLWQJahd31yp/Sb0E8BvDLep1Lwg
	tjp2hOfMWbysNcA/ZkdW0UzA6A6q33VTfqKEH0w3hilCvlcCNg8s7tjIUjiL0ZEJwXIUSHeAD+W
	p4t7W1zqrMMMIpvV3pdaJl6eJsVghJR15F+hzSYAlvvha/+y04+hY28SGZ2wMVlMSd4+eCMGGV1
	+F8ME2/7wLhBZ/sj1pniwtxgds1BkWXx3cEeAcAsDl8YEoq6vqQgQ4Zz/Ts9rdiMSkKqmOVuAY6
	sxPkwp7gOoxqOUAbNwqSFpM3fn+CZmbIjwapaxVfADq5ULSmT72Rlw3LyqtUmLvxP+simyj50K+
	tcwA10JR/NqStTUcpdANgAkDYggPvkB8b6w==
X-Google-Smtp-Source: AGHT+IESI7d4yMPX4Gomi5BrvgKwifRL4HxQ8pL4JyprC9qVhJrCk6sdSTKAXqUhayqLsAgIZf2coQ==
X-Received: by 2002:a17:902:bc41:b0:221:1497:7b08 with SMTP id d9443c01a7336-2234b083b00mr182877785ad.23.1740932200503;
        Sun, 02 Mar 2025 08:16:40 -0800 (PST)
Received: from smtpclient.apple (154.200.184.177.as28165.wcs.net.br. [177.184.200.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c67sm62663885ad.135.2025.03.02.08.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Mar 2025 08:16:40 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][Patch] Does it have developer documentation?
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <SEZPR01MB5486585EF47B99A59C7E9F4DA3CE2@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
Date: Sun, 2 Mar 2025 13:16:26 -0300
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C748EB41-1F8A-4B67-B809-623D4104F78A@gmail.com>
References: <SEZPR01MB5486585EF47B99A59C7E9F4DA3CE2@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
To: li li <li0371859@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Does git have developer documentation like haiku os, where you can =
quickly read the source code and know what this part or this function =
does.

Git's Git history is very descriptive and the commits
are themselves a good documentation. If the function
description is not enough, you can inspect the
commits related to that function/piece of code using
git blame or git log.

For example, I randomly picked the function
`handle_path_include` from `config.c`. We can check the
history of that function using:

`git log -L :handle_path_include:config.c`

I described more this kind of search here:
https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/

I hope that it helps you!=
