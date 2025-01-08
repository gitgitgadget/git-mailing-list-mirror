Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178B1A00FE
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341602; cv=none; b=OGEEmTDPOAv4smBMBwfekJHATG3JwIlClDDU5Ct95DPWLg5CIr4a++6TgLqqXMN7iWZPluf2drnan9S3PdLWIbyjRVm/h7I+JCVMApr6dVumIHMj3wNWvCiPwk8fVw+NjofrxTmXN8LgUF8osvBg/KiHXAUFG65Ec55wfEO4Fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341602; c=relaxed/simple;
	bh=CxvRBXMZfb2DGRi/34qw4OGxduy83v8Ilduwi/J6s7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We3FOlxeBKOzYvJ/hpNC9fVtQlAYWrp3/W8ISrJOQXTvkK/O/6cyFskQA2cK30qyTBftvkey/+spTOby+7BWditH+7vj8XcNTxsDkfA+/A+SM65+l5jZHP0s9nUyv8TmJZAMG2oKdtg2vyUyF9ut7yXdHl/ID1WsbTkV6auGORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObOyZ3PL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObOyZ3PL"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679eacf2c5so157026221cf.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 05:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736341599; x=1736946399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNnacAOV/C67++KNJf4IE74stX94Ov4IjKty+XaqfVA=;
        b=ObOyZ3PLKjksBNPZPkCR1Vf5IHcs7ZXmOWnhrkQ0JRpsWeUU+bugd+hFFJVppcJjNB
         SSAa/Vj9a/LF6Q1NZcjiJbg153yp36ru3xwtv4g81RZJsMN3rynVEZ8vwjE1BsEODqrc
         YVCC7AP9oG5MW9UEVXhML8/bvqzJdDSLhPq9/MGLBbDbN+iTDTWBuLPPyIasmugeT8IM
         K4/nh9LEKTh/63eYSE5ekucrkRA9Dw2szhYRipdTxp8q4dAxcSx6qoEntI/QU5iJIWuO
         AeDj8mMx6dBfydReSXoAec9N5Bjj3qz+8jDqOy2uVPWQ7yVqfwwg5bL7um7+zULr58+j
         v7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341599; x=1736946399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNnacAOV/C67++KNJf4IE74stX94Ov4IjKty+XaqfVA=;
        b=u5492rn4N8HIj+QB/L8wrCAQC/zhZSZ1gmu67bqh0/hVGjLQloHL1aoSOae7NKZCDP
         addO9mBS8ycE/6rlSw04WFF1EoVeBaG7/GliksLHbtruta0qgk8MxpO4Hs0tFiFMmCuF
         RLKJMTnJksZ9sCppllj+vZjTwydt1ZUfS8GA86MHKBv8bpX8YJwjK17XZ8U1BK6B61Fc
         XK5Eird7MAShlUTjNEG0QSsVOCej6Y6/jaYvZJbPeQaKLDnxFe6w5FqWum3c2EtJlcGe
         ZJm6BJ04LhahdHLdVL336BVZ0ukQM8gjpyU95al/6Hw5AY0OU59Mbr6dvT1PkVi5e/3j
         rGkA==
X-Gm-Message-State: AOJu0YzZrdhzRFONpXZTLa/9lA5F+3qM0usHqzZdSenD5Q8+XVijUQfp
	G8oEyYfgXJm69wRgX+jaM4diHZ3ygHwFvo8Pgfxt2WDoQehxftA2gKpP0fvqSgENUgpWBR/MB7a
	B9/dr4lTGrrd9UTg1aImb6joJJ3AoizoSFfkNXA==
X-Gm-Gg: ASbGnct9BBMLYmsrG6ryj133nGKAMGpTaUsXiz9BBNULyIiE0dQkUSfpAceuVLMMK/9
	CC3Xegh6/2tEb3n6DpBv47GurHlAVyMtN8wikog==
X-Google-Smtp-Source: AGHT+IHizzbKDiDNJ0vYBovRmmmsE+/8gaJeghrBKx4/RR+eHfibeTrLKkyNRVBwetYNRIHhOYpPBFAeqBI7g56tYos=
X-Received: by 2002:ac8:58cf:0:b0:460:8f80:909a with SMTP id
 d75a77b69052e-46c710314ccmr46369271cf.32.1736341599436; Wed, 08 Jan 2025
 05:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <xmqqfrlvzzcd.fsf@gitster.g>
In-Reply-To: <xmqqfrlvzzcd.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Jan 2025 18:36:28 +0530
X-Gm-Features: AbW1kva5wS3kGc4laEztlv4mqeVWULqwJmz8-0XX5lTgqpqsjgeCBxPShpZeVSI
Message-ID: <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 9:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
Hi Junio,
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > +
> > +transfer.advertiseOSVersion::
> > +     When `true`, the `os-version` capability is advertised by clients=
 and
> > +     servers. It makes clients and servers send to each other a string
> > +     representing the operating system name, like "Linux" or "Windows"=
.
> > +     This string is retrieved from the 'sysname' field of the struct r=
eturned
> > +     by the uname(2) system call. Defaults to true.
>
> Shouldn't `sysname` be typeset as a literal, just like `true` and
> `os-version`?
I will do that in the next iteration. Thank you.
>
> > +os-version
> > +~~~~~~~~~~
> > +
> > +In the same way as the `agent` capability above, the server can
> > +advertise the `os-version` capability with a value `X` (in the form
> > +`os-version=3DX`) to notify the client that the server is running an
> > +operating system that can be identified by `X`. The client may
>
> Hmph.  I am not sure what's the value of mentioning 'X' here.  To me
>
>     ... can advertise the `os-version` capability to notify the kind
>     of operating system it is running on.
>
> conveys the same thing with much fewer bytes.
Yeah, it is better, I will use it in the next iteration.
>
> > +optionally send its own `os-version` string by including the
> > +`os-version` capability with a value `Y` (in the form `os-version=3DY`=
)
> > +in its request to the server (but it MUST NOT do so if the server did
> > +not advertise the os-version capability). The `X` and `Y` strings may
> > +contain any printable ASCII characters except space (i.e., the byte
>
> This is misleading.  ASCII printable characters range from 33 to 126
> (inclusive), but by saying "except space", the readers are led to
> believe that the author of this documentation thinks ASCII 32 is
> printable, too.
Thanks for this, I will make changes in the next iteration.
>
> About 'X' and 'Y', we can just say "the value of this capability may
> consist of ASCII printable characters (from 33 to 126 inclusive)" or
> something.
>
Noted. Thank you.
> Is there a need for a registry of canonical os-version strings?  One
> reason why you would want this user-settable (as opposed to being
> derived from "uname -s") is that a system that is presumably the
> same in end-user perception can call itself in different names (your
> Windows/MINGW64 example) and having the users set it to a string
> chosen from a small repertoire, the other end would be able to
> identify them more easily.  I do not think it is a necessarily a
> good idea to limit what value the users can set to this
> configuration variable, but at least with a published guideline on
> calling various types of systems (and an explanation on the reason
> why we publish such a guideline), users would make an informed
> decision when picking what string to send.
We plan to implement another config option `osVersion.format`, which
allow users to fully customize the string sent to the other side using
placeholders,
similar to how git for-each-ref uses %() syntax. The user would be
able to set it to
the string they want i.e "Linux" or "Windows" (without any
placeholder) and would be
sent as-is. So, the `osVersion.format` should satisfy this need. I
will ensure to document
this option to tell that it can be used like this and will give a
small list of `os-version` strings
that can be used in this way.
>
> > +# Trim and replace each character with ascii code below 32 or above
> > +# 127 (included) using a dot '.' character.
> > +# Octal intervals \001-\040 and \177-\377
> > +# corresponds to decimal intervals 1-32 and 127-255
> > +test_redact_non_printables () {
> > +    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
> > +}
>
> Just being curious.  Do we need to worry about carriage-returns not
> just line-feeds, and if not why?
The function `tr "[\001-\040][\177-\377]" "."` already replace the
carriage-returns with "."
the redact_non_printables() will also replace it with ".".
Carriage-returns octal code is 015 and
decimal code of 13. So, we do not need to worry about it.
>
> Thanks.
Thank you.
Usman.
