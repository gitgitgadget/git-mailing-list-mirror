Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793218953;
	b=XSLCjZw7Oo6xcE+LAitRsj/jchQU3nAtMD9HtCXNIsNWsqHaWFKmwRBpfnNUnaJXMGzK
	 99+Nh0vs/GlPR6YVxkn34MpGLpkgZU6TXti7qGZptnDtpxIe3ayxophNfoYnARLdCyVv7
	 sdsD5MpoDOy/FSNX+MNKVBhrocXKKHWtPIpydlmrWAVl7KhDzFnJ4ojMuWQJfI0sInR8q
	 uPidJ3fp0thgekMF9iIa50RWIW7PSYjQZ0jlXluWmYVWRrCe0zj1ufTmf2w+IjZHXoXxw
	 815oKgx5AGMFJ7D1SSDsLS3/2UfDLFySjQP3mjlALtQgHbzwO8vIbO9WyTeUL3ShPxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=XrC1Gj5Rtac/l0k7gEKb34+J9GVjUcw1muteogeibx8=;
	b=3I//5skNHPgrntCAMv3n1/g72y7hkUJSgShMZ5JEibxO4jpjYS1wc9ReygsbXjeFeUii
	 foCnbH+2GYeubD1nRk0LBcjjz4JsnxY2a7woVPREmy9AWSEeYqluk95JFOAdj7uWFfAAA
	 fnTykdBR4+JBpRsQv6zTe6H8w+9I0jMZ4RqESd9d7kqo8nUK+lVvdOq3tdNbi7iNYrcbB
	 YmEKzohMVsgwxFpb8ox9+O1PIjkTeC4QPro3N9p5AyRP3dQMRPizy/+L2UFUmSRTTd6G5
	 PFM5K1JO1x6tk0cJcTzQd+Vl7xlLhiaDTVD0Oct2G0YVi7mtyn7oZ7QPMGPyBcOi6vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=japQ0J59;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F46606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F46606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=japQ0J59
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1481097d50.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793218952; cv=none;
        d=google.com; s=arc-20260327;
        b=VSrTiLSem+7g88qUuAIg6spOMfEDWAcZpDvOzLGry7A7GZ5qYEpLgERBw3wqJEJMsC
         vO9wJd4Zer2e6KmxSXSZo9K22mu0clFJg/YkshEUvtSLBJ85drA7HnUSaEKPDfwTGBkC
         YPu6IuiR5L+RX9wZYMX3jEApo3YJC71eoYvlSpErKEGAosCDYReYYAX5FBWQ9hwDGMo4
         Uy2bYT9jrID/9Z/00k5SUlSaJnnhvImT7RbgQknCHtpvPMUWD1cyI2Oi2V8cycS4lpfg
         AhwFzBVNaIzcUlLc4DZbvYh0YWvOAlNuvm6AtLUEKZgMIQNYAFIhiWrIwkngKfwZk3+y
         kWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XrC1Gj5Rtac/l0k7gEKb34+J9GVjUcw1muteogeibx8=;
        fh=yh48E+bIdIF5bkOxOqeqFS6MqWS5L1IGeGCToXGaOZs=;
        b=VjluIe4M6+O6jnchd/AtAbTp3nTf5sL0keflD3H/iN2wTZ8BOe+inXjus2oGnRgnL6
         4QpfQyZdx+i+DqdfW1jrx2AeceZu29NU7m5DIM3Y7qXWIQB3VwoqhMAUI85dbk8Q7ypT
         //1rlgDFP6o9RV31JAW6tQC5Crp0PDCB2xZlEKqfdaJArLY0mX3JvoK3PorE1sNKDTCG
         TmrvO1ktJziFtjfBpqzub0IAMSIqdzwuRf1PEctUlJTS1PWvefpjKSKCNPEmEOMuBPB9
         U1DEOSnBwa+yvGn6WRWOQuVd+HbKM0Uyz9G8AXPuuH0n9WlKUygjz5E7iZcw/07hOW+7
         DUYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218952; x=1793823752; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrC1Gj5Rtac/l0k7gEKb34+J9GVjUcw1muteogeibx8=;
        b=japQ0J59mc9MZK1RqAEAF/fCpVZ/Y+tyWomw4uPDy5Ef9+WE3uDMY3YDb+rkBJ+NH6
         pGH3FWzWCcORWinY82UABGIMu7RUdDXEPSHNuHs8wil/94J6IlUPCq32maxvRvMfpCXe
         259P96ldmSLhq5EeRbPUTX4dw6NnHj99nojOat13AvJzsY2RZJupRSSiUFO0ZzZKY9V1
         INPg4o/EKfJ/Iyg+xSP8EREph/Xba1yEwbZUQlLjfLIRBkIqpdr1Gd8a8DRRrk6io+8G
         D18STpZTwgffxZjJ6rigsmlM7H4tFAttokD7PsGuqZKsw8PxEzrFKP0X62oKbGFZa7a4
         3YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218952; x=1793823752;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XrC1Gj5Rtac/l0k7gEKb34+J9GVjUcw1muteogeibx8=;
        b=ALnKg2fxtBYaOfKHoUqFZiDhrIs/ZqFAZPQsnz1deRdTkdKq/FLPceo0PG9Cb0ctgr
         CTy3JL1TbD90IEhrv+sQQvX7OFRR0tpKSJuU7BhUiCxk/1MnSNaVDcNecbRLYYPZlkD8
         7PtEN676fJljvtw3QAG0S5zM5RrdTH8ZKwblKPma+NqEFa14ceoHuq4zZNOuwP+fziGO
         9qi5F5avk0Q7mD9sc8GqBiQrN30x0HnDL8aMt/XPM80lJyZ6dA19FsZtNvUrRrqCPbKC
         OnVaRyJzJcJI9VErhEAxJfi6By0FzK8cVkVk746QSz56Qs8VURtl9+ltDOM2Eyj4W+3/
         6cNQ==
X-Gm-Message-State: AFq9FYK83Erb/BnFjAtCSxf4NlDfEe2Rn3dbO055fYLvai+kpYMEpm01
	90YBGQKu6nlppWMwCWDlrk7qx+NG8OqU/jYliZixkYADRiqo6oHCHMjeY2sw7KX5ZdRNJPhfi+T
	DyGUzUr5zJBvht3MO5y8lYH6XrzCSpg==
X-Gm-Gg: AYBFou1izte1UxEURe1rZult7/yQCd7ihCXAsinhls7L3TG6suZ+7pnPjqhji/EEgN/
	AIC7STMhN6oCOkGJVZJEx//vyz2IFmUPM0MdDCBXQ4loAfemGJXgWNlsZ45UTgzvMlBoGD+58h3
	9UiGdEI+AFsg/8YS9bUID9lb4TJgzSILq0gjR8/ctF3kife91pb/u2JbXp4z1d7fIPO4QJs4jSt
	YAJgLm2CorVGnnzQHSKP3Dp4do3evuLt5BaeUEZMBYfP/5OzLw4eAnwq636OxjMvNflrASG1w7I
	wJI4D7ZUjY5ZGGkVuvdwSq5pbUvF5ubV7HW6DERukCrDXENEY+VdHV4qIY8oT+ZEnHl2ckTlP79
	c3AnqX6jzoCjO2Io/ssBT2C5l83hp4jIZKg==
X-Received: by 2002:a05:690e:130d:b0:676:e85e:5ec with SMTP id
 956f58d0204a3-67a7bd4b423mr1993858d50.139.1793218951989; Wed, 28 Oct 2026
 13:22:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026132525.45414-1-fiendora5@gmail.com> <20261027145451.8617-1-fiendora5@gmail.com>
 <xmqqcxsvkorm.fsf@gitster.g>
In-Reply-To: <xmqqcxsvkorm.fsf@gitster.g>
From: Fien Dora <fiendora5@gmail.com>
Date: Wed, 28 Oct 2026 21:22:18 +0100
X-Gm-Features: AclHuK8l-nrm6-Z41UQBq7RMtB7nGwYFsp4iS5g5rigGsVd5MMJRibjJQ3bjpk4
Message-ID: <CACWAS-X=fFnQayFiUEa=PyCEC8J4csuSzL-kbgND70iqvt=cNQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] t1402: test --no-allow-onelevel option precedence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I haven't heard of anybody planning to do such a conversion, but do
> you mean you are planning to do such a work as a follow-up?  If so,
> write it more like "I plan to do X in a separate series".  If not,
> please do not make up hallucinated facts.

Thank you, Junio.

I apologise for presenting the possible conversion as though it were
already planned.

I would be very interested in taking on the conversion of
check-ref-format to parse_options() as a follow-up contribution.
Although it would be a learning challenge for me, I am willing to
study the existing implementation and work through it carefully.

I would be grateful for your guidance on whether this would be a
suitable follow-up project and how best to approach it.

In the meantime, I will revise the current commit message to remove
the unsupported statement.

Thank you again for your guidance.
