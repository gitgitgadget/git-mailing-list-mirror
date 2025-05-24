Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACB2F24
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748072004; cv=none; b=FJJi6pZkOkxjG4Y//KERBV/J2sZkkbwiBPJ3Z1HooihO4nuvbqRi9QsyCP9P7+JdW1j+9w3O8OCVFFBCFWvpxarBeAqKvnF/qVEgPrkdp9CH3Zjrdd4VxVsB68uQlSE1xRzNd2vFOhOvXD+4xoYkTqXrLwjeC9T9wk8HPHo8Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748072004; c=relaxed/simple;
	bh=3OlV6jZ4UTnKd85KCL3Cxe2SPPsWlU2hERkPf83eIdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IysfZhA/iP54cQeRxEcQbTNd9Wrcmc0CZREqPrBtlrpARQY3Ri5KcnhiIrc9DyRV42H4DxWixQx7nv/RpkD/pcwohLp0iplPU2xtYoMTglV750e6wh+upgY1sGJaN61iM2K0SSdm8VlwEHN/+n2gQwAmBbbyGOyBDKer1YST1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6zCy308; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6zCy308"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-477296dce8dso5294401cf.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748072001; x=1748676801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OlV6jZ4UTnKd85KCL3Cxe2SPPsWlU2hERkPf83eIdk=;
        b=B6zCy308pdXWKs0YspKRP1WBcSz5G5oKvMHJCYEFUh2elFZ0YUHCZ4TlK5Jx7p6vX0
         tWgL0qMWTYnabTUmXTXlAbcc/m8c4XFXrRKd+fI2w9cO7CUcDce7k5fPDANXcXE649oX
         /9AS1RIjtQ7KHE4QluKK/4tXCNCy7e5DRKsH9S9W9fm4alzl1Stw82jYoevVA9OtqEPO
         WTOFq+CFx+YTCbsNHs7AgqTmQ5Jnp45ueXLJU5nw7gGwtmvo9TjOlc1RtaZELYOOHzQ/
         BnID653Z5NEt2YH94ZqXkDnZvQuPdepBSD5ohBBiKZWESAgZnGUMC2AFD8KiqOvHKR68
         8qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748072001; x=1748676801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OlV6jZ4UTnKd85KCL3Cxe2SPPsWlU2hERkPf83eIdk=;
        b=ZSqnzefDn0U31jLOEYmPm/0cJUUC6qgZfyJHHVoF5aB4iSBH7xFY6y7ikKIZ0IPZe5
         qhneAToPjK0i7ghajbKqP652iNUm90pghGcSRSUrE5f/afIgzbTQGmEAhHrBnd22uV9G
         bvUx6WDVQb3rGJ9QpCc8mY5JiAnCDgfUW66LPzZs32MIMIxOjdZlbBFUWy38QnZZvSlc
         jOEVjxGffeL6RxQZqlj8Eeer5en4EHBeZH2D6TDidE2dVanKImhGVCVNhEAsc6atNpHq
         WbsSMecr5X1ckorG/d0iNCBZiH1eR3wUADSHBCmX8oc6+DVaxK7kPhGyqSFvJRLQHsv8
         29ZQ==
X-Gm-Message-State: AOJu0Yxm9zYVyNOQuLeiA7RxQ7+jtaVnOt6Gnp3UnY/uYG5SAmkXDxod
	vd1bfBStxtPjtOajRzYk8SUvOEMz3Hw8gX9150r6GgEcjLSdjyOWye8pQRzF8sqiafkxPJjwunt
	d6kzb5V/3s/sv2K04KVCoQ+30CtXqYMs=
X-Gm-Gg: ASbGncumYrpiQmt3OpU5516dzbapWT9W6dWOLAEkVLSOrtaLsGjDy+PXeNsORq9DrBO
	xDi07K6/RML51PxCJ7OFGVUPRQq73yHJouMl3OQj8ZLz+/YnqSc4dQA/TEY9osB1txRu4qq64Qr
	z0+Q6uptoVhsDZOs2E9uH1ytfLrErQ2hmXPzHXLcN5uhKR+a4oqR3R0YrCIZrG7vgPly0uRfioq
	l0=
X-Google-Smtp-Source: AGHT+IFDAewVwoJqp3/sR60ISPtjmjEatszTBdEJHxe+94nA4D54fk5DxCmdm4HEQMLzXmj8Kp1iUw7uRnwWVqGTjKc=
X-Received: by 2002:a05:622a:1b94:b0:494:a01d:a912 with SMTP id
 d75a77b69052e-49f46940cc6mr36416201cf.13.1748072001443; Sat, 24 May 2025
 00:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
 <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com> <20250524073055.58092-2-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250524073055.58092-2-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 24 May 2025 13:03:10 +0530
X-Gm-Features: AX0GCFuHJifo93gA1iaa4HFThD5mQeoOTcnsbkB_Yj3Zm2FOPYMfqcjEPN_8gxc
Message-ID: <CA+rGoLdP+CPhqX8WCAPDUnKBUfQSZBpXeSJOXc3KuS4sVR-2ag@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] The seventeenth batch
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, mlell08@gmail.com
Content-Type: text/plain; charset="UTF-8"

Oh my god

I'm so clumsy today

Sorry bout that
will send in a new thread.

-Jayatheerth
