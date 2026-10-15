Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE03F7895
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091105; cv=pass; b=svQkdmTVf0IVDzi3D14BOTGNPOVX3pFsa/uhjdwy3D1wIfevt7KvNm7LUn8L744hN8XEkY8E1siiWbRUTQ3kC2UFKbqhXf20t2GgpfelIYpRvbVPl/iQ9dLb8fdhDhnIVX6+bNMpqdq9kqie3TF8AwDazoNX4d5Ew3ILPK4SefU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091105; c=relaxed/simple;
	bh=CkY7UBhyN3W2ApLgrj9OLeRxjRtATTsK4mXgRSTlryk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnyR7Yh6u4w4nJ2yPmFpCA2GKHQAK6ifMt1wMXyt2aP7UcfZesBncCo1YMottb1DrX2LjWoZxChRZFGSw3JxBrX88/xixbFEZeZ+og4lNNGoajN94E0caLzkIe/LTUox2025d2yhFFe0IlCuIzRfBKDc9qnboRBgj0jRKI4iSy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV308HPm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV308HPm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e49fbf92aaso33816045ad.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792091103; cv=none;
        d=google.com; s=arc-20260327;
        b=XNy4UdKEG1eFzTf2DjYLL36eVm7+DD9p7gplFZxEnsxShH+l9YIrKMQDInsHjlN9Cp
         VyUiDg3meBKCnInyqOVSjqVAhxYVZCh9tOAxX6PsHweOQSC7iz8T837aH+fX6OdJeIme
         ZtxWY3vQlwcAid8esM8RQidZdTGCjSaV1jGwCEmV4DWjTZ2xcVN+9FjpgVmTNpiIqjRy
         bVMsBFdOEjdoDrCZwVcQcz8fU9OxJ5H+45J25ULuKga/OU2rgp8RZB+5OkFD0oxPUlLi
         qt0USACfy8q/GZLZ7hHHFZLPZ3eaCEj7JH3yAn7aqKH47BUR/HO28IMyakSKew8/pflh
         1K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=efhFGq7/HXix+Ma7vsHMfvBBkuGm/qPztzAX+KsRrwc=;
        fh=ftd+A7OIHlEkxUogFH89xDM+2in623JxrHhqikVMV/c=;
        b=gFW8veI0O2mvpM6fF63ZAX0BYIUiLvuxO78vru3HTMiV3dXbJx1C0pukDMH5i4JK9X
         yYN38PtD8eqyc9QQeL645+GKK+K+ebNfEOKmxvp74X92o46YQUQutqFlQoC9SLnG81CQ
         exj/4QQqfq2CB0ruHzItvCtEi6t49jimoB4S8equYiMbw3Pi1g6JZl0h8pOTJppusMIH
         4IUAQeEkQXeUx1g4DZbmVBfPqE/OxyYXFztxXOuDi1KNp3cMVSTASAFBeoW46NYmuKdy
         tz1w4TL2Xy1QqMUXv5LkvkxZmqe0GJ2eopdUy16xpsAltXOkQFWf4uEAhhekcLMswh5p
         toOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792091103; x=1792695903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=efhFGq7/HXix+Ma7vsHMfvBBkuGm/qPztzAX+KsRrwc=;
        b=QV308HPm6yl9Bu9QccLGOa3NOOr7On0yNaM4BB17BjWgEDJpcHJrmb/uKn1i+ojtA7
         V5GmEbzgXsscrs+pzfZV0HnUC+DFGKmJcW42tOvq7XHDT1npe8WR0iBRjyrkYqt8gYjr
         F0QAVbn8l48/nZVybpTC2EcZFKp2Tft65ULXRlyR1bjwoqIkawzgn1VWj2DrzirwIkEg
         QsAkFQyXfWIESdGD38KmFbiwgiFjwPmSEw7dB2BCusSsTa1jUTKDVFZkFzPKho9grD+9
         TAtyMzZIrR3uMM7kCupGNzfZNQIgX7v9hcnnC0wirWUc7Sq9iXffqkh3FBW/Dq4eW1Kj
         PnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091103; x=1792695903;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efhFGq7/HXix+Ma7vsHMfvBBkuGm/qPztzAX+KsRrwc=;
        b=lEy7wKdWK2BaYF7MNwPW0Bg4zgCdcBKNPhG021810LjKN9BxfC/0/9PzoxcCKSY4Qx
         lKteBU47JdoOqQqNORZj3pmDoWozHXs9PN4yOE3DL5MTtj6GdLpcBO1oXiLmCgPzDL7N
         1fNJ/XsLd63n3NFjzsOlu3pc1WKjDixwOjgc554pDO+rqocRpO8r3quZ++apQScDXJom
         bH4op6ZVQaExrLwI0dLowQLrlnGFjtkcSpHM4pTFWwFvs9WeKHIa6JCA5u2TSyD3ST4J
         cSuhEFHpjxxge66ad9TvCw+9TJL5LbmoxEw5vbE4Qh76ZMygR2HHxxNEBmmM5tXIsF0w
         5KHw==
X-Forwarded-Encrypted: i=1; AKwUvBzclIgZoSVyaJ+omVq+cRua0yHZFe3zs+jEJ7dzaCsj04cpQxK+ylrqWR+RJ0yML/vh18E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0C6a9SzDzy97zNYccAhVXDaB7zc10BmyVBfRX1zcGqYn+59GP
	OITMg6wRUviSWj2WiJXIGhq1EpdgvqyhP+qks/kwyAeXVJZldTUyECv/sEwO/8m/7/msUW1MG3T
	UKlW9II5hj32pff86Grjk4mqXqlAVQAk=
X-Gm-Gg: AYBFou3227VJuZEAcmKDdYXKNtOaGiC85wwtNVfuEyLX+M6y8RSsvAOJcx3xOYOPLpH
	0j/G3Ejh82uwsOr1wtkDsPl4ZVNoHoT2kH1NWSS1NW3+2payTh9dkRn1LCdcEGelsvoSE6BjWgj
	h2qbCmRIfywpjID3FXguaTl5SC3ccLT0vnPMWUUAVqVNeY6O6BgPgLC1RlydFwbGt49TzWlW7vb
	AH5UC2Vtd/QfFIoqPwWU3PF/AF/ZWjQDCqJGVSSkdCQ6OGjaGDfyTPQ0JjWfaNu4t7NJGXkg8US
	qFSJUh0SNr2gqWtXE36wsmhdsOpUUbIDWS0ensEbHoBcsC0wyIqc5M8MaoRXOMkRKBc8mZhA5n1
	vpl7lozXfmg99J4JgV8gbEF8chl7GSyp1gVSu01qIBGzv5zd/UhtUfb2p6I8/5bZliIvLC9PnYL
	Izt32txdhWaihQUTjGFhJ2q4G92HdKsA==
X-Received: by 2002:a17:902:ce07:b0:2dd:ad73:5b6c with SMTP id
 d9443c01a7336-2e8429ad1d4mr174591435ad.28.1792091103423; Thu, 15 Oct 2026
 12:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
 <20261015133624.82112-1-haraldnordgren@gmail.com> <CALnO6CAi_rh_JMOhL0wrHSYZQYCZZstVNFuTxCGCavBnBPe+oQ@mail.gmail.com>
 <CAFuK-oaFyp7QdA=Nrc68cNx1iu803pQSUOZ=f947rRjWbJ7Z5w@mail.gmail.com>
In-Reply-To: <CAFuK-oaFyp7QdA=Nrc68cNx1iu803pQSUOZ=f947rRjWbJ7Z5w@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 15 Oct 2026 15:04:52 -0400
X-Gm-Features: AclHuK9WKUf19WLC9b2TIt3VvI5SaGvTEEB5IEUhgEfbN9u0alMuy_jaxUYbybM
Message-ID: <CALnO6CDH==atdV5tfHSiTuF6MFNebbjyVEzxBU09=xmU75LYQQ@mail.gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
To: Venkat Ragavan <mail2venkat21@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com, git@vger.kernel.org, 
	karthik.188@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending with corrected plain-text ':D]

> On Thu, 15 Oct 2026 at 10:38=E2=80=AFPM, D. Ben Knoble <ben.knoble@gmail.=
com> wrote:
>>
>> On Thu, Oct 15, 2026 at 10:20=E2=80=AFAM Harald Nordgren
>> <haraldnordgren@gmail.com> wrote:
>> [snip]
>> > > +                     if test "$storage" =3D mixed
>> > > +                     then
>> > > +                             git pack-refs --all || return 1
>> > > +                     fi &&
>> >
>> > I don't see any reason why a test would need an if block, we know what=
 data we
>> > expect, no?
>>
>> I didn't examine too closely, but this test is wrapped in a loop over
>> the storage variable that appears to determine whether and when we
>> pack-refs, so I think the conditional makes sense for that?

On Thu, Oct 15, 2026 at 1:13=E2=80=AFPM Venkat Ragavan <mail2venkat21@gmail=
.com> wrote:
>
> Yes it does, I interpreted Harald=E2=80=99s suggestion was to write separ=
ate tests instead of looping over a variable outside the test block, either=
 ways the logic of the test is going to remain the same.

[we bottom-post here]

I don=E2=80=99t mind the loop, personally; it might be worth looking around
for other tests and see how they approach it.

You can also extract shared sections into functions if that makes
writing separate tests easier.

--=20
D. Ben Knoble
