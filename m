Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C132BE02C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972566; cv=pass; b=szJ5n607V7TDYpRTeYSl+AAkieY4TxwRCQj/RagYRTQy5GVj9oZBR9lXXkV4zjBQyl2wgUYfiUUr2ZTE1ETo2f7zsg7tyc3hMNLH4EA2CL2e/y/HR/GhiHeK9JZcrI1DrY9/tNX3WVykEsaNzK8m4b4t5GPNKhGv6AH84dtPHRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972566; c=relaxed/simple;
	bh=myG1iGXaaA+DP0KN3WIEusaUGmPRo2FclDpJNr4bdjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilzY6Hmnv14qd9JCiFUk6gN1+96IrUzGojbZ+gvclmZ4Ph65b9IYAPM2L53k07qd4O8p0Ko0uL1oHHPMDkmYj1mUqYhWBYzQiF4y/wUwn+/jp4hRFD5LU78KmcOSIkn4lvD1VRulw4JsOgF2u8ZrR7bz+7N46Cw17NAPUcoNIlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=aEvdGFGs; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="aEvdGFGs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664c6304683so311328d50.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 12:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783972563; cv=none;
        d=google.com; s=arc-20260327;
        b=i7QENibnicL+ljpkUqOwT0dD1O6VHAOtkmYiOMLpTUfxRQlAChOTj93rkTmUrjl8iN
         wpPdWM5C5PuDVeICyayoycjHZd/t8tfGtDS+xKTUNMellXSOvuQeW8SOhwZU9vvfEMJB
         oA7Q04mLkse7rkv9E6e64kusHJFjXSvsNxnOK+oLHIjE0mvmngbaND9Ly89ZevT85Rw8
         QhbgeNry3f1ex/M+wBL/mD1IiCrN2xIG3wAdo38pd2tQi6E4Y0p1FxTEi0yNA36KZxWF
         vljT1x8MBZQGXoUkG/+C4yF4Rk00Ey3fJFQwQQhqLBTPHRJgPANuKCN5okCWcPO/5uUU
         7QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=myG1iGXaaA+DP0KN3WIEusaUGmPRo2FclDpJNr4bdjY=;
        fh=2+zP8Sg2S3a27iGrGt+L4vKH9EbONM5yuwFkz08mzQI=;
        b=i1jeEJPZL9BKisGBSLeBCdM5RyTrbYRA2JKjjk+xbtplpfeubr/gGZcPVUzZ6fekEF
         zW0SpdUURh0/Z8T7rqWFpq6na9SvVlIr/KjH88LZzzhOrIFA6N+Ji6yOcFQ5VXd/xuQa
         2CIYqez3nEl9UY6jgX+lEmuFfTTrI4RKynTZ321hS+kK9Pd0pO5cXnzd4jpsnr/AEhAR
         ZPjZeqd3cBlhASK0v8S/PlgApXm6qujpNEC1cZddn99FQ93kQlVdjlRl5fP5Y9Pg3xZl
         PQjluteI2qdPnsbkt9R692+OSSw2XMzoGgOeUZ/rnC3+TKPbItNli8cn+8id3/yWkKRl
         7rKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783972563; x=1784577363; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myG1iGXaaA+DP0KN3WIEusaUGmPRo2FclDpJNr4bdjY=;
        b=aEvdGFGsMaRqFhrC5mB9gxGPNiW5/ONMHWawuwJQgG+hRtVNYh2dLr1hkbzfG4r3Jv
         W9JcZsUUg/lkVvWZjKimVmdY1GU8YfC+hWk3tbuxUJyQhLrkNTswAbeO4mtgQVotcplo
         SlXXrSEgX7qRrGajlVpNUFkLoeDKAfKcT2kzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783972563; x=1784577363;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=myG1iGXaaA+DP0KN3WIEusaUGmPRo2FclDpJNr4bdjY=;
        b=o+v6CMJd02natvf/7dP2HRUu2Osu5TzfFZVU7g68KUeK05tcnWud0qOJHNvV7/SzOm
         tAEbDbtXSjo6UuYch2lngIjgRAOvUgE8I3C9NiWuJNSQMYeAMiQH/bir/f9Iq7oRdU/y
         C/8xZAf6TySgaac42/HdYmoNS3+DCt0YrgM6cwqVOrXQQaJsZNoQVsKS7Suezh+BjtrA
         Snl0XRztGJw+zP6oicWlSvH6DtpuB6D/lLUqZoMf8gMxc0RtHIMKzG+ci84iWJugquHD
         piDZ1SzR2RwHEBTCjYsvVXPZkerL/h8P3W3eRootOlGtHSapdhAwy+ZjPC9UKlKljKFW
         9naQ==
X-Forwarded-Encrypted: i=1; AHgh+Rop+n/iUZAU2f8SAaGeEziaucstbw1Sn+sx0bsPsWZFtB3ZtnYJgL1Dxe9oZboMAEoI2Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcShZZ3XsG2qQCyNyA02Ej2ZYAUQ02Oa/3L2zuTjiNAyY69v+
	MP6In+PLT9rK5yowj9pATvd1cevJ5KyniUEh8cdNI0m+5RVvgQ6OoH6Ksj6JmrC3+6dQWNasy15
	xsBAnE2V1PKjanuc/QdJsvSa9UM1Ka2cApjvZTtyjUw==
X-Gm-Gg: AfdE7ckajFrpklSBZkrny2iF7M+YQ7WfvQQuZHNav/ph3A3ua0bxdgKzzcPCYyDgjBn
	og1RUUqocq/IkTy5gMU0R8HG6v8xm3rSzyuGnt74nJ1igYWdqEMJtqyArJrgHdPeVnzS4v0WaM8
	n0OG/fJwhobqdkEjW0AoqfsbnHdoxMBziZdyVmy1vEJyg0R24u+KvOduE5CsVz0tHBIjaubdsub
	KycOILXHYY32rHPRqzYaiIiJRdM5tGOQ/wJY5T65bhGTqjk7BjGyk+h+qV/AFVRPeaLFraSzQ==
X-Received: by 2002:a05:690e:1504:b0:667:b996:3e6c with SMTP id
 956f58d0204a3-667d7f1028dmr5933238d50.81.1783972563553; Mon, 13 Jul 2026
 12:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <ak0DUx5Y/5y1OINz@nand.local> <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
 <alFthqGQjsowvpEz@com-79390> <xmqqik6mbhtw.fsf@gitster.g> <alF4rYSTxpQUC38K@com-79390>
 <xmqqech99qe3.fsf@gitster.g>
In-Reply-To: <xmqqech99qe3.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 13 Jul 2026 21:55:51 +0200
X-Gm-Features: AUfX_mxgGi3yldP3CsAOM0Mnh0XjOoRA5b_02swd5bsEvcEcES1ipXWCQtFRdhQ
Message-ID: <CAL71e4M8-KtnkC5qQP2iuhON=ROoOTVZfbZB8UhJ-+3KgEP9=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <ttaylorr@openai.com>, Taylor Blau <me@ttaylorr.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 23:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <ttaylorr@openai.com> writes:
>
> >> If the test involved is longer than 3 lines, I would recommend
> >> against it, as "git show" of such a patch will show the full code
> >> change to implement a different behaviour plus "_failure" changing
> >> to "_success" in the test, with the body of the test hidden outside
> >> the context, which makes it hard to guess what the behaviour change
> >> is really about.
> >
> > Hmm, I am not sure that I agree. Or, at the very least, that is now how
> > I have written series in the past where I want to demonstrate and then
> > subsequently fix an existing bug.
>
> After applying and in viewing "git log -W -p", there is no such
> difficulty like the one I described in the message you are
> responding to, but it makes it harder on reviewers on the mailing
> list, to make a quick pre-review based only on the material that
> they can see in the e-mail.
>
> It may be easier to write the commits, but given that we seem to
> have more patches sent to the list than reviewers can review, it may
> not be a good trade-off.

I've been pondering this dilemma for a bit. I agree with Taylor
that atomic commits are valuable and I quite like proving the bug
exists before fixing it. It's not black and white though,
for race conditions or hard to reproduce cases I tend to fold the
test into the fix commit directly instead.

But the review process is also critical and its overhead should be
minimized.

Could tooling help here? The submitter should know which parts
of the patch need more context for review. If they could selectively
expand context before sending, reviewers would see the full picture
in the email without sacrificing having atomic commits.

git apply already handles patches with extra context lines just
fine, so we just need something to assist in producing that extra
context -- either some configurability in git format-patch itself
(like -W, but more fine-grained control over _where_ that gets
applied) or some post-processing tool to expand context in patches
before sending.

Too late for this round, but I might give that a try in the future
if I run into a similar scenario again.

Thanks,
Kristofer
