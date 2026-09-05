Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B5212542
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586938; cv=pass; b=gO+w3JcMYAIww3NBQGW/Q8TQjQkcOuoNjacW3LiwQ+Us4RwWY6EU0ugFEOi/8YNzGv0nIWYkM/pjVanKh3yEgq3yoQGU1RdxnU1UJX+9aODPdJpsdDsErxlSoz0k+VKqkPtNoUvzKhXu6gDQX1nkOdZv3ptZBxVu/kBYegz84kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586938; c=relaxed/simple;
	bh=XyPmaHbpbxTx4fw6I5Gtffocc/l1q0JyadVOn++n1Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psEvtcKemI2+oeblvbSrh7cSdM3Wf8juBh9e7WT1cWp8vS2dXkuEfgJHO+G7jtyYuvrCfQtjFbKg4Ai8uQoecWr0eHT9O93iUUPhzGA8atCRDBkL924cxBNSyDKHH4oCZIu04uOpANh8xIZ4MNklYSAj3yCDQkpt0t/vfxSUuMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=CaIif5gS; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="CaIif5gS"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66f78cba2e1so1858053d50.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 22:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788586934; cv=none;
        d=google.com; s=arc-20260327;
        b=YXbPM49WDXCJsbYoxE6MfAcTBOsheu8wfUVWoa09mltr/4t6UnwNzwKgyDOkmQsEwQ
         WXBy2aJGbalTp3F4yXAYCS6tttrbbKdv4CgZSQvDarIPZ01aIYncQsk3Fum2Qj9uDlbw
         ExgdPF2OJyxjlwS/wUM+FHqMmBJgg8HHuX/mvsuqXWUpTrdV7pqfXKV4z3sGmrK+guKt
         jHYK+Wvp1ZxdnyZOAuBqSvzg9IJG629vJrrqpfWth4Qpi+xnAoyMZpBXIHxrn2XHl6NU
         L3vIqi8iM73kic2xkIUAVRhCiigrx5LGN9/v0KkXZE1ZiNlqDUrGOSQ/NuEpWZvLWP9V
         qwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QVo9x3tU7nO4TMcgnEdcwdRNPEB0D3r0V3ZcPhRJV58=;
        fh=B4xWB+FGXOTbjOmSImyCDTJrSmSxCk3OUUi821w/3eE=;
        b=ZD/I394A3ZrfHELytO8DAqEcQwWeJRniBu3OOFj9QEj3wfNnZT9AfInQf1gWYUWyfE
         XXFBw+WyGtzDpHlzUcGvcAMakXFdHxLJ7WsctpITUvOHUPbskRhub6jKwbSIN9AHO+/O
         zGTZn1Fx/Qb/isdzTgFWEVRwiFNMQUjzokLjwNpAB5QL+RQGP9dsDB5qM6SrnBjEEYjD
         dFz0GGmfuQ2oRos8PHjjUMvnZqAj3W6lcTara5pCz6T6a0HrdgVoni32H9Pmd3lqQQDQ
         RmaupJIqhggy77Mq7AaOdvouVs6I9LYB8eLnnvfoAXBu0ydtoE1VpcLMYgmjUO4xRURK
         6V4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788586934; x=1789191734; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QVo9x3tU7nO4TMcgnEdcwdRNPEB0D3r0V3ZcPhRJV58=;
        b=CaIif5gSL2YSAUHBrX+nThnRUxeueIaHF1QUJ3P6GS4/cQx4AHp8IYNj5HpOdzmKS4
         KTRBW1Vvq2O0Ojn/fpUfxEnW9y8+LWwbzqXPhoT+KArMSb+FC6M256cuuSjhhrRX189S
         fCG78SP+DVc/A/fm0IyYBQoZL2008ejnNO/9nxzc9QCpiGfxoaPl47m8eO7Y4uFGdE2m
         IPWiHf/XvjitdxpeSQ6BgmcIbgxb7OY6j8UANI1tAj6sHX/OmlKSz3lWRC3hg1EMqSgU
         XxB1GevoDrevhLgViMAQmWnbiySF3Ot7lUaFjMuMWUny2GCceyU2bEL1WPmo6vb4aCAE
         CZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788586934; x=1789191734;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QVo9x3tU7nO4TMcgnEdcwdRNPEB0D3r0V3ZcPhRJV58=;
        b=cE5sVuo3V9oyI5GmkOT/UDTNgHcEQrPYkluqJy1tAkJguYkyWfnvCe9HfGOu4Q1xMT
         9N3DCd1JX+cifXdTdLW6AU8XWUZ7K3UqiHI+zqUSeXhjZ2nw/TZS8DRDmhVc9zI2iXjE
         k1Dt1AFEk+EMUEHXRouDuaVXGNE9C3SijT2NxAKi0Mrv6SgudVm2yrej761Zqfna8S5U
         ZLZF3NNWU3PUng/o2szzuklpxb9htntUOH8tnBFjjTrgk7/osK1IYuOHE26RUgc5F3FM
         bbhBvK/ZGBbDcnxf5pXwEQBbp/iQYRE0y7brT4F2oQavMNR4Pi/l2MD6t9aHcR5lXGp3
         x2zQ==
X-Gm-Message-State: AFuF++mi0dHGL57z9H52oQZSWpvaQ3F8lodgcY3McJSmfDiv7psF0ye7
	O+5UCslIfKgte7BIPrKWlmI8hVcFXJw3MQGxZkSAgjo6v/8vmlMTEJFdT4fSUsqY/51TEwufi8i
	BHR6rLq5fqpkPCOam7fSV0PNIRh+QKfQWYq8AQ5btjg==
X-Gm-Gg: AYBFou3q5kWIl/z9FVxLzqEaK5LDq3szQRFh/LZ4hPuWuz6TpRqh1eCPCP+l7xPkVV8
	uVSkhibCYxJXxu0nHKIHK6wAiEvErNECyHD90UjuKLMTBogG+/MJjGBHmAiIoLvJP6LdXAnnPI1
	s61SUFxeyXZP7n4hATEQuTuVtd8HJJEaABBRFvvGlgZHSbrNwog5VoPMGa/dNaGkwUbhsmaZ7Be
	/behuFZB+gN+uiT7MQoA2sBeJDAHPrla3cu6NzxR43N0bcsoSxXgMprGU84nUPaIQrEiK/xDpK4
	fG7dOuSrtTrP9BenoTAsL8yNM/MAiY/c6vCUmzJ41OIr0CfhlEP9PbletT8b7vYoLX2FhkZrGyG
	ZgG0=
X-Received: by 2002:a05:690e:2590:b0:66d:7f5:37b1 with SMTP id
 956f58d0204a3-66fb59b568emr2608096d50.18.1788586934443; Fri, 04 Sep 2026
 22:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
 <xmqqwlt03e6k.fsf@gitster.g>
In-Reply-To: <xmqqwlt03e6k.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sat, 5 Sep 2026 07:42:02 +0200
X-Gm-Features: AcwNN1Vh7hegFQKFOQFZvF9N2pvOvvQhZV_l91seYYQBfwJfc6a2Tzx_tVT3omo
Message-ID: <CAA0xjtokUaNPxwucZ6p_-G6DsmEMsX9JfR4UOwZK=crvEd5fAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
To: gitster@pobox.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, ps@pks.im, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 04/09/2026 23:21, Junio C Hamano wrote:
> Does this have to be a "struct strbuf", not "const char *"?  The
> latter makes it clear that it will never change its value once you
> built it in disable_auto_maintenance().

It doesn't. I'll make it a char * that replay_ctx_release() frees,
built the way you sketch, in the next version.

Thanks,
Thomas
