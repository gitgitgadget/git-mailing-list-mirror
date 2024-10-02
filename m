Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CD1D0B86
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882313; cv=none; b=PV6qJWnbgLv51Qj0l0uGUBIHpxFT9oKjbMklnPSTFN94o2yI7fGqFLBgsYTktYjVX41UMmgFRrlR1N4RvS0B+EZAFl9B61eMrnci57R/mJ8DH4KBwW2vzBwnBNN6EI84cr+b9WTzNlgTXs3W8OhZvvY4bpLOl0rGtZRZ07VVDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882313; c=relaxed/simple;
	bh=lfGJBVWK5h27YKOOkQy5OonV1OI8bkCXsflbwpQgYs8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FP6iRGeHcJnBIQGWI9Nd09/7+jrKjDm+eVyFbsQ5mMUp06eHK7XA5ca3mFWqXmBD4h3wCzHdKn6ALtfjgcrJ50H6EM36ar5/vMRKlsI4HhmoaOFlzmvdJMn/X45KfLpz9mnBHYVkxnf5/zKA1EnFxipHfgZt9trehhBZMPrXPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVhDFxjX; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVhDFxjX"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso185342566b.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882309; x=1728487109; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfGJBVWK5h27YKOOkQy5OonV1OI8bkCXsflbwpQgYs8=;
        b=hVhDFxjXl7ElOkpPNiJOZjulAHszMyFy2s/FqanEH1B0QuiYbOuu+pQb6zsbCAch7T
         90GgAcLb00h9T+z4igtUoQfh2L39+3SM/zNMAxi9bGTNBnG6Tum6c1nfSSMH1RvKUw5t
         ONulwyHRlUUwfByw2drrcvZg+QlmaPdGCFmhiaiSx8OHOUWpVJOQQlSxxlaX7kjqsN9J
         RMhwk8qz+cAvdWS+92r3Ot28ipUJE8tyAtwvjdtE/AOjsoQbBiDg7Q9hd9iw72UKl4Kb
         3IW9wu7YsSmwouL7MF/4G5QFfeHkovchpU27hrPuDSoCcPHlQJivgQgnb3z8Y80IWQ0Z
         2nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882309; x=1728487109;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfGJBVWK5h27YKOOkQy5OonV1OI8bkCXsflbwpQgYs8=;
        b=wN3qOEmLYwe1BUL829uu767D7I6Tb0LvK2vMMUATdpgX0b1Uo0fGlU91G4i6xmienK
         ItlwyNBrOZJd9SLUEFL7n30N6NJpcEIwLK/4eERw5N0lHEBfYAmyQgqno/wPS9wr5k7a
         eXEws6NRTtHTT7pKrwAd4o+/0eybRdUiXZYR3b3iNFc32qW5UnbEhP53DN5MsuJpPQne
         FC3YqZ8kXF6fV9i+Kj5VLtqyIf5jsB2jBYdO85W7/jTe9c/q0av+dsxf3iOVgcWBMg4/
         x7x9JCHoPQzbOa/MANDLJyZt52hCODIBhsfT9GDHcyzBKKDdxSPKrhn5cgRROesMTzGy
         pH5A==
X-Gm-Message-State: AOJu0YxZAoOTb6L8P7jDk5ShrnVxsuxBvxjl3BK2fZiQheJGj5nhQeI2
	qNcSWneIRgg6Mp5LIu4/fV81ujoQj/uE6oL3QgUf5Vy8Dgqv7lo7XGZ0xVK0Lck+DhaFArzkx6E
	Nikf7vj5M0K9o+Ryz7loFcttc/H4haduYu43QjnIj
X-Google-Smtp-Source: AGHT+IFCuHfP4HgVz3qB022LqcaI6mwkbFtY9Vw02I4QwUWD9f5SXcC1VzdI9WyLdnicvVg3VysGYCzTEVLPK1JdUdE=
X-Received: by 2002:a17:907:6e8c:b0:a8d:4c83:d85d with SMTP id
 a640c23a62f3a-a967bee906fmr858885366b.12.1727882308786; Wed, 02 Oct 2024
 08:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Date: Wed, 2 Oct 2024 16:18:18 +0100
Message-ID: <CAK83d8r6OTX8ThZV=7wmdB1LXKTMoUx8LPin+kKAbhzH560pZg@mail.gmail.com>
Subject: [Outreachy] Intern applicant
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

git subscribe
