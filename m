Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990629;
	b=JfPYtYCe4tCGZMRQ3Hycz/6n9Lf87/nLgvKp/fTBSAphjAqCfQHKJtWq/eCJS/QsgTUy
	 8mBRd8GbPoS0+yAAxx1hmtbmw+o+4090t6N/Xn9U6WD/42ijBTWuvJ1eG1J8HEuHvm22t
	 TRydvA9M3n+XuLdaiSW1hr+5e07OGrtENh/qwLsgSg2kC9CaF2YkSEenbdwttagSoL90Z
	 FzQHnjBAb5I1XpIUDnTnBoEQUHJB7j9TaFKEoYXfIzozikPN6XhPJ1f1SmGqaY6u7tFl0
	 gA8YQTt6SBbJPjQUl9h5Id3/MGsUrwK20GMbtOhj0RQB93Hffa/mQF2Hm8CnLaP3mtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NmE0VQ+wznagLm9e5H9L0D7qy28CLOCQdbzYNhXER30=;
	b=36IDCqXg9R97ah9KvOs+CYJmLVOnO32BNnbRmE/m2rIeP7y0LtTSlKGBmpcAPZNRtirR
	 cW3++HF0m7sdsdUWya4g+qQLgIIj6d+Pg4Okp56aVoPwKB/vIR+kvU1knL9hCAM4SYSYA
	 BYEpLP9lMbY1X3ArCOPprTazwtXNOyJ6Thrb2XBp9Jdx5dTks79I9mcC0sNSmBUIVlPQa
	 mWqqLoS7efoafEkWry72hX65SlBL7vly+H0t6lAoNkeWvzmy2Cr9TI3S8d961Tr6lcbju
	 J1iq9kQDXvIEiNV9iLkjt3BjMEfUHKjeUYblYTkOCZWB/ot5tFzuBns5G6Qb6m10/mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="F5Cg/GDZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03663606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03663606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F5Cg/GDZ
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f48c750afcso1587986a34.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 21:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792990628; cv=none;
        d=google.com; s=arc-20260327;
        b=crE74Sxr418cl1bQDJFPPEp4FlxTGWrhZ1x3zNbuH4wLeyuXqC24xfOAnxpyBztIJL
         0FZPVAAoZKTax7d91lkZNGuZ18krQZsNkO+hk9Ogq4dIczS62geB4uaB1+Kitp+tF+pd
         KczT6m0xpI5PeJW7ERNTy6wepS0N3lUHrHRV4c6Ec4Wkfs4KJrUgG55qVituF6BDYdFZ
         rawovlQb+Rugc2HxKqs6xC6OEjIkqOJ9CBsGrtaLFaAYLH0Z//zJRvG+2BrSv8DXedgY
         cEsT6upaxL9Q/XB0XVH5GErUhguYvaAkF014Kls/30pKd3J/69cxWsshy3cejuVyf3FB
         43Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmE0VQ+wznagLm9e5H9L0D7qy28CLOCQdbzYNhXER30=;
        fh=Npjlb0gTp0KEiOlZaLATLTAYXAiHc6nMBHcw1scvIto=;
        b=MU4UsZijAK3ENSIsXDNl3SJt4G/M/MvMp2c2y138PCCfRuvQUeuAeQvSz/hNlobOg1
         6pfyvh/oKDJzaDpUmLHnsjD89HDJxKB4qbY/NxTDXGuc5Gg3duk7wM6Y/9t+JG09/wxL
         NS2DXt9osXxN57XvBxTj7gcCd3ErTIms7UP+SE7vc2CL9YrihW2uANtq/b3eXlTCI1/G
         6vu9XPaRTSh8nNOX+L3cQgovmKUyF1AhsLb2tgxDFBMmBf2ed1FInxCP2TW0RaftflOa
         D5Tt32s9/HEg2olEccVdcs5kp07FJaLwfy0vAY53O0Y0qlEw9vY+/QXbptCZy1tojYRa
         5zWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792990628; x=1793595428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmE0VQ+wznagLm9e5H9L0D7qy28CLOCQdbzYNhXER30=;
        b=F5Cg/GDZresv2g8u1bqIc9hVuDFvYpHI5fTWaa84fVyc95bJY/52f9vbPQd2iOSpOG
         aQ2dyfbN0BbgQeQXPQQh23eBl4vcwkNsXLJkYq95CvwCmdIaM0PpHbmYq0zEaSSAK16W
         rKMhXTHbdoNbF4ABkYa8KH1zCqj1ZWybfsXkl7vZS9Y45w34rir0gHvGK334XPuzcnyC
         TaM/Y41c2ddW6r+cAbSUxjsrk3SzzHuUnEGstst3wAKNmdcMips7XMJqHBSl2cNQfEn2
         iACjSyEBewwWGxB/u1W8XRzHSL0fMdzzRHRlATZn+07PMTrLQQ8TQDYmZgBrfoTQmw6s
         OW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990628; x=1793595428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmE0VQ+wznagLm9e5H9L0D7qy28CLOCQdbzYNhXER30=;
        b=JOdXFIHAW3BBPqGeGzv3g3upBvN8YmY9Di4X4lCkfdeMPn3QHI2nSFdp2SDyFgFMYZ
         T/X5gSJ6cgC5Kn3SrgYa6+tNY7EQYdanHjLrI4kVRASV85fsvORydXXn4BGJaDrGuLFG
         q9Qf5MvmUgfNdi4X+6tjcLm/CYLo0yA1pHeaid7VyCyZJghjQnsAuHs3YBSDszrpZRkx
         uWfTqxqMBtfiCBC6kUyek4MRDsm1KZ5/WCgZceJrh9r834ItojmDxftM+7M33vpoDQU+
         ZFS3IMyjNy+E2E2dJJqedVcHx1VXEJIzDuc441F/3X/VnNk+j9VNl0/rxj4G95/xtQ1B
         D8hg==
X-Forwarded-Encrypted: i=1; AKwUvByXz40ElquwCUaPnDWqn+EAvvUdNgLWrL815+vpuokb8nxCh21b04qMVWSHen+6BTDjQOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1DCW3NWDjbbLQmUuWdfjnFOvjW1N97F5c7bj60rtpofq5H906
	LFfCa1LyMY9VpG1u9BVBtgfFkR1gZxm0Leigongtl0YfM6TM9IReYfzsuId78ORdnx21RVhjgZX
	WLfN36gDIHZVcBM2KKaBIponxal+F2m+yHNTa
X-Gm-Gg: AYBFou0ZjCzbiWmy7T5tcByxIJXAeuN6hs4kP0bEOdolPX3sef0dSw7vAXsjIalPO/z
	CQvZcbTCNa4FSA9R2sDXeP36MnnT9YskrQpBf6TpOYutmt69zZrX6ct8MH5MCQ/jJn9Rxb0xPm+
	8NjwTs1PK/e8gEPulG74Bnzu5BydtGpyD48/NdR8nVPaqPZ7LFicz2aJlY8bFlK6+YdVVkpiFeq
	JPoOBZ8WkbuUHXHN0OQl7J8reoOtQwdCavx9EUhwt8KzSwbtkA56pnD+27FpKto3QUD/nDU1sMs
	7J3WxnQD4ncXUUNrSDXKOhy2GBoB0Wi3At7A4LVJBjx+9wu7ySKTosbvfEvQH8XdJdxSXWyRw6t
	36rImVP2KxQqhVNmyQjJNhWpHBq/uK3j1c/lRzw==
X-Received: by 2002:a05:6830:3481:b0:821:cee2:489e with SMTP id
 46e09a7af769-850fb932258mr4487547a34.2.1792990627868; Sun, 25 Oct 2026
 21:57:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGjZMyRqv5RsLF4Vo439zy4urfr+R=CTwuDzmYjiemauuZan0Q@mail.gmail.com>
 <20261026013254.GB3575069@coredump.intra.peff.net> <xmqqjyn5w2l2.fsf@gitster.g>
In-Reply-To: <xmqqjyn5w2l2.fsf@gitster.g>
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Mon, 26 Oct 2026 10:26:56 +0530
X-Gm-Features: AclHuK-9a2Ww67idADMEsuVf87KXNuegvmMGlwf46ARQLlvQHGsFavKU6HnLh70
Message-ID: <CAGjZMyRF-hV8PMK2VBJT-9kzvgtQYP2EfYSMPjxSKmc2ZgscDw@mail.gmail.com>
Subject: Re: [Discussion] t1006: testing %(rest) with object names containing whitespace
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff and Junio,

Thanks for the clarification. I understand that the limitation is
intentional and that using the resolved object ID would not test how
%(rest) behaves with the original object name.

I'd be happy to volunteer to clean up the test in t/t1006-cat-file.sh,
so that it handles this known limitation appropriately and removes the
obsolete FIXME.

I'll work on the test change and send a patch for review.

Thanks,
Jyotish

On Mon, Oct 26, 2026 at 9:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > So IMHO everything is working as designed, and there is nothing to fix
> > in the code. But using test_expect_failure seems weird to me. It avoids
> > the test suite announcing a failure, but it is not really a breakage to
> > be fixed. A test with %(rest) and an object name with space should
> > probably just be skipped. We _could_ run just those cases with the
> > resolved id, but the point of that test is checking how %(rest) works
> > with the name, so I don't know that it would be testing anything useful=
.
>
> Yup, thanks for finding old (but not so old) discussion.  We really
> should have fixed the test including the fixme comment as we knew
> already back then that there was nothing to fix.
>
> Perhaps somebody involved in this discussion thread can volunteer to
> do so this time?
