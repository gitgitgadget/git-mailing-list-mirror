Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1F4A341D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968163; cv=pass; b=o+9CBGoMPxKwc107NkELA+qNYzXLsdG5wPalZdg/AUG/N4BmBa5gFM5OmHhi5t73IX0j5zjmg4RWyeNZKlJy2vJM+T23O6dxnxPMlQrIyr0+oE/TecdR+QtTqtxQ2eS/UCD7pEKNit1RtaVLRCyl+1NbMrRnFcygFf1LeplR9MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968163; c=relaxed/simple;
	bh=LoQpgdLEhpD0XT0gKWKVmIQm/snUYgXInip2I+Q4cCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BN3LkPLAsNCji08XO51oPgpYrWPPt3F+yqHocLyMsYb6c3Fv2f/gnS6cp5pITUmsUngy66R8Mt+eL2eIWKUSz/z8LZ2X81vNEOk8hWubBxIS4g91N/0zlQMFel8SSwuI+xE275gyhcvj2/W22wJpJgik+HaSlFeOccg24a1XhG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgVWgUm/; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgVWgUm/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e75d1ba1so39010101cf.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 01:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791968160; cv=none;
        d=google.com; s=arc-20260327;
        b=L05sbuqcm9fV4a0QP506JMSOF+Qah1F7E9qepFhhiGJJHTJAG4/m73MnIXHE9TNQXk
         suvnGq9ET7GWJyy/mbL49MZaUqTDRatA+ZWfD2XgsQrWMwjKdEoXwDSKIuGVjupEBEPn
         EO33/4IiaL+6lPPL5GtVzfcSobbWGjKB2pv6m2TpUm9vM/QN+JY0JpfvAZlcUpGeAgDW
         ALXhUfokJGH5zB1CikVUCSr740iPhdtHfRya6AVfE77nuEgPrjKYpzxAPwvqvWucuR8y
         M9egUe0V7FrtAYvPjsdr3KECLBQqOGp/GFnzeMv9p0bbHMkUUecMItGFAaA61ftB2poA
         iZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=LoQpgdLEhpD0XT0gKWKVmIQm/snUYgXInip2I+Q4cCk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=tDkjxIq5BpGKdMel5F9iSn4PhzTLL8UAsrLRU5eTEObGecgUFEkdr5pAFnCsFLJMUC
         jPjvrLR6V8sJbTXpolD2vLAQgVpBgfqK6/0A/zgCF6HmoSNMExp0yCFy1LZRuyDZBkNd
         O7VbKx/UHhvG9idij5JBpDtIRA2GvNNDDCIA0fDc5TH2xiIOGbEi5DaiTRDE/5bj61fW
         ZUCKRR78OYzxoqG9i+eoqjC8RfivfwU03gbz0s56BUysQ4R3W1LZU8YiLDpWq779y3YH
         OAR42XIgT/1kQPj2zOO+JxMHHPm4gB2+d5shBHj1u1qTQyFkKWZSwORy3nYlNjZxpgNq
         RPSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968160; x=1792572960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoQpgdLEhpD0XT0gKWKVmIQm/snUYgXInip2I+Q4cCk=;
        b=HgVWgUm/61+OESD6GDty2bm1y2aTShzzitrylCiSZFIIKFI6qyplqdSR0QZcbgxInI
         3LAODWYWjz4Y3m7tRKxs0Sfl5Csl9gLSMSHntBmD2QK98RUz4BYLzxJ5Nl9xu1Y6SB6v
         lQrffz/6V5ZbWijWVoPTAqO1snTrz904TX7yd2mG57eD0eQwGcLr6VqMxVbkSFWK430L
         k38eSwFlRMgHChWGI9hpYq56LD5d3q8/rmZSj9af93bJQojncmDNqDSsnkJIqcjm+lHJ
         lap17TyN87BFRh5Cdr9OE6Cv8Q69jS5jrqEwyvP8ri+3G6rD1++4ts9juEPonsflW8Bg
         djXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968160; x=1792572960;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoQpgdLEhpD0XT0gKWKVmIQm/snUYgXInip2I+Q4cCk=;
        b=vYpCCaYtAMu0HDwXqMV27ak43uVIFlVcTrkxamx6aInFHNbg+WaWRkgC6GUd6js6sn
         lweW9s2ob0CfQRgj/jCZfAhuoEyKTHooeb9sP+0z6gJyH6T69tDbiClZ+lq7K2sfmaQk
         SmJEDducIiV5W3KPT9xuUjKOByL+WcD+6IQIqAEP9aTBfhHEGpKXeTUKqAab+NrKv79i
         sU+lKDzcLWDr3qTp6TDY3pv8jMFr10vN4D4NSGT3OTnB5bqOWsK21KHoQQh/8xcJHMMj
         XOv1ersi/58KXIhNdD6fO0llMGoRquKBW2Qnr8FXJiGq9jO9a3fVBJLI+ZEBtqb3KLgp
         LTow==
X-Gm-Message-State: AFq9FYKXtyQgx400RtggHv7TquTaFwR67RShtzJkJlMZRBOpSdBNwCxm
	ozJltLyJYiaK1kW4Ed3j/9TJQ+UHy6W97y1YeuEYyjdmqZhAYBUag2XknY/MQy9bZPQ8dFPdmId
	uOv03KqJnm3+vGBlwQuu/N0aFF01b+ZpM0ymENsoypw==
X-Gm-Gg: AYBFou1zz3JQQs4tGioZFZQGq6khegXaGyEE8Cx7WJJSV0K7geNg62q9Y2xcjKYGcDH
	fNO+gkQp/VNbngodtEF+XAWZMaDhIBNNGP3i4oG/4d/5i1xbOJc44dyeeoSq3Nhfyjf3epVN1eO
	Of/z/k6urHQEv4OaYWARBkaAE3extl5HSex/pmRGIdfJpEeguYH0LUBgSwj7+LZK5s+aGgRnIKO
	UjtumodxGvtXYYdqNsyBP9RIylWNIjYQo3QxWeygmlv8cSip4EpH0jLq9eqMLpIkQUJDc+HfOzA
	MtH3Uu0kmdQ6pRbgbJAnPcm6vhbyNZBFYyWItOFaWp93yfr9DJ7wPIllLA==
X-Received: by 2002:a05:622a:1e0a:b0:533:3228:74ad with SMTP id
 d75a77b69052e-5359fae5d3amr244413391cf.34.1791968160458; Wed, 14 Oct 2026
 01:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor Okafor <vua.okafor@gmail.com>
Date: Wed, 14 Oct 2026 09:55:49 +0100
X-Gm-Features: AclHuK9Ycizgukuo4sV5Fuh0uCHtahLFoh9t68N5cOtA2kOHTUDIcZtjLyLlq-U
Message-ID: <CAJoPjcM9s8s9+0Pgyw=dnQXcg=kXuHQ7dKZWx8OaJswo+a1viA@mail.gmail.com>
Subject: =?UTF-8?Q?Subject=3A_=5BOutreachy=5D_Interest_in_Modernize_Test_Path?=
	=?UTF-8?Q?_Checking_in_Git=E2=80=99s_Test_Suite?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

My name is Victor, and I'd like to contribute to Git through Outreachy.

I've built Git from source and am starting to explore the codebase and
its contribution process. I want to work on =E2=80=9CModernize Test Path
Checking in Git=E2=80=99s Test Suite.=E2=80=9D
I look forward to learning from the community and contributing to Git.

Best regards,
Victor
