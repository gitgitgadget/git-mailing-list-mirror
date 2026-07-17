Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219036A01D
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279818; cv=pass; b=onsxCYwqZ1BLKTd978HVg52bBK/zCShQ+4qVFYbTKu1CMTNfwoUcWjrTGSO460upvOKBr1ZxzBXRPsE0NHDxQ7iou7qHNJ1lAfXVxZyLDQRPYw1rqaMQeLPmDzmPoK90js5ozhFOfQqE6wzg4/Yl2uMAwaRQ+JPRwjFG+AMAJCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279818; c=relaxed/simple;
	bh=OKxip/hAP5t0Tm+nE41CLfap/W4bZ3reKzBbda4QlW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIDtXGE/PhHFGuxb2i+WCSOasR+rmZDdP901AukGG5MuRv4oTRExWw56mH+Lh28Stu4WWx6qIJZpz6eA1dmyJ609r7hcqHoen4TfW6HdWWz7rnwUQXONuCxGKhBGIbZiyd0ZRDvOk/HMn8lvCqZxFu4tsHdy5Uj3rQ4Ns+UL2EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVaGq+/G; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVaGq+/G"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso6948639a12.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 02:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784279815; cv=none;
        d=google.com; s=arc-20260327;
        b=NJSEd81y68Q2SLUCavSSFbG62Loow4JBk4IPfSVM68DmEVXnHyNcw9isj7lcalzPmr
         Gkf6kRxYQe+FG3nPlDhDROlMTu6zCVoeGyV6d4XfbTONqRGTWl72AvWGF2/uBPQ9BXYj
         6/qCRI577H0rkcwjEhTBM51DfKcBWc9RhSYSpZZeCccyOleWsWhcQ4uAFVTbTe41A53B
         WDfp1FjfYlQ27fpViO5PwhrnKiBKZd/yG26ILldu/3ddtDf4bIfgdjvm78769w9fnnrS
         b5e7diGRceIwelHHH91u2lvIKQ2119qhbfkK6OKt23Kk5q47CcHhAk11dLRM2LSQoGYW
         8yqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OKxip/hAP5t0Tm+nE41CLfap/W4bZ3reKzBbda4QlW0=;
        fh=lCg1EB8RLwX/h2jyJY8GeyJ2LFy8ccNlMLCfrMJANgw=;
        b=QK/q/IbTFZ6EosAhBLo4HhOmUn4837h83SeLElwIz5YzISQIqXruFyPp77RhHpyaiU
         Mq0JEGls4d/igcNf3iAmIwrgV8nRUQez+BWYYMMZnpJu7wWcesFdGKqjL2znTMrZaSWj
         7loJ4xm8QsGY3NO95Ek0+ZHjkCqL828+Hxtn/6Evvlw3wUa4/C4ohoIjGZ1QaGvoh2s1
         mVBb8DAh8zU93hr/lL7eSZC36mw1/FedSDbvnpL6iRDX3iy+M7mJH+ieqlciE2xox7rz
         LKFAM7HS+UBuJED09b+gh0FUYgCzJMTrAmrAxQmCojriAG7nR+XETyDOlEWm8h6hvjbF
         q2JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784279815; x=1784884615; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKxip/hAP5t0Tm+nE41CLfap/W4bZ3reKzBbda4QlW0=;
        b=bVaGq+/GuyHsc3AtROYha6mA8NdzuOTheDJPPYKEkbCrERNsN68jM8QyGp5s8qOwty
         qH1UJyKAhBFSKWrNVmcGKHekDnppazpjRqDYP4A2dcq3g0tjm553W3Y7m/rx2LlWgYwS
         htnc7kYyWZnCj1tKza2a+Do4gNNxWiKxUnkQb3g0zBUGmt418mFkVzvN8jBsF2NbaeQe
         qspfRmCdstmpEA0Y5I0Mo76snHXjTFesY1fzxRVe4e9vvnVbKoJDBApikQYHGXvm78MK
         eC6yeE60AACHOXhxl0HnHajmewe6kOapKtsPaxKINhVw833BeqyZo+X5JzHd0vvnc1rI
         A1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279815; x=1784884615;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OKxip/hAP5t0Tm+nE41CLfap/W4bZ3reKzBbda4QlW0=;
        b=OLo6WjheNuIN3GpW4ex3KJ3Y7/cxWBmjiiy2sBPd/QctBm8DrhQW8gHBAFyPwjLuso
         FT+3g1hHSMwqKcBmAHBpYYzI25UbThONiph9YV+TDzNIgPRfMcAIQLGBHi+OETCbbgLR
         hVLMwMG+GGEGeulJ0cLbgDoaNBXR2L6ebr9hI1NHA/QGtaUcMIjjNed8VAlQGIYo76T3
         xteqiOVxUQuD8R3uGjUdbSYryIInZTFfEU5xZ6IPmyb8A6UeLF9z7qkrVZEmILRj3Tln
         2ku0+v9yIDmVi32s+macNJ7P+gVNX1iPsPV3rDVcUTRiq6NpJaSX+FYHvG9WyicSBEyE
         9fsg==
X-Forwarded-Encrypted: i=1; AHgh+RoP3Z9rV9AhvlJYl0ieu3R4QC7+ibQTYLknZLuwzk3Fdtwf20YNaCNN6djnKnK+qvUKj84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGEgvQbUy0KAlhBy+8nzN4PtYgGuJCDU2P1IVmYAgsI2GkXiD
	qI4ptZXHG0/2dfs7J/hSBT0nTFiP0uw0W1ymRTOSaH61F2J+9SniisV8ynNI986ZMUq2yQ90S8f
	ircUWvA5KzDpl5M+/DlVW16oHzKQF/FI=
X-Gm-Gg: AfdE7cnngMwkGILKEXnA3rxWr98NxGH+50N1Er4jozXK1BdmNldoWDm3YN8ssyDZI+v
	2JouwJ3GSX5v4B87stiRgmqYbiXveO1o7BHNHSnnTM+Tg/Qm8ulyOMIa+GfrDW4puLDsw/YKDbE
	q1FCiGHXMo8QyJ9l9vfNheuLYT26l8TKDUD8O/bj9ruyyv5u0wU7QqhtossbIjlIICowqN1z+h/
	8oL6lVR0DM+UI2DvV+eAs7e25xcvSUqsBpxBQCSztlN1PH27/XPS3s3h1LdJg==
X-Received: by 2002:a05:6402:354a:b0:697:7f9a:8652 with SMTP id
 4fb4d7f45d1cf-69e652e27a5mr607454a12.27.1784279814742; Fri, 17 Jul 2026
 02:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
 <a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
 <xmqqse5ihmsz.fsf@gitster.g> <CAHwyqnUFfewFm7tr-Busv1rKP=4Rqnq+vJ7mEdgbaRLKbpbo=g@mail.gmail.com>
 <xmqqpl0m9pnq.fsf@gitster.g>
In-Reply-To: <xmqqpl0m9pnq.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 17 Jul 2026 11:16:17 +0200
X-Gm-Features: AUfX_mynUNFvegDXBq-C_o_2DcRmbjXRMPf0O-6Q7SVI9-RDpDU50HZmt0Q9W1w
Message-ID: <CAHwyqnWOnDoMpMP7gwrQWRmaJqBrSDpdLN0Dp7U6vPU0GKSmEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] bisect: add --auto-reset to leave when done
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

That's a great idea!


Harald
