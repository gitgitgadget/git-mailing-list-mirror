Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8853161BE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252827; cv=pass; b=hvjC246bMaUIcciyugKHKlnj0DEbL5j2dFjfXF/iem5qhSt1tUVOcYVO95560J3DkMvUQq54o92s6kw2kvS4WQCQ7T+ttWuhewL4OO5/D5rySsYin7xSCOCQTEjjdB2/k61EWcvkX+LL/WdKCPiXcjPrvvsu7inISF0/KbsDXwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252827; c=relaxed/simple;
	bh=qkfyB/gFmMq5HbTqrDIOR0+5L5Q4luoVyf4f5FIC/nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hds2JKSEkksstPZd0LUvlitoiP+T37CK5TehAekBCcP8ScZlDulnlJF9F97jR4CiC82UODM6SW8oMr/qmFMwONfXsjjkIJiYKCMD6CxlAdrlMCRFwtm7P3RGIThIYe7xANhcnV9b6sCUplEzb40P83xTO48CoXQ0OWhC1nwVU9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaFG9wrs; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaFG9wrs"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8299c75f730so137977b3a.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252825; cv=none;
        d=google.com; s=arc-20240605;
        b=DmPDR2HNcwd/vZllGhkMuAT8pMi5SRt+/BmpyEVdLHG6C8Jgfz+zqb39QIuB9XsdWJ
         hMpY7lUuAMTcoTeISuftkd6t6HqAfEIedTPF3FWZQIyT2A4pO8KBbCvswtbHaIazNNlA
         +nFCvSrXvG98v2uEzSlmFx73JSPtEPOSCpuboWkmvwe3PAviETDKAZ9l/eSjRcLmy7SG
         E7VCtcUAPDmfJpv5dYE4c6H5/0PbIcTtf0Z0p4s5PEuooWtEubW251hBO5uoZkYKl/8U
         fw4jhpD872r2LiFH8ztGML2TD/At303dtHxBWRRdiJX2i6sHVr0vA+y6ty9FUw+vatJh
         E1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qkfyB/gFmMq5HbTqrDIOR0+5L5Q4luoVyf4f5FIC/nc=;
        fh=KaLnBZp1yZPmY7BL58epWeAfL0HmH3SPUatxE6goP+o=;
        b=ebg61bQQ6536b0s1TcD/oV6feKpVwkrWNzxHTHFTaC4z/aRQEGHrJ6nQoGMvh693ck
         fqeONXYO2sO/ElMQXXhCIWF++NFHDT/yF4OKzjhP9QZEt8xymRVxALyjutky3AnJ3gcg
         owe0Vv+zB+MoHRZo0ccfK4FJizrzHrQicRsZK4WGepMqFaKN6uKxiz4o3YPbGSWmH+Ap
         EZxatfmPGetk8gkQRajs18UXajZYE2cFqAlLZPwXVKIbP09DeAfpQlDZiTZ2Tj3cMPCx
         YkSuW7UrkYfvfKeG470I0nOdEr7acpNiH9+QNFtKcrdu5gl+Dzj/mKBKvd5F1bBbsWtX
         NsOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773252825; x=1773857625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkfyB/gFmMq5HbTqrDIOR0+5L5Q4luoVyf4f5FIC/nc=;
        b=AaFG9wrsj98pouPpbFBKY3QH52VXTJHPWyvjvJWDPcdyaFxg286Ak1iVoVsCGmrcI+
         +jl0TSvSlSkuYvMQuCs36d1FOwV0u7N+4RnW47Qxi/zBAu1MsQnrIDOjL4UzZ524Nm9J
         GyEqJi/zFtWSdmTDAYfSrJbZpJev67rV+LxcAFF1I1AlrK12h6BJzO5u5o19OJ2WORfW
         9Tzehn1C0JurCXseB8LjMC9xxAh3onPnL2MvzM7Xp/7RgrWazLv7V8ceeT7IJDrv/GTW
         P8XdxXs9CUNhqACPws6UL9l9Br5nZHIZ4+XaQIwFbmvKzNPGTI0hNE91LUS0MUpU3ZhY
         5uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252825; x=1773857625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkfyB/gFmMq5HbTqrDIOR0+5L5Q4luoVyf4f5FIC/nc=;
        b=E0yy8CtZv2c0BD8QD40y9nbjke+bpBHnvevFujM2gj0Hg6fYEH7OEleMTElVHP5uPs
         2qHEZMJBOcMfeqPxnvIS4ojgCRb/lMAKjNmgdSE2PbtafNdUxzj2QUo0dqYNx9fH9Npt
         nwzejnSAvuQlul71f5ecbm5On1p6gbfNxeJeyPov6TWOHdP5Xv7nhJQUfRpOB5M/h0x5
         ynKvOtkx9z895kbYogacmnDCq90Hv30jEIM3W1fLsuktJ8HcG1eCL1AVPvBpFt6cr3C9
         28iyAyoqs/Anyp1cUUBsULpWPAlYh9xUuFjfjj+nmpKTdqmq9rZZga2GAjpXi9B/PXP8
         YoZg==
X-Gm-Message-State: AOJu0YwqMYRrwwPj/lUA0GPrJWGyZBV6tYq2d+3Q0ojazwqaXiuTPL4u
	QhxA6qPyr5MHgyE1M+pNk9bP4jI0lKBmkp9PAYRCJS5kA0kFVbU+sZ6Y7LlnYXL/wbDQK1DH42F
	QGzAFpuA7WksajktAOrYaT+LKtwpZoHI=
X-Gm-Gg: ATEYQzz6VKaUSFVZFbewGB2TAQeg4DCEIdUmH0Ru9JLtjKGdEBl+A7elZWBn5fwzqxi
	YyiQrXX1whQGQ6KJEr4yXppPZNe5XRZ+ZgMCUp98QOMz6KXZIw7gio1HHsbS47s1f3DTp/n3tSr
	XOiNbwK6jIekTWMiQM7aQXt25OC4dQ64m83ZyozkUO3PjvsIcJCgvorbjt67xt6XsnPFYnTnekh
	eetCh2e9EmWrUmK9ZiZMghYqrgVA4kcUQmB/SWhVswrveyN6ms+5Ha6VkmK3WKmyE2pC3dXG4xi
	55RT+BHlKz+nRQon51H8xsHQ6bd6IztXZ52/oyM=
X-Received: by 2002:a05:6a00:13a9:b0:823:1bc7:ffd8 with SMTP id
 d2e1a72fcca58-82a071aeb8amr454380b3a.9.1773252825014; Wed, 11 Mar 2026
 11:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abARj_VI9n2nB_xT@pks.im> <20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
 <xmqq1phrtoen.fsf@gitster.g>
In-Reply-To: <xmqq1phrtoen.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 11 Mar 2026 23:43:07 +0530
X-Gm-Features: AaiRm51Qnm6KzdJmmMfJcx420LtYfPwxJiQhKF8uF6NeiHs5aMKaXUV6d0ODbKg
Message-ID: <CAGWgyh_dJX7TteKjwVXUwnmUL5kmZifpA0a4n1RiwRvCBEY5gw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/help.c: move strbuf out of help loops
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jonatan@jontes.page, 
	Amisha Chhajed <amishhhaaaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 02:03, Junio C Hamano <gitster@pobox.com> wrote:
> Having looked at this patch, I recall somebody else is revamping
> this function already, so this patch would step on their toes.
> Please pay attention to what is going on in the project around the
> code you are touching, and coordinate with others who are working on
> the same code if necessary.
>
> https://lore.kernel.org/git/20260228104654.80831-2-amishhhaaaa@gmail.com/
>
> Thanks.

Hi Junio (CC'ing Amisha),

After looking at the refactor of list_config_help() in the
other active thread, I agree that my optimization is no longer
necessary.

Amisha's new structure with set_config_vars() and set_config_sections()
is much cleaner. Since the logic is now encapsulated in these helpers,
my proposed changes would not be applicable.

I'll drop this patch and focus on my other contributions.
Thanks for the guidance!

Regards,
Siddharth
