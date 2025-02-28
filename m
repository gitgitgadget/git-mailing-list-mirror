Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0025BADB
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737538; cv=none; b=ABpjgPJzV51MoJXWaCKR3R9d+vPvEFAi18lr1JYa2XIkUTgUrVDxItpCN05wiKUcQqlDmFz2xBA9OGN6TpMqc+9l5WDK5k5lm47mofbi6IjDl9mQMEC0tHVKhF+0OUyfddElT6tKq7qnjcXQFaNDZ5u4bBaryRRjBIs2mL0Rt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737538; c=relaxed/simple;
	bh=6Dn3a/vx/9lRRgdCNlY0+BwCmPqaDf/rbvurGnQHgNk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k1aHqJCuRj10DT6Las1f7W7Djg4aYgRiEGR+xCCqbbDNANPyDErRIj80owjaTGXqFSQPbQk2AlzJH/P6Oqeksv0QY4ESUikiet3HW8Q1KniN5o8jUaID1Gno4vxfNeXxTmEUUz3okYvTEYg06EcKUjpbDRy1aAo2B7rQd2ZNInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD4x7Lr3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD4x7Lr3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2230c74c8b6so54229605ad.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 02:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740737535; x=1741342335; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Dn3a/vx/9lRRgdCNlY0+BwCmPqaDf/rbvurGnQHgNk=;
        b=GD4x7Lr3P/a9OVP23KCoSSDtI3D33gRytF40HfO7Q6KTcFfr7aVrEhRYVK/spWT/YM
         6qTmnhQ7nI9R6zVdOXkbpdlSlLh5ITNQokaU5UQwU0xoZqqn4BSlHI5pAcQdSA87Hdns
         Qws7wtVSl29XxYNTSRwCWbrJx+K2Hi5hfNIYgnysT+URrZR5XyLu4T7jl5Jx3s4m6x2y
         lf0wAhEVez8K3C4g2CeZDtLBkUk1uSX73V2+6aCRSYzuQ9uyyXA99iyA9i5+ayUzSL5x
         eIMGPrLfg+NHCf1xRxe4rxiCQqE26jk4+PpE3dDUW9EsWra60YBHTF5hInWKT7xjI5qa
         1ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737535; x=1741342335;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Dn3a/vx/9lRRgdCNlY0+BwCmPqaDf/rbvurGnQHgNk=;
        b=f6v7Aicur7foy/Dp3RAxP9pFIzQYV035kt6fB3XglxwsP2L+rhYhal8tJZXmHRGNwa
         fGzdBY9bo2WX747KaN++qsn34c6s+stAwx9GXCoqONd1J5D6bxj5TazuHsVi/pyhLH6j
         Aygc294rnGi5y2TehJAsZvXKTpxj2crLDqJF5kMFBpWZNOt5/Wo8rWhQNiiWC39GX5Ri
         BVQfBc5Aq6I68f/ARjn6dLn7JxOvPa2+My2MpoL59d6DG5XRsiDXREDKWc4FU9oYb0fs
         O8VCCQj8F349g9wz7Lihv3vaPei7NJs5t8KGGVIQoTwNmzBuuqu42194RKuJFbxgPtTk
         nHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXZAA5w6lMrrV8zicMFvs8rIIYy8uXtFpph2QkuLxPrgBh1YnwZxML3gup92iU/pF1TYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedDs7d27InhSqvhDmw7F2qu9g/JHihbiNixB9g5wBZZjk1xig
	HuWEud7E2Zqyp/PtdBTjg0W4MeBEEqfEw11Ah3qZ9eGDEsIjHzhw
X-Gm-Gg: ASbGncuOhl4IRvQ2m/1jygkvCRP2w55AsQK89ZV6WxDWwMz7XDbGXM7mlgS7FyKcUGO
	VDVqaiS/6aIevBYgh5Nu3hhll2G/rWfBXtO8fjhS2PEaqXOA/MmWNSeLxWjIDpTHNegJGWwqu3R
	+0fEVdYBwqAJ/pNQuQJTursDJlNCsFNIIKBhVguiHBpaRl2ZVCDFZ5o1aeCibXcYrS4yfxNgn81
	CSQHEyKS43SrytyZklsXmYmePzLKyQd/AIZTB2CHdyE30c++ltg0H2xB6xLE396jBufOMkge/7X
	3sb/Uh3yFysU/LdqNVLN8lYT5GUPng/rxsujqiH7WMkE2a062Ypt
X-Google-Smtp-Source: AGHT+IF0WjisXnJCq5S683NnG309hzYpd/bHV1ER6S8aDs5mTqkFNLyL/1BmwlSafZwqN2Ak3I6rlg==
X-Received: by 2002:a05:6a21:3291:b0:1ee:e4f0:629 with SMTP id adf61e73a8af0-1f2f4ce5333mr4358234637.18.1740737535281;
        Fri, 28 Feb 2025 02:12:15 -0800 (PST)
Received: from localhost ([2401:4900:8817:a511:ac4e:77cd:49db:c935])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de37e7asm2621674a12.40.2025.02.28.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Feb 2025 15:42:07 +0530
Message-Id: <D83ZYCF2FK80.31D5JQKVVP069@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Git Mailing List"
 <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Karthik
 Nayak" <karthik.188@gmail.com>, "Jialuo She" <shejialuo@gmail.com>
X-Mailer: aerc 0.18.2
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>

On Fri Feb 28, 2025 at 8:33 AM IST, Kaartic Sivaraam wrote:
> Hi Christian, Patrick, Ghanshyam, Karthik, Jialuo and all,
>
>
> On 19 January 2025 3:43:29 pm IST, Kaartic Sivaraam <kaartic.sivaraam@gma=
il.com> wrote:
> >Hello everyone,
> >
> >It is that time of year. GSoC Org Applications for 2025 are open now[1].
> >They are due before Tuesday, February 11 at 1800 UTC. It's good to see t=
hat few contributors have already started working on microprojects this yea=
r :-)
> >
>
> I'm glad to announce that we've successfully been selected as a mentoring=
 organization for GSoC this year[1]!

Nice!

> As you're new to the program, I've sent you an invite. You should've got =
an e-mail about it. Kindly sign up via the same to read an accept the Progr=
am Rules and Org Member agreement. Let me know once that's done. I could th=
en add you to this year's program.

I'e signed up and accepted the Program Rules and Org Member agreement.
Thanks for managing the process!

>
> Let's look forward towards for a great summer this year! :-)

Looking forward to it!
