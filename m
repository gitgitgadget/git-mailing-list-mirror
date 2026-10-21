Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588732;
	b=h7uBU2hGd2zXtCbKvwBUxVxdIeNK5UAshtdjUj1jqEwW30Y+zO5YeIvPvYgSeOoq51S+
	 w0Fe932PQ/YoTlSaql/AJADevigA83dglGKHBgLXL0eoaFLmlpNRj08+/XcI/4Aef3qzb
	 XMpCeuaDWxtQO6kTBQBERyiu5Aclo3LgoxMVKN3dzh9c81zXQ6flPuPKDZZaajTAJeTDT
	 lIFgbs3hM9WjBrBDyXv9o8S9g5uWRRNdUbyhySkKRmALIsLmPQP1FlBHWscDjcsWArKd0
	 mxXE6UrRO4xMXOaucd9KpkY67zcnE0blxKOFq+k2zIcN1NLrM/mz0qSCQ8hvx8/Q0uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WbnkL3Onw7rn0zoIvjam6GYPk0MesakcyJhgWulguug=;
	b=Bpen7R7uelZ3AA1JvFNL2CLmJSnxE3UNXrTctPrO5xwx9jle/hHjiWaPwYxkFEBjX0ri
	 W/HWfBP+TxayW//GAWok1uO3T0Qzn3pdmOoc5PRyS7xm5yJSvm8hwlTtIz3FSz/QN1Rqn
	 jqci1YChXy3RCSqNzrusxUJq/WF611J3/zZzWX3idfdyDwCflJmKw1cOESunLWuimXjqb
	 H/pktX4nhLZbCngkEAtD6U9YVV3HhEutzNX9umJYCw+Izyu9BrSGzG14TYA6eLrlnXxQb
	 RiTqpiSf8cjcLTRn3EXhfYLTCL8hOP4bMNjYdt4tNNGdEo0Bt7mFKpv51ncs8isOFwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CLzgRiX4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F710606A321
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F710606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CLzgRiX4
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso4474025ad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588732; cv=none;
        d=google.com; s=arc-20260327;
        b=p6MUltJnxxTI32+WJ54bSg9RClXkFw++j6LbGqVgXpIfT0WV1yoTHjFUUEsSMMW60m
         FCD4hcaxpolxnX3SomctQBxII+v7cRME7++3NYHukkpPGj//PaUF1BTWDrTlDeLTs1ct
         FHikQSA4u58rb7Av68dMpFyeIYWMcU0ajNOxgMilnKUubC1AHkINIBXlfoMl204U5WqZ
         d9tv9GCUejH0GnYooKMJKbs+j9mFda9lpZ+8zDAtP6Um8bagLjajMHP08NQayHfLpVwh
         QkDMPtK9syEEwbGD+ciR+a9kzHX6D6QTnRcsOVy5jeUgHLZhT0RQbg/xUMZghBOi5+1T
         BRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=WbnkL3Onw7rn0zoIvjam6GYPk0MesakcyJhgWulguug=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=auAX7cgFDDteJIvgeOHz2jwxiz7Q25dSTiAeg72HT7ITFBwk29wNtoQXVp0jpcup30
         4FPOWfZv4Ux6GFdsX5OU83iUPhd5T1jCutY42bdJNa8ZM4wJxhH+l2ATlplcUFDA2ffQ
         oBOICV+Rbo5b0ltYsBr/hY79qZFvJjbwwLI5KpXC7xsGiY1Eb/g97sZnQoU7xXm1nQB2
         KT/f7J6blJt1tk94jzcoxyo7huUv7lx5WralMbOh+X1XMmqPpEbzoUxj+XBV0naOPEEc
         3eaQ6MITul/eJCfl8jUVAP1xBoGWonxKXXM4r+rItJqnERECmgsmxwKTb+LYl2ZM5Yvi
         Yx0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588732; x=1793193532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbnkL3Onw7rn0zoIvjam6GYPk0MesakcyJhgWulguug=;
        b=CLzgRiX4UlLGdIGRSFqvatmF1mJdETMwnJlZsj27HKh4mnwJ97j4UggrEli2uQqirh
         s5/aeSVj1HgT5Off1bwzb8mlkiaFBjMkzChpezkj6If1/JoV1eedi6LuhMNGcCK7OuPz
         UwPtOXnFlyFFoyzdDeogz4/s24AQ+8+Vj34zh2gFYT6/iJnZbMCe/WO+PyCHyP6NTmoP
         Z65luzvvy6QgqStfTRY16cbtnZJ8LkqH9yXWsrvGxCiNENOvO50I5CCSqlb05LOWFLdq
         Y/2WHJ39VtZNNT1q3L4728M8OWz/b2QxAJx4/7Y/yafl2fRvERHHBO4C95G/BY7qHDis
         3LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588732; x=1793193532;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbnkL3Onw7rn0zoIvjam6GYPk0MesakcyJhgWulguug=;
        b=1KkVapQowPEtRCfbBBFGBZkx9833OaWq7MblZWjtiYbGv0IIdOMKjHF+OOntR1aFG5
         vdxHLQ8ZD/LOsrAjUV1CdGf7u3XziPv0ac5XQT8cGbGyMr2f1CE9+LnrkhZqekhkChsP
         XScht76XrUxRvA750AGNQq7tSnIfhNEnQUo24w+cGYjZWzYwzNI1r+WuccrOUhLRYq/H
         4Kdc2et9i31ukhgHY5jvrN8QnHXA1ARCA06j4MmWqgsyFFAb50x8InH0QBfqCl6yTdW5
         NTktiwX8EP4d9u8m203EvnLIk0MntWX6KHLj+n19Bk8nT0uyko/7l3VgeHMB5yW4JUOq
         9phA==
X-Gm-Message-State: AFq9FYIb9OAxjdW9AKstC5QOadHbYTYDDep6bervNNmlwKVseHJW66yr
	zELwi27GblAWO60CwLMm9NCrggIA6uxANxTmyI2qLyaq6CfRYPWWDhuCigq/Ig6JUr2UCfRcQKM
	c+QtNEWju4njnWhO5CyGRHUdY9orjswFN4eFrAyY=
X-Gm-Gg: AYBFou2FG2kT8WQf6fUk9i4u533auNVOqBlbDBzyQGqSSqf/g9YYqZS8xhKSbGuFSFJ
	SuBq7xE+ePLoLDxCGX2XgtLvKer7Bkcy6C9VaYsQEaYPqqgWz1zCxRromkD/3Qnobsh5F2An3o3
	XaLDH9IPjWj0IgDWp+i5+5lxyh/qXEZSg0Ju8HLpYVBCk8tgaEddhi9NidmQzSTLNjNpZ8ow/d1
	+zP0K9ow0V+vAWsfUvm6jp6uGbCM1ShhW46BQ4z4HttXNMoqzs39JwKnYsglokNwV6m+DZQ+AjT
	vh71deiJ2W4saIaGu6D+nEMRiNYSAHLweJP6FSKOVGQ1mHLhu+aqlNfwPhQ5n3rWmPzT62a4hxf
	5Hdw3NqW8fBNy/hR6nDd1LeaGh7wCJf78UvZKoyVAmoHCyhGeof69yl1eQ31mMWPYw3i0cA==
X-Received: by 2002:a17:903:458b:b0:2e2:b624:54b7 with SMTP id
 d9443c01a7336-2ea439f4ae1mr17810055ad.17.1792588731580; Wed, 21 Oct 2026
 06:18:51 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Azuama Odinaka Maximus <azuama69@gmail.com>
Date: Wed, 21 Oct 2026 14:18:40 +0100
X-Gm-Features: AclHuK85PblmI4gdUS-oexwBBmctjQsl0dieZXgiNyGs2kI1L2lyWqryjaB4OAA
Message-ID: <CAPki72GYsid5DqaP8urq-gVrNEvMZM+sXUaNjir-VXc+qokMfw@mail.gmail.com>
Subject: [Outreachy] Git command argument parsing micro-project
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

My name is Azuama Odinaka Maximus, and I am an Outreachy applicant
interested in the project =E2=80=9CImprove how command arguments and option=
s
are scanned and parsed.=E2=80=9D

I am a beginner in C and am learning to contribute to Git by studying
its codebase, reproducing issues, and writing tests.

I have prepared a small patch for builtin/rev-list.c to prevent the
early option scan from interpreting the argument to --grep as another
option. I also added a regression test in t/t6022-rev-list-missing.sh.
The relevant test suite passes locally.

I would appreciate feedback on whether this is an appropriate
micro-project contribution and whether the fix should be improved to
handle this class of argument-parsing issues more generally.

Thank you for your time and for supporting Outreachy applicants.

Best regards,
Azuama Odinaka Maximus
