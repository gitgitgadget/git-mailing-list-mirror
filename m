Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793217647;
	b=k0Rll06iGiDPWbbxRc7eNgC509uPSm251yQTMaUwB8msZinLveM/A9FsPPLIrGXYuM3G
	 55fCL1OK4ffThpJ1T+crBga1WCp8OGuxTYERxoX90g2AnMwyk5VRCB0TjbjinF7vvlJy2
	 QE4Gzo+xjH11J+jDkDw3Tk2rrg13r1hCRH/jLqhZyQCz7pcUnJ3PdFGavWZPjRkuvjCBA
	 Ckmvjkxrcs3LaLfwjZk3xDaq/G3cJNQCOvK70Evnz8wNUJbpV2CEHuVJAyebpR5RqKuY2
	 Y2sqkhI2F3ubv6UmupJiuka28fBZVdxXUWdAmXoA3yFr/oQ7J32Is/BR2TZHguNsg7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Xe09ZpwCMYkBcUTwoqW3AZu9cglCI62NUy3RfxID1d8=;
	b=WzmdgluFCYc4upEarWHPx/sAolKAO1Ie1m0+6y0AbtcMkQone55C1YZSdUubCcuVLuz/
	 SC2cFoSwj6JRp3JNPEF+xkyfDGaWvDh3+OAzZ/WO0H1Bt/wp8zJAInWDSX4JS2exx8t2x
	 nC9s7Kv+1oUcH91srQCPll7+P97ynylr6C74PYekj4d5Oetho3juxWe0iHCmfldQOSU6B
	 DdcMMDKYEEjT0jIhmcY22GjIVeWfRKXSjEk3gn/cXysk7N/Tu2yCWYMKkF878Gdy+AFsu
	 dev5LmE577BXxqUzlCcpwbFlirhacnNd47pqSNTrqpH4BjpRDoAPOc8EheEzB5ymq6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSWjM93R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810B606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A810B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSWjM93R
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679965fb848so1572109d50.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217646; cv=none;
        d=google.com; s=arc-20260327;
        b=LHlOwX3Evi5rpi3pjS5j/2Y+llVysfCIqrb8467RiH2ZSeG8++wSyLaK8FWiWZJfKY
         t3KLDw2sVE9R0PQTw+PJ1HW/iNt9mjCN70FQnzfawklqC4yiWVlW4nJILXrHJoJcGPGy
         B6B5xYiq6W8Sv9YdglOAtEuZ66xotVVHg2QLsZqUn1fWU5CwSZvp0Psk9iIBmlMYUcEv
         0G1xS6KBYbcHMXFWrLz34JschBmC1faPJveFxw65jDI/J1la6m/sPHRcWXu2xIgTsPqV
         xBi/fNniUm/8YhEyf3/kLVdmojgaUk35Z9/3KV2AARZrEIDQ3RhBfEd/sf1wqactXxQl
         LGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xe09ZpwCMYkBcUTwoqW3AZu9cglCI62NUy3RfxID1d8=;
        fh=yh48E+bIdIF5bkOxOqeqFS6MqWS5L1IGeGCToXGaOZs=;
        b=s3V+YyYlU9Gdk6+65riF4PqYAnsmQx51LLuJ5+XE8iR9Hb0uYa//je7DkgyyJkm9Yn
         5TCXnPhGpcZkOWHBgiEfyVzIzw9pq0emc7E79I2DxHku2bFOYIvVa+dcSCvWxfULVbN4
         PmYiFGTe7az6REX/leeJk8nEI4c788mgcVFdrraF6ZzowVR9WUxBkHQ2QgT4GZ4GHkuT
         SIduR9hDqhgDomLI8aVD0S8bS2iZKkOWFPvvCHHAewmpYHjivOLoHmgIWWnvzVxKfuf9
         p+AEWpIgfv6C8B91tWGSCdVdOyWKPm0dDUbusw1maK/31iFMwUaG4BjbUKhnfeu7zslV
         MVbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217646; x=1793822446; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xe09ZpwCMYkBcUTwoqW3AZu9cglCI62NUy3RfxID1d8=;
        b=oSWjM93RsN1/9WvJLXjneawUFRw8JlUN6dCWAEX2EzGkrwcsGcGg3V7lQf3Fgn9ulR
         iU3CRgT/46AyEwv4AqYKmd2JmnGcX+ghcoCTEtNvjSUSqcKDqyTILn2keYsuqU7F02gB
         t9Bi7sxpH5I/r3Mq3/aUXttmtdsPAHzpPkq2ayZJk+hdZw3lSINpkupTFJ15HLQVlnTr
         qLGbFaOzma8TPICG/Hrqkfaw2tDPShllZ5LvWf6TOQCHW/Rk5ZxfHCgYun11UC3+vtsi
         YhKzbZPLvS+PxZC3pjtNstWILEgyBirQj9vLH989vfoXPINwVupMl0QG+OfA2Lk9K5cl
         STBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217646; x=1793822446;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xe09ZpwCMYkBcUTwoqW3AZu9cglCI62NUy3RfxID1d8=;
        b=0/+M/7UyesWoOhCtCeWQSqs8gbWktWrHVberwBEKWIqvH6fauvoK9v4rkTZJ25ZgJJ
         T+8PlFdbM6ze/XFBmZteidXAlC8dEFi4JNgfODIvec46NfYZ43wpRrRHzsAERsWgcotN
         1evXFHqiEyBpPYaqElZacwgYjN7vGjbjxwRd45/x7S9XKG072JjigaQf1XJyzgt6bLVu
         3uVWy8LFzdXvTtBqxlQy3uWmxKk5DP0l5F+XYaQsPC8NBDjZexRVCUjn5ox5oGV9MyiK
         TuYbHBSP0gRdtCd8rdJoWEQ1ac/4KHNN9fyXY5hmMoj7HqqGogxYlHECIVm54zvTt5wt
         mf/Q==
X-Gm-Message-State: AFq9FYKmUf+09fMj2d4SxNy4UNFuFI+vFgnx7RtJUIVbOioklIdZ8YFA
	HH7fySVt86dxOfdsO0zhIGGrtI2v8pQSmyp1jKQBbPcOn8mTAYhB/lHvpLy0fBlM8RgYSP0QFHL
	olhWWoAxBMcl7ahdUX6OC4+tHua4gZw==
X-Gm-Gg: AYBFou1GyRCIObQaX8P4KbCC4mK254LQq234fb9EsUBjFbJuDSFe5kLYsOqA6RQMtvy
	EvgEY+u93KH9dqrerW9h50naF+OOuLSg1/l/pXlLrHJ/v6BZ+LxE/2VtvE6Y1jc+NmggW9THJr2
	HXDVoFJgHpZa0dB6ZoC10Af8RovAM9RqlHCFDeGWNhft77ZjomkOVuCfkpSco3DR/SnHElPlCMh
	ytxJxLrFpqStCjqSNHyh2ksM/EDufFhxEN9EE2LhaSTucL+SB0tE07qW03tzzsoFKG5LC73XtTQ
	3rXoRYs1K+Q29T/T6faiVEkpqD44vViZvKOq/fIEDoTRdC3mty1QBWclGe8fWTVZxuY1gBShYot
	BG/9cL8UI1cowuE5iJPUtlCGddTU6xptq2Q==
X-Received: by 2002:a05:690e:1697:b0:67a:2ca2:8a39 with SMTP id
 956f58d0204a3-67a7b992bd8mr2397466d50.3.1793217645553; Wed, 28 Oct 2026
 13:00:45 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026132525.45414-1-fiendora5@gmail.com> <xmqqfqxsp3xb.fsf@gitster.g>
 <CACWAS-U2-riX0ajiaE4VgiQWxmoWcL-d9-arrSASa+dnVxoyEA@mail.gmail.com> <xmqqpkwvm7j8.fsf@gitster.g>
In-Reply-To: <xmqqpkwvm7j8.fsf@gitster.g>
From: Fien Dora <fiendora5@gmail.com>
Date: Wed, 28 Oct 2026 21:00:34 +0100
X-Gm-Features: AclHuK829rcFRQKh9F_ZTTOQjU0MwxxDuIJjJU7zU6fY81gijlOWgU_rw2M-wWM
Message-ID: <CACWAS-WBYxD8FhMRRyyeEjsek=0Oitd83PUBxqMWEX8uZk8CGg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] t1402: test --no-allow-onelevel option precedence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Fien Dora <fiendora5@gmail.com> writes:

> Please do not top-post.  Your response will come _after_ the lines you
> quote from the message you are responding to.
>
> And trim your quote to the parts necessary for bystanders to understand
> what is being discussed.  Do not quote the entire message.

Thank you very much, Junio, for your guidance.

I now understand the convention, I will apply them in my future replies

Thank you
