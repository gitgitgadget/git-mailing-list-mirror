Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6949192D8A
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319112; cv=pass; b=Z8Nbh7xkYm7drurjvOUBEC1sz+lBc35K/PxC4wfaNXnmU/WfIbKXzorB0MM2vG6iTSfuMSap2nFNLpVVPZrOXEDZyop1gR6/PkryZH6HnL6E8wST4RDOaXApu+kghkOVBpUesT66KIlUgI6wjc7WPiiQbJiF8X6aRawjNqn5tuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319112; c=relaxed/simple;
	bh=aIck46pte3GQwQnonoIka9hDFKbHJjBQU9cvOC+0Bt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnZun+LRwV4FExKWrZUSMzdGc2rcDz0vev0YW43oJb5tCGJzNwxUjEzAJPs75Be60zSOgNwoEO8qadgIgS5MwCz+tUfEaV/KJiHKybn1rPVhPognuyuxrS2pa8Ytxr2HE2tXM5ePtliKTCTtGSLHBJ9H3cZSS6VPLAwbC6pF8EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA5gLbsJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA5gLbsJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so1204944a12.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319109; cv=none;
        d=google.com; s=arc-20260327;
        b=DrWdKxMyA7op2c1SGYq+4+79q2TLJQNAsaeQF2cnfqkZgIktMD8ZULL1NH6Yyl/OOZ
         3TjoFtUbfDJKmRjj8LeuSqoPtGw5ngtBPREPxDtFfwTtI0sliPvn2Meiq6RwO48P6rZx
         YcKLBm0Dz4lPqTDYOy+p9/0VotwYVhU27mg2Yx/j6zGGB86BwUE45ODQdbC1qUTyguT5
         UIcNkSRq44vQf9DqzFSReZVSltApo9aPkP+ThYFnIjmpWJo0uVVZEtd9RMQe018TSfK1
         qmI1bFFVV3fb4fVGffLeS/rIfXNhI6fTQ/cEN/ujD4XqJJ9554CetuXYv3073op1GB06
         8dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=imZ62CNqmQunmLrbfKYugk4CnF0iZx3ZnaAfYG85Z2E=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=EDA7l4YbPak36iYEJKOsmir3hklL6umQTVeQi19pQQRnzdeRZ3cL6mMQNtoLDfpsMC
         NnSYZr0YgDUXMqq1kpb1mpoHiivmivHhQNUY4R+p2ID0aKWEN7tPj3V2vMGWSCMYaRSj
         Hk5cLHSfnt7ljP/UUJogHODLyRwl761yIfcl5xXDoMg+Jv47l+XGP86eH9uJiAQt+4+v
         SOBbH87mFiGLIKrHjpd6flxT5cJ4jWf/T4xh49+TPIqN1lFStTVdA5AF6b6QDNpzv4hS
         Gmxj5zGRkrp67Moq7W+idWCl0sQDvXgMX9SoSR7bSCtko4mlI/rr3ybWGPlH3FVTKf9H
         9i1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785319109; x=1785923909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imZ62CNqmQunmLrbfKYugk4CnF0iZx3ZnaAfYG85Z2E=;
        b=iA5gLbsJriZ79BkHdlGCIHQHWrKqqoL3IW4OPbH4x8mAxvu9c1gawOoApOCVU+hgYW
         eysPOreGxoSwzcIrmq+V4h7gp3VUkl/3Uj7/VZ8tzYZco35cVy6DWxq+/03/c2R4PY/K
         4MQl4IrG26X5YoKJGPbCZ16mTcwfmnpSEvJgxF16IO4AJ++WcuxHy7MRQpeNeLvD0yFi
         FssoGLatk0c4H87Nn/hrE39q2RTgbqyJGmPaBTR/gVyvf8muLCGqwvXroJAMXIZvMam6
         ZlUuGqmv4I/uSEFlaWSudXTvBZqvtpmnbpNxAy4yuQTl4A7oR2SRS4IZdD45sW+6y78g
         aHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319109; x=1785923909;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=imZ62CNqmQunmLrbfKYugk4CnF0iZx3ZnaAfYG85Z2E=;
        b=kXlg1FCHz4sOyOCvCq9OMpxM8cwPZcxPcz956dGx54jWM75Pbc8hs8ciK83Z1J6Zof
         iGQVDzqsCBfCakrCpe6nSdtJMh59BGChDfd3MbuqiNlyv1q/RnOTcEdilECyP2NVUZws
         NdLTT1z45T5J1LJ+jbYRx7oJHYRWDGmh12zoN85LiT0SXpgEg5xXyrEiqgumDhoC2/Cu
         HsB5s//OplIbeiNMzEcXuQ7jtLR44u4cKvKTntHsjmlKe68hqT/x3nDppWRZ3HaJO4Mw
         kucIFiJ9zCa8IYLg3NBfWoYqWVXfXS/cgsRcsmUZKmNdkm7ANstSfvO5Bg3WIn1wH0tp
         qpuA==
X-Gm-Message-State: AOJu0Yxm/ORnKEV2CoX9DiKWJoztFoHJxDEyueXKzXNoG4kRXqrmLghg
	akjjoIBIwdbEwguTbJihsEzNynwZ9XgIk3hIoM7lN+aQ0YckDFvYhwQNkRqIwJ/wX7djI7lP4m7
	e4NEZngAqSwnQAapFVCdvvNrUfWBcCdKGEHAEr0w=
X-Gm-Gg: AR+sD11iaM8dKmsKi7JhnjfFl3y0IRldCJ2BzG3Cf8x2QsWuHJxO96728Xdbkk87XNl
	gF7y5dTolitNXMltMx8KGgV68CmRVuww7A1S578gu3NYeSGYiKpXUFmdF2Z0A+VSOnvi7wumMXK
	JUGJZHvembBKHsKv3oQzJkWm5gT1gqKpmZWbLP8z+De7nvQnOb6jNrlC95RC2Fwe8FeNWCutbWI
	OLIaVy6G5X8egPL7HWmu7EstvjFvGkIJWji9NurWO/mAFMlYeravvo2h7xW0VrmQKVU8ptmgmfb
	gh1WJD7NPEj4qO7WnG741tHccQ3mxFCYErcTbdXt9AOUMZ0mo+M9XfUbKqgKFL4rBVCjkoIy1ck
	z5VgQxupN8arKwZT9gB9+g3o7BCWKTyMb6ZLyE1K73qY8ECfb6Vv8U3weDg==
X-Received: by 2002:a05:6402:3584:b0:698:aa8c:c15e with SMTP id
 4fb4d7f45d1cf-6a034a79e30mr3279632a12.25.1785319108787; Wed, 29 Jul 2026
 02:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-4-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-4-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:28:01 +0530
X-Gm-Features: AUfX_mxEyjuIg-t8uMqoM3Jyvr5AdS8jMZ-N5ZHRXZqklgu2-zeNSodXqq7EdR4
Message-ID: <CA+J6zkQKHVhDLSXYz=hFtfnACHviSVZEDignagbCVLhEWBZiJg@mail.gmail.com>
Subject: Re: [PATCH GSoC 4/5] serve: advertise type capability
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> -# This tests depends on %(objecttype) not being supported yet, once supported
> -# it needs to be updated.
> -test_expect_success 'unsupported placeholder on remote returns empty string' '
> +test_expect_success 'objecttype is supported by remote-object-info' '
>         (
>                 set_transport_variables "$daemon_parent" &&
>                 cd "$daemon_parent/daemon_client_empty" &&
>
> -               echo "" >expect &&
> +               echo $hello_type >expect &&
>                 git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>                 EOF

Instead of this, what about creating a single test that verifies
'type' is supported,
and modifying this test to verify that the other options are not?

That would actually preserve this test's behaviour and make it easier
to extend in the future. Something like:

+ test_expect_success 'type is supported by remote-object-info'
+ test_expect_success 'unsupported placeholder on remote returns empty string'
