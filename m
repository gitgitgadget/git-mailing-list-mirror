Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718C13AA2F
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268149; cv=none; b=styCjgl+cjAwDJUFMRefMheSEiPDxbe5OF8el9Nvv6u6sqCEAIOUXNA8lcAghxLHhmEeSr3YWpRN29XmjOrA18gR34o4jwVfRb9RvPhNtui1bfOcLIDySlLCKxCROvoPeN5Zd309PRxN9EN35p3WO2Twn4xzIUt6ULzzrHnzI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268149; c=relaxed/simple;
	bh=dj5J1MLHTuMjND5fsitNqltegLY0F5aSNW1Y325MSx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VolHwnDZpTnoKe1wGj/bvA4Qjqs/T0SicsMl6rRh7rvqWMebj7GDgGkJ9Qj4f15/tehL/Nvw3i0RxHAJmdtV6AeD7JWRscwTxOjxAIeP1W3JjuTDUDwZVKWildMrFcZCb7mAxHg269S6QVphueCwZ0YQeT4tGbwIxleGEipIFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH/iJN31; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH/iJN31"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad617d5b80so18708025ad.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772268147; x=1772872947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+TafjU+/+LopRQNo7fMP2oJni9MktuBQToK7T0+6xM=;
        b=CH/iJN31qIPgAwViZ80EKxGUL0jwv2Yge7LwUPFZAlk2ZlawYxeIPoLRIq6UP+c9b9
         Qnvsub83M/EYuRZQQs6aDCF7LsDfOL+OI6GCgECBQk8TXvtFo2kRwWAE41KZHrSiHh6S
         OpD3H/LY3gvxWQCEgL9BzWZpT5lNRTkhFMQqIpw3xolDLexuXgnMr6MMc5P6s+/cJ6NE
         YLtLSZA5kZmw7pArTS9tHrc3QRJVI4tIcvN7XKUcTiKfBx019o8ekF8LHghrcq4+y6rQ
         HGuW62m9vkoBViujv4LGNpFg9Dt+KPXupVCChPoL2SH7WFmTEkOsaHnb9y5il8LT3DEK
         mAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772268147; x=1772872947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+TafjU+/+LopRQNo7fMP2oJni9MktuBQToK7T0+6xM=;
        b=wCeZRUPDgy40dTUe9f7C08oterkqrPFTWxgAoR7HMLj+QAqqewdXbN7LsV7Y8yglPz
         iqyiaK3hQt0EzI0xLCe/EhkdxSCDiw0mGlWHfcR/piAQ1pleoCQLwUzEcttuoMPrBfuH
         3Prcpy09NT5RJ/oh2uCD9J8a64kvp4Y6CXRkd2emWieSYMt68oMrhuvUE+14/sm88/9i
         SMZ9r49sd5l5NMh3WyWXgF8RfgeNcOdT+6/LAX7J1Ex+tHqcrvtlnlgGSpXfWTcEdrzQ
         4YQXTu/GehSI6+kdFMhoux0e5JQpaaG/UCqyUvplD8Rm6DOjcGG7yW1Zc26XYiH0UCAi
         RqPA==
X-Gm-Message-State: AOJu0YzhWymE7qhmdj/Jk9MmW+tgVH40JGA1oWE9LsoYSESjvAs81Ic5
	OKGRZddKMNZ9LjoL0SF7SL9GQ8vps2hKeuvNRBIEsgEYaES2ePsJoeE5evI4lg==
X-Gm-Gg: ATEYQzz0EnAvAcA+L7BeQxpI3+pXzdSH+q8alAyQJQN95H8qnT8rj6J81Zm4xGUcN3H
	UwZEK+ffy+sL723pN3BVpvM5wTeFV0YMh+yZ4XYeufMbjJNv9lsQGUoqib8hnp/cH2/KRDYWpa/
	hVDRFsB6Et7znKYp15r10yU9WI1G1+sF6g7clLGm/MQjptH2g0FzhtSx/nbg7vuoOqVOBNrCP15
	SApx4RnzsKFqO6UtOwDjnlM0U4ey3pGtlT8+olAfS+gRxwYz8LhnodynQBr60PPiIChaBK4vS4Y
	m/zQKMZ6i3LizLiyhvLBZqZQLoh+GmZKjzoYnJb2mxImNc8i8Y1yrurdhc+hCbKcQS5Elx0Y7lc
	ARffogUh+KPxFOAVI9nSsVi5g+jXZTEZBM3AF/96AfJlNB8P90bg55q7mG0OeVb4Ar6Chj/uyeO
	B4csit0C/thDJnoEynWB+20Mlj4nzBU5HsU/dWhRRkHz5ZeNegGt5jrAv00w==
X-Received: by 2002:a17:903:98c:b0:2ae:3fb2:ec8c with SMTP id d9443c01a7336-2ae3fb2ee81mr5945665ad.23.1772268147510;
        Sat, 28 Feb 2026 00:42:27 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:2af:8eed:2c20:6d15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1913sm108337925ad.77.2026.02.28.00.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 00:42:27 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email
Subject: Re: [PATCH v3] send-email: validate charset name in 8bit encoding prompt
Date: Sat, 28 Feb 2026 14:11:34 +0530
Message-ID: <20260228084217.239120-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2.dirty
In-Reply-To: <xmqq4in32ulj.fsf@gitster.g>
References: <xmqq4in32ulj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >
> >> diff --git a/git-send-email.perl b/git-send-email.perl
> >> index cd4b316ddc..3230b80701 100755
> >> --- a/git-send-email.perl
> >> +++ b/git-send-email.perl
> >> @@ -23,6 +23,7 @@
> >>  use Git::LoadCPAN::Error qw(:try);
> >>  use Git;
> >>  use Git::I18N;
> >> +use Encode qw(find_encoding);
> >
> > I wonder how common is this module already installed on users'
> > systems (not asking "how widely available"---which is "can users
> > easily make it work?", but asking "would this work out of box with
> > what users already have?").
>
> Answering my own question: "yes".
>
> We use Encode::find_encoding as well as Encode::{de,en}code in
> gitweb and git-svn, so it is very likely that anybody who has a full
> installation of Git would already have it on their system.  Also
> Encode.pm is distributed as part of Perl itself, if I am not
> mistaken.

That's right, Encode is bundled with Perl, so users do not need to
install anything extra, other than what is already required for
building Git.
