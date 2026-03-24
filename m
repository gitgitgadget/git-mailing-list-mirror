Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D411DEFE0
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367448; cv=pass; b=KgpzET8R2KHHcZHv1B+vOsCaQTmd3MQNGsMEOcJCZihLfEFATFNMNhhvhmzvq69KulA7gzZ7SQSHpYq3eY2l86XavIWQIY7KkLZi5pixzQOjXubgd7uq8f1LxGCIXn1K8cEfsJ3W8aAanAdbaOiuMHK1LO03S9IzLg5HYVySyeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367448; c=relaxed/simple;
	bh=lcpd3lexdNMjHo5/3PichYpxIMAVeUyDO7kbg0pJUtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYbx4WosxtygkNWE5X7rNFkE8LhgAm0m+cjYva3ssS8y2Xjkx/rCSM9tvDWo7KMGqKDx0cxVHiVIx5EUk/Oo6gyekwrg3OYIhRuGeukmcOS3TrdBikrs9yq+MRXxSdG7P94eUanUR+WnN06XDqfg2eOB2+KJ/pJL9uRU3RfMYGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl6QYTTP; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl6QYTTP"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a71ade78cso1831450c88.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367446; cv=none;
        d=google.com; s=arc-20240605;
        b=NkPyhAX2oKV1WCY5NGT4Wfnh3qT8885VHixqO1auJb1WDLfb45cymwbCzFoVTFK0iK
         HkydEKS/mN3iI0R1GZaB/ntvURA3GqUkWQ0bMTMTlkcgj720KsXHAkLE7MU52eGYDX96
         Lg3arEhN+xYlVg534UBR9tPKw1S6BPBNKIxuiytrZH6ECbDroLraHMKnlH4VzdbbtMng
         aYf6xmqWWHD4IXJtsC2gVfBuuOLXQtx6U550+5CwrJQTemE6BCXqre7Mw6KvuQG5E/hS
         LFERwfm9F1bX2aZLNf95VxwbQa3V25m14w/rtv1zeM/RPdCHHB+FnI44q2pPUYtkPmlx
         fmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lcpd3lexdNMjHo5/3PichYpxIMAVeUyDO7kbg0pJUtY=;
        fh=yEE4jbkyo5i8oazTHT4hCUxT5On7YUISrf6X4i6bnjQ=;
        b=LpJkhCTiE4tB1Ags2d7CmV1ewf8tQo501CHWV/6HiBhzpCzAKXyIJwFlZvvHVnG/Ub
         hQumTrZwB409EbUO5VaRNJs0mEpF0NSR7Ah1XggMzCs+9do5yHWf16/rOhheKaydB5Xe
         zj6m99WL935QYnXRBP1tYutQuBaiyM615u+cU10KeEchTT8K39YCPWloDtCzxIR3yGUC
         qQy639V1NCBIeO+sO5CujrWxBmwsbkuJNSPaerzQ4aJS0JeslBN/rlIAhiZHIK5/Q+Qt
         Kj/zMQPuU6nCpD51THZr1Xx+mHb695T2TDwy58f5KJhDrN/gN/8pVzTYXa2GA9AWBpqn
         aEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367446; x=1774972246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lcpd3lexdNMjHo5/3PichYpxIMAVeUyDO7kbg0pJUtY=;
        b=fl6QYTTPvWvuSLzUUAKNIeUW/oc1oXgrTGfAe3ruXYtCQGOpotah/NOR4xh4H6S5v/
         oZ89xzdb7tJOIhAekrplI0wq4beSo/Jnq/iKbcMh+mRLTWDIdm92daPjcH5j4ei9EyLD
         SvRNK+tk0DJyOXQuDRO+7p83eF14Lm51MgmeC/DqIG+5Q6OxmzqVohmGK7qJJL+N0GJQ
         o/ckSeGqX3qb2A0TriDWUPfuOBJ8o1cggmlp0rYe05ucyVnat+tc7ZCW6niHjvo8V43R
         1S/nZUix+vPDLUIvb09LDtZ+ZR+BlLQJi/90QQGqKO6HOwCRWjdrgGirftbc+au3K33V
         uHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367446; x=1774972246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcpd3lexdNMjHo5/3PichYpxIMAVeUyDO7kbg0pJUtY=;
        b=guBkv5vNjks4LoBVXaWhICzniVU61/vIVJtqHMQckmcb7CE0fclFOBK3QiIPUfyyJH
         wDn9DTHtjkV/s/yUHRfav+S2Vp8txelyfynazq7FOyH29NVEN3MYxmrO2kgpY6bG96jo
         bDlzVWDqTargM9nhLtllFVR5cW736MOs2Miijag6XUqP4yJLBCoUd09BpW7Pq9aI/uYZ
         sjrIT9zBCdtA85AqvVaK/P8AsD5C99BAf3v7x7R6gBCl/KbvntFRLqZQ/+NUshhhafVB
         1UKUWciMBym0W4CuVIvLVSEQZkF57y/ziDQPhghXdUpnQ5PjRNOV1xOg5MptrAZ+XaAT
         AAOQ==
X-Gm-Message-State: AOJu0YxK++U9YvMbxx3fOqTfXzXEgL44Jhl9qm3tm7ubPPJw3NE0fOAy
	61fGG0gp27/jmD6norKRc5S1FS0acdfh51pxZV5ybsHbU6YOIEMi5cbNVje2yOde0yhITTK/8kL
	dm9+q45Pgg512VQyOkaWMNnjrUgTrZkU=
X-Gm-Gg: ATEYQzzNnAb/Ek3180EVrHIhQxOc0fdC5vmBFQ0vpyIrrTY6yf61XiRlsdD6UeniLkn
	m5pmBsVezoqiH1P0QzrkQKtTdPDdKDze0jIyYiZEKtuEtvvO5jQzBdHNYf3XZBpLZmvDWZqATqC
	WcujRS1VnpQj7byS5UDN8I6r/nmjfRR9WGwJvOzovN1c9CNJfPlbbEc8hxUqfbmF2ftNjUXygFv
	C7/6vClncdFmBEJ6NbkW8uDi0Zt0FZCoO1NQJxtrYX6Fuqcnvn8NtX+s3PX0aZpsvHEm+p/UfBh
	abVER/tHmUWDs76te6nVo42EVHMEu/X2z7SsEQ==
X-Received: by 2002:a05:7300:fd15:b0:2a4:3593:466c with SMTP id
 5a478bee46e88-2c1095aa022mr6765653eec.8.1774367446115; Tue, 24 Mar 2026
 08:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgEQTPhxPeEYkm44+BuSj5GG6PWhRrqGT7Vq7zXFPKZqoag@mail.gmail.com>
 <CAP8UFD1Kirbt-j5h7NB0UcxPjz=Ger7GBK+excY4Z8X+yKtdzw@mail.gmail.com> <CAG7UgES4Vm9yboUk1nnPKHBdMu17gt-2dh9VmXD_=Lpc3o+3Jw@mail.gmail.com>
In-Reply-To: <CAG7UgES4Vm9yboUk1nnPKHBdMu17gt-2dh9VmXD_=Lpc3o+3Jw@mail.gmail.com>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Tue, 24 Mar 2026 21:20:32 +0530
X-Gm-Features: AQROBzAwf82KSrpFIYnM7f7nJ_8msVwIeur-qbM5sO4HPuF6UZ1M2ezyHzb6b4g
Message-ID: <CAG7UgETAU6Pn0t_HOdQphdT4r6Sa88D0OFiqCcOuv3_uxjUaWA@mail.gmail.com>
Subject: Re: [GSOC][RFC] Draft Proposal: Complete and extend the
 remote-object-info command for git cat-file
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Apologies for the incomplete email I sent earlier. Thank you very much
for reviewing my proposal.
