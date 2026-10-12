Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B947AF65
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836874; cv=pass; b=HGvL3LIhiG/WlnZy/+ihjcBC3OTO2UCOz4iPwDS0mnQ6HyoXSaZJE8G8UqcMPU0fv4dExHk1fqJiUe1xRj8IY3gsnKiQOJ0ggImhTYzNhFexBn35IbitT3mxBeH0ZiPIWFxyschVmE+L5i0iSDujnHijVj85Asi8gXdSpxrEfx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836874; c=relaxed/simple;
	bh=EscH9NECl1bh4jw8POFkZci9ufYkc+NDHsT8NemTycw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayjduQSl5VLCMwA4v54zTjziHeHn1BAZ0f+2Uu6lH+HN37ZQzW7mL80PupIBFUxTadlZeXQj0/VSp/iqOHcBxkUmH6/h2ODZyl+Ydt4mjEEQX0kf1iOmiRuKLqxSAL6tnbEhylqerqwMcCCsVCJfnZwX9mVkxYX945ST7v6MKCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5uVC+O+; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5uVC+O+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso344015066b.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 13:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791836870; cv=none;
        d=google.com; s=arc-20260327;
        b=P5QJ0Jz7gWJcAQpdjfU/g/2viIVIq2IY0Xs5EY8jAgYIb9LdLyHmUBMlM2DSkKb3dt
         sCTv7f5Zlj5n1AfnkzcvARO7AzdsYg6UlYY5WKHggwiBqGN2nojmeYVlCsYA8upijILh
         e8TRdG1eaXzX/B2dtBoUn5XZidKuPbAuRcWnxkSVIumpcPKgDcI4oqi2CcccWD4xOXh7
         XLygLWVn4wIShege0kjIu7uT5ELG1in2n8YK/DZovo67HZKUTK+sOlGND8K/I0t95WI9
         hf5kDnO4wUceFF7/b787t5vWlIvNeO+cLpUxwgWxMxjnheljw0cD4Zs/2DKzjD5W5hcM
         /zqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EscH9NECl1bh4jw8POFkZci9ufYkc+NDHsT8NemTycw=;
        fh=9Lzif198SaISN0B3ewSwpRPmQDDG0wg96+SUL1c8Xe0=;
        b=RFPZjmO3HbjvRioGxtPtHfyHFvY68IhzkD78Lgqvx7+xOzzNDvSqeG/0ehTqzr3pkh
         nmGbUpUjhpHjUbARPUN1Xe9/peWOjKuG7VWsPxEDiS9gYOg8XbD0zoRIKIf0rCwiCRgu
         eH7hWAdsrsHncH4m6W4j0X8tHDmfT+fnCEf4olp3Frtn7NztXpzJNYagE/JVcOkrbwv+
         4rgw/qD8DF00qRyR2pZA6ZS7cvZXHxA/flitvvU6jF/LjHQEazaRAvoUwO+vGxE5E3uS
         I/ozyMLrqGxgjGVbLpNmMrhZmVQo/fWKDD15jeuWqc+F9YwHuEW9wVjHLkUHUlLecjD8
         zMQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791836870; x=1792441670; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EscH9NECl1bh4jw8POFkZci9ufYkc+NDHsT8NemTycw=;
        b=R5uVC+O+k0nBpskdmNl2vDCWfu3LIz28pCKofKT8cKuRg2wCJw8ixCBRWuBHhLtzsw
         g/DyALvzvAH3asnba0JZuod4XvIacSy0oipvbEKkYWoMRr5x2lKn5WhsKrdkQR5/7I+a
         iwjLyrq2ZwJc5sNBuxFbaESLUJ3B2TqyHrmIqKUarLK/eipesXz+lFFEzw1QIaXZqgoF
         mbbb+4h6x2wZuU6Qeob6nSEGcSaT5Wq1lQlAJKBZUuQDfz21xpK0GayMYbijrE9isDNK
         J5wVRxcu9ypiQpcSyU0lXtaAOluFiWAPtE0liSHn/eXfbWXMmooHQ7FW2WXxg5zQUxGJ
         N+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836870; x=1792441670;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EscH9NECl1bh4jw8POFkZci9ufYkc+NDHsT8NemTycw=;
        b=rdBkIT8pzeEaVB/gn5kQgHq7A3WkAWn7zQVi9Nlj5V06JX0nUVPIv8iqlJmJuTkdWc
         QDvbEZmnBpuqe3gyH6hbWGZPQLKRBQ8fdQk3Z8aQOXvKvSO15c7h3HQRdRRCcnZNH9WK
         A52WGVt6YLq3+3w6jSBH+xNG8EbasvxvNOLKhbtWZ2b0jwBDdz2yIDkx2GoVDy7meT+O
         kSfOY7S+gW7djQKg8SG/XG7g1s8co+kRvl4f3ZgcptYQ9tqllMbSTQRg/mGzpr1cwxLx
         8wtOaDYK+Dq/J8zg40O3wm+6IrGe9e0jJ54tDMBZerMV1Z7+LnxGHUz6a06r0IjquKwF
         EIyA==
X-Gm-Message-State: AFq9FYINWhrnekI9mKyYOxtC1RxSEcI0WfNtdMU8lRYsmnhWN5d0GhcQ
	4ocgP/SHkzgClGg3YJSVXFLU1vnDh6IKzR/s1isCGDiROC9K84DXPYGpx5nNfzVKNUEs7gae781
	PxrqIqQU143b8NKYOTEF4d5KrCsaNFkQ=
X-Gm-Gg: AYBFou36WzuDJKl8sJ4gBlhLKMgROZWwh4SYi6WKtegkvNq/mx0siPYQyLYbSksBizz
	+9MpoE4xHFuKr9i8rdB51GrWXt3467sOxwMogTUeQ6PghifRIL1AwLkXGOtOG/XHEEn+lpfQdiu
	gB+yTmdlS8wk7sPCGWMLQ6k/fK19xCNDMbiILFRo0y1a9FfkCTWJDDfi4N60DMNAkKcBBsaOn+C
	4PP9BFnBET8JMBH5PXbHrTIy4RNx6sMRLYHKN6jLGZOaHG6gYrT/opLunN02XmzMuaGua3c5Jj1
	s+k33qZQAaKpyFE808xIjdiIbd8iJxBaIiyPATIr73I2ePAw9SY5zG5bBbBlKvl/C6HSZpx0omN
	KV6kmzpzBoSkPgw==
X-Received: by 2002:a17:907:1c98:b0:c26:1648:a065 with SMTP id
 a640c23a62f3a-c31aa06ab3amr1009162366b.32.1791836870243; Mon, 12 Oct 2026
 13:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8Uu30SPCV9uAtn2K_0sVrD=FEt7DzdgYUWfwtbh019xK0MQ@mail.gmail.com>
 <CAPSxiM8Xjysm7XbXEmtkMkaFnOcb2wWY5-YRUKd4tGsx=DodUw@mail.gmail.com> <CAKA8Uu3d_SuB=USUdoY2Tz+oySAotr1WdvMbpdQ7ejQ+dWyrUA@mail.gmail.com>
In-Reply-To: <CAKA8Uu3d_SuB=USUdoY2Tz+oySAotr1WdvMbpdQ7ejQ+dWyrUA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 12 Oct 2026 21:27:38 +0100
X-Gm-Features: AclHuK8B3sPab9XJWpuAdGjobCOUnkenX9gnrfDguj8e5C0Eafucu8cd_XKa5TE
Message-ID: <CAPSxiM8bDktTEGUXAaztwV+LJa-ymLYTs62XryL6LMrQDTzPHA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Joy Gundu, applying for "Reduce Git's
 global state" project
To: Joy <cryptocurrencydiva@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Thank you!
>
Write your comment/reply inline. It is very important in Git
