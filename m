Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4301487D3
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064069; cv=none; b=a763XiIz772GXErNzyKbo1+AwMB+9pP9neWMf9Yjj4L/EV3CpB1fuNTK8BIkbQ0R0dGcMwAlZM0rPAi1cjA6tiqOgTv9PJ9damqCaAz3b4f49R34Dz51sZ7sONyIUt96aBuEZFtMFrKkL4ew7IV8FRUSsIESIj9RsvQIbs43HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064069; c=relaxed/simple;
	bh=dDbPeB6n0adhf+Z0p0W/yWRrEQgeX90nY6C/BShw2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCNMMDLQrvuvyUZWvT18039tCgQtd1zQ+8ByIlqwJLu8V1lgtCXM/+TT1gaBjiihEDx2YzCQtipcBYoZi1YoAIyCoZziYcoZW3gjxxU+RrrFR1ZXhr5geoBpULfOcDUmQyNn/1g5RALPnxDpf5f/by0u6n3XTGpH83kYBEqy5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW5kDm/q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW5kDm/q"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512fcef91d4so3410777e87.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709064065; x=1709668865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCBwh+vXSGHaKdHJ4p1Vmse+GbTtXLwKPgBZI2vIzac=;
        b=MW5kDm/qH3YYP2aNasn4zh2HtwElM9EC+84b2uiyzt69rwn8aY8LQMyyZBPNt5bnxr
         MiKDpJAioddqRDL2Dp/huSoSApjC6zZ4ECAehF/P3D78HvWMe5BzJFSOJwkPCU17uvjE
         1Qtn0C0Tdgwmnhn1BbOaIRRdzgkiScHfwlvTDPw3+sdzCHj/CXQB3na+4vHjo8BZpsAI
         COTjyLW62CdTLZN0j1fA7hdkurcu+xtfjUtsD9ng3KZAgm7McmluR55ixhVQ2Vr6Jn34
         3u859qqS/oThnBFHeP2WL05chb6seA7rJTZbNTph3Q+L5u7WQVESsTbpXR2gchroKxqj
         GOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709064065; x=1709668865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCBwh+vXSGHaKdHJ4p1Vmse+GbTtXLwKPgBZI2vIzac=;
        b=lmGhdtw6weGF0HzRJsDRf7FcS56sQbikzJZYHpGG6NiONRD8Og6HxUr/BluoTeAVqP
         xZaGYvLdZ/ClrIv78YAC85HNIJ6fMsDzjohcGUL93PCAw5Not/9VARyDFEGBSXD/SLjL
         w6FMpEZP+oZ63YS+RNynljWaEThXDLxF0VZ9TcsntNBMPbbWPs5+vYNd3IpPbCBX/VBz
         KbI2fzjO+K3HAsiUSb3gsVUsLUqfA71Q2n94F4pY3HRxFyYxNQr0OB0N1ji0vGIVGH9z
         oeMpJgXzdvLHWG8Q+wHF39I6IKK1+FCdxx3x3gJKA086Em1NgAlHA/klZvPYmfc5hnu7
         +suw==
X-Forwarded-Encrypted: i=1; AJvYcCVRMUFQs4zR3GLrr5Mjs5lE8Gu8B5wh1eP5zlNMRsfbwNNlAELbi5L9KGsv0jRsnwofs2Z9flkPPGPix4h1kqCpT8JF
X-Gm-Message-State: AOJu0YxB+LLdfVWMZdizK/3ylxdfh6xfrztwU7s0xLyR/iWO12VyWlvU
	bLJzuH+2RtmewHLVIOxkPcO71cufTLwh4nAcYICvJY/xPd8+7iuNcuW0PhrnNeGwmD/iTZ1gOt2
	ZW4Q0C9o2AQH5PbbPQOUGI+8IzqkNEjTfeHR+0g==
X-Google-Smtp-Source: AGHT+IGPlBMPaFYwmjEzaJFmP3ooK0Jtil1E1XbIWJjhUfWl1Wkn0/UtVL/bLBiMAAmM4Bqcktefz6wjn0QjMEU7Av8=
X-Received: by 2002:ac2:5463:0:b0:513:972:dff5 with SMTP id
 e3-20020ac25463000000b005130972dff5mr1618773lfn.18.1709064064864; Tue, 27 Feb
 2024 12:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
 <xmqqzfw2vr7c.fsf@gitster.g> <CAGJzqsmSzMqEG1OU9dH6CORV6=L7qUAFNJSmi41Lqrajf9mSew@mail.gmail.com>
In-Reply-To: <CAGJzqsmSzMqEG1OU9dH6CORV6=L7qUAFNJSmi41Lqrajf9mSew@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 27 Feb 2024 20:00:00 +0000
Message-ID: <CAGJzqsknN_RmYeT0xcn4cTLcJhsxSOUC6ppRVepxMDf3day5Fw@mail.gmail.com>
Subject: Re: [PATCH] credential/osxkeychain: store new attributes
To: M Hickford <mirth.hickford@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 22:35, M Hickford <mirth.hickford@gmail.com> wrote:
>
> > Thanks.  Will queue.
>
> A first-time contributor contacted me to say they are working on a
> more comprehensive patch to credential-osxkeychain, so let's wait for
> that instead. https://github.com/gitgitgadget/git/pull/1663#issuecomment-1942763116

Please disregard my patch and look at Bo Anderson's instead
https://lore.kernel.org/git/pull.1667.git.1708212896.gitgitgadget@gmail.com/
