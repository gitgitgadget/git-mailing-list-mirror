Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795330173;
	b=fXkPsjmd9487A/ZvX7eEIxCrFHSyIp9ILMHrR84UN2kBgdwhNH9ln9rLkZkNDVf+yXMt
	 Vo7/nTonwmjqeqLexZPIDSje/3eyYnQT6KBRzVrP25v6PMoDR6VDZt9QMRg3PoMfYNifj
	 jFpl3/jO7Si1LG5ZWvzSsvyl2f8n+k+6vRr8kcJTiIx8QBDqmFrkuX5MKDV+B/aIJkhPy
	 j4vgW63xtPpGIka0Emc2c5zvvTRGwrSGlOaCsbc1xEO05WI6wv+JjaZbu75o6QA63cywg
	 aCkDOw+0UDYO446V+wheIXMJ8z1/2GrlrNzfuleYez2mgTf9vNHWX1lMVWsLgzhsPkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=OFBBYaEHOB+g9slngUeuuVMVw5SA1X0GRPwjPclwi0o=;
	b=Q1B/72kVWvtYdF3kGPF0yL8Bn5N2yJHqzaX7Ryjre1wGmgK3881FNtQTIGomkuuagLZb
	 alhZr3sfCIfmPE96QZdnU/hvJSKslxGdhQReInarK02IscTnBHy7E1dyWWYL/CVzpnGb2
	 MKayoBWpcZVBd+Ep5FLhTQwR1d2RIeKy2jgwqibN3RUi+QnLQYOBiAaHM6Mw1q+wGTfyJ
	 UOo3hH6nQ0Bo5WhcW4CnSDedpfxFCP5rL/Fg4+OZ2qDNc7H9GSwedQCsZ5x4MLFYpditD
	 PB8020PSqivaOxxm1J7ze6+m8aO2oOvFGA6+geV+031ZEg1CPaRzpj8f6xrxGemZ/VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNe3Etll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE94606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 06:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNe3Etll
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-843cf077f10so3269950a34.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 22:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795330171; cv=none;
        d=google.com; s=arc-20260327;
        b=Iqb3hQooTxws8YmQrwtNPAGjTex+G30Wi7hOqecf8Wov41kmOdmVpyFNNYW3QjzVeV
         Im+21GiqCF0kU0yflEX5m7M7WIRW0DiyGNTZEdlJNZvocF4E8eOnXEzB6yUK4z8ulhgE
         qWrOMHIJE0jEF1KWhSg+bkKl5Q21SXyKIVCeQ7PoxelER6z+8A9nbkhBWCuGVBGvU3+L
         NuyBvKoWbESA8t7ufvK1iHI1CB6K3ugQAQG4ubvcV9KQQCCCpjgcqLLuHC69LkdbY1Rd
         Wb9M6JADYrH7jD8uqxKqFvPZRbUJxc6Ecy9XcnKHoPW+g6elBXXU+7N6etgc/G8niK3C
         FLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OFBBYaEHOB+g9slngUeuuVMVw5SA1X0GRPwjPclwi0o=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=mHX1+n1p+xhdLW9uS4YF0GHVJjWwMQ7AvLLk9qxpoRPKtmjagBfnzZe7mNAqNmJwCA
         OjuDu00I7gc/qWYB/ZK+hm68el5LnZcrxLY4TJNKxgaX8L38abDouPDV1YyY+HVRzrgw
         ee0KwZ+Ljp1m3uFsqJHguL04fLQq90aMnWhcOp5Q4gTqm0ZztOaaIuNyZlBI5e9oAfMc
         e4q6pk3MRBpqQDeJiJ8PMOxYIFTwJOwlM05Qm3Db1095OEqFOUZ7GV8FzCHOB6e3j7Rm
         AvVcDzpvqcjOWzOUzXKLQATfJIWVcC1ce8FCod7ugdn/f6xcbrlXew8f56XQRDBQO/OG
         /WmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795330171; x=1795934971; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFBBYaEHOB+g9slngUeuuVMVw5SA1X0GRPwjPclwi0o=;
        b=PNe3Etll9EX0BLu5zupV4m/1y/iOi7G0O0GJvFbGI5ArObJz/owtjNhF26rpLMdidD
         We08XVy422SvBqzQFX4bM1+Iipg7bwKy63EU7FOQZInAwLeW0DRRfKyDy0fYgtBbMaeL
         pa1j+fPFYIQ1rcaCXjtj2OQRAMG8lDRhFK8co4firVZeZnffj7BsqKQNfNrJMzEf+XPq
         neD79QZbyVOvFA/hNHfdFUT585IYeJ93zhz3lbPYLkl2C6dzcIicMn21bJybpB8O1y0A
         mkaIaea/5YU/+Fl1WzzWLpffPwAJaQ+6FmoLJBMpKMTAoq7vrDIUBxk0PUx/YP7xxMGW
         I0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795330171; x=1795934971;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OFBBYaEHOB+g9slngUeuuVMVw5SA1X0GRPwjPclwi0o=;
        b=Suz+IhFvo/yzUmSsDsN7/ililak7FRh/0P/L45fReBlVtSHGmq9Kc+RmCyqgSvmT67
         QZ36fElfiOJP/huRsZXdiyAsnvWAKQOuydbdpdf+TbDUgFG5AjnbdvAu8oRmaZXd7Pru
         BNQBwO78W8LRY5tng7sxWETm0CdPQKxPa0Jvawr+n8LulIojzAeFc0hTowao1cDE3IeH
         CL0rS6os2BvnfKB4ZKOmX1qTm2epk2viZYvbhIoeEW3O4wQSssa5yHcMf7d37BBOUqXh
         JgU57sORNPsNA2J0YLKznkNFIh+UsH8BiS+c6ZYsmeFdlbrjReghqigPJk+SQD9xuQKP
         M4Rw==
X-Gm-Message-State: APuU4Z+gCU6jKyfMQ3gTPp6SlkNfbshG2txDJT2MRRYiK+lndXgzq/dK
	7k8bbS6t91DzbYRjUvOiysmKMB81bVZ50VQJLuuUar+y4SwxH69A3kDDYixwwiffTmGaxKuXOF/
	qrxyVl6XzP7KPkyPQQDdq8eBmOeaef5c=
X-Gm-Gg: AZFdTZe1CPgkTIRGMEeDbkVdx4eKZq0l2slZtcAcMdROjeg/LWulVsJJQRrFBQX/L2L
	HRhkFomv54RJfDaQr9NLvyyolXkYmGVKdP0AG1gAaNiHALu5BBWqImLQigoiyJdRM/9XVWSA711
	KXX9coyFZ4/U9m0Ul5etISL8X8l5I0aMrX2dF6/00tY+mCHj6w0aWFpno23RF9jGxT/4edQGo7P
	bw85Cz0VnZhpXcQwGD6qyPvcqKwcODX1uePj6Hk4siWi4ufPeCuqPxjk4z2/irJNw1NBuy0nsZB
	eWysUEBxVnkYLu0hUKXrI+zg67H/H0jVmQpSs+IC3s+NEuJb9NsFlXBe6nFIr5cbdwlzJQI9WbY
	thegNxX7cOGKkw82ZcQzZOwIfWyqFb6Itslg=
X-Received: by 2002:a05:6820:1344:b0:71a:d99b:e879 with SMTP id
 006d021491bc7-71b39405588mr6446835eaf.29.1795330171443; Sat, 21 Nov 2026
 22:49:31 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net> <20261120-master-v4-0-5ff523db7285@gouders.net>
In-Reply-To: <20261120-master-v4-0-5ff523db7285@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 22 Nov 2026 06:49:20 +0000
X-Gm-Features: Aa3M54pyxT3I_NiFbrJN04WKjAVdOe3bApL6u_7ofhzypDimq251onHiqYL3g28
Message-ID: <CAHWeT-YEEXzx2Asczmd9tPY6gGO2FbY9KBpnGH1kJe2BgwxKBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] utf8: bounds-related fixes and a doc fix
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders wrote:
>
> A patch here on the list made me look at
> display_mode_esc_sequence_len() in utf8.c and I found two details in
> the file that are perhaps worth a fix:
>
> 1) utf8_strnwidth() disregards the given len argument when fed
>    with proper string and len.
>
> 2) The comment for utf8_strnwidth() is incorrect: it states the
>    function returns strlen() for cases when it actually returns its
>    len argument.

This no longer describes the series, which I think has become a bit
unfocused. I'd concentrate on these:

- The comment fix.
- The optional end pointer for display_mode_esc_sequence_len(), and
  changing the callers accordingly.
- The end guard after the display_mode_esc_sequence_len() call and the
  bounded utf8_width() call in utf8_strnwidth().

display_mode_esc_sequence_len_all() isn't needed for the fixes, and
I'm not sure it's worth adding.

As the series stands, patch 4/5 doesn't build, because `skip` is
undeclared.

Regards,
Andy
