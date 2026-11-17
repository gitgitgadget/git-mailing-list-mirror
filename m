Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953033;
	b=ng+sgAlFlknHvR9qf8mtrXeNh68l8gGflQqaxWtbo19JyYvggACRgSoYF8FttIPXdxMy
	 AAt84OSDza6At992jb0WrWQCNA8i464YM4FgkzJ72vsJMRs9ZHQMmTeaCZf2ioy0+Dnjd
	 lyf5a/pb5YST1Oojydr8yBI71+WloWAy+4+0kDWOSbmS9RLA0Vx9x5qWUmETYmdo5IAzx
	 O+9rlUJPzfdRJqJE+1VSDiqc835Zc9kRFynWwdLrqM0ZJ7Ww3C+aSpIQV5+1y678jcSS4
	 AVh6/gj0SVBzS8yiwBdGvGCsVipUW9DndaISt/38lK8vM1tbt23T+kGkRX7D6dSOWuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PWuwk2XpRjDl2etUBp/ls5xh27TyiqpHgnM5P4+Ieq8=;
	b=pK12Low7xgl0N0gPPf8aSsVhXYNLlrvzT/M23KTJPVTX3qaC0j/akIjJ9rk9tR6cDE/A
	 GUk6ksYLtK22csTU/tfWpsgsusg8mcD50xQ7F04hGZnQ9H+ooOKkvWkSiB5nRksSxsuxV
	 V/bS0+ctwKguSajTGLAh45XNXDb9275zjgPRhqb2eJ4arHSkUYuqXMWO0BYQevVeUhm59
	 YtNvP9GBz3gxV8EtWoQ6Rup9l4wqKKZvJPRG0buIKRkTOF1bTArYYGxRFJeJ+uSix3z9e
	 M3cZwSZ0tAT1T1vA0TtarrvbShc/7A9WGi/RjE3GajHVuBrmrs7eDJWsqibirEwZKXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPoxUYe6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBC606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPoxUYe6
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso46690a12.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 14:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794953031; cv=none;
        d=google.com; s=arc-20260327;
        b=MGfx42U0Ai/OodA4Wdxi2noRYVcW4/NmbLmVhFwxandk4HzRIarlSD4j3IFM01s670
         22NVDvoyryOJI1KDhSWif4+jrkFcxykUpsN7XC8oW47XTvRL0osRUTszGijXL37OJnmr
         WcLaZ07xJZYxAftO1T//3jA8TglZaG8G+zCiN8XqfQ5a2M+OhqwzZmrOL6Q6zO/3OZJ/
         ZhXECcrR3ip0pnVO5UFPsr6M+JWYkQ+VYNj+UZfuBt4JhUu2/sHjXIzrdPpPYzh9YT6A
         edzZCR6ZNrH6N53buJdJGJsk366L0bXCcfgdT+swYsZXwTy1eqpOwkMuxx4DpWAHCVCJ
         C87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PWuwk2XpRjDl2etUBp/ls5xh27TyiqpHgnM5P4+Ieq8=;
        fh=cYXcbqrIJytuSNKK67oplzNR2h9W8ncZAd8wsBITsyI=;
        b=qz+nu5tqi2p/QcxTIMuh0QkuTNG0On6/08gnhmfMMwXdrHNPP6vCIAMuOqB4HDdgZ0
         k1p+hWAWLWfjjamyczcW1G7GaRSUF/W5KrKPvgKzNVJ0V03TNYeC2oK6falJG7/ZD4Np
         dsqnVfCL3zjuOEahrYhUbetG1uamwuZfDPRVRxp1QmAT0qbgbbmM2PIxU3/hSpXDEu82
         F+O0F4mNbm4+9DgPtHHuHja7wTbpPEYteSPR7CYcXY64KDXXpx6X0Jg5JlElw6qHo10Q
         sL3czl0Z9XcnwLgbD7La00ZsifFNRpo4pZRPD6D3z9vGpOmEofKb9gG9anvYbBjuAvCZ
         kE5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953031; x=1795557831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWuwk2XpRjDl2etUBp/ls5xh27TyiqpHgnM5P4+Ieq8=;
        b=qPoxUYe6kdbaIgBK29/qQC8nZL8LMT0mxd49enwqiSI47fzKR591pVwBIMM5WfBOCt
         3NUn3rH2hEh85FCMGaHAOmYPkST0qrrUMs4zA7OBWsOgxfN/QYJS+O34j7MiHj6AytJ4
         pxDXFEycPqpo+FVl9plFefTHzVNceuWiedvOOpcapGq/UVmKrS+W1jGtOlblLtwCjHd4
         5nLw78njg/x9X44fX5NEyMDpJzUFPyqOMe9FfgONjS3ENgXteHslAhg2qBCDqA4S4aQf
         1xw/bnIzzgPCuRuW/UOhZkL69Z3NkxFYFKjGYQIrCBY+8bBjwKf/ctKsdNSXc9HqkGnh
         2Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953031; x=1795557831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWuwk2XpRjDl2etUBp/ls5xh27TyiqpHgnM5P4+Ieq8=;
        b=mfc5hx5QC1eFKAtGgpU7EgvMNNlpQfcsqO17EY6gND7jzc9t3baCswLlXzBYm0rTEl
         dcxsT+d7RlFRdH0BMlCS1SkRvzQ/B5kp/8D+aYu7K2+BNCXQyI1IHT0qlyrR7hExuPq7
         BF2iv4dvUrs5gYX0B7EhHmk83KT7+OBSTkRHfMEyIVdIPAjjdjQ7MqXOrjS2PIn1nhFx
         PC5z1nT0bK5QpXjdmnd/0lXh3H/Qbt7BCLBZEz3LRMqDx5YTG5+jp1LyHW8SbU38vvuE
         utm3wd6oNGaOaqiR2m/u6MGbDLfRKLYgzbCl2jjqKFDcxiB7WV59rgWOqH88OY9PFL1x
         4fFw==
X-Gm-Message-State: APuU4Z8QfgAM2TEKX88tOHkxCzp1W6DnIoxs36gq7zT9qWtYttNrcmQ+
	uWdwIcTlBKb4IPV6OfsIgMdgnAkfnVE9a6Wr569nTflTeDm6Ey1YKLvUqPup7jaDoOdz1ekiWO6
	68hsUSJFQjHkDDJsqJGcjju0zoAAt6/yD1A==
X-Gm-Gg: AYBFou0li2aEtvQdAAiU1p+ER3XEZGESXDsank66PQ3zobYlLcKWzoZrMFmXCUohRzb
	SFrp8U3MFSIOSCtTsMVMRS54BOTAI2TpyubkU4I/ouiSZTnXlpmAP8WKrf26h9oTM9YEe4KCNZi
	UASuYvFOxBtnZbx6fsSJcS7/I9t6zCbUfVAHPnrcGHwnyHoHbJPuXZXg9KXK/eleU1Tz+75kMcS
	9B8F12jEyFEpYu7THR+gdmcgwrEnm6mGypb5yrC/5aSkQwgiJL/WXAsnG5JGirfY0f1G61t4Rq6
	svd+89luzqKnFZlAuHf98qVkmSgVjqn03bohkdbs4nLNgP/6uEx3H/ot+ObM2A6SpWJ4hxfT/1z
	tsPd4ARuHP/wVxG8MiEvujUTnvueOXIGMqePU
X-Received: by 2002:a05:6402:234a:b0:6b7:df6c:d38 with SMTP id
 4fb4d7f45d1cf-6b887f1dc79mr394706a12.32.1794953030981; Tue, 17 Nov 2026
 14:03:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
 <20261021072137.258934-1-gitter.spiros@gmail.com> <20261030090545.9744-1-gitter.spiros@gmail.com>
 <20261117212756.716005-1-gitter.spiros@gmail.com>
In-Reply-To: <20261117212756.716005-1-gitter.spiros@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 17 Nov 2026 23:03:13 +0100
X-Gm-Features: AclHuK-Imm4s4r15XSqCAq5u19LGdozFZLaXILxTRQ40NREmQJSKzixIyRuJiEo
Message-ID: <CAHwyqnXmOFTYLM6Am54SGE7Za9wiVS+0uJQhZfxeomS18COLvg@mail.gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v2 looks good to me.


Harald

On Tue, Nov 17, 2026 at 10:28=E2=80=AFPM Elia Pinto <gitter.spiros@gmail.co=
m> wrote:
>
> Hi Harald, Junio,
>
> A gentle ping on this v2. It has been queued in 'seen' as
> ep/status-missing-upstream, and "What's cooking" has listed it as
> "Needs review" for a while. It still merges cleanly with both master
> (e1ec09b23c) and 'seen'.
>
> As far as I can tell, v2 addresses the comments Junio made on v1 (the
> shorter "missing" he suggested for "[gone]" will come as a separate
> patch, as I said in my reply), so what it is missing is a review, but
> please tell me if I overlooked something.
>
> Harald, you found the idea sensible when you looked at the RFC; would
> you have time to look at v2? (v1 was a resend of the RFC, not a
> duplicate, as noted below its "---".)
>
> If something needs to change for this to move forward, I will be happy
> to send a v3. If nobody finds the change worth having, that is fine
> too: just say so and I will withdraw it, so that it does not linger in
> 'seen'.
>
> Thanks,
> Elia
