Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F10426D1E
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749418; cv=pass; b=c1ZGknRM6rgW20IAz8FeqQw+qUaMhDYqjNFHTIfht4KTj/hPvuFb0kYJcJHkzplu8gEKlw3PACPE02q1LzMpyPjB0jCdjTDXKp2sfpbGWr5VLVnZhfHqFGI6ialFANN3fBUXa26TY5K8CuDbECkxF1gmMrlUWXQSRbniM7IuXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749418; c=relaxed/simple;
	bh=6nc7J69a3r+HVqNwsTx9IVF+ePlDboP+r6MoWZTcvOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5C8WMPMxAe4rNPkKH0OWeIRSSdvctvCsevH91GiR2fSK20VcV0HXssACWufaHJ/mbZNo8k6DlpYOcfvOuDlXDzeKSLbtI/hAaIUX9y84UYOyxhyfbevB542YaDfi0bYm1Vi3udMt3pBsTupi+renMOFFr+rX/8EB3oUMu9538s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/KSZk4/; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/KSZk4/"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso3349359a12.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782749415; cv=none;
        d=google.com; s=arc-20260327;
        b=BjmHpNSMszKdci44NlrBPAgnvJP1g4kqIkGeypbsejl9UNw5XS6mvnX4z0Pe7U430i
         R+uNRoZMN5lUseZ2orPBvRDHakukJ9mXf3kkyGkf+o913nY6MNhGN9rS8RRUcC322egg
         ftCCDXujgFDrCvnyYVJVQ+jyBLgOW/vTsOlT9JAzGPN6WaUdbqJY/tBABNR4amf6Nyqf
         SMpRaJvBG83SXO8ddCst9v2QXn0rb5fihv+W6wMRg3754kki3exE7zuvDNokotm9f6fz
         Kvu/F3icFBVQSUAqTnQla8rOd7HZ6fL72D9gsJ5LDa21CflbV2P0WOyPbmOx5ii0jiYv
         2TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6nc7J69a3r+HVqNwsTx9IVF+ePlDboP+r6MoWZTcvOY=;
        fh=cpJQUfdhIG1w/wEavbyIMFoaZbiXmMEbEqqJI/YK4HU=;
        b=Hpnl4mwgk/W3Z5CuPlwpmBb9PHkNefPUy7i8PnSzfbCvbxII8yyS+MWSURAjAkgHsb
         4uuVflhnKLNrBFlL+02o9okoEpXST86NQqX+riasoj5/gNtZFaKu1BAPzGf62ek16rj7
         QjQWEwq5O85n6JL273QRdDzyfMHZuppbBooRpQoEh6Rj442MUTwSEC/sRPKPiTpAbJLT
         KzIj8/uCJ2vnhg97Fm8PRJB8vGa/fq3vsTSHps9QhjDcPJRpmzteql+HWKVThkY0mBVi
         odtbGpPoVtXE60Ai9jywm3lGjxmLoDk3fF4ET1YLo1JopbHF6qJ/++xO81Pvs8IaYXwy
         RcEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782749415; x=1783354215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nc7J69a3r+HVqNwsTx9IVF+ePlDboP+r6MoWZTcvOY=;
        b=n/KSZk4/8RfSXzllNjOX83oSbEH2F8Bpnw7s1474Mr9YI1iu0wt9V+VI1e9aWXn0ek
         IS2NYvW4gqnAqE2weLWM1P3hztHevxOclcwMTzGr8SqSjsZPdr/BvML/c5dS3LHTVKIn
         dh9TWiR/gU8bjbfXog2ov4ShTBM26DUtbVmMLhWuQDzmWAljzuhtpdlkoQJ7Z22sTeHF
         3NMdnrlvNCjjTVAE6EBu+GwOZVcm4ZW3F537TcUP/TP+g2Gp8KrQ1t2xPqLiX1MsUyJP
         i9nttX8+azkqKl3qtBy8/WdhZw6f/leR50cVcqBl70yJJgMR0F0yInGEXbRKvJ7ZzUt1
         g/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749415; x=1783354215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nc7J69a3r+HVqNwsTx9IVF+ePlDboP+r6MoWZTcvOY=;
        b=I/gLwlB7KVv6aVbGoogGAQ4fFDQc8chp6WbOQdvgzrfl++AGi6Gm9jMnnUlB3bU9hQ
         ZX76wHbNMrI+fOpxvTaM7noP5PVR8HXutDPeaHnqvO8O0rnY+ruaOWPSabZg97mv7X6u
         2ICccX+pELr5olO4Vrn3p9niXO6L7NZ47n1dbqQzUl9aKwU/a1Jg1uJl8J22+F7B6pk/
         i3R235qHBfqLUQ4N63MivlHjtgo2TXwwrs/TKd3voRRHXuWbOlPdt/v/fqRc8+4CUQAf
         +WgOMs5tbdMeDzc1cXM8enzTi9u+WVqn20NVxdXnFwCOEVr+B6Vzc68WoOqoccBBOed0
         cdYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqpoy8ys206oEUrCac+pj5TouzsfeptkJaQ+2JZ6dYfQFtqdQ4FYF+Q8arnaMdO2SXdeDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYKHUNr6lBmp4sOyzaap0p0zOsFk28XZQm076lM1XOoCprscM
	3cZFXb+bgEDNWc7fYHEBOOYwfLbQF+HsWbXoz8B/9rJQ8rWwIULkqKX+dd93m/FaA69aOt1Eaep
	Oi3haMD/js2Pt923J+vMlRp/rLZJ8OB0=
X-Gm-Gg: AfdE7clixzsiq6wA3V/19lvayHOxoIVybAJSX54VgAVpTIvCb9YYHLo3e8SNhbQnjOE
	XrHeZcbJJFh/rHUsVuXCc1BTF6qGCt2AidLUlZBp9TcylyCRXAM+JbHLeUXuw6byVSXKI8sRxMe
	cYpo4Sv/spcpwf9umKltNghOiCdiamVQhJVnvYnmc+D4KOX+Ccct38tkuf160935BRWI0LMDg8o
	KCSfFHoJRyR7N/Ez23iSa8nrlpi39UYnIcRBUHRqBet4W6Ci7clijeVz3VIEI5zhSEpV+zZ
X-Received: by 2002:a05:6402:3591:b0:698:4831:f9aa with SMTP id
 4fb4d7f45d1cf-6984831fc61mr3284648a12.12.1782749414850; Mon, 29 Jun 2026
 09:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im>
In-Reply-To: <akIQLM6xZTHBudWT@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 29 Jun 2026 18:09:38 +0200
X-Gm-Features: AVVi8CfKAo9_lbhcjRt25fuo5iaVIoYCrwRoa-U7hnhUe4blMEqN0lbFR9CR8Bg
Message-ID: <CAHwyqnV2J2d+ZHEOfMOe6xZPdfP54AfJ0GnyhfTwFmPVyQ9Y-Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yeah, I agree that we should punt on merge commits for now. They are a
> can of worms, and I'm not sure that we should just squash them. I would
> at least like the user to ask a flag that tells us that it's fine
> squashing those.

Do you mean not even handling simple merges that are fully within the
range? I'm already handling those, so remove?


Harald
