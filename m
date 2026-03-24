Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CB3EF657
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348935; cv=pass; b=SUQNUMtM7IBn6yq8oYvMksbV8JFvezCzy/wk7j4PaNo6VTve+83io1RxZGvilX280oAybOgI9JPfEy6UdzwLuUUAmUHtI/+K8wls8glg78s/P/2bmUJOBYYHoIzvAhQ4MI+XL9Mj9D+GBLsGiejtFEAwUfYAaE687HteC0mRr9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348935; c=relaxed/simple;
	bh=dCdq8wtPGr92D5AkjbxiegDv+E38vNphf9ovW8TptQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH6od7Hl5/WzQuxTQqYUErpMK5SoEjrh4DoufGFq4JsY1CghL2poRMk9UuLvZ4PgBNnmG6vyl3E4ozG50nGN4qyRQ8NxQBgruyIJRl1CzyM1NnZQ7c4p4aD0vQTRPDKvU/IReYkdpg07W7m16sY7YTeYG/O8yXAXHKR0fFYxBoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLtzDATm; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLtzDATm"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-409de4132b5so2143617fac.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 03:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774348933; cv=none;
        d=google.com; s=arc-20240605;
        b=bbt9W3Xa95jeDR7Xrn3ujAkrMYuguX39i615V2kXLBdYoMv3cHB4xbQTISePC33/f6
         BOf88wVPd89qLj31Kxl6M/lpeRSsASDM3UyGpWQy+6/Ti02W63WFTfUN82d208973G4Y
         1jGfB/anD9YjIiDnO9r63QPmYb+43WJh49eGz1v3BMCbD4b3T6gwe3LJxVvBUcarPGMt
         Xioh+Qg37hYYE+bIaAlRaitFmbrZ66IBNyVTbx4lbdnI0Xu4Kfcr2gsrpO98ypxF+gBm
         2rGbwGDdZ1h/jAlRJ4ybUGb01F4cKRCU1B7cqDXug3c6pSQXjig9in9WCXGdcahtOErI
         ndKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dCdq8wtPGr92D5AkjbxiegDv+E38vNphf9ovW8TptQY=;
        fh=W9wnusxVK94aZqtf2WZp/TOQ8W0QMg0c2dOHxyW3iLk=;
        b=dIgCv7ISpHbHK5KOHVKfBF5qHik/OGsHtQMcqvUtvP3G+zEFlTtvdNWzdcdNqEChPU
         Mf7N/vlHDDKUxFsmrFVARQyNSbDSI8Fc5Lp7mSJcgd0umoi9xYdXGVBmMrMyYYgiq8e/
         qf6d9p1bidUVqaVYFSNhryLQhOMuGJjJv5m1iQHjqJJI+Ua3CG6D+v8FMOwNr7nt+waL
         7JyPoiroGNRkwDZjTnLEguqHZ6o0v5FciWGFUlwDoOQ+IVS6QS25729BJfvvrslSaK0o
         yDIO22/sHD6K7H0h4Tk4vMhKVKg7QwHQ51zbjMuqOZX8oSRe/wFrPZ3hqkwmWlVt4l91
         JENw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774348933; x=1774953733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCdq8wtPGr92D5AkjbxiegDv+E38vNphf9ovW8TptQY=;
        b=fLtzDATm7FoycyqRmveD6i6yV7EOEBecADljjs6z+C6QzJIGCjeynRUsR1aAQqzyXS
         Wnp6p0UeI8yqJXo9CvMG6xJLwpTAue1TAHIeQRW99pxTeWxVMk++O0dd9cDmEJYPYJbF
         v23OadQUXNcVxWilqF1ADY64b1hhzjH0e1SDdoAxtN3EuSMOlFkl9tPD8Sm/CtxSiD8V
         7lHV35j5dpLFT6o6NzSLzS3sSWcLMxmbz1+mrqFYtirItwUwyep42XRLFBmxINllf65F
         PzHsr+iZHR9UccoACx0WVvCusbjUMrAn4DYOBQMfLNu70y4A4QU2vlTslJWBX2t5GpLl
         OIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348933; x=1774953733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCdq8wtPGr92D5AkjbxiegDv+E38vNphf9ovW8TptQY=;
        b=GahwfsLLqE6A6ogOE/KaE6ibGnOGFAYit7Xfjt25rpE0YuZx2XF1nEo2VQEFp8RoS+
         JXucj4vxV/6TZhhYo0iO+OtF9Kd8xnAMbEGNjdAFIpTrZn2UMtbBm6BOgtHPREaRKQRO
         EyT5axcrqllFRrpVSh98xhRWvV5CkLST49IQNMBl64+jFENnZhHVmQ2IabeLTna7mURI
         cXB37S3Op7rskhsOzC2iFbVFajmggjQINv9elrDMpcui5BV4I957En4rkmQSdzKubCZ6
         i0cGPrVXNDAh7k8uhh+GhN1eXmBxoSJoYyUQcp8tYdjkVyxeUG5LPWtjcungx3BNYzoZ
         sD2g==
X-Gm-Message-State: AOJu0YxdEQBdFcCVTyGkpAvgQjy4y+xs5jsKXRPJACaeNvQ5HV5e0rzw
	1mp5IGL34OZdXp1bo3UkL9n3z3zRVDIuv2zrLnOXdikovdozI0zsEyqZyMNE8BbE2SCltPrXLYM
	8ft4bJn2+RFabV7EWJe5lXoKqHE3pz+qwUFzT
X-Gm-Gg: ATEYQzx+m5bg+fnaQoKN6WulF0BgMC4Nx/tfw7AaxNyWEJ/gl8HkHigIxC0WX3+ols6
	AwO5nuuU9SFpEaoteIOMWRY43HGqxVwt1FSOkKVfZunb/WQciT3X1gBhDCwhj8KfvquRPriGFL2
	y32Dm0XahZm2hN0xAmEMonhf0S53GF91nMn80DJ6D/QawlLpmUos/+eap8XtwOhLGYlYubSFowT
	3U6zYnum3waTl3Ujkz18ZxJU9HYEBLWmjD2v3wuYQIRFwvqM+wHMKJH8fEP9B9pNAgdU/wEfDLB
	UILbDLT2DXF3dfFIDeXcqDJc08tQ+TwzIeE7WvgtYOEckgxWS0Rc4uFoBrHA8fdDRASR
X-Received: by 2002:a05:6871:60c8:b0:3ff:46a0:a25a with SMTP id
 586e51a60fabf-41c10eff775mr10312966fac.4.1774348932911; Tue, 24 Mar 2026
 03:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgEQTPhxPeEYkm44+BuSj5GG6PWhRrqGT7Vq7zXFPKZqoag@mail.gmail.com>
In-Reply-To: <CAG7UgEQTPhxPeEYkm44+BuSj5GG6PWhRrqGT7Vq7zXFPKZqoag@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Mar 2026 11:42:00 +0100
X-Gm-Features: AQROBzDv9iuE58PJE5_JHpbGRAcFCopJY4p27Z0I5tf_fpA6WGSpH0XQ6Qi7t6A
Message-ID: <CAP8UFD1Kirbt-j5h7NB0UcxPjz=Ger7GBK+excY4Z8X+yKtdzw@mail.gmail.com>
Subject: Re: [GSOC][RFC] Draft Proposal: Complete and extend the
 remote-object-info command for git cat-file
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 16, 2026 at 8:59=E2=80=AFPM Deveshi Dwivedi
<deveshigurgaon@gmail.com> wrote:
>
> Hi! I would be grateful to get feedback on my proposal draft for GSoC
> 2026.

Sorry for the late feedback, and thanks for your interest in Git and
this project.

[...]

> - https://github.com/processing/p5.js-web-editor/pull/3492
>
> - https://github.com/neovim/neovim/pull/33235
>
> - https://github.com/kube-vip/kube-vip/pull/1087
>
> - https://github.com/WasmEdge/WasmEdge/pull/3963
>
> - https://github.com/openfoodfacts/openfoodfacts-server/pull/10037
>
> - https://github.com/openfoodfacts/openfoodfacts-server/pull/9967
>
> - https://github.com/processing/p5.js/pull/6761
>
> - https://github.com/processing/p5.js/pull/6669

It could be interesting to introduce these contributions a bit more.
Maybe for example add one sentence to introduce your contributions to
p5.js and one to introduce your contributions to openfoodfacts-server.

> I was also grateful to be an LFX mentee in Summer 2024 under the Open
> Mainframe Project. During the program I worked on building a new
> frontend for the Software Discovery Tool and integrating it with the
> backend to make the tool easier to use.

Do you have a link about this?

Thanks for your proposal.

Best,
Christian.
