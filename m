Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33126335BA
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779891; cv=pass; b=N5YTmhyF3yW7EyulKhQbXtflB6t5JYoYh7u//FdWU+xEkr/EJ5OTIXhy0hsSILDapy+XkVz81TmkFsAQGDBY6+wgOWr2T4/ATAyfN9SIJChjDc04myYA3Z1Y0S/aRdhYD0lKhRmw2ZHWuuJtpDA/ipfUn/PXm9LtUyPfBWYtqh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779891; c=relaxed/simple;
	bh=GfTG7M4irKus2uZBru9HaYQswxpMwhjpnwH+42kIdB0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8ZqVaQvFDUb+gLpZWtCktTpuniD/5uE05r66O4scBmgxJ2KWNFWv291cG/gfYUYVsppBmUcXx7tNwZitDOBrJTize8okXC6XEVODm1AQzgSqsSKFugfn7tlgK2vEuppGUsDmmztoLxqxbVrWUUCh8QjV6bDPbTA8bWFhVkGyBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJdyVWXV; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJdyVWXV"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948aec218a2so951291241.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:04:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771779889; cv=none;
        d=google.com; s=arc-20240605;
        b=Aq04WFkpMmGpL+Scd69DYyGansRx8wtMCXyM0L32hvbvxkZv9F0J3ainy5MktbMK0Z
         P39p7I/Oc/ixWvJyYOM1EgjcyV0zTwNv8S+OuZV44ymfUVvgpwTiUa7uAlHQ1iYg3pn8
         bzj3Rz6oEnQ+AvbO2hYwZebtSr2P9vEfRhOKcTW2XlhQGeFYc3rXB+ZL9qYChW945GhZ
         SEieQ+aFwThIAPSGgyybFSCoYGyZmJjtYG2c6rfxcYBCzp4zJ1uNtrz7ButByrwimWqr
         vKPJE5Vg/2ab1dV9n1L5PWoyu5ojl1mVB4xUEbE7UhE0qDx7RdBHGIAkAmCV24ddKOWs
         aUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZX57e1bHN/kgrRCl31HOE9lAkdUM2dkA72XmtXvX7Nw=;
        fh=V7iu0p+2fxnmv5oNVRFBVcgdvkW8PQdAQbrAzTbQ0So=;
        b=h1LBHgryhD3eU7mqnoZe7j5ABGpjuAQylTTFszaDA//IqwnnWt/jgoqmkkCmJpgwHl
         nUoSfTTbCMir3vnveRFxWyVoV1P2hh9bF8ilfvnnZG7Rxc7kddsQ7DB7uFs5sjzxnuz7
         ZF8FDjEJl9or7MP1k8+4jj/2Q+/VPNQND9uQwRhO08bi/G8SvgqMqbALjr+ARhdPZT/+
         xL44XHooOEkxb/VvhQ3Nsd8KTNx77/H8GJk3L/0hdrVO3q82iRl+yuTGJGq21MrZJc9A
         mJdd/+9iJArT5/U3esrSpTD9eXC4q96DPM4cuBUI/Py00Ei/T+cWy0AssIzJbwZt3KY9
         HK5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771779889; x=1772384689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX57e1bHN/kgrRCl31HOE9lAkdUM2dkA72XmtXvX7Nw=;
        b=IJdyVWXVZM1jj04qo6CA8wru4vLWCgR+hSqmeiGbFN74ks7lbxqgmMGucbjo1bidUW
         btm9PLxqmSOGSZXyz9TBD6VYpdhElKB2I2l/d2zbNTiibHay/lvZxDPVjveHFGnJZOA0
         +EVagB4ghoJx+ZHNd2H6kESugoromG9BCNT5qiZCuo/ZdGK+zpPonfvm8hvpZCppCXrS
         Joif3bfqbbU2k/mnHtAqF0lahp534X3xSsIykj7HuDKs7nxRaUKW6Trny32+w5iV7J1F
         r8NOAj5+i8Kgl9jZpHtsqYCL9A+ZAFxFVmiNlpJUiXIgYMpVhRi3AotZ7m0tqV5GPGBx
         iHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771779889; x=1772384689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX57e1bHN/kgrRCl31HOE9lAkdUM2dkA72XmtXvX7Nw=;
        b=q+6t6FeSwx11nCCw62pYqEtmULpWDgDFQs8pDtoDsO20O42GoH526TiNshgdciub8W
         lnLaKDicjrBxvx02Ckl3ttd/RBcCN5ulbSzKG4JKmGbSHl9F4W3l6SCb/vUbh2asbX+b
         QnFtN08DblHgaP5CV8USqqS2xAxNWgpFe+ZKnc1VAgzTIfzpyEGBvBYSXwSPjjfooTrY
         Y/SYmAYXw4hpVrsOqonzuh+E1sbjkwLlkotHGSy7JhTi79VFNzieT5/Q1vWm4BJSgT5w
         2tVU99ZNdhqIP4H2TvK2TJcautlw2bna2YuoEqDdSKvCtXSFmSRBhiP4cQVvrW9kJ5tD
         o1TA==
X-Forwarded-Encrypted: i=1; AJvYcCUudkk8AnA5ww3RTdxbtzSy3afT2rEFHIyqkjbRLr6LrjxawB3G5PTDHaUkyjQkbvQ3qMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWJhhAJtPEHzDAZNwNwjMLqgMLAcfJbmbR6qEZlr+1iJSr7h+
	3TZN5SMsJrH4LTeEcRZlcCx9wscjWuu5gkYfzO3exj9WccugZt1LSvMge0PiCEqY7YVHyayldNV
	71xTq3bw8Jqdu08S4ACF42DOptiit7TE=
X-Gm-Gg: AZuq6aJyDVYEN1q0ZPBmAngbuOF2JD4JV0hBrLSl5UGO9tYLbXn0NtOe78AqmdwFToE
	JwbkmWcDs5i6UptzpgZjAFkoN/jDNS7kHDbyEEB2EC/F6Os8mk0gkjgB8yErqh0XliTiU11CMZV
	jrqrDR61trNtSfehferiqujt+e3zNFs2U4yQTQwx03p9SwkiFrMHZmVJLO+oih2hfVACHlFWYuz
	xSyMXI5ZaZ4IFlEvhS9PgNkzTcWVQdbJzNn5yx56cbMzglrOdhSXbt9J8gy6pRq4Y8tMa0lYOF8
	ZkZcA1hNUIORuMCPrhVp5zvI+HcHYC/lPBtYhAA=
X-Received: by 2002:a05:6102:26d5:b0:5ef:2cb7:b6a5 with SMTP id
 ada2fe7eead31-5feb311e736mr2197229137.38.1771779889087; Sun, 22 Feb 2026
 09:04:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:04:47 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:04:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260219112149.GA3529@coredump.intra.peff.net>
References: <20260215085755.GA86262@coredump.intra.peff.net>
 <20260215090052.GA695631@coredump.intra.peff.net> <xmqqqzqjckgu.fsf@gitster.g>
 <20260219112149.GA3529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Feb 2026 12:04:47 -0500
X-Gm-Features: AaiRm50--ZAvhdNF0JBk87RtdTnCFVy2wZpH-J3Vow2l3wwo7pEpl11JIDfDG3E
Message-ID: <CAOLa=ZRr-Oa-aSzMBOnKWdyjMxuo6cd6mpcCydDrN7SMe2ahjQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ref-filter: factor out refname component counting
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e9016d064b6ca6e1"

--000000000000e9016d064b6ca6e1
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, Feb 17, 2026 at 10:07:29AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > +	if (len < 0) {
>> > +		int i;
>> > +		const char *p = refname;
>> > +
>> > +		/* Find total no of '/' separated path-components */
>> > +		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
>> > +			;
>>
>> Sorry, but I have no idea what this loop (copied verbatim from the
>> original) is trying to do.
>>
>> We start at the beginning of the refname string, and while we are in
>> the leading run of '/' we increment i to find the end of that
>> run. E.g., we start with refname="///foo", p points at the leftmost
>> '/', i runs from 0 to 3 at which point p[i] points at the first
>> non-'/' character, at which point we do *p++, to make p point at the
>> second slash?  Is the dereferencing of the pointer in *p++ a no-op
>> that is there only to confuse readers?
>>
>> And then p moves to the right until p[i] points at the end of the
>> string.  It does count the number of slashes in 'i', but there is no
>> satisfying simple answer to this question: "what does p mean while
>> this loop runs?".
>>
>> Anyway, the conversion looks very faithful to the original.
>
> Heh, I missed your message initially but was independently staring at
> this because Coverity complained that the dereference in "*p++" is
> useless. Which is...kind of right. It is a void context, so the
> dereferenced char goes nowhere and it is a noop. But if you don't do it,
> then gcc complains that the two sides of the ternary have mis-matched
> types (an int and a pointer). Which is true, but since nobody looks at
> the result, it does not matter.
>
> Writing it like:
>
>   int i = 0;
>   while (p[i]) {
> 	if (p[i] == '/')
> 		i++;
> 	else
> 		p++;
>   }
>
> perhaps resolves the syntactic confusion. Leaving only the semantic
> confusion. ;)
>
> I guess the thinking was that "p+i" represents the traversal, with "i"
> encoding the counted slashes (so we must increment _one_ of them each
> time). But I cannot fathom how that is easier than counting the slashes
> like:
>
>   int slashes = 0;
>   for (p = refname; *p; p++) {
> 	if (*p == '/')
> 		slashes++;
>   }
>
> Which made me wonder if I am missing some corner case, and it is not
> just counting slashes. But it must be, because "i" is never incremented
> except when we see a slash.
>
> +cc Karthik, the original author, for any wisdom, but the commit is now
> almost 10 years old.
>

I'm embarrassed and frankly don't remember this code :) Your new patch
looks sensible to me.

> Is it worth rewriting to the "slashes" form above for clarity? I was
> afraid to touch it just to shut up Coverity, but now we have two
> confused people.
>
> -Peff

--000000000000e9016d064b6ca6e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c992ef7297f19a1c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tYk55NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzdkQy85b2xpSEduVktvcWx1cHFLbnlXNVpDR1R3Sgp3c0toempReHZj
c0M2Wjk0VjNmVldEYURYMnZyUzlSbVRNUWJkd085RlpueTNwank4M1Uwd3Z6aXBzeDl5QjNOCitq
L3hVREdJNG1tY0d5VW1tMmtLbng2UExvOHM0ZHBKb0lzeXNLS3h3c0pJQjMzMzBNb043T1VIRlNp
L24xWWoKMmttZEp4QWM5NWN4ZnpTdVRTYU1venJvM0ZXYWZUcWVydzBsM1lKeXhPSUJSdW5oQWVD
ZmNrQS9Wdk5oVDN1MApFaGM4cGJJRmFGSnpLcW52cUdPdTY4ck1ubFlEOFlEazZkMngzVmorQTNG
N09MWmhFWlE2YkNqZlk4aGI2b0VYCjBGSkRCTFFjRCt4OFg0NXdWRXVOU2Zac1pQdjAwcm04WUZ3
S0ZnT3JXVXA3SXoxYlQyVnYzRUsxa1luNHRENmwKVlk3TXd1NkdZeDNxdXovNHZPNVVmSnNzL3Rq
ajkwb3pQMW1nSm1xYTB5RTZ1NjZVeG92VDk4eTFqd0czRzBKMwpZaHhCOWZYNEFTNkdScU5VUjNR
dG1BRnk3Y1BJdEsyODM5MzRJMk1SQWtsaVVhOEZJZEZHcmdZYkllMFFZMUZQCnlKQ1JValVWaDFO
ckg2VTFHT2YrUTFrem1LZGEzMEh3RnpnbFRuND0KPU8zQzAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e9016d064b6ca6e1--
