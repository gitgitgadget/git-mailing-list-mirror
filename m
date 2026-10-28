Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793217006;
	b=b385jU6ysmU9nkjZDrV9XMz4Z0qrcMYeFo2lihqZQ/1ZfVl+PlE//oWDmlZXeBn8tMBv
	 CturtTH60s1S7JogelvN0Kr6d698dKyuCBtSJ0bnn9agYP18Ug+blUyZIHoT4mRcJfJuv
	 1NwmZaTLsXdJHeVKYN49RNB3uh0luvWhQ2AxnCkNsOq7SC6ZMiXdqbUDrgKFopUSBGmOJ
	 7Qk3wE+nJF9CwKcqFyYt3aYQEXLVlQ66akPcAFiCM69bSCz/1ZALFd0BFGns4B2KbIfEo
	 aEkqqVvBK2H6a2Pl/wboIVS8YbydrxVNwvsgWCBVGMlJKv7ubl2EmrrGzUCGgk9yZ0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ykQEdFjksRS9u/D2TVjRBDnT1izVseJdcJyQ2Mo+08o=;
	b=H8U2MGFYt9tYi1kMAzL3jKhpdymd0ITfBp4vXfhWb/apEK1S+1jCFuHOyMxN/8m9ziFx
	 FFH9GJBpO8fA38sGZ0+XglQ/uIyeasFv6RqE287TZVKjkbDjS0SXybH2sqcmjClA+5jCO
	 mkT0OOTwhpgG99TqvqJEko6bowDEQMRiTPj5Xqp+F/XK0+AiYy0lWYdHFyyPPUY3pnoaq
	 Zrm44+xxbQYRaOoi2Iakgi6C1b5OMHHpZfS1D62vXF4Ivj+RSRC//kxY4hb6WrB4G3Hp1
	 YlbCQcqdXI42KSOa6Tg8LxS9jupm1Ca8Ax0KGMNKaIrNe0lZ55Af57CspgNjJKNWDgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1fqafLE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBF606A33C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91DBF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1fqafLE
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679a2297c55so1668215d50.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217004; cv=none;
        d=google.com; s=arc-20260327;
        b=GrebmP5eJXYlyI+NdLLhu5NjA1gT+djHG1JRsJmVO3A/lgYc5ohSzncG0MEwNgiuEB
         9LcC9nUhJ3/P8P7v/g0Nh/arW6631BQvlTXe1+ZPJelQ96pIMzGbH48C0hP1UJTodyLZ
         yBOorQNYpd+qkTaVD3ttWLmnoKUwHRruYD6MkVMetTV30ycYGlsQfXFmkRCCAwlbumPK
         CbByGAZcl6N6G51QMpGQXOdX85hBSdKHoh6zZZNWns/Cfy2HrmE/ocajJi+zlysLRzDb
         FxA4D4zPSqSKkxVMiX3t3CMCkDwUqv8roool9bGODCCh2vn/U6GRYkDl1tQVG2yFV4et
         ajpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ykQEdFjksRS9u/D2TVjRBDnT1izVseJdcJyQ2Mo+08o=;
        fh=yh48E+bIdIF5bkOxOqeqFS6MqWS5L1IGeGCToXGaOZs=;
        b=M9Jy1lwWmHR72fG6GRi+INLvqzrhFBhYyZYTsdDDtNLlOqin4/FXqJA1/lbcgTufDc
         ufud1FsEur1H+VDJMFs/mNqMJYbOGuVALJmg+ThHJYn3gYK8cZRi+wKEMihX8CsTrqu8
         Ptu1ehVbMbbKUAJSCkXs34cos8gjqiDKNR54dkSU0RyaRwnS8He61w6TO1WGgyYvgmmc
         M1GlAFh2luXftfj5TJuqFQHzYyOscM+8s/rw9YXrZxz6TErRJDNEZrYi90Li7OcHN2A+
         U09fJV92eoTKwMHvUTOpQcAWjBwxJczCnxDupqPdu480IJtbi6nNQag9yGW81NnZSO59
         g8ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217004; x=1793821804; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykQEdFjksRS9u/D2TVjRBDnT1izVseJdcJyQ2Mo+08o=;
        b=v1fqafLEMK0/qPVWaI0Y549hNnNarb4CV5ajvxgrceYgxHl5ExygCxwu3UpE5+c+jD
         lUBIPAoHqmI4MUw9fC6SIvxEteehUYmux3Ct0T7tzZ9ah9e3P67MXtOFIknO92j+zlcK
         /hwtXjgdIrvZ2d7peZntoPuzsXwqNZWoakNO/HMiBNkaGmNwkNAEhlV1rdFcCkf+iNJl
         Q4pf0FP7vJdfnm7tyKIxcg7DrC/9KCINby87FsyvwSFtBfIy5bU3jsGqjrz+ZEVJCCHT
         q0OEvgkvhs1HoJ/A83aS1paSZsMQu1VIGi8M293D5xvXtIsMSSE1O2L28cxpFDPubnZZ
         9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217004; x=1793821804;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ykQEdFjksRS9u/D2TVjRBDnT1izVseJdcJyQ2Mo+08o=;
        b=x8+rnVMl+VYn/PMaRdC/m1zn3rV6NQAL0kSCvHkxufFc0tBdPl+6VqutMoTGrjyi86
         mKeSaqep9D1PHeDKFT7Sk1s9yKXBCsekdunlaz/qqNhsVrJTfnMbXCTwY6vtmESY0HU1
         qxK1ZhKP3GooZN07fo2XOkDjABM4rRByYihIWNJOQi7Fu8uGCrIndnOW72gZqOM0awvL
         kdnMMhArXF83IsBnn3c5PlMLEMwERvfn+O3e+ivcw6BE5i8+eBwJ3TRAK3WETcDL1Tuh
         Sp87OeualI+Dbx/KJyg8mDM+bZUGDJDl0xvuTbWO5Ru1VNDbMafY+fVLAInI6f/8jGlD
         uedA==
X-Gm-Message-State: AFq9FYJGmAtwyT4zBl0PoESy88bq81+BTDae3YfxzdW76bWB0p+5vrIU
	dAUnAxrwdWUWoxBG3rhcKa+1f1eQZuBpYCjZ53GgfDb3Ti2lRxG8gGsrV+wIwekki13gkY7jq4w
	E+r4fkVBYIsf+kAyc41BwS+2Iy3Kcaw==
X-Gm-Gg: AYBFou3n4RWSWjiO+z4hUFlgLLdFO93CryHIfpdqm51n6v8QkFlZsbdeqabsxl70mdw
	5opor7l9qB6VchOaBixUmU85GXRoS2HisEGMSSy1n22dAs5a3mUrZHirubQlO7sZCJW+8cQRrOm
	D5Qpy14Y08SQpDtaqtALhL5gp8efX2LPC4K+4vWL1sA3VXZf/ivgWrMbOLkrHZrcFpSsUp6z9SD
	Z7E8Oa0WPAr4CcyGWJLzaxK3WatLTSOJz0mJV8UKUBzX/llyoh44d6PelzKCxKw5VVPY23dFKKN
	0NCwdwah4ZclP+CIPK+4nlwrJYe/K+kYtBo1DJXbXNckkko2yRlmJynoaiPh8BF3tOVmVEpzPSq
	ZmaXcd0uGDteyZna7Jnpu0RRgbTCbopvlzrIRa/XAVFXwn6vgyCt6ym0=
X-Received: by 2002:a05:690e:1489:b0:677:c6f6:8cba with SMTP id
 956f58d0204a3-67a7bbfbae9mr2807630d50.20.1793217004470; Wed, 28 Oct 2026
 12:50:04 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026132525.45414-1-fiendora5@gmail.com> <xmqqfqxsp3xb.fsf@gitster.g>
 <CACWAS-U2-riX0ajiaE4VgiQWxmoWcL-d9-arrSASa+dnVxoyEA@mail.gmail.com> <xmqqpkwvm7j8.fsf@gitster.g>
In-Reply-To: <xmqqpkwvm7j8.fsf@gitster.g>
From: Fien Dora <fiendora5@gmail.com>
Date: Wed, 28 Oct 2026 20:49:52 +0100
X-Gm-Features: AclHuK9Ifl95AQZA3322j91f7XBgQYZHdzRLKDOJfNIizNErknzgJ6-MauAOf2k
Message-ID: <CACWAS-Uc3WvgGsPC450nD_+ZGjdgf4PFo+gHpYhAbfziEq3F5g@mail.gmail.com>
Subject: Re: [Outreachy PATCH] t1402: test --no-allow-onelevel option precedence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Please do not top-post.  Your response will come _after_ the lines you
> quote from the message you are responding to.
> And trim your quote to the parts necessary for bystanders to understand
> what is being discussed.  Do not quote the entire message.

Thank you very much, Junio, for your guidance,

I now understand the convention, I will implement it in my future replies

Thank you

On Tue, 27 Oct 2026 at 17:29, Junio C Hamano <gitster@pobox.com> wrote:
>
> Fien Dora <fiendora5@gmail.com> writes:
>
> > Thank you for the feedback.
> >
> > I'll revise the commit message to better explain why check-ref-format
> > needs these tests, with the rationale highlighting its handcrafted
> > option-parsing loop and the planned conversion to parse_options(),
> > then send a v2 patch.
> >
> > Thank you
>
> Please do not top-post.  Your response will come _after_ the lines you
> quote from the message you are responding to.
>
> And trim your quote to the parts necessary for bystanders to understand
> what is being discussed.  Do not quote the entire message.
>
> Thanks.
