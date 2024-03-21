Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8D7E9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979901; cv=none; b=Z5IY2pz4q+VkYfob9pG0F7L+da4ZRz6ZpkEtx99PpFiFCEceTKEqlWdJmlb9RY9Vv/rNYesr93x1zM7TPSGo7vK5z0+6UssL53QScn8/SdOOLQ3J55SQO8dxCPmsHjL1Q5m9xeWgaMw9ecRcPBcEGym8w5MrfK3rgjhLAjtT5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979901; c=relaxed/simple;
	bh=2ZAV575Z4lgVL2As4QANFuz2Kba3L6H/juFZYGBAXFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCWEEOc/6E2mxL+JOXBv4Gi0unJ8vKkS23TIvwfcJRf1OQS/JzIIIHUKuS57e/z8oSD96PaNz/tOIe+8CvzFjZppBu9V7zdvaaK3NR+zEzLywSzmwocQzVjLdZGI0JAGgLDIR40FcuCziJw4KVQl+GtAcF/7iDGVEPPY9sBle8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZVretph; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZVretph"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso408601a12.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710979898; x=1711584698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iB09WnzZyrkkVkMxFuUImGkoilUP/7oxQgWPP8jpLk=;
        b=WZVretphaDk61hUr3Z5jFKXvq/6MWrV971PhH8nSwOLvgDwgCJge/iVS9l6KqvHEik
         3AxK5DYVD2qTrsB+iei5h9uKiuCcaEN4jFOw/AKr3oBhe+S2FNLtZ10vX/4s4sc0szVQ
         iZNCMGSBDUvyMMk43dz7w6VxQuLAhoTGX+h0fm9IHgQPGnXimhWOkUZMLBsZqN67IEHO
         w/4K1g7U8GHJ4kHvU7iuWj85ZE1A16Y2aqMvWBcibwiAfUd4QKRZECs9lEFYnVY2VHAK
         DmYiW70Ku+P9Uonzftkgagpl1HIgHFrBQj9kYy0hQX938gSoC/mtD9PFhGTFNj+kFDvT
         Awrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979898; x=1711584698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iB09WnzZyrkkVkMxFuUImGkoilUP/7oxQgWPP8jpLk=;
        b=VBjWu2EzpPmsVatWJuj5EZkcz8NeKn6Wt+4qOEpRUJi4SKpGMK8JDPpYp52JJXGstc
         rn262iUK3h/wuQDtK5QQtmDGPy1Rn/8lmjK1GUWZXqW8AYqFaL8CCb8kuPPG603LaeCi
         YyQKlcRNWratDSqkUjeYfYCEvFJrh7DV95NGriTdGqYgClao0Sa6D2BaE8W8gwX7X6zR
         w69g8F45mICJ6QPkyAVaS0r9ImYrfJbhAsm7NX5YctsFLV0fAR59bulvDFOuKh37UC2T
         tYagy21Uk+k6ZlkIY+9fRYJ8PvUgOXHaGm6hFovFCeIs7W/hq4DQGRRJVq9lglh3ad7k
         xEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEyeOTSTQYF563Q0qwKOa2ci8rSKaVam8T/kGdsof24YeLSUF1D3dNYUWVjg8rzmi5pvaYFEsOJUHG4RCD+Bbd7fpE
X-Gm-Message-State: AOJu0YwtC/23WIW+QbxhVI3EGoNbu3GcJRHNJ5ruSXiAUk7ftr4zMrD2
	cOQ63R2076+Wz3lN7ra2rocgsRdCm+w0f2fAJIfx7XnnXR58cHOfqmrFILKFl95OXxhEpTwns/a
	oEWyq3FlgOBQEkbe/cUK9RebkuwS2RCREqLk=
X-Google-Smtp-Source: AGHT+IHduxGgz210sMtvL6Nx4Kgwut25ZH1mKZE5y9MYGcwUQciWXJD9NO6JQlzH5cGNWXIKAjemULt5Vek7wjxKUGE=
X-Received: by 2002:a05:6402:1f4b:b0:567:3c07:8bbc with SMTP id
 11-20020a0564021f4b00b005673c078bbcmr2787338edz.21.1710979897800; Wed, 20 Mar
 2024 17:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-2-ignacio@iencinas.com> <xmqq8r2eneut.fsf@gitster.g>
 <20240319205753.GB1159535@coredump.intra.peff.net> <xmqqo7balyx9.fsf@gitster.g>
 <20240319211112.GD1159535@coredump.intra.peff.net> <xmqq5xxhnbgg.fsf@gitster.g>
In-Reply-To: <xmqq5xxhnbgg.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 20 Mar 2024 17:11:26 -0700
Message-ID: <CAPx1GvfZJpM6T_sbvFvNhg787o20QxHqVAhTXO0a+UEX7Gu9=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Jeff King <peff@peff.net> writes:
>
> > But we are not testing "includeIf" in this patch; we are testing git-gc=
,
> > which falls back to the string "unknown".
>
> Ah, I wasn't aware of such a hardcoded default.  Then replacing the
> existing "hostname" with "test-tool xgethostname" and doing nothing
> else is of course the right thing to do here.

Note that if we choose to use $GIT_HOSTNAME (auto-set-if-unset),
we can change the test to simply force $GIT_HOSTNAME to something
known to the test script.

(That seems orthogonal to this change, but I thought I would mention it.)

Chris
