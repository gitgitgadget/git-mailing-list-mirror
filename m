Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778869;
	b=Bh76ck6gn1ZvZwrbX5PIy5PNWh29HezOifXCYQOlkEDxdHW5ddef0dXKnIjEHbDParCJ
	 bLxqyRaZNt8phRPiZCn/MKWfBNh9Kh1PcWBt1cYp6aU+vnOP83tT7rIvTnsxNiR/5Swr9
	 d/bXNDRr9e001US1q4PTk5ktt7txTqUGQJP0TbvCY7xQ7joPh/bmtyuwUyeykQndSF9Lq
	 q6Ed81O2kAbTfUYUk0vGvUL7NZemGL73N2PmtWQXAv8bsnx4IjuhZwNugzwW/gMMwvbSV
	 GucX+q1KkotAbdh8nLFVRolyFfJSTFqc/dbQPmtJ3f9I9B62umfPGHUk0dryMxWzUtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=KrjNvnLBPpjpieggAYnVMEfVpVfYNlIUM7mGEtv7uwg=;
	b=wfHGMyBhVgg3v8sq95kwwZxzgqNVBEyODSQXwplX2YRmKAbi1WI475IUNQmdvi/gGgmB
	 IshGVcTT6XiKk8f3qx6Hc6PW+fMc/rPEK1axWsZzCrDDLq8v/5nQbXkhhKDGAoLtqVpZR
	 OkV3XpBa2WIzqmZuNeksHIcP+8HPu6m3mR8BHPr/ZUyXPpKS2jyv2nXTM1Lty/8PzH7M7
	 xyvUrl7pnbqfAz2iPSzufJUrrQck2XiJG2xAEYu4wdZn/qOHVJqFzj4DoPI8QCQs2+Pem
	 s/H9HzaBc+7vlK5kYn6Bt4XI0OQOghsdW2SdmZ2y+KGFTn8e/dggpET1OC0rIL56kFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rk+PH5EP;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C1606A326
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rk+PH5EP
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679334baa1fso1298057d50.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778868; x=1793383668; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrjNvnLBPpjpieggAYnVMEfVpVfYNlIUM7mGEtv7uwg=;
        b=Rk+PH5EPjLETV56mG35d2j9GQO6NggHWtctAp0+5/nfzuQ5pBjI14HuYQ0E9a9eA0D
         L4NwziNV77Wo37GJWaR8h+Wiv7rlm1ooc9E5R+G8PKv1BOrRA4OKU147TR8Xx7zBJmSJ
         mky/XDGdFPdfr8anxG5pCQo9g+GkOlIMUbx8Ho2cW9R4LSfF1J7cGmXfbhJi3sfgzqyW
         CXD/1rKs+ZfjJ8upjqr4daMLzHk9jV1S9KnY0gzU5unQHAChKBdxNwdfWywPTqPPYwTw
         hMjRGpcnm3QogJHvxCFWj/dfgCbmVwMF6SDC2hSZCf4O+bzC7jnqphnvmnKfg6B/LfFT
         WkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778868; x=1793383668;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KrjNvnLBPpjpieggAYnVMEfVpVfYNlIUM7mGEtv7uwg=;
        b=gg+pDdhIBP3WIZPqo1CSln9Gy4tFZMUnD5wybxYDreXTLkzHFeClLECDyHABjPNH+j
         PMGCfJ7P/HGCxUTMnnhaXCl33dGCOlu79osZprketbhXhCM3/nVFlf98KZv4SiogUrSW
         9Qe6cEuCsdQFjdHT+4CWAGuVYzu/NOWIO0l+tK9uoCHlG/V+u+QWlGeLmU3qkgyjOGPq
         51mK80ncDhBX6kIBvNoXUXmCm3v8hYOtwH93sHDqrkQUg22b0R6FyTHFLTq6lZgFL9+r
         Baf0gNOKK7L80Z/z581mHGA1nUDdRyeO/KrVGFIazWKwOiXQ9VnWr4JdZ/r8djmphNkD
         mZRw==
X-Gm-Message-State: AFq9FYK3aAKn7cqjBUaosMoj9gk+RLf+57hUuCJEnJ6MdkAIG1KI/1u4
	Fjjy7vKOMUT3uwjmT7hpnu/Xf0eQDwqs4Iis87BPXw0opef6Wo7j/O24
X-Gm-Gg: AYBFou0qWwMuqoRnOdwn+jcuNeK6lYLZnrIF5cGZRkEQF+JUSmHhjLGetKtY/wC8S//
	e5xCVk3GPuMnF/3sQnmP2up4jj9qyBFxIQ4GZfeaFg6B49dFp1vxKQBB/14lsXffV0CI9/CALiJ
	Xto9l6wcn/6n6byW/SMAX3oJ3OgiofezG3P3sLRJSAlhMkKLWmZVDBSPbAcxY/d9xZmcsvZhq3Q
	3grk8JSTj/Ibxt3Jg6rHksc+F1yr8vxFA7xP3lEGnlDzobHmFCktSKNgWv44Qq2MMMI0oPF0/O+
	Cc4Va9CJFywYT+16kTwyRTG+Byk4I3iYeyYTksZ76gGxI7uu+jrDXbZoeFKoIr4kVaMZn9Tap0S
	aZ4GlYR/ixpW0OSQxUW6uFRWcwL8mN0Iu9fOL5BLn+9QC6W2KHLr4h0WnK8nFSlkstgmXV1Mog1
	0b/iYzgQF8ehVwbNuxWDRD0gmWWQ1aJ77/kJAb91RuT9cOe5yjbpItNiiGmAzQF++9fa+9qLdAw
	Hm6BlFn1XAGH7CxJpQXdzHKvF0VeU/NN6n8gJC/Be/T5G9EHjbEiDMbrC+OAlddw+8lUM5rVWmy
	38pPMjftVhR8p2anxbQLp0RC4+58phVA1UqBMPhnhDMhfzW0ph3WtkF11dGRynjGULUEtk975ic
	pR0NoNsX2j1qMhcr83/X5PZaOPg==
X-Received: by 2002:a05:690e:1905:b0:679:a4ee:84c3 with SMTP id 956f58d0204a3-67a35c2ac1dmr1654785d50.99.1792778867790;
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:1d:477:fbde:1358])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a42f001c1sm290312d50.15.2026.10.23.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 5/5] completion: drop "stash save" completion altogether
Date: Fri, 23 Oct 2026 14:07:36 -0400
Message-Id: <53FFC1C4-1569-4A9D-A1B7-B60A1BF53DF2@gmail.com>
References: <xmqqpkx08hyk.fsf@gitster.g>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqpkx08hyk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 23 oct. 2026 =C3=A0 13:06, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
>> deprecated in the man page, 2017-10-22) and the previous commit removed
>> further documentation suggesting to use it.
>>=20
>> Since we recommend push instead, stop completing for "save" and remove a
>> special case in completion code. It still appears for "git stash <tab>"
>> when GIT_COMPLETION_SHOW_ALL=3D1, and when typed explicitly we still
>> complete options for
>>=20
>>    git stash save --<tab>
>>=20
>> which is helpful for folks with finger-memory for save.
>=20
> Well, if we can replace the command line to "git stash push --" on
> the first <tab> and then start completing for "stash push" with the
> second <tab>, it would be superb.

We probably can (I know Zsh is capable), but that means
more complex special-casing ;) I=E2=80=99d rather get rid of this case
and leave that nicety for someone who=E2=80=99s motivated to get
consensus for it, which I am not.=20

>=20
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
>> index 697fef5462..9cd9c7cadb 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -3558,16 +3558,13 @@ _git_stash ()
>>    __git_resolve_builtins stash
>>=20
>>    subcommands=3D"$___git_resolved_builtins"
>> -    subcommand=3D"$(__git_find_on_cmdline "$subcommands save")"
>> +    subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>>=20
>>    if [ -z "$subcommand" ]; then
>>        case "$((cword - __git_cmd_idx)),$cur" in
>>        *,--*)
>>            __gitcomp_builtin stash_push
>>            ;;
>> -        1,sa*)
>> -            __gitcomp "save"
>> -            ;;
>=20
> Nice to see this go.  This would have been maintenance nightmare if
> left forever as we will have to remember updating it when "sa" no
> longer becomes a unique prefix.
