Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4432DA740
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106538; cv=none; b=PSEo00yytclj9/ntpm8OIsjnOVR+K61jj2hGlu7kNCaxNAxtydxkB54kbXeuUd/xaYkeI6REliVzYhWDOi2UYv/PSKvj+OKgBlLcGbL2YhncgF1CDas4zcTwW11Y099tSRqWZE5QP49vCehYTOLD25bwvKEGC42rJuPCtflp+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106538; c=relaxed/simple;
	bh=rJ+rB96ZC9kRnlUMB6UAwxN/Hpq+E7Ab3PspMfjDB/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XlvNYvxORFZ16D5hOYbpIkvDahWy5fppPspl0bwRIpHbw/zGgs50mJDNBvROS7ydiih+xe+e6dDBX3jZePJHA78TtqBZr8C89vUL0uL7i0sL5MI8v906PfQoMnqclqPiPfkPzFS1f1pPV3f4gBaVTRIk2VcqoZjwuTCPAIkJOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhA6J0DM; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhA6J0DM"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso4414498a12.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753106537; x=1753711337; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsFVeUF70JnrXli5NdJew0KXvHtPZiZNPy+Gl5PH5N0=;
        b=AhA6J0DMLZbez10gzTKWd+IjcJ/77plhejY91G6LcNhaHip4DoB2oP9hqVzDQSXVEd
         syDYkncJmR2D/+VP4RZ9J+rGtHzj3q6EJtTsAb5ZoDSz++9KoI7ef6fJPv2mvISlIe7i
         5D5EJPcFFaDvcw0KCnX1gFpdPzhtfHxIWJL4FCriZo2y5PKMTnOXGG+YBxdjhgJd5OEl
         GyM5Y787Z8S34RL9lwUeg6/JWNkS5SGqa1XNBAcl0VmGyTDGG7Xi7dKTd7iR+1gpn0me
         W3UZip6aM1Yca1nxxE1SOT3I16WqORhVAa5III/YwSgUrpsOFJeOaIDvVWX8bZ+T7F8V
         bWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106537; x=1753711337;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsFVeUF70JnrXli5NdJew0KXvHtPZiZNPy+Gl5PH5N0=;
        b=dliUISe3UvJdhrbqvKhAUvPOgEqkTJFXZWrm1c6oG3CnS7Bf2W6MNPDKL35hwwcnnz
         uDDNleBS25AEb35Uf0iZnp+5eb1Coj5F2qxzSjS+h+qfTA4LxQxqJEdTk7rHPtSzterg
         n63u0mKo14hVpLaRARtXGknWpFwrsD70XR7wKiJxo5LYImnAXCtrgIVIPEyP5Cjg0Wsz
         m6CrPz5ej4WlyU6QVcRE9XnL/9pkqHpa4KoMIHuPU8EyyPfsaaGKkBcV7LCf6EkBUyWu
         Uy0RaMfL2cjZ3NOpUReagjRVkFmgxu8735x5NcxdPCjcMkyPNpwGpFYlzeK/zcweBbpH
         YQvQ==
X-Gm-Message-State: AOJu0YzzKeGulfnHvsqkMJCTSuRv4MF+7sXHncMJob39bUFvRZN5+2Q3
	/gwKy6ImQ4VYom+cERgd7woHcRMNGqVYpNTcQ4zqcqVg5b6Sa0ggRHG1
X-Gm-Gg: ASbGncvbKWjabMRUWGPMkRBPjO49sj1XmzSrbLQ9uDKrSvYQdWbmfqrO9wmWyHSBqvA
	C5CwUqGRqcn/liQcx0KssYTf3jppPWQBNpk+NNuu9FbRnuXQgQT1LMqCKJ/xPzDnjgFmm1N89So
	wCq9lRxFJHw6OQDdjlVknZX/ODPb82K7DgEF+J5SFdhuz8KJabBbSsHFr4VMtWQGknazeYkXdz9
	cPf9OZJU6q2nGm9W/KF5vFthGtQxIx6ih9dJLPO6m9HmJMl0y6TCvBMqQcm6HN9A5sGFc2Z5ura
	FOEjx83XyjtujZ2NqPjoUT9zZcYHErg//TfqjRdpT4VJ6RbvBAnH2So9K5mSCL1/R+MzL9k7Lat
	EvI3xtRxlmTlny1DuYf7NcfNZwSKSxOdvU1sv4tizGEiY4zPkdZ6RquWhen5DMP6+bW2o5zagOk
	wodMX37ojzLXsmKbVqp0vNdQC9GqFbY/5LFw==
X-Google-Smtp-Source: AGHT+IF5qPntr+d8eJ0YcSG5ZFlhed3LaFIdPeHW5+wjqLn4vVdoWXSO0oriZKjr/d06ozyZw//Jbw==
X-Received: by 2002:a17:903:1107:b0:234:bef7:e227 with SMTP id d9443c01a7336-23e256b5dc8mr245346135ad.18.1753106536462;
        Mon, 21 Jul 2025 07:02:16 -0700 (PDT)
Received: from smtpclient.apple (awork062199.netvigator.com. [203.198.28.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d8825sm58221125ad.169.2025.07.21.07.02.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:02:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
Date: Mon, 21 Jul 2025 22:02:01 +0800
Cc: Git List <git@vger.kernel.org>,
 Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <148541F5-DC9F-4A3A-B1B1-0FED8AA5A101@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
 <5d7c631a-ae94-4a59-b4ee-8161b5136d86@web.de>
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> +#
> +# Creates lots of merges to make history traversal costly.  In
> +# particular it creates 2^($max_level-1)-1 2-way merges on top of
> +# 2^($max_level-1) root commits.  E.g., the commit history looks like
> +# this for a $max_level of 3:
> +#
> +#     _1_
> +#    /   \
> +#   2     3
> +#  / \   / \
> +# 4   5 6   7
> +#
> +# The numbers are the fast-import marks, which also are the commit
> +# messages.  1 is the HEAD commit and a merge, 2 and 3 are also =
merges,
> +# 4-7 are the root commits.
> +#

I feel that the reason there's no significant performance improvement is =
probably
because mostly we are using the priority queue to sort O(siblings) =
nodes.
For example, in this case, the most time-consuming operation is when the =
priority
queue or commit list contains 4 and 5, and we then need to insert 6 and =
7.

Assuming the maximum number of siblings is W and the number of nodes is =
N,
the time complexity with a commit list is O(W=C2=B2 =C3=97 N), while =
using a priority queue
gives O(W log W =C3=97 N). Perhaps in many projects, W isn't =
particularly large,
which results in the performance improvement not being very significant.

- Lidong=
