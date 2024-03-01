Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BD3D65
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303972; cv=none; b=dOFmcKqHIGjHUJjhaYUmjsB2BDqpGveQD8hotTxHuIlBYUkH9OSiSua2N2ADE9tBGLxqHwJoG4Rkgh7denxfMqVHG/lacq4ia63umlWfLkAxqZSsrVsd/kMAmgNVJMk50vD/++8nzLc3NYxDlh+aYcXD2vilrnlLtmCMnXdSMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303972; c=relaxed/simple;
	bh=4wCka2LbW6Zbk2mA64rSVsK5AUNOA6N0AXFjkBd3aWo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tSwtyBkfzYkUqVwhl5sGEvheANpG7G8fT2OUG4bvE98jghC4HILoK8ESIrsPfbRZUYnWF/FWv/UGmZBPc0Pxb+KlBAM7iNnuKzacJEtH2vlcPafwhKK4ItQZNRofyQQUCo7b/4e3olk8gMLuKbZZ1rtBzSZ7eX/6w4akrrFbowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU1Fqm3c; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU1Fqm3c"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e558a67f70so2135250b3a.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709303970; x=1709908770; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wCka2LbW6Zbk2mA64rSVsK5AUNOA6N0AXFjkBd3aWo=;
        b=jU1Fqm3cwhfz0iGfMRAmTcHm59XAv10Ce0wCtcgAVGnUVXkNBidA7ke0z4F9pYcChw
         oltF6ruUV2UbkvZgUplxSxunXT1yWDvzpmU7aVP9eDsot5frjH9NzE3GK0xTSLhOewJc
         fXuIH2uvkrXvNaG6PmrUe5WG28D6H158UHiX5Xqr//9IE8wXYZQqI107gh0UIugNnACa
         H7UNv3RynV586nfmc7pYEcfuWN1wAhS4CVSZS28ut2j1uQn48n+8EfUxce6kk9Cy4I7f
         r16Jf66F78TeSMURdutv+C3/xDjD/j/q6i/VMOpF/2/OlSagVALvWZNSWS24puukxsXU
         cKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303970; x=1709908770;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4wCka2LbW6Zbk2mA64rSVsK5AUNOA6N0AXFjkBd3aWo=;
        b=ib1YdbZxkbgfCCtMBXQD6EVE8J5Dxpxm13BlYQpl4N/gvI+/3UygZmDZLfiQKSP+LE
         aLwr0U3r0gqQQ1wHZQWPe1UWwce4qwJvZIe8Ubvem7sZLJUjECI54z8uxIn62otr+p5G
         U3FUAGsQfxjaWswEOk0oVNSj2TgCYgqqGjzpl1ofmh/iIsxfxM3X3jAdT0pXz7acXTzT
         pPKAOATiu+thb4S2azT61LywzgsucNgwJ4dolMKNkV/4NtelSg6CvqRpdau8JGGSQCg+
         H5B2Dz+IPKCeIgbAGZ+ElvOnZATIdk5lL3kam7XXBL6PmI1HfApRNEG+ZXYJe8VKW7k5
         ds5A==
X-Forwarded-Encrypted: i=1; AJvYcCXEz1EHZJRO8OYuNyFjBrdhEoA9UlfLDIVhIFxSvXC3ID2Y2QvsdGRAktchOrvys+krtLgsef9rdptuw1hTuOPGv556
X-Gm-Message-State: AOJu0Ywq/gnjGEQcX2ssI+GADrqzjHR8cu0qecmtTyb/IMkce7mjh0pt
	AfQACm49yBoxybyBkoUck9L8KBgzTgx36pCsgp7TpnbpKpjVvOoG
X-Google-Smtp-Source: AGHT+IGhh6UigQMPGUi2XXtW0bs8okptlSYcMioF121ZeJQkyZw6oD1++7L7pLB8E7sFH2oQPs64jg==
X-Received: by 2002:a05:6a20:244a:b0:1a0:f096:4ece with SMTP id t10-20020a056a20244a00b001a0f0964ecemr1991596pzc.2.1709303970166;
        Fri, 01 Mar 2024 06:39:30 -0800 (PST)
Received: from localhost ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b006e5dc1b4866sm35822pfd.144.2024.03.01.06.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 06:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 20:09:25 +0530
Message-Id: <CZIHOPD4IVXH.32HVLZ4K0YNXY@gmail.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, "Junio C Hamano"
 <gitster@pobox.com>
Subject: Re: [PATCH v3] build: support z/OS (OS/390).
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Haritha D" <Harithamma.D@ibm.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
 <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
 <xmqq7circevo.fsf@gitster.g> <B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com>
In-Reply-To: <B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com>

On Fri Mar 1, 2024 at 2:39 PM IST, Haritha D wrote:
> Hi Team,
>
> The win test(7) test case failed stating the reason as "The Operation can=
celled". I saw that it failed after 5 hours 59 minutes of running the test =
cases(build). How do I handle this?
>
> Please suggest.

Hey,

This seems to be a recurring issue, as this happens to me majority
of the time. Seems as though the vm just sits idle after finishing tests
as 360 minutes is the timeout for github acitons.

Usually, rerunning the failed tests from the actions tab works for me.

Thanks.
