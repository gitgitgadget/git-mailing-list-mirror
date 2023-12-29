Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503B1428A
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0LNjsCE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb759e73bso4489581276.2
        for <git@vger.kernel.org>; Fri, 29 Dec 2023 13:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703883809; x=1704488609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2y4NSJyLcbpt3HHc/pdTKWKuLAV4wJnKVDDxmkItLQ=;
        b=C0LNjsCEdvD8NnliU52mvArr6SZUXBPJxrEvWJz5GU+LW1kOmmEF1nuVM+UukMyYTh
         p7AQLmdrtNH1jorXZR3IJiy40MuQvvlaA+R3NpQsLzW47ohBqrZPnSvZBiVVP5QVIoU8
         Roel9RDN6KTLR2/JZUp+pV25EhZkERJJ4tZl1uqSGEIDYWkn9P+Q23dIk+OKOInFqFqZ
         kU9AiLfY+mBcEbGkcbLOeEOwpohkdzbwlrk6MCfNulQjX1+mtffvs1zYcIVO5uvdKPHe
         Xq9ZS0XbfE4tnha38PloeAn61jeX7eunsNt8wAySy/CBAz+Jj8iUnV/RcDBgHQyPrh4J
         ncwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703883809; x=1704488609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2y4NSJyLcbpt3HHc/pdTKWKuLAV4wJnKVDDxmkItLQ=;
        b=CnKkn2Cq3Hb8AHOpHdMEPNl3Jms2/k7O0TmXMyNmoE2U8sDmwxl4VJvq3p3slkEYsQ
         fUfymLMo+HwZrITe/fcJRRYj9t83qQyYb7KByOxQ7HWZsY+zYJaT4y8deaNqRXoiRpeF
         10z3NIAW0788ZvnlEQm4YWmx/YKeHswyHFSAYQQqZYXk6N/AV6s4mXIXE3m7DS/bmaXr
         ZQBHpIUl/lrlTVYO8MVGzuuhEvh58uC/EJOpl2is5rr0insLoN7JQ3SLC+jptFhOj1Oh
         QyDve0buUgftB8DU9s7Xh5TqpnbrN+QnldrzbxUFfhZsHj7hqlLx8K9gya7jS2I7FKJU
         t86w==
X-Gm-Message-State: AOJu0Yz5Qqq2YSspOS+cJLwec20F09Ybv6qBe1BP44BGO/1gCQXjbno8
	RedMagsKl5buky63UoxTRDj4vpi3uW9w00yeUg==
X-Google-Smtp-Source: AGHT+IGOouQ+uw1pn8W3MMGHmWm3Ny+gvY94HjdPWwV2ImiXciG/QDSAxfi1Zcn/lL4DbkxlwTJljbPIsic=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:154f:b0:dbe:387d:a8ef with SMTP id
 r15-20020a056902154f00b00dbe387da8efmr121043ybu.1.1703883809029; Fri, 29 Dec
 2023 13:03:29 -0800 (PST)
Date: Fri, 29 Dec 2023 13:03:27 -0800
In-Reply-To: <owlyv88hqzlu.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
 <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com> <ce25420db29c9953095db652584dbed4e35d67ad.1697828495.git.gitgitgadget@gmail.com>
 <xmqqr0lpoue3.fsf@gitster.g> <owlyv88hqzlu.fsf@fine.c.googlers.com>
Message-ID: <owlysf3kraao.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 2/3] trailer: find the end of the log message
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Glen Choo <glencbz@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"


> (1) enrich the trailer API (make trailer.h have simpler data structures
>     and practical functions that clients can readily use), and
> (2) make builtin/interpret-trailers.c, and other clients in the Git
>     codebase use this new API.

I've done some more thinking/hacking and I'm realizing that changing the
data structures significantly as a first step will be difficult to get
right without being able to unit-test things as we go. As we don't have
unit tests (sorry, I keep forgetting...), I think changing the shape of
data structures right now is a showstopper.

Step (1) will have to be done without changing any of the existing data
structures.
