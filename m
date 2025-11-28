Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097261D5CC7
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307448; cv=none; b=npfhx0avmdVhwKuDnIPvpk7M1M/WewonRaSt5DZngSr2cobnn5ZNCRCZcrWEVZlLdheq6jWYJ5QV+4S3Nd0YgZYwIBKaNqLy/54dv1P0iKTOTVPaiv0PFnS9quIPbhTiXSERmwl4KHFbYfEq6Fh5wXgqGlaPqXYj8EcQZTfYsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307448; c=relaxed/simple;
	bh=rJkNbVuH8X9eOiSNiT5flfw1Km+8BSpefyit95zsCtk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=TrD3Q/AgbYQ7hKueB7KA/EdGVq7qBS0O0R2NfjF9nLfdxOhOQsIvibAd+2KyBXAPuEVww/CjZL8oBqLQ9SjcnyGUJW4iziEz6uwqp8M7af8mUJKx6Inr9+DLDr12reaQnb/NNrY0y8JpM0rmz/2/i61eLBSJnD+2VSBx+1xtLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcqS83Wd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcqS83Wd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1753836b3a.3
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 21:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764307446; x=1764912246; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJkNbVuH8X9eOiSNiT5flfw1Km+8BSpefyit95zsCtk=;
        b=GcqS83WdzoqgmGHXZzEoSg3dJIsSF9WjcgadYqvby1olBPjrVS97DTY0J9+5tGKWFp
         ogFnUo6/2OyZO58iZN5VswTlOwGfeoiiaItZgG0HwSwfi9VKq74Qds0zhfLul19X9pDp
         ZhtXE9kFRkxwjzpGZETqqxXfnDNgXaJj5gI898xhpQvBSIhEqCjTa+5wOmP2QBbdECdS
         JlWoI3PD0IymIUd7H0sXSaBO06eD86liDpuzvsOofybt7piyXM3vuUqAG6Nj6XgrVfpA
         XgUWoFaYLImaT8hFeP1N3iwKzurjoWbXCQUmGzzLT66CdSfVS3xIoS0k80aWGOMhbJJE
         liGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764307446; x=1764912246;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJkNbVuH8X9eOiSNiT5flfw1Km+8BSpefyit95zsCtk=;
        b=DTFg+xf1klykeG2Ht9NMSKqzgOr0wAjVwUzlEwnmOSEMZwi0tWBH996+xfMyNskIj6
         jW1oWuPH2y0Eb1pPWvPvDilrGu5M4Or3TG3503/kn4Ev047ELCc2B8lw800x53zURaUJ
         GiIFzHzvW6j6mK0b4zu05SIuBOMULJdJspiZ3GAYB04rzsxSKm4RqYh8l7b+0uFn6S+d
         4YZwAbe9121Z7p7a9SleSeFqyM4IddtjKQpSDDeJoM4Sb5lu/vptAIuqau15bc5elfn8
         4kUxPArgUVkiEK0WI6xUYB3xffSqIAOvsZICvaT8RbwzUVeLTfdv2PavlOgJa/6qdGy0
         6ykQ==
X-Gm-Message-State: AOJu0YxD5AeMxzUKtjAzgaqMDwwrAUW/96ZjWbtHkhjLg6DxbcAOvmHv
	wBOvwoKAZ8EQVoHyM7AMEAFeOHd41XuO9wuVjsqrZB9UbHCqiiXChLq/
X-Gm-Gg: ASbGnctPxxaZ4/yZe+wLM+2oUcwQP/OtsNEKMRa7O3Qn44QclLVlBlREzS6XRGOjU4x
	y0h3yFpEsnOEnlhU5Vse+DqIQuFdihrZl/t1Xn6q9V6x/jobBUq87/0fhFXc+WpQib5ujELfiDh
	ZacY1/hL0jH2cdb5M418j0Rk0zm1ZH5irkV8aaiVaGfv0XM7vHYXMKDI2Ffr0lWHcoFap5y0tP+
	EeuswjgAnqiNDlU76nnrxYv+3Hepgba59T0UrP4jvG1dC0YqEUglPnDYYYvjJEHRgW2Qowo3nNR
	npcECHUfXp5W8pz8VIqZO22u1DNC0w3EayqZR2OZ1+D/lltry3x+B4XOKpF6SeAYGFmH99h6rsA
	pcAesaoDpQVjXnT4PqKnAlLwtN3Ivw1GBxB9uRLR3HJV0LUl2F+PQdPcOKMbn0BVEzae98+b9I5
	U+ktWxKvX4S/Ifwr1K1yDKsvTbdhItllMDz+M=
X-Google-Smtp-Source: AGHT+IE1msV4cinyZFaK5rc61jCZSnnDZXa0z9PKFMo+kyHsKZqsymjZnsVAPx47J21VJJQdUKcprg==
X-Received: by 2002:a05:6a21:99a5:b0:361:4d6c:3490 with SMTP id adf61e73a8af0-3614eb0df15mr31248521637.14.1764307446062;
        Thu, 27 Nov 2025 21:24:06 -0800 (PST)
Received: from smtpclient.apple ([49.228.101.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbdeb242sm3387200a12.14.2025.11.27.21.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 21:24:02 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Natee Korn <nateekorn101@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference backend and directory
Date: Fri, 28 Nov 2025 12:21:21 +0700
Message-Id: <9A052A46-0273-421F-A6DE-83DAEE8C4275@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
 jn.avila@free.fr, sunshine@sunshineco.com, toon@iotcl.com
To: karthik.188@gmail.com
X-Mailer: iPhone Mail (23B85)


2..
