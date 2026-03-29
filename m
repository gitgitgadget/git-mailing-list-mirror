Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385337A4B8
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794853; cv=none; b=FDmqcY2Kt+1biMH7+/BONvUAu/DzRRCaOIdTZmLdqjt+hSDK+1QC2BxZ2ajl+pPADh8aIATyigcFiRCsb+D15ABHcZqJU15iFJb7ngUxvcEAqW3pLdUIINAbJzBWXYegx53PNYUAvlSgjmpogGKi2Bqbtlb19Q5OI5nGMlHsdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794853; c=relaxed/simple;
	bh=zCiBnOMChXBJqJAjA1KL1Zp6Mh/Li9lx+i8lkDEBQUY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=h8m9xbWwiSp23G12kgEe0qf6OK48eQ21jaey54fTPcGEdo4MC54UKeMQ+5Jg/x7yNnpBbNLshF8RQ9I502XKYqK8cTTKpA/76+MvQ3dsUGEugrb6J/AGWwiXC5Vk6FojEPDn61MYI2ROLLrpwreGwRubFVE+a4yQbyQTuABwC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRv45DCQ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRv45DCQ"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65003f40a22so2432433d50.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774794850; x=1775399650; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCiBnOMChXBJqJAjA1KL1Zp6Mh/Li9lx+i8lkDEBQUY=;
        b=LRv45DCQMIKRTgiivB/jm/8OsD+L6kJLuw5EBsJya5ab20D4h6JfwfAkS/qnxConct
         MzZBDP898sEbYI6IHlyVFfUhIOgXBU3LGM4H/fiRb2cIb+NDwF11n8JULkLUXKWfxOoZ
         PPag5qBIv2nbkguzcTeVI32sW3558KBMPsFacAmifs4zKAC3foJ/rdXzJxTzyJsUuwLT
         DdtIoVRcc9H9SVAN+PS0bavnNc/N4vufhsynckpbkRfNrEEsVoEj2s3Uv7oZq8nRcrvP
         bUQ4Z4WndT6L2FU4SQB+TBGvT+ezI4glcARADaq8sjCifdRJj9OM/YPOtto7RXo+wW0g
         2Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774794850; x=1775399650;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCiBnOMChXBJqJAjA1KL1Zp6Mh/Li9lx+i8lkDEBQUY=;
        b=MDGnKSRo8i7I5Z2HSvIKCxsETaN2+pAhyZq0oryw5IR5zM93oEIVtNcZJ9CBpSHwFW
         NTtSLgMN1G250BV/t12TIkg4ingYOSngJXl4ZxvoVt9tRq8h13EwdASgZqEPI3PZoSgy
         WUFI9UR7IV/Pa8Z0fC64inxrMjF6bBOHhxF3tOeQjDNYzyH8ijJ4QdDS8lsznerlJjze
         LKfBRU681YFIOVac9cbddy/0RsBRQk/+8dz3c3EoNfvmiC5HiEGFwQIBMNSZ4AeU47JA
         R3GPQJQBycegeVcGMeeV0Zx5M3diG3+EIY2+VyUUPHYRViuW6I3qprcq6vbmQ4Hf5AUV
         p2ag==
X-Forwarded-Encrypted: i=1; AJvYcCW4yVYtz+EUAkvcgsG79nNdzlAo/+3hU2JiOThLNJYqjAkmc+LchT86cfhYO5H1qLMpNJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdAP8hOm7lSOs+5APxszDun79GAnnGW2jcM3b93L54B+wiLtA
	xbf1aX4QZWswwwr7rvgLuFfHGBFDj47VUizu47pCQHrPHQO7vIJDmFAF
X-Gm-Gg: ATEYQzwnmN1+Fu9V4VmGdWrMcLY2EUJ74U8pnt0nAxHuFS0glELEMxJGtJCG+Sm2bJu
	D1afmq2u7bpy8EGkkyGyxS6hCjRT6q7I8c+7IAQYVbkhPM5UTUg+xJL/4K1JYsVzYJnXYhNtgVN
	Ve14VBH9rO+M9chEaC8SxbxXJh0XTtc4wyyvLzzzevXw/h6cbBoabiWkzRtCpztP5M+9inUq/IO
	woTjqW/E4DLFV9sACyt1/A6XiwObcsyY+ANXBPOzY4ZupkNQcjFB3mltiLD6zXFVpdILXb1y8L7
	Q3g2/IOcPLvGQvbTo8m92Vka14YUoY68+Z1wZLE33zZZ13Zcer3pSQXDWOT+GXfDYkte2RkpelB
	tXjmLfWiY1RZi4RdwE7bPbUowl9qiUG5bVLqvm5gSQG9vuK2mIt4RukN2EDFCoIeeAOTkCbt4Qy
	6nIlS9/a1+CpBEcTTlxwsencYS2nhGCWEUzZbE+CTyRO3IDfRkxKIiU6PSwhPPpKbjqIL1ilyMz
	eSM9m19br6H1XCGh+CV8IaQH20vxVyUIu6qClqHFMj+
X-Received: by 2002:a53:ad83:0:b0:64e:a9f1:a6c2 with SMTP id 956f58d0204a3-64ff720d1e4mr7526939d50.22.1774794849887;
        Sun, 29 Mar 2026 07:34:09 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:841:cc51:4211:e4d4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-650092059edsm2573256d50.3.2026.03.29.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:34:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH options
Date: Sun, 29 Mar 2026 10:33:58 -0400
Message-Id: <ACA4834A-2F3F-4817-B2BF-1EF8134FA02A@gmail.com>
References: <3d8c9b3f-66d0-460d-bd61-a879a6bbfc56@opperschaap.net>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <3d8c9b3f-66d0-460d-bd61-a879a6bbfc56@opperschaap.net>
To: Wesley <wesleys@opperschaap.net>
X-Mailer: iPhone Mail (23D8133)


> Le 28 mars 2026 =C3=A0 11:02, Wesley <wesleys@opperschaap.net> a =C3=A9cri=
t :
>=20
> =EF=BB=BFOn 3/28/26 03:46, Johannes Sixt wrote:
>=20
>>> And not portable across
>>> teams with configurations committed to git. Myrepos is a good example of=

>>> this. My former employer had this and I know the Perl metacpan project
>>> also uses mysrepos. Changing every URL dynamically in committed configs
>>> isn't really a nice ask.
>> I cannot comment on this, because I do not know these tools.
>> There are ways to achieve a considerable amount of customization of SSH
>> connections with existing tools. If you need additional features, you
>> should sell your change with a more specific justification, including
>> examples that show reviewers who do not know the tools you are using
>> what is needed, but missing.
>=20
> The ways to do it all involve configuring ssh to configure git, instead of=
 configuring git to configure git. The remote is already configured in git, h=
aving your sshIndentityFile and possible other options close to that configu=
ration is beneficial to users. The escape-hatch of core.sshCommand doesn't n=
eed to be utilized for a simple "Use this indentityFile on this remote".

Hm. But if you=E2=80=99re connecting to a host (Git or otherwise) via SSH, i=
sn=E2=80=99t the natural place to configure that the SSH client?

I use custom host config to control identify files so that each host I conne=
ct to gets a unique identity; some are Git hosts, some are other things.

I don=E2=80=99t yet deal with different connections to the same host, so the=
 only Git configuration I make is to rewrite some HTTPS remote URLs to SSH c=
onnection strings.=20

> The only way to configure git without touching ssh

I think I, at least, claim that this is Git working with SSH, so it is natur=
al that both sides may require tuning.=20

> There is no need to configure both ssh and possible git with rewrite rules=
 with this patch. Which to me is a cleaner solution. One knob in git for git=
.

Hence let each do what they do best :) each knob where it belongs.

Just my 2=C2=A2. Cheers!=
