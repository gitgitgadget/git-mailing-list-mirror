Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025F13FFE
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muHPHVss"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbb4806f67so5368139b6e.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704208729; x=1704813529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LadBu9yZUO7WoufkTzWssLMYO55t7n02YkccG3lf2Y=;
        b=muHPHVsszSFIBu8+oTTGwYG6y+uRoKuzm/QvrWvJjxrRd9qlnVcG7tVtmeEMePNM6R
         2c4GZCD5uGQTq84frYpdJg1sbo7sxD9BxJV9+/1LwtewxrS/170P6zWBtYun8iW9xLtY
         68s+W1yBfWeZsMCz8k9RJcsDZNAY5WGT3Nl53St2sA7azMbBdrSKGUAdHlSoiBWLG1eX
         kmYZWnvMBVra/I9rQGJtLPaN8Iyfxj7lXI5BzA/gKu/2MdHJw+7Tsh0drD6Lc/QGH8p2
         myDZWgeiFnVOaFLtdjQIxDIJrZACK+jqEku8uxS53aDBw0MEAS2S2HViFb4k/2DOpEar
         w/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208729; x=1704813529;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LadBu9yZUO7WoufkTzWssLMYO55t7n02YkccG3lf2Y=;
        b=HfpRaDLBfO82Jg5KfK9wgIQ/Smm8S+waeVZ7dtIP/s07VsGBBj1RcXuHTejACIzLtB
         rO+mBLWQ7JYrV00YJ3A0lTpVSy7oXbMmfbOzB1PNc8tk464gYqk+qaJaotLOPbc9RzKF
         hpJhHFo0y4/EShTtVVjw3c2e9Tlc0ombVWOSo2MVci+/UWznxiGQwHfm7toHsPyOufOA
         sgtWDWhfd2lPAVeWrv8M5K8mGCfLU/BbvqsJqUAMtPG9jKx5V43M7dn5iKdENaOwlDE5
         jm2ZVO72bAB+oYJ6+ILhD0H+jBKHVG9GZRqkN5vowKfpuDUKu7oDss7GPwf4Nc1Zj145
         dLhw==
X-Gm-Message-State: AOJu0YyRjTIcEdHUupbOoqvJUgos3pv11PWRSrTBfsYpOc11YaCNCoF5
	cmrS88vJ7Dy9KXEJV44+oScl0MXeSckjbbq4sAU=
X-Google-Smtp-Source: AGHT+IEQtaUg2yEGTKSXGxwqM94/DBUCzNlDZuCH5dEZ0YE7hzbV7KdK/ghjrYT0twlw9AuINF8MD2a9FoJ1N+Qd1NA=
X-Received: by 2002:a05:6871:2b17:b0:203:1c85:21fc with SMTP id
 dr23-20020a0568712b1700b002031c8521fcmr22087235oac.57.1704208729012; Tue, 02
 Jan 2024 07:18:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jan 2024 07:18:48 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqsf3oj3u8.fsf@gitster.g>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com> <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com> <xmqqsf3oj3u8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jan 2024 07:18:48 -0800
Message-ID: <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ea91f1060df80395"

--000000000000ea91f1060df80395
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
>
> It would not begin with 40-hex, though.  If I were doing this,
> perhaps I'd say we should first split is_pseudoref_syntax() that is
> overly loose into to classes (e.g. "caps with underscores that ends
> with HEAD" and everything else), silently reject false positives
> among the latter class.  Then we rename those that are misnamed
> (there should be only few, like AUTO_MERGE that should be a
> pseudoref but named without _HEAD; I do not think of anything that
> ends with _HEAD that is not a ref) over time and drop the latter
> class.
>

I agree about checking the contents of the files to filter out false
positives around the filenames. Alright, this seems like a good way to
go.

Summarizing, we'll change `is_pseudoref_syntax()` to
1. Check for filename to be UPPERCASE including '-', '_'.
   a. If the filename ends with _HEAD, we return as positive
   b. Else check the file content for SHA1/SHA256 hex

This still leaves out HEAD ref, which is not a pseudo ref (since it can
be a symref at times). I'll figure out something there.

>
>> While you're here, I wonder if you have any thoughts on the last block
>> of my first mail.
>>
>>> Over this, I'm also curious on what the mailing list thinks about
>>> exposing this to the client side. Would an `--all` option for
>>> git-for-each-ref(1) be sufficient?
>
> "list pseudorefs in addition to things below refs/"?  Sounds OK to
> me as a feature.
>
> However, "--all" does not mean that in the context of "git log"
> family of commands.  Over there, it means "not just --branches,
> --tags, and --remotes, but everything" which is still limited below
> "refs/".
>

Good point, I agree, usage of "--all" would clash here.

> As "git for-each-ref" takes pattern that is prefix match, e.g.,
>
>     $ git for-each-ref refs/remotes/
>
> shows everything like refs/remotes/origin/main that begins with
> refs/remotes/, I wonder if
>
>     $ git for-each-ref ""
>
> should mean what you are asking for.  After all, "git for-each-ref"
> does *not* take "--branches" and others like "git log" family to
> limit its operation to subhierarchy of "refs/" to begin with.

But I don't think using an empty pattern is the best way to go forward.
This would break the pattern matching feature. For instance, what if the
user wanted to print all refs, but pattern match "*_HEAD"?

Would that be

      $ git for-each-ref "" "*_HEAD"

I think this would be confusing, since the first pattern is now acting
as an option, since its not really filtering rather its changing the
search space.

Maybe "--all-refs" or "--all-ref-types" instead?

--000000000000ea91f1060df80395
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a54ca098ac9fa878_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XVUtWWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXZkQy85RFZZT3VtL0NXaElHVHZCN2RzamZhZUNCaAorSnJGVEZRUFRq
K0lUVWMrc1ZLMFJBbEIwU3ZMRFd6SjhXWjdtSTZ2TnJFUy9QOHNKb25kV251RWhtalZybVY3CmlV
Kzd2Slg1V21YU29KdE9paFBKRzUyNHpUdENaWGVtSzBlYWxLYi9KQ3NjQ3NSR25heWtWYzM3N2xW
aTU3WGoKbDl1Ynl4WjBEYm9uU3BRSC94ZVZSU2tqUFhXTXhpdnR2Yys0UE1XUDczR2o2NnEwMDUr
RnQ1OEtxUllQZGNiNApNZlNvY1FsWXlQZTN6U1FTSTF2eGN5bkhFMllsUkFXMUlVZGlhdHBUQ3hN
b0V0WHJvK2drbFZPWVNRT1pXdlVOClZLdHR2ZUp3aHJkaHVHQ3MzMzV4cXIyNHJFbjNiSGZ2SFFo
enAxem1WdTkzQnVSa1hRMmVFTnlwZGlzWXNYb2MKTE1iOUYyVjdiRG5QWVZXYkdENENmSWMwajhB
dXpDVVBVczNZUmx0dmFnN3V3bzFwZ2o3a0hReHZ0cmwzQlpGVApZRWgraE1LYmRWUWw4L1RzbUVC
TXV0TGZ0OVE2K1NidURwVzdFd3BOZ0lnOUpFcTg5b1NqNm00SVhqb3ZXdXNDCjkzQVBPaW5hZDZU
TUUvOC91YXlRbG5hNloyWTZVelpzbWJNTjFLbz0KPW9DK1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ea91f1060df80395--
