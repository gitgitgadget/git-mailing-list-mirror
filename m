Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FD3EF0D2
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182799; cv=pass; b=dLx/58IudIhgdQhYHfLGQZdmhL6ykDTJLKe71MMzsMuDwxGZmIMXQTGuCbBMFh3YALABaGSUTS2Ntr6f8b9yYeZ2okW4qFyVXYBPwP9j0OWU2XZAa1+3RNXsfs0H9QSmaTDVwa2YgtLXUgYRhkyOt4+AkQJHJN6fRaSaKWpmmnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182799; c=relaxed/simple;
	bh=n1NR4zuE6EsaabLI3q7MFizOYQPhlkmp+EIke3dzfwM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kl1IbI91hHQN9r6C0fYUfha+hFnHHcIYBRQ/j7tM2icvk3CMm1ICGStueGS5fIedklHbp0aZNzaQwQGgkVvRso90O8VyXm+fwWiVANF1rODz6b1NsxjxlprpU4c2A+IzMLkC5O9/AA676IpMVPOBLAHSpypW/3l0ulw7aRcG9c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVwnvD2P; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVwnvD2P"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5752b279662so1072030e0c.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 02:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779182797; cv=none;
        d=google.com; s=arc-20240605;
        b=eieFLSHEqh1lvq2Asd0E0Petzk0YJsSm3zmkxtAQkURKQmrYDR3n2SQrriWLXgtOW1
         FciIJ6q+pdgcUMnkwDVG2VSUYJ/T3xFF47rdMmmsbvYDmu6VIClNbXeLWb26fuQTQKvr
         +ictr1Cl7oDJzxfLX6w3tfTV2Y0/NwWmLexTLo2urAdhVC+x4OA6g0G8zRzWySQdwwId
         e6VVGLCPWjOaNA9xMHu3iDgtEMGgwE4Ax6dF1Yt+aTKdOmuQrDJP8vWrXuyPBTT09OO8
         AX82jnZHdTv2BuLx4SrGypll+/W1Y25/Wni6HiZ3Q5D6NRxvxNtDQhaPH/dso6pt3CLU
         81Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pWtvvC500072r0k2jG7l4UC2JDjrHFwN3Wlh3Hf5BaE=;
        fh=4MfBEAXS2VjQDY/I+ja0W6oblPVtjbn+6rU5oDKUeS4=;
        b=k4ohd1Yk/fjde3CkPHR1THaUktN1GhfC2G3gXU4b1sP5+kBR6o5zHzioJ6EfJnnTxw
         lmdM6NnPu5f70tpDLW4FHhxy2CbFNpKX4hymvTUHVwK5FIfSTuJPrTUc2tcVFjzLt/5T
         IfWlzsTZjLbFIRlKtCQQekItMBxw1/2yMngKE2CqKUDnU+apU6d51WEt5uafO6UJdwao
         wsuFJeKU8QEXXc4z+PluY70LfMZN8g41h7OvieEoPSQ+2v29BQO3fGoQRLVPCBS3AYsL
         fKl4G+SYxrcbRVbCzxLHSorUinseSu4ZqSfX5Xsuh0Ne7KY8P+ITw9wv0TZpEI6AxYYt
         GS0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182797; x=1779787597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWtvvC500072r0k2jG7l4UC2JDjrHFwN3Wlh3Hf5BaE=;
        b=jVwnvD2Pkbs22avTC2ax7vjWO9ood6ak458kVlgzD5RHYBhyx5eO5mkeT3Fu7PgclC
         fqpmnCVeLGbEmJmiXc3lyRYp2C0vDlaIhrbvrm2sn/BKXr9ztn0TwwKxs4jQIC9lIGTu
         DoVTnNoroPfgcbpUcPVO2iqg8k6/70GQ9IfTOtqh+/NnlEn0GAu2bB+OwcrP2QJ8N65P
         E1F7iqYQHhfYFr/WQnA8VNhH77wp2l4FMa38UeEa3qMgP5Iftp1KFNQ9krYiWL54EB1c
         rr1a3zjeRc0dUCrImiuHq+VoLzdCGlEh8YKu8jCJW4gPV05EjjOQpd6UeFscoEEiXD0i
         WbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182797; x=1779787597;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWtvvC500072r0k2jG7l4UC2JDjrHFwN3Wlh3Hf5BaE=;
        b=nt9dNyFPNQGe1cAycxQN6EpzK/+BfvLdJXCGPQsg2u4CQNgJAtz0STw2xfP/CLJSe7
         5I60fWN/O8ZEBcz0wBcfBltKqP2BFZMPEf/e0tZeJEwaks0VIy8XuVXvhC8QMVLRbixX
         YbNoqP/BEqVo0kKcSp2kxsh2qcD9vFOl95QZ2mdLvy0MPr2nySnWpHMgcGxgFBqws1VZ
         BAsM1IhjF/RIDvYr2Rbd/jxb9k2Jnc147U/S5QbIl9tcJfDZLqWJ2HmPLTUkJ6nXFrkU
         yakzRlcsL/+1iYJq1YulcBW4zhl26cF/kMIAM1vCh02gau4VJ4WoCaV6aklMOOCyj6BX
         NO8A==
X-Forwarded-Encrypted: i=1; AFNElJ/hBwSGG27bRZdB/zQ0Axmp2dkXwUfKqEBc8s/o4ck8rE5VO/zOVLjyMvpWJ9RPT/8JNLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUmMl/qSrchuEjyU8zg/lxqqibzPgU/k/4sCcXHYWOKAuHwpP
	/C70/JKywY9dr6QVZrXLLcMqcbq48lFLhxz5ILm1S3BmnrpzRl89kojIe3HbRAQtcAvVMYHXgye
	vigjEtnIRk/sdjvOhlMDVYV/cUbBshsw=
X-Gm-Gg: Acq92OEOKqYzVVj6oQrNC+w2uTJy/ZjY/3EMNDakqwcLA3o7wEm0HcV/UMRT3XDr7Dl
	bkqDvlUHagJZZt6MRS5w4e6WdjrSZkriXlA2N17nSotNY47erKF+Fq3EWHY8PinlfMf+iUyePTX
	2BFNtX5cAJEm4XUqBCxIW4nSIOawkeCEekMznIJk7tq52Jxpj6IDMYH7LV0zSmNe27BSvwZgWoU
	D/Ox1NsMUgT0WPSkd12gOIthGiLPDvenxVVYpTq94DYvyJAeV7mlgUtE/SZt4r5rtlfBsnm9iug
	8GY3O8AecgZ5eR/MyWzPbOIfQL6Wy7xse8axer/yGZxJjElC5tbDHEsesZTJDlsegkZxYic/SXB
	+g7WwMq/H
X-Received: by 2002:a05:6102:956:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-63a3d94e0ebmr8444113137.12.1779182796860; Tue, 19 May 2026
 02:26:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 02:26:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 02:26:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im> <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 02:26:35 -0700
X-Gm-Features: AVHnY4JWwYVKdhwcHm1eQ18lz4fIxEWM3xmibHaJnST3eW_kMvrq9mBn9fnmcZU
Message-ID: <CAOLa=ZSxhtorR+t-4M_COxfu6HwpcB0hr43OhqcwgkU+VLX6qQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] setup: drop uses of `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Content-Type: multipart/mixed; boundary="000000000000990db40652284628"

--000000000000990db40652284628
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I've had enough of "setup.c" and its complexities, so I finally decided
> to take the bullet and start refactoring this subsystem. This here is
> the first out of the following three steps:
>
>   1. Drop all uses of `the_repository`. This doesn't yet allow us to get
>      rid of `USE_THE_REPOSITORY_VARIABLE`.
>
>   2. Convert a couple of global variables and drop
>      `is_bare_repository_cfg`, which then allows us to drop
>      `USE_THE_REPOSITORY_VARIABLE`.
>
>   3. Refactor the subsystem a bit so that we stop intermixing repository
>      discovery and repository initialization. This is my original
>      motivation as I want to get rid of `odb_prepare_alternates()`, but
>      due to the way we initialize the repository it has proven to be
>      extremely tedious.
>
> Most of the patches in this series here are rather mechanical. There's
> only a handful of patches that warrant more attention:
>
>   -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
>   -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
>   -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
>   - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`
>

I think the series looks to be in a good state, I left some small nits,
feel free to ignore.

- Karthik

--000000000000990db40652284628
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bb74c97bea967f55_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vTUxNa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODdjREFDQnhmUDA3UEVDSnhsdDN0Zjd4Z1d1alRNNQpJYWpRSHkxZ1J3
K0NnU0ZXWGllQUxJeUZMYjB5OTlVSGVYbC81cSt1ZDRMc2pPNEs2c3FOcDdnVDNTYldxRDVuCnhI
bExHT1FWMjA2K0RucVFHdE95MHprdXA1MHg2OW9oMXpMeEtyUjlxTW5pTGpZRUNFWlFlVVlmRmlG
WkZ0RlAKeDczSDN1R0ZMK2F1TUFLZnl2eVUyaGlsVGFzMmozT2xKeGpMVnBGSVBGM2p1MkF5RXhi
bDVxdFdYTnJwM2JraQo2S3NTaVJYc0hPcThPeXlnS0ZPd0pKY1NmcFFwZ20zMThCSHNpdVg0QzVB
eE00QUdQU2xoZUNHQTJUclZsVm5BCm5rbmVTWFYrQ0N6Qmg0RDA2UTF1QjZxVjQrZXY1K0xHR2xl
blpUSldNZjZ1d2s0UE54SjNkeldrTEsvVGtUT1YKOHNCem5FK0c4RW1QRW5pSzNYUXI0azFKM2wr
K2FHUzlrR0hNaXRzaXJyQWRaSllVRjFYaHlkVXNBRnQ4bGttbgo5SjBCajZid2VpLzdoR2RKZDNt
cnRMWEdaOUxxdEJPSlg5UFFSNDB1bTBtYWpvbGlFR05yb1JPSDhDaVdwWVB3ClpBRGxlRlhtYi9k
RU05MkxYMThZejBIdS9nd2c4am4xWWJ3SlpnWT0KPXFFOXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000990db40652284628--
