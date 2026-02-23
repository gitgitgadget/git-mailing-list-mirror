Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DC330B22
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870335; cv=pass; b=qk5HJBcA5GO51lUN6kipyptsuR2ee981rR+I2UfKCu9Uzy8ixlNA1sxSH6+HsCwtpMPRkfK+i4Zw3a9aUKc6kNlP48bXeG66Pj2m5kOphjX1nlA1MEAxC6sbA/9jGToPZnuNzQzBxJ5hya8WEy1hkz6bAXX6x4N+iJ4IwU3Z/gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870335; c=relaxed/simple;
	bh=KuH5LaZmji9Sdnxo6isndgKJPlMEKnxEMZ48zxarMkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssqVVFBCpdPoCd9l+fw55a8+ARkvUusf6y5RZvjvuHNwKUkShmWgaJDioK7M27qvf2L/OjmkcM/lvF11hg9cakwoM1winUI2k/hjrhZFSVQFdw2pXz7HqRVLxCzB4IWeJXWBLd/+TYmcLLYgFqVU6Rka8REyjuV8nETYxuiDGYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRGN9B8d; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRGN9B8d"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896fcfc591eso43331166d6.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:12:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771870333; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAN6yL2PZ39lLh8txgijQS8M4hqTFb+qDIRosFBJm/qP8P7yMcxY1chKb8XK25laA0
         5gzygNjKBd174KjalyYMnfUXFraxCuH8y52rHkbK+4qo4jO0jdSH7ujgiTAAyDjby7b1
         klhWI0sCXVman8UKdXW4fCasq5wCdcSfQ4Hg3VdGjPklQmmGygmhFs3S+B9hN0bm39eE
         ulPovlvguaWnmycB9TB6iDsJvbr8qOeDKqXrkyhbJFiEipe/a32ycEpm0ajY29Pg1rWo
         bbNFHhtcYg/DHQnjn9EwwWzg8jgU8s4GVe8MhwHfEDcsLpcKn5EHn1WdzCk63uzaHvvK
         uxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KuH5LaZmji9Sdnxo6isndgKJPlMEKnxEMZ48zxarMkA=;
        fh=nZ7AwcQB774YPW8HuUxIWUYZ0mAEzqVhEgrGoYVASPg=;
        b=Ar2Vb9hS11WtKizzcmTK3RtAKRKep76a0Tpqr6u2VbIwaAE7MfLdpNRR9bx1+AnUa0
         oNZSLTGkKVksd5mVczQpHtbnME7x5tP7GjS+tCM23PvhBjEEHmC8GqKVQ8zLglKuefkY
         GbAKgWv5jG/Ig38iWO182eM6pSKDix6kctHBLfzWd76FjmqNUPP7eMxYHzSYqyv8wlOi
         893kamDZuzAksV/9Yi9psMEl4bl86dN60c8hIy5fYd+7xhoAof0oZUdV6p3yKglDKIXR
         WDJ6yAKZNWDo1ibCBE/Ny/tAR6WUY7srOErlRsK/oXO/VpXeZGlLLjG2JrUbvVv0kBgF
         e3cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771870333; x=1772475133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuH5LaZmji9Sdnxo6isndgKJPlMEKnxEMZ48zxarMkA=;
        b=HRGN9B8dET2YRjkT/CrY+sXEdtXnC5ChCfOImcnar8Dce2H+1AOmjf82Ys4S3uhJsH
         b/WTIBSj/siVD2M5icYtmWVt9AR2Dt8Abt2eJ68o/ckn/krkzrWNRb+i7Sxuk8aaVwe6
         6wCZQ9SIoDDW18jKsxOnGlph3fmL6GDWdJZPoJ61DOOJeajRSWAQiSw8rEcH+pSLbPVy
         CLDeGLIPBZgzrvRyDt9CJy1cipF4/BGQ4IOUgxX+RDmOLFvUmEHXe8mawEr/pmBIKBza
         Vi6JBb3mtUTSq2CtYvnwhIFiDHE1VMlcdxye3lG/otp/+P/Ml4XfXIIVQM6XqMyKeJa1
         UN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870333; x=1772475133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KuH5LaZmji9Sdnxo6isndgKJPlMEKnxEMZ48zxarMkA=;
        b=NxVKJJIuUJ7MhpN8Z2TVr7viNJuZIvbdUmokf2jlOXdzyfuyhOt6Ad3RtrWHZIhSKt
         R1WTQm+Wme9WO/BzrgrjxXtQ6bPf/sfa4y1fhVhmate7yobbSCdts1/tsfI8HdaQkrG/
         HUuJmAdfAPgrX+Ft2+A71iqlSE7sDCwWUWDgPggRBOD1zZ3Vklnbib/3s7RmdAE6WfHG
         5gOb9AMdlconxt1W1V3EfaQjchDd4HRQ1O8Ljbm/zOCOzvh3Ov1QyXUYYudTM5CC26Lh
         4McUJKvy+LnIt7VgSRd2aIWcPbwR7xYGb8k2r7s85ZkEkHTj3Sx6ZuoAzut7c55jW7uv
         Uaig==
X-Gm-Message-State: AOJu0YxALemI8Gb0inq/kR6kPG0f8V2D8BwwnCG9mscr1xzezk4wkVN9
	zCIoduxbytHWYy3C7NF8KWsyWuOFKytqCKL7hqyilbGrp2v1iXfWeGFB4VZ1uWvq4NdASRb8yw5
	/skxHYo0P74hu+wgw4INqZLmlagmmSiQ=
X-Gm-Gg: ATEYQzyQZhduXxd3zJY7zS+AjAfO7bbg17Utc74+pV8JIKxIz+UyIyN5ssS5blxZwt2
	epqT1C5nXDMaF0zZ35LwqC9JkA5OERouON+HMDiDiMiPiAOq2sFONzlXEjKl5VFwhUeQGLRblvE
	vWIgthOZvnR+wa2ObeVGWVKS+gQwG2sM6+AOYVoo3BvfUs2fdqDraWF1CneuK/1AmAWU6C8I9Vb
	3ewv8WqFNbWJyWojOjcCtScESOomN5zDsHk7UgSoqca8OEbDX831YIZ/dOBUb6YZfEE0b5nAcvW
	7Q6i
X-Received: by 2002:a05:6214:da1:b0:888:89fd:a720 with SMTP id
 6a1803df08f44-89979e31e5fmr132326296d6.11.1771870333304; Mon, 23 Feb 2026
 10:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223165147.3294516-1-cshung@gmail.com> <20260223165147.3294516-2-cshung@gmail.com>
 <92e33f7c-f45f-4f5c-9d51-83ef6232364b@app.fastmail.com>
In-Reply-To: <92e33f7c-f45f-4f5c-9d51-83ef6232364b@app.fastmail.com>
From: Andrew Au <cshung@gmail.com>
Date: Mon, 23 Feb 2026 10:12:02 -0800
X-Gm-Features: AaiRm50qK-rkQ1u9VsBzu5bb8it3UxTMrPkSJVGGyNGcFZdz-TYwtryuQT69Cos
Message-ID: <CAGVkMb5cO9_7fvVQOLNSiznZHcTkGA8fw2q3JFnTEnvNZzMwXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] transport-helper, connect: add atexit handler to reap
 children on abnormal exit
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this is forced by the GitHub don't use my real email address
option. I won't be allowed to push if I used my real address there.

I can change the commit author to use my real email address if that's
preferred for upstream.

On Mon, Feb 23, 2026 at 9:15=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Mon, Feb 23, 2026, at 17:51, Andrew Au wrote:
> > From: Andrew Au <3410332+cshung@users.noreply.github.com>
>
> This email here,
>
> >[snip]
> >
> > Signed-off-by: Andrew Au <cshung@gmail.com>
>
> has to match with the email here. Or probably vice versa since a real
> email address is better than a GitHub noreply email in this context.
>
> Maybe this was just an automatic don=E2=80=99t-use-my-real-email-address =
thing
> that GitHub did?
>
> > ---
> >[snip]
