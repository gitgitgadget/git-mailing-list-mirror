Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4441F344
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378650; cv=pass; b=eqhaJg47LpejqL0UhBtTWVYOOc+XBIx6dVA/EeOPxcLhWo30og7fEI3yll1f8mq7A4EsMgazeJusilVzZgysYWR6O+GIcW7sAy84iY6+5k24BAi0OHgOZDrRk5ffJKBw88DHlualX2B0NESZXdG0likW8HXfeRyEbmFzcQ4Qm0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378650; c=relaxed/simple;
	bh=SRpbMTohHGnhgSThQWnvoA7wz0933z+StgMtIlj9lw8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/962HK/7OETfK1V1tFDacyiibWpIw8wFfQOGw3fSQAismTNg/w38GF7pSpIQ92+G62ZgfnFx27msnaRlpUTyXpHMwa+7RqpmlRjOR7cHfzAmhhfqJU0trrwzNpMl0GwRLFaoNdLmvYC9ZVL9fN5cNmCr0S4PtZnWfxVWr1C70Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbNGGxpc; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbNGGxpc"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e9af41731so308357241.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378648; cv=none;
        d=google.com; s=arc-20260327;
        b=hFvSK3dl2LZXUjhPy/LDs86PM4CkW/J1B2ItftT2FYBf8SUHezjY6aZdJ9up8v5Fef
         eejtJvBXSWSmEWzJRG1xLDhyYNHsuelsPFLXzSvHNtUHlCmtm83TkMY7lrTs+FufrEn4
         9/QNPeFD3yVX+oOAvmUef5Xzw2rCqb9F1FiWQyKuceJIe1siQFXZHjbrYAk2fZHgCF0/
         Wc5ipuyMNk/JF2WLqMmwFBQy9igZqtzNbMRj9PhAw1cGwY2Vm4rn6HnAWEBIfnnTkbWv
         rjzDcKowYRGMTqd37CCqf7sEjecLSxYj4Vl3mIUFgZ4Vo52sw3iUtLaJ2hxRROWwPobb
         nFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3DvcJqsuKii7AHiXerEVmCyh1o/nwZnIcjC2VRHvzcc=;
        fh=ijZexiaW1xrZ+K4uEnEuMQhOSrFV/EQObaDJ2BipXAM=;
        b=P36iAOo55aFNne87WYzMxn3ybnJu4YGSk8+uxxEqJSMrSA9Y8Y4XnwhGCtPhlkwV/L
         fHofHnr3wCaBTHRdZSSgLbSfPzD7Cqn6+f88ZDXOO4p3h1v7cSHH+o0jDp0FrAf80+wN
         HXQq8X6xm5DBCUji38SeBKf1MUaF/O8PVQA417pOqeSTXXVKzRDYmn5npvIygW+5z5Ls
         deF4w6n7ZL/cRn5ln6KGDiQxJVj1AFxqR0s2i9vZTaiHli1J5GJTQbAx91YvxkWu25io
         rwre+Ssa2pbxRDy1ILuIYIs0w5leuGkF9uGhLwNEqmIDzdc+ifYEn+/LPiV51JpEViuG
         eGVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378648; x=1789983448; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3DvcJqsuKii7AHiXerEVmCyh1o/nwZnIcjC2VRHvzcc=;
        b=AbNGGxpc6tjUCAVkodmkbUc+U0aFEkJLCvOqUKyU+wEUaDfmqaRY9B4PjNrg1Wh17d
         YUgAyR+QA6FoWqo/x/l3rOgCL1WupvrL/soFIlf2GPAzw09paAqkvco97eF3wW+wDpNS
         gHB2PIGSDJ2oC5HhIXtWaBk74GmsUKtX3hI+5xmJYwzLiiXIcAQB7O2vGw1s+XJzpzEf
         5ty7l8Da823FcB/dREyEq0xi4iqduSrU3ovo8YY9U9/BPXwvayHp6cQBQSgmlP5UBKWF
         Aryss8kuEr0rLLVz8BjWASEy13dDhUH+FU94cKVrxHKuAHLVxNxfyVZ1o+g5qiddn5Vy
         pGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378648; x=1789983448;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3DvcJqsuKii7AHiXerEVmCyh1o/nwZnIcjC2VRHvzcc=;
        b=m1OQ+zqWmNBYtumVCIkP8o5i/NHnBkh7pgeCGYBzLmxU5I9FM+rC/mmbyvf9hknvxS
         8aBpX3nBP3yivUbqVcqe8J3R0AMHYsSD8HE2oP4Gb38kVjAxqNVAs+Qb/xVTWknj3ApE
         vFUf2ITji5/wewDj3ZQ5Wqi0wfW/ofFgZ/6qmwMCKVVK4tipGksxFnxQ6oZ6rd83ctY3
         2tYRoR7ZMKFBpbb0t6bO1P3Xr1UkZ3dGcnI5c/cIkzdAwCYHzT5HqAEXAYzLm05g99NA
         fEKbwGQLo2puathAgW056MzQq1b6M+Mb5Yf6kYk764z+uwjAp7lLV3IJqiY9SqKj9PkM
         P8/Q==
X-Forwarded-Encrypted: i=1; AKwUvByaO/HgTkl2ZHUecwAByqxoG0x/ailZs1GIVDKReLdXG02ziF9Fqhj7EhYI8M+ycnAETXA=@vger.kernel.org
X-Gm-Message-State: AFuF++kNhSfXl7ZWSgabNFnzH2v9hjQxqnGc7wYv2UbqrmcDXUQkoxd0
	7ddUAUhQ7M95XIYfD3ACpz+krTtFv0gyo1csz8u1ps/MgDS/PyJUf/WoaZXBcLVhyJ9pzw8rlrT
	jNz4BIFELxTCcYLGjkcZQ0bsAYEVst5k=
X-Gm-Gg: AYBFou2QUaMvssWulLcSH7gE6E3G1AvrkJ64beYkBdg+JAT6ASBMH8UnLWvuL2c2nDO
	byV4+zkETFEV0gqjcXOQnwSkNbZhBoI1kcoZI22tvje25QupeQsK62NOWvdy4edMoYr+z2wuIKc
	px+jwK/foFZHegIKSJXUJ5qTHnc+Xr4TxSXjgmzLK++YusrHHNQgynyTVk3/yI5H4DqZKXpRhbg
	ESsO4aQ2EKHrL8VRksKLPBjyBHV4M99Yt6Bq2/7KdhgpgiIFp8ZmdfaIU6nIeJ6eeF1YN7JGiG3
	l0pq67Fkp37p1ozYhDZjfOoeMPDfNiDjiRuq2Fi4n9nwVEDCNjQ8kj6HzZFSBdr9aLbbf/x4SFf
	LAzG7HcG43vdsv2XcaA4gAWvK+Cok4vSScbNmgcDIHkrS0A==
X-Received: by 2002:a05:6102:3588:b0:79c:6276:4cdb with SMTP id
 ada2fe7eead31-79c6285a9bemr41445137.4.1789378647780; Mon, 14 Sep 2026
 02:37:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:37:26 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:37:26 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 09:37:26 +0000
X-Gm-Features: AcwNN1WEr7on4kuMeQ1QKelYfyTFGAZRlf_gQ2J8VH6AWYwxKlq0fjKbv7DHzSU
Message-ID: <CAOLa=ZRxXimh8W-QBJB3VhbHOZWMEfWXB0ST0a=dOi+PNiR6sQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Fix inconsistent ref storage format terminology
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ab8f16065b6e2e9b"

--000000000000ab8f16065b6e2e9b
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
> storage format" instead. And that also paves the way for the eventual
> "object storage format" switches.
>
> As a cherry on top, this patch series also extends the
> "--ref-storage-format=" switch to allow URIs in the form of
> "files://foo/bar" to bring it in line with all the other ways to specify
> the ref storage format that already allow for URIs.
>
> Changes in v3:
>   - Add breadcrumbs for the old names to our documentation.
>   - Use `OPT_ALIAS()` instead of manually aliasing the options.
>   - Fix a comment in one of our tests that still referred to the v1
>     "--ref-storage=" option.
>   - Print the correct environment variables in error messages.
>   - Also rename GIT_TEST_DEFAULT_REF_FORMAT.
>   - Don't adapt "ref-storage-format.adoc", as that documentation is also
>     shared with commands that don't support URIs yet.
>   - Link to v2: https://patch.msgid.link/20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im
>
> Changes in v2:
>   - Based on Junio's feedback I've renamed all of this to instead be
>     called "ref storage format".
>   - Link to v1: https://patch.msgid.link/20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im
>
> Thanks!
>
> Patrick
>

The new changes look good, I only had a comment regarding the use of
OPT_ALIAS. But I think we can ignore that.

Thanks

--000000000000ab8f16065b6e2e9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ace439d305f7682_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xbndGVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjVnQy9vREdvZTd5Q2hJMW96K3FHVHNLSXE2ZDNKTwpyVWdybkNJRkJL
bjh1eHVpc2RXZUZ5TkNaYTlpbkJFTUZhVElRWk9BTS9wSTRRY2owZWIyQ21xNk1mdWpiUDBNClZK
dnJDeWxMTVlZSUZiN1krdXR5NHFWM2lqVVhxS1JiUXNza0FYSjdWeWo3U1FDRldyYU5WaXZiNWt0
eUMrby8KSiszQXdBU1hKbjIwVGxOekpzbVNlS25RUXFZQUxQZDRlNWQ5YTI3OXlMTS9EYkptSUky
QlUwVm5iSXB0NlNPdgpkRmVvMktUbFVaeWVXZnVSR2R3dVhtR1lmK3ZFdnVzWm16eml0REM5cXht
MVE1V1lQbUpsK3g4VXlNQjVJUnkzCldxZlpWNmtFWDJDblR1ZlJpbkkzTlplb2tBRElsK3ltSkFU
V2poREJlU1dIRS9KcXdwM0VEU3NQUGJ2VE8rVVQKdkZMSkpQd3ZTbHlKTmNkZWo1SExTQUpqakln
RnZBNW4wU1BTUkZaYXhKeENFaUJwS0Rncm1WWnd6dmNJdUlJVAppbFp1M0lJbE9oQk93aVdoRzZm
b0ZOZXlCSGdybFNjNHFQU2lkNnpxQ1k2SVlXSWJZV2ZYaHVRSG5HUURra2FxCkxVSzlKdGFqR2Vm
Qk9pQ1JodDNQcWxDVUkzTW5nRnBkZk82V2xXRT0KPTBKMmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ab8f16065b6e2e9b--
