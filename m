Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1F37A487
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787506793; cv=pass; b=QObfcThlrQGgCWeCvms4AohpGhZ87rVVx33cw7ikVZ9tbMW2Kac+LotdW/z8jQgHCNlRP4zCvaQkZz3xS+G9ep+1c+XDCuY0usGEnkr+UD+JZz/mnOsTdkh81dSp6eEecMk6Q5z4+8l9CzU65i0AuaoXuDLSY41anJ13oSlRuWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787506793; c=relaxed/simple;
	bh=/TVhlSf/4tEcOpJnNdhGTyoCRIDrOgc8ecl3dXTW/Kk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNhoXDQf1ikwXlpf42nF9lCi23K5/0o8jtdUsAPqFIWJ7bykMrQB35vN+QK1pLYK8UCs9GOqoh4aJMEh08v4pcd93UJ1FceNx8iaQn1K/LMKr3qV7EK+aUH5CAyEUEipDBshe5Cqk1kLs2pQs0Y/HEZbRB8XQ5VM6j62XWZmkLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX+bj0ai; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX+bj0ai"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-75609e844faso1990321137.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787506789; cv=none;
        d=google.com; s=arc-20260327;
        b=sMa28MpULA7be3lPJf86QCG4PoxgXwWbshuN6PEgepNYYNDlRHNq0fLKJRcA7YBQ8u
         +SbxhWwnjgGPiek1X3Mf+0hgfKzCkJFNMrGtHvoPQTrvceDPCGOyfPAJZUCEDvi6XAD+
         Cs0ecqoOXZD+MDHgO3eZXOx602EZDmmT1kcO8L/n818O0gl0JeMrsb9Hs9smoxzvOXqx
         6EhF+3u5Re+PhmchjK2J+H5VqEHZGhOfKiq8FvkdTxoOvxpTnN9G5lmVhqpNs0T7ks1E
         2pQXHYOrCTCan2dN161sLDIWuRrFfGPXrWxm6PPQ4qxUNWmDme9P/RTegRXoejYOCjhB
         pUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IN309+rH3HpIwjIcDUKVH+3Jw/kUl1KX3Mzdsnz3gRY=;
        fh=j4RL08xKTOrt8zeEZMPZNsRXOjiCEB3mbvHjNbX3qoo=;
        b=CwgYczIYNW9goOUlVGUyzmWieKhtxX0Xn2Yl34BwNmp1i4VhSL9yJCdg99G+paOPTm
         jkwxm8w4rQoE5EIhf3NUjarZ98+q++0WWG49Bm7aarHzFZpOUoSB4Ya4d97/VT/2/ZJh
         D3Z6FirgPLpJRNIai4/OTKc1GyHVR4y/4hXEMKAd5rBERFNTu1G+u9bISck+sICL7M0I
         mtqiBncHDCX+2/A16bf3CuuofhJRhcpVykII8UTH3iY6ceHgkFyMCNjAS4mpZYzrjGPn
         oGJ+okppM8w78uZHpMqMSIqD9d6jOzVsicy3byXmstUvBfF7/Bw1dcrrG+UJNN/Q38jJ
         dpBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787506789; x=1788111589; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IN309+rH3HpIwjIcDUKVH+3Jw/kUl1KX3Mzdsnz3gRY=;
        b=FX+bj0aiyjF1c0MubjK05arM1lCv1zo1f0ev4yRHjM+Y1UvPLVkL0CAE4BHBwkR1Os
         elnHZg8X2CbiGRUz/N/lNkSEAV2/wTXPVn5vxErsKDyPNcLC1jDhvJJMO0DWFoiQ7zMX
         YbEaV84FnoS3UgTsDyKJhFDdwAjs6kGTqtMk5KZKOGP9PR7gE/SP7rqdwrSYjsGV6xmf
         oNJer+LQ1f3hfu6+8QNqeffehHpvl7MzyCiaAnJHvUwbnbInZd7GN3qCOZy+yhDbcYe4
         OIViMRqv7orrBx5JYvJLJHF3az+aEE/+3EmpJ/I3i4spcraVcEAKwK69xfeP1P7AQNVK
         4NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787506789; x=1788111589;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IN309+rH3HpIwjIcDUKVH+3Jw/kUl1KX3Mzdsnz3gRY=;
        b=aTxaxPekC7jrWE1289BearyMYjNkRu77s0bOvRdnSHJtzxrOlwYpAMVE/PyDkOnog9
         s1U+R5uoFvg0peM1zB46FNWofbYVojrgkwNDoA/kwLX8WFIAodTAkgmgyW9ZJ+7DbS1G
         g2HZ7kpS23YLOOwza6NsfKvaY+lNbhdaTFDBWJ+U1dYK4pc6EEp35G9UkvBglbxIYcZR
         9DVMm7q3baUwDl6AMtLygvYzpAc6+iqzSHimuarD1lngdTEojZC1DiLhTEdiqYZ6ZEVj
         CS1Ci5mbG+2LHWQjvV6KvWW2JuWG+01+ALzokK0IEg+aVXtHYjvxPUmSbp6yOD70RTP8
         iC2w==
X-Gm-Message-State: AFuF++nyay9Gjxp5kXl4QQteDUY11MMxNNRheQYnQkAvBfebv3p2qcw+
	HEPrN1Fn7B3vLofXzz5+BhYN9SuyhUlH0uQfDUD6JD487wRIGKiBe1U79N8WhQ2XWsIgHDKT0Gc
	GDeKL6cTVOPW0oErGc5oj3LuJoK3G8j9eu12V
X-Gm-Gg: AR+sD11LGPvli5i0e1bEVS1Ynpc52edGRirmDyGdVg2PEnTGTpipSOm6jO+M6YVVr7b
	4GZYBm7b2za1A4RrOoIIqFvA2mdFPJjY+Rgz/EW63UVSoCY2fq5pFlwpOSHzo9z0ZbAroLOU5ID
	pslRSaSm5kUNYjzU0T4vXIZNiJE4q25c9sHaDq4SAPATexlXfiiZ2mYFkjSSdyqBckmmRh4H3jl
	VxhR8+6R6IBChYsB0L/hDoy0MpMS5e5We2snD6krgx0dXzqqVDnJtGnAwXo2Vjv4yuJAqXhOxkw
	kQGZdyAXsCdzrdeGkRTSnju39V1wI7uKRjHZcRfbKU/dTOca8llwV8pJsNecX6OklyYEt/v0Udg
	sUfEb9YLxcPmIFSVvq6mx5hFiqTV7PQUObus=
X-Received: by 2002:a05:6102:1594:b0:77e:7010:7f2c with SMTP id
 ada2fe7eead31-77e7010a8d3mr94170137.1.1787506789275; Sun, 23 Aug 2026
 10:39:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 13:39:48 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 13:39:48 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820075342.GA2761530@coredump.intra.peff.net>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
 <20260820075342.GA2761530@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Aug 2026 13:39:48 -0400
X-Gm-Features: AcwNN1XDtEpDYEDsynmBy3DDZ0r1_7DFmIuTh1J8kn8u3rEL6HSbEMTMhA3iM38
Message-ID: <CAOLa=ZQpeCKzQ3EVXQEhfxL1khUH0YD6_Kc1qDQhxoN926rsBw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable/stack: avoid reloading the stack when
 already locked
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000357aa30659ba5bd6"

--000000000000357aa30659ba5bd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Wed, Aug 19, 2026 at 03:19:39PM +0200, Karthik Nayak wrote:
>
>> Benchmarking with a fixed, non-symbolic target OID shows a modest but
>> consistent ~1-2% improvement in clock time for `update-ref` across ref
>> counts ranging from 2,000 to 100,000.
>
> Interesting. I get ~25% speedup with this patch, doing this:
>
>   git init --ref-format=3Dreftable
>   cp -a .git/reftable reftable.orig
>   seq -f "create refs/tags/foo-%g $blob" 50000 >input
>   hyperfine -p 'rm -rf .git/reftable; cp -a reftable.orig .git/reftable' =
\
>            -L v old,new \
> 	   './git.{v} update-ref --stdin <input'
>
> (where git.old and git.new are builds before and after your series).
> With 50,000 refs I get:
>
>   Benchmark 1: ./git.old update-ref --stdin <input
>     Time (mean =C2=B1 =CF=83):     125.8 ms =C2=B1   4.4 ms    [User: 91.=
2 ms, System: 34.5 ms]
>     Range (min =E2=80=A6 max):   121.0 ms =E2=80=A6 135.2 ms    21 runs
>
>   Benchmark 2: ./git.new update-ref --stdin <input
>     Time (mean =C2=B1 =CF=83):     100.4 ms =C2=B1   3.1 ms    [User: 90.=
9 ms, System: 9.4 ms]
>     Range (min =E2=80=A6 max):    95.0 ms =E2=80=A6 106.0 ms    29 runs
>
>   Summary
>     ./git.new update-ref --stdin <input ran
>       1.25 =C2=B1 0.06 times faster than ./git.old update-ref --stdin <in=
put
>
> And it seems to scale down linearly. With 10,000 it's:
>
>   Benchmark 1: ./git.old update-ref --stdin <input
>     Time (mean =C2=B1 =CF=83):      24.2 ms =C2=B1   1.4 ms    [User: 17.=
1 ms, System: 7.1 ms]
>     Range (min =E2=80=A6 max):    22.6 ms =E2=80=A6  32.8 ms    83 runs
>
>   Benchmark 2: ./git.new update-ref --stdin <input
>     Time (mean =C2=B1 =CF=83):      19.2 ms =C2=B1   1.0 ms    [User: 16.=
9 ms, System: 2.4 ms]
>     Range (min =E2=80=A6 max):    17.9 ms =E2=80=A6  25.8 ms    135 runs
>
>   Summary
>     ./git.new update-ref --stdin <input ran
>       1.26 =C2=B1 0.10 times faster than ./git.old update-ref --stdin <in=
put
>
> So 1/5 as much work took 1/5 as much time, but we still saved 25% of the
> relative time with the patch.
>
> I'm a little curious why we such get different numbers, but it may not
> be worth digging too deep. Avoiding unnecessary syscalls seems worth it
> to me regardless, as they can sometimes be more expensive you expect
> (say, on a networked filesystem).
>
> -Peff

I can reproduce your results locally too. I was a bit stumbled why,
I was using a modified version of our benchmarks repository [1], which
was using a fixed static target.

The difference was I was updating 'refs/heads/*' and your script does
'refs/tags/*'. The difference is in `should_write_log()`, where for
LOG_REFS_NORMAL and 'refs/heads/*' we shortcut to creating the logs.
While for tags, we do a check to see reflog already exists. This causes
a stack reload (before my patches). This shows the significant
difference in our benchmarks.

Funnily, I use 'refs/tags/*' for strace, so you do see the diff there.
Will modify my commit message to reflect the benchmark :)

[1]: https://gitlab.com/gitlab-org/data-access/git/benchmarks/

--000000000000357aa30659ba5bd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 71d2cede9c79fc37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xTE1HSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1BCQy85azB1a3ZWc28zVnpGMm5iSW5VMVpBL1Fvago4djR6eE8yTlJI
aTcralJWWXBGbCtjOXM5N1NLOUdQUUc2Nm5NR0haRXZQYVcyWHQxdG9wZXN3c0VIYkQ3SEIvCnht
VXZPNDdCV1lZRkFtMUVxRGd4bzFNOTltdGZsU2xDbFUwTkdtN255YzNnUk9QVnZnVlBTZTEyUTlr
QVV5d3MKcG82Q25wUmhaSTkwMlZSYXBZSmw0clVaYWZsY2hkL2UxZ09SYlhPdzVEUWViK25JSWlM
cHFpaDE5RWNvNDM0VgpueUlTOVFkRWlqM1FwUkc1N05aN3JWRnIwN0xjUkw0YTFDeVhkUUhhbmVO
eXI3YlB6YThKMVdIR0VrT0tFUU1aClNGODVZYmQwS0NXTzQ0MGJmenN3U3dCbER6WitCZW9yRmtR
TGlxS0E1OUMrNFJKU3FTeXlIWGthQjRna3QwWFcKTW1FVFlsT0NNTWxxM0tHY1ZlMUZ4clh6OUNU
V2NDK2N3VEFjODhteThIT2hNWUZXeGIxU2JxRFNVdk1TN0Z5dQpYLy84NTI5WCtOb0pnL25DQXBk
TzZyYTcvcVRpQTdNVm91ZTBPU2tTbSsvaUU0TkFXU2JzekRsNnBmZENFcitiCmJMZVF0ZDVuQUMv
ZnFQcWlaUERZZ3o4clVJdEU3N0diUlZnZTdCUT0KPS93WXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000357aa30659ba5bd6--
