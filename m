Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473034751B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528231; cv=pass; b=W311KVrLXgz/DHzXpxTtVjimDakHqFIK/IPvkXFGK+Ryoct5RlZak+Y6nw2IGNRTBmrLxnM+Ega0Vnn5TthJxioGybKv6iQ5sSd16vMh6dnQ6q4m9FzHaIdFJpHqqUyRs+Y7ECQzLlNYOel9N0TzLrOpWkey7DYQJzFqY4juNIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528231; c=relaxed/simple;
	bh=+0uinrjZFf9QAHhEbNE9ZS89dMr/BJYmD636atbeLFc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=SS5dGv+F7G1jdF3lgN0PzWKuBhnNLS5Gt0ar+FrUGzwtHeuHQ+paKenWwKosXiqOYpHqz550OQ+2mq1bFgxkQE5Vl90BZVOf/DYSR3LcdxIBWJDDljJPQ1jsChfGipFpzkNfdMlk9OWwraYCyR3ujk65FL9BkNzh7/02awig4a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArVJg2nC; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArVJg2nC"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso952215e0c.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788528229; cv=none;
        d=google.com; s=arc-20260327;
        b=TjA+a53rffVOZFtMxKL8t5SalBlBpqzHcGvjoWn66cJVRG2O9jyDEWfu1/362neVe7
         BtaX4UZ2QTKsepwnen4KJB8c4BL4emkg2TDeoPpw74ZR60W+xSiq3ysS/ft1ekLJbxeR
         dugaNjVv8ToInAlhBrk1QelvU1qb/qoKGtiJE2weEu1Holw8k6ChFeG7Ngx7U/ZLGawx
         rG8ohwS99XtAU4xZHqRz4qy7mxUCSGdi5R91nGoMEJ0RXW3YetsFX6MOnBBhDgDfA0Ee
         nPd9mXFxQ2jxbKITsXe+kdZgUjAn/QGsGHVf8bZHEozOZjYCoyRQsdgUW8NkUqktiVxz
         RG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=beYWal5OmLkdxLwKOkFAn0wEwliZcsT6m4nqTISMzkQ=;
        fh=ot4uXTeJFHukbzQEEA87b1utizXqrhaa9YNrPg9qDkQ=;
        b=JRqAHPwznQMmNGpl81pmNjffkkCWBupbiB79W68TSiX1LzEqkVpa2U+g3rIBqagmUn
         37U4Y4SFOJcbOUBC/EKJrWPVDScCivfwvs9TEsJ316uEnMSwbnoCRaR81nEf9GBVLz2k
         cqaydvr8Z7EcAmRivyXMyboaWTXDWuhZrTMLvJj8+PWMHytm7L/0SSuap7DQxAJaN1UT
         5x6LGG8Mp1jiu/c2T9MrhbtiqpAyVz6qZ93uBe2/Bi5saE2696aVbzHXQNmFGvm13yTh
         A4xegWBI2N13zqkI4sJlobw0mAqkry2/+yksLxZWCm0TNTgKTL7ik32O5cULqRSWLZAI
         1h0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528229; x=1789133029; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beYWal5OmLkdxLwKOkFAn0wEwliZcsT6m4nqTISMzkQ=;
        b=ArVJg2nCx4/6+ez9CGBRCwJ9mvdUefQ4N1XkB7w71OEQxyEktYXnJI7xZZtJRIg2Up
         IktxdPSBD9xlqhCyJ0tUB5IVZm/uDuWR57WdWDHrPAzRMPuKAjPN9EgXFKEC5uK5vmWr
         9ecCfhCrizaPlPRyg8g7B5LnSjnJ99rCGJcFk3sTkAg9qcuOR86doOD3EG6aXzbs5b33
         mvSe/AXfZQK5P48gSU89063RwNBROflQoHbW1FeZjtOo/4yI2oxr/SgJEjWFTFGyPHzw
         E+iRIoVVmIgt9ukvZ0SRPkZz8Ms9G8McofeKeQyF4WLS2SiudDs9bkk+cfcYSZ1o1ePS
         tFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528229; x=1789133029;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beYWal5OmLkdxLwKOkFAn0wEwliZcsT6m4nqTISMzkQ=;
        b=YE5ZFpAxGqi1m3Bw4QFxPV063pS9YRay1N2dHV6yTBQSIJJJEcp8oaAvSWcGz7GY6x
         eI4gdMZwA27XUCy5jPKj9TaT4Pk/qB5NTaKscN8vznKfrRV04023FkVWr8YCBwAC44wQ
         jutFOnJV+/K4WIVoJy6hg8qkGvmDb+10njdzXkM8dNKRjDQC1Tc2QBHLiupJHvmRkVPa
         LzfXn6wO1D6w+4NVdq2MhWtSQmXLq10CyBcrQoGlDQFZF9z7IBPQzn4pTCC1ZB4W+5F6
         PWQgBzvhvRLNs8/+Ud522ORhERym9Dt36bmK5xsuGQMj1YFteU4TW4tZ0VNNgmUDXytN
         S78w==
X-Forwarded-Encrypted: i=1; AKwUvBxiEoRw1CAmVTsTyOVP8E3Vs5zhNeI8bFMVIt80F5tbBA2bjk1id2sgctDVHs2g19Hqb1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mALJbKwYSOMH4v+K6LVUdIPvIpYzNqyCvFWFQS2BbtghvqpogD
	WJPDbKGVuzSTCAPol3P4IxjYTh9yu6eB6MNe6pL0D1qOAcqTkv8aPZDV/kMIMyRHLO5/lDkLZBD
	ri41NXFbbbWKAW5te2tNZ0MSXUcMlSq+SQBBL
X-Gm-Gg: AYBFou20Y448xfNpF3aSXcHAvdbvv2T496oOImyGJzRGt6pswGShF29zkJY5SN/RgSN
	rxCDt4cAJy0LzdTVq1PUtASWlXLMlI48pUNWLB9z5dsasfYkPFsBS6Po/0gMswOw5jNnCUG1hnt
	d451GDuynZRwzULeZG9IpXEY54YKSBy85Yf980Y/MPgS5SpaJJrDMnqgmdk4wjc8hZAzJ99PPez
	vnMDYvemqdNtoR67xzR76XyVPt3Z6ko7h3xly4OlPhJrrGBsvDInHcITI377nFMfIFK6YBJ447w
	fDjZwVcCdIEic6i2pI4Ovst6NA3x48DFPFPuXgIfqwZoJrysiggVGWy4x1g0wzTduTRok/RvQQH
	RQ+sot3KxE5V+ik8/KJDZCjJmhR7hzc5c4OI=
X-Received: by 2002:a05:6102:8023:b0:789:5fc6:3693 with SMTP id
 ada2fe7eead31-78a4a6f8278mr1993592137.6.1788528228990; Fri, 04 Sep 2026
 06:23:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:23:47 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:23:47 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 09:23:47 -0400
X-Gm-Features: AcwNN1V5WC69XevgRNZQ2hCz46qYjSwPz6bdAbUqnutS6dZtms6edQ3Sci4V3fQ
Message-ID: <CAOLa=ZTi_ZdEZ+hDXXoyf_U875-zwUHBydDhu1wjXYGHQANXfg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Fix inconsistent ref storage format terminology
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c29ac1065aa82d37"

--000000000000c29ac1065aa82d37
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> back when we gained support for reftables we of course introduced the
> ability to control the reference storage format that is used by newly
> created repositories. This infrastructure has grown over time, and
> unfortunately without a lot of consistency:
>
>   - The command line parameter to specify the ref storage format is
>     called "--ref-format=", while the corresponding repository extension
>     is called "refStorage".
>
>   - In most cases we refer to the "ref storage format" in our docs, so
>     calling it "--ref-format=" is inconsistent with them.
>
>   - It is possible to override the ref storage format via an environment
>     variable that is called "GIT_REFERENCE_BACKEND", which is not even
>     remotely consistent with anything else.
>
>   - There is also an "object format", but that format does not control
>     how we store objects but rather whether we use SHA1 or SHA256.
>
> So in summary, it's a huge mess.
>
> This problem is about to become even worse though, as we're soon going
> to introduce an object storage extension. This extension is the
> equivalent to the ref storage extension, and of course we also want
> users to be able to control which object storage format new repositories
> are using. But we cannot properly name that parameter without creating
> even more inconsistencies:
>
>   - "--object-format=" would match "--ref-format=", but that parameter
>     name is already taken to specify the hash function.
>
>   - "--object-storage=" would be a good fit, but be inconsistent with
>     "--ref-format=". Asking the user to execute `git init
>     --ref-format=reftable --object-format=sha256 --object-storage=foo`
>     just feels extremely awkward.
>
> So this patch series aims to clean up this huge mess that we (well, to a
> large extent I) have created, by bringing consistency to our command
> line switches, environment variables and config options to all use "ref
> storage" instead. And that also paves the way for the eventual "object
> storage" switches.
>
> As a cherry on top, this patch series also extends the "--ref-storage="
> switch to allow URIs in the form of "files://foo/bar" to bring it in
> line with all the other ways to specify the ref storage format that
> already allow for URIs.
>
> Thanks!
>
> Patrick
>

This was relatively quite an easy read compared to the number of
patches. I have a small question and a nit. Looks good otherwise :)

--000000000000c29ac1065aa82d37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f67501f4127826f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYXhtSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2hIQy8wVlUyVmdFTUZJdXZ2NzRZV1hCTzRsMXBnMQpScUV0dS8xWnlr
UVZ2ajhxMGQvTnE4NmprVXpJUUFqaUo5OVlXMWJWZnd1SG9OS1hxSDVxOUlsaHJoUDJzT1lEClBV
UWV2NE5zdnNKS2t3akZnOFk0YUh5bXB6RUxVRWthMmlIWklFd01NNzh4NGgxbUJLY1Nmb0Z0Qm5j
T01zVkQKeDJxQmpVN3l1Q3owNFR6a3pQTkxTdFZXN1JGVTgvb1oyeStxWmFVZnFWOUM1Sm5UM2J4
NGtyZWhJSkIrYm15UQpWUlVhZmo5R1Z5OVY3eUlMRmVvOGJuTGJVWUpzOFNxKzFKQUdXSHRNbFhz
cFBuU2QvVStjdWFUUFBWOCtmUXBCCkFLeXR2YnVVWnJzdGhKUDJ1MGEzd3hlQ0JtN0ZMMTJNU2Y5
aFh2aUdYNGpwRUJTWnlXbjc5am1JNCtBd21RTmEKcnlFUWN3aWU4WnFsL0laUjlkZjVRYUxCUWlx
d0tNL3lnSk5NYTZnZ3VuUnR1OFRteGhmdkdsRGR5WUdBYksvVQpHTFdUOXRqUHEvclRsei9SV0Nw
Sm5xWWRMSkwwaXEzR3NUQjVROE1YYjNCZkJCbVZScjdnNWdBSThJYVB0a0dGCkpobmZWNXluR082
MG1KcUY1WVc3KzNuTW4wSHVqVUlCM1JxM1VPaz0KPUlWY08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c29ac1065aa82d37--
