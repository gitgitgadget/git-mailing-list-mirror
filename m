Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186335;
	b=egYxqQVFqDS9pIXQTkH8HEK9fKjFuV1PZKOxXJezgqxSr7LGZiY7ltO6ZjRhIDnz9HY3
	 EMnVVoHzpdzZARWFK/mtTxMnGDbc0gJpTB9Wp6in+IXWcdP/GfkS5SnHLjsFVMq6mTCWn
	 EPzDNv9AXN3iyjn1BjOYSYPZcUob0vzR2qaxZupxZ/0lj5EsJhF5yHdgzIZqYuWJM0w9T
	 aEGV6DZp+XgwJueklJGxmYpbUI9GQEn51O6AN26jeRAtJcHR5O/bh7KTqErEonZCWwU5E
	 61LIkzfLaBN2ipIq2CsaEWL8qlfVAAT3EfwLw4ZsmYgGDtg25gpWKP8A/YJg6ocQcgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0DF0aDnoPYkR61NCoceQNQ6jCUjvsf7JVllELoRWeFs=;
	b=Uu+xbK9Np+k+EFTOMA99C49vuvrC5VHTjo7c5XPHSu8gPuMxaKH2/9bJsoSf+W1MTZeu
	 UQUwjbrk7acxjG3iAsHSBa/I8cOd2Ki15rNDx350XXdxksdZKUb+WiJUdSU8Y/Gjf71Ie
	 GXHsqlZo8QfhTZGqxOcv2nSmUMCuHu83IT7Lg7TiKTTyOS3Bkel/Ko3Gf5ARG77PFGv6t
	 dcd61y5CBmdXHKy/cSWWIsRWpdVWjaRVxoYCL1Wgb4Et+J1Wyy1hHpME7KffDIbBQo+Wu
	 4GacPO+dOXkNP1lz2HnkLYbt3imuCXEzeqpADBfAYjBO6SP6WumhbXFzDsWKY7hN+LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b74cnJCh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B84606A32C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B84606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b74cnJCh
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ac4806e210so6763127b3.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186334; cv=none;
        d=google.com; s=arc-20260327;
        b=p7SlJ6cPbp8pKryczo3Bhkk8zJjWBY2vWMNuUtbKv3k4orhO5AJ/6iVj9KcfnQuyMD
         vTx2dFdvxX/bxN/Qa6FoYKEpk2XPn4uyLnzpidwhGGo/fGY9dcxl9zHa1eoJW5prU3ds
         tQ4ADYfKXufh+Ky22kzquoetW/PYf3Ic8iKOR/K0e78tBdum/YRf5T+AL10izbWyrWYb
         BHaQ9wm306cKdV2xtfCWxj+OasyuXJ/1VRyH0lPMCojgRjoaRALZ04pzRQ257V/RC6Uz
         K/WMjli7UEAmm8GRBVBdumN3VKDS+6J79UIckizG+pTj0XmCtr0SGv1+e3l4QIsyLzPU
         19Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0DF0aDnoPYkR61NCoceQNQ6jCUjvsf7JVllELoRWeFs=;
        fh=jFYMTOEZ0Y4Rt//aPFiwqcF1+l8EJvifOQ18SzRylWo=;
        b=bKQlQ3mNT1BmRsmTs72nzOtMdqDGWF8KOBCuGK1fK45Xytj4fiFZYkxeqESlSOXAMp
         MozMXLE9ZHmwEsCvFMKKOr5nljUiEF89RDcvHYqJ3Txn+mk6Qa2sIz+06IxvVOBvrPn4
         ix2GYJwXQOWkKtvPPM4po9+ObLW1Nd0v5pnwN6YakfrVsXVzKQEvXPtLDdi+vNR54ibC
         09YOv/5jZYXBuY0GODEV9Sx9ULi4xRpLDWMDcrEM8b+4i7FPoMYkMpY/APi4JBbhQlmq
         TP9vQC8zRPDu6LuMyC3gjEmsjp+Q/Ef4hBvJnu4QBsp0vcWceNSLJ9kof5VtriGjYXSR
         Iv7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186334; x=1793791134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DF0aDnoPYkR61NCoceQNQ6jCUjvsf7JVllELoRWeFs=;
        b=b74cnJChtTyZpDgfTx9eKmJvCFQzDwizOGeh+Rx/VwnYuztkWL12sDpfUQY395GZka
         1o5a8y+bY+jfZgXmu4e6AJWDLGjwCrdIeBS8o2zNCMDpiC+yjmrw4dCSNH5i3Ynl+hd4
         CG4Rr5YHHEKcxPwMewjUoUh/2gM0kG6APusOGprOMScJvy9bBgPATzXOWg5XCl9ZQ6mg
         WJPmLqT7Bvzs5ql0dOnukJqkPLJ/Wg4H9444z/4wcRkUVY4pm+oiIrjKYjwRrJD+thcw
         SDsMEd178hiwOWAvSsk9BUhQe0G4P89rxVSEeIUJKUkxt4FFX+SS/txlBEvuSwDAh4Wv
         eJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186334; x=1793791134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DF0aDnoPYkR61NCoceQNQ6jCUjvsf7JVllELoRWeFs=;
        b=Kswm+1+NyGK22vgZvXcJ1bF9augHjiWyHEfKfQCxbfhZbVuxRze3JZ6jGaL+ccDJUy
         dIOR1lMaaPuH+nkPXu9iEaedcffzd7RCG3ICbvCixB8cR6gn9/GL+dxGuPauNZmDYE20
         LZRbExhYjLtJlesOB7AhJJg1huzn6CWe2PRe/QVcvx5tJxSiwYJ1RHhpn3L4hMSg+ifZ
         zbrf2eU/g6jwwo53CtHi/5E/OlAFSrg/R3iBA0skLVZQVFWuXCkh2Lddi8Zjc+z6iw0S
         mmJ9dgX5I1vl4gazkFRtiw33UK2fz/W4Eac0x3CMpIWU58VC1K3kg1cHGGmcQ6dvNfhc
         FDaw==
X-Gm-Message-State: AFq9FYLo55uAvIwI8AhLk5tVR3Dwtb/qtherQCqONTHXrosu9aMju2WN
	iwVVqWdpMJYOM+nRxtOZ+BWojHrqUqG6464RbbrlM/D0JoTOpLgDgd1Qvojh1ItvZOQ6WT59XmY
	lokyA3Hj+gsnGLxffAivhhq+Khw5Lh7U=
X-Gm-Gg: AYBFou0WrVr8HQczmDwMtfwpeZwP/wznp5v6MSMQdkW44LTAKSMOI7CID5vEJB8ueim
	r0jRhFn55WKq8dqR1cvA1EtN1mmpfE3ezJNUVqC/qjTlZWY9B0TGCGx1sdC9SvOKbVaCm0bOlR7
	615vqS6N007meU8tgINmvIlIDjWNSzFrDRMcfO+FQpBPTF0YMuEGkGq+F3qFlAFcDWXXpao8K7O
	G9ophJcqjMOX3uSlcMTWvKzSdhQ+zHm9RtbAyfr8hZpVmh2jxQJbkeGd5EkxPW6vxSiOkf5Icv6
	1bXAi7nnq1QA+azXCwoXkkNEY5eLUPRh2Ugs3mwq/8GecCJlz3p9XDV71lHBXChcxbIoseiJlnk
	YhkYlIAsI84UQDYVktshnl26Dqh40ArifwF+IhSxNEK9xXRV2NE9XcXofKS/Mo0HeVI98KSc9Ve
	A0jfHF4vv/YA/VzG1AaXI38VCdq3ZPJxINh36KSnJhrSugkt42MNE89buEGI1qywHgqDow6Xxx7
	g990sW2qRTxAQnUus7UudyI1pMZsb+eONV0CYk=
X-Received: by 2002:a05:690c:18:b0:8b0:e238:2715 with SMTP id
 00721157ae682-8b1b59a24f8mr15571087b3.5.1793186333331; Wed, 28 Oct 2026
 04:18:53 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028093455.76247-1-okhuomonajayi54@gmail.com> <CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 28 Oct 2026 12:18:42 +0100
X-Gm-Features: AclHuK9pVCx7jeUdzFLtle7F3Ox3Zo9fQZ08a0DKvSguM5ck8T9PYp82VjQti8E
Message-ID: <CAFpMFfAD1O6WDbvz9oCkfHza8okMAMWs_imEfKFZwjaieHZQ0Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH] bundle-uri: use the passed repository for refs
 and tracing
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:05=E2=80=AFPM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
> Looking at the callers of `unbundle_from_file()` I don't see there is a
> reason for divergence. i.e. both `r` and `the_repository` should point
> to the same repository. So this does make sense to me.


Thanks for checking, Karthik!
