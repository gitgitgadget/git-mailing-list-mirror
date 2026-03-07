Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E217993
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867123; cv=pass; b=A2ImYD59QU1pDgE71y0vHxR9rAI/+e0IUL54rIvdzif3Q8kIqfAsWlMNUMfVhDsLOtYAbDuE9DmGIlfOkBx/ZzJY3zlzRqvxXD5T7a4zyWDBQtojNGOZMU3NiVPg+vYUTsSJSHK0K8xgHt3m4QbXJHyB/cHKTU4PYt9qGfHrWFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867123; c=relaxed/simple;
	bh=QE/uEFX08xbongQ/ml9kOk3AevXvMrc6pvqng4pGLSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9usDd6yK1o771id23yrV7I5hSjNJvAEOoQSphrf/y1BBiO87WKDZ7Cdksr3n006uAv52zJcbiYgN8PK8X0cZWTjr1e2KVT4q5OTu90bpx36onqcXt//oD93ImtmwzYBNHxw6x2+MxNs5R9+eGtLYKWF6krw1uy6owOsaT1LQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b8095668ebso627311eec.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 23:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772867121; cv=none;
        d=google.com; s=arc-20240605;
        b=i4PONMht4FGXmKf2TNp6EiWvuzDDfu/I3TM40HIFr144Omvt+slCUlOeFrOPGFPdFL
         xc2iGY0OBeUrxQQ4emn5pQnPCvl3zVwqcZlWjJnjfCYPEs4kuq6ypa69UseRy6I6wWUn
         vBNXg6f4GIVRDob7WqdwnU5GMMsZ9NX5GpAxpc2F0ZEdFZdCLzl9mzG0TEjLtruQLfmH
         dRqubSKQn/r6JnmVTcdbrSpQ7+MDALF7FR1jG07YVmK//meroZ+B6REF+tcg7bR6SMWE
         2OVbOzSXWmW2uiKP2gSmCTrTlLtcv/H3skac4ahTNFHweycFgewQkHmnRE2lQ/F3QW0Z
         eDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QE/uEFX08xbongQ/ml9kOk3AevXvMrc6pvqng4pGLSA=;
        fh=re9Pn0uXeTIBNmWTMijbLDezn9nU+JDzVnbgV5hB4Do=;
        b=dZjLgzgVl3yo+32VDUFiFDIUw+LQOjv/zXf+IOQv986D7YvPTNszdGopaRlgIJ9h9M
         Ul+2KWCPOkM9UPn3NWUBFNNQycAz6f/kbrerjHj1qEqmgHPnsX2owo9gh2c+sdrQUr1C
         NmFqMo4Rj843/2eOFiD9E3fJVANewaDgC17cOwub5H0GZGqTVMhqAaqWrjgIuuwTf2MV
         6N89WAFFUVXlJORICDiBjFY3dnNJNuLFvy0Iy4LQCshKQlA8JPcOHmymQ2ES/Q9V1U38
         tZorLef29jtsxrzz7uO9dQlFksXA8svlhwfFSJvMqx88Er1hqbJc9Nz+3KXpIqZnUSfA
         mvQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772867121; x=1773471921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QE/uEFX08xbongQ/ml9kOk3AevXvMrc6pvqng4pGLSA=;
        b=TndW2Sd6ky1gPQ5XIlK1kcmLaUb7afFAqfQNytj8Dv+YEPwRPYyO9Qt7gDC4bmBK1O
         HusLwAn1hjXRYAGRJy2Oe8wDCHLjpJ/uF98S26xc2aHFaWU7d6anzfGFUVHwT3tTxvwI
         UZoSClWCbMQMzwrhXiH2Db01yBbwgsLQJgcFH01G53KF/RhSnQ1+FWVx12snDZ4jMt/7
         mc+0BzIS6tvO0mHr/N/62fut4H7qawVdNk0tnVera6bVqkkSSYDFhwAOKAZFK1VMBZxH
         dtaX3o0XejIx5WQKPykozvFgQdTnZQ961+xJ0nPsoQjb+6pJ95sogcOYRaa3DTc17n98
         Ik0Q==
X-Gm-Message-State: AOJu0YzjMuRGpCJDNn9PecvuIm9RvaJ1Jdk1anI5EonYhs39oZAWc+dt
	Tx+RttREr9AqUNrXJXgwsG3BVOVDrHeCq3pRdsdPDgTNN3rUnqWCjL+fUXRh/0RsE5iKR874oI1
	K13fKGtLAMCznPDicuTUhZlMNu2iO9v4=
X-Gm-Gg: ATEYQzwiIuI4BuXuFOCAsAvxtYS1fEuuLY8Ag/m/DqdRpROLn3lHMW0YbS/cHlF6U/o
	6Zjjg8NwRAjSE8k/flfiTmMTRdtXCIHAO91baEobiiAkd4GsU5Q2QIrmxyTNfqpGpyiLMYhC3Wu
	d5aGH3U1EHkD5D7YMfsy1/YhKdQ6cN+fBR3bFP5+yPpEu5d+kt/PBGwX/9f41eGr91xe+IiXoGf
	aIJ6z1Y8i/kCxxAs7lrlnZr0/s5gPCaO4WikmgIMNStNhVJj/hny2m2PzPFrAVoUcd5RFpLOLqA
	C7aJEZoAEc+ezYea0N6JrnX87m65lKX2b70M1sJW
X-Received: by 2002:a05:7300:6d07:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2be4e221185mr977932eec.7.1772867121324; Fri, 06 Mar 2026
 23:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com> <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 02:05:06 -0500
X-Gm-Features: AaiRm53Wl32acJHlfJrl8wm8eKT78wjkJHAJknl1Skdhn2bku9s5Rw697W1Tu88
Message-ID: <CAPig+cQu92SNS9mamfEwfdZMgqHeDh4Qn7HExgB9OzFiTZTHtA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: add prefixes to new branch names
To: Yoann Valeri via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Yoann Valeri <yoann.valeri@cea.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 8:14=E2=80=AFAM Yoann Valeri via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This PR adds a way to add prefixes to a new branch being created. The goa=
l
> is mostly to ease the developer process of creating new branches by addin=
g
> shortcuts that can be set either with a command-line option or with
> configuration parameter. This is useful especially when you have to do
> similar backports on multiple branches, removing a bit of the need for
> finding names or typing the names over and over again.

Sorry, but I'm having trouble understanding the value of this patch
series. Neither the cover letter nor the patches themselves provide
enough context to really understand how this feature would be helpful.
Adding some real-world examples of how this simplifies your workflow
*might* help sell the idea. Without such examples, it's difficult to
imagine that you can't achieve the same with some simple aliases or
tooling/scripting on your side.

My other concern is that this implementation is too special-case by
assuming that users will only want to apply the "special value" as a
prefix. It is easy to imagine some users instead wanting the special
value added as a suffix or embedded. As such, a (possibly) more
palatable implementation (assuming this feature is even desirable at
all) might be to instead allow the user to specify some sort of format
string into which the special value (or values) is interpolated.
