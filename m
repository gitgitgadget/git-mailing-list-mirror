Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29660283FD4
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598808; cv=pass; b=HBsMc5XTeQ+c/H1spfnjQdVGdNvBDahwhOzro82k9aJLmRf1S+WI4Lc7YOLeSqMfQwEUw03kktES7Qshzy5SUMwe7fDsOPt6nOxLaUIiTwkbQPsiluQI7DPgnu+vQxTUK6RkJ/nW9XzNV0sv6DWrhV08rIDlfO2WGaZLRJOlS9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598808; c=relaxed/simple;
	bh=nhGVh2gduCjk3yrXwwp8b2G+aEuXcUo/KvuLYvnWwm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoaG0bZ0t7IKvue92sV2O3Q2fRAk4gp0IXxFwAXbTJ+H7sHhF+XVO15EbDLHxXkSkCZ8ZOiO+kaiMnxmQSLrE9wskFAWD9c4C9dgw5o1LGaM828nUJJzu9t5l1bij0gJGKxVIYAiVO6PRrMGP+dQb4+QG6wCOF2qwXdpF94qIpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6NriBGK; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6NriBGK"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df8bb777e4so9974435ad.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598806; cv=none;
        d=google.com; s=arc-20260327;
        b=N51+byNjUw+gM5KWKBIjR1Y1lHRkvLdS+oZxsH/hyxuh45XEipliF4VhbVEbFPV3rq
         gDQNKaCRMPxCiTvup+0yxH3xwRiGuDkGVE/ZE1ySmR8hBnAlKU2L0z7NbiFUshRzGDxw
         4Cj1KkSHxneIKqrrabyLpij+xlKfGxcIlw9GG8cepybTIzOr+5+zrz8HFXOXOeSVYfU/
         YiJnCJcbxPE1hLhuz10Bc2ybaWAjnqm6vpptpHMtwiBzr0OOV1Xvjn9vnkStAPMJpT87
         D2EqhJ8xxnqU1eVcuRPI65P9Li9ug1GFxEApKfoZDeE33bRviSJP5brQUc86gSOtgFwT
         I1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nhGVh2gduCjk3yrXwwp8b2G+aEuXcUo/KvuLYvnWwm8=;
        fh=Q23qh5vKvXHCRMti64507cuJxU3rHgK6wTTA6XR+jF8=;
        b=kYvsuS5Nnnf1wN4k2DH99fMNOx6eEG3uCfApXiT6YzlnpddQUGDblHAeRtknv5bmg4
         12lnJ0b9TBgph1ylw1Ba+Oxm9DEICiLiOqwa9oSvvzwpLklTwlEz7AnATM5OP6gQgjjn
         h6sSlh8OzQE7pbMl/rPE3upK4tOtqU1Dq3mqLKcf1x5FXpV3yUgzlb08mAPj1jN/C8D+
         xtnAg6poRjZpr3o7vxCRjQZ0VWXL08UT4gmQSxacwRWtoBPfHgoi/WVldRwBnRQe1vUF
         AfcoCaj/0oWgkfzhCES1yhQj6UIel1EJLOv3HG17nKGNjSfp25uXeoHcUM7FTL8d948E
         0kMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790598806; x=1791203606; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhGVh2gduCjk3yrXwwp8b2G+aEuXcUo/KvuLYvnWwm8=;
        b=K6NriBGKjGyb8MR9LdXNNVRyzAPWG1BoBV9KjLU+Q5cfwSfxFUZeASIdVpoabTnS0C
         SjSybANSHvRqD8tyh/xQoyvifA7af7+S6VOuZp9d/yqAfRA6X2lTD3JuNXyXwF0Qfx0Q
         XRJq7Z5uyaKbOk5mci92Zapm0+qehREr4gNkOrCsOAMIEkMtei/dABMmTbLgexeUdQBm
         FYNeuJ74pbv+yuJiR0zUr4NkEKeKEp0stLr47unsWiAscUtc6Wz6SMvn6F2LovVKrvZ6
         Fcvxn95l2Gq/mCZImY129xJPv5wtCmxRiNPhR/PilrCBFz5fcqBGaJSDg38g85NC/lg4
         tmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598806; x=1791203606;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nhGVh2gduCjk3yrXwwp8b2G+aEuXcUo/KvuLYvnWwm8=;
        b=Wbzzl6+TGg8lzwg3nt0V1icyChw/SiYLM1qFg8L98OoQxrhIXxg4XEsVff90UxLPFv
         kfCn3ayHD/mlwc/ZmPP+64nKTAXFtnZ3WgOMa+xF3rnW6s668KW23HdZMc/1T3Q4yulG
         fH+hbBbRtq7YlZ5JNH4w9N8IC9hddQLL//oudfi3uwItlZvjEu50BR5nGp8TvriYQJSf
         /ulqwLUf+7zlvDiwB51vLELiAHYWJ9+pkEYp/qt/biBOatjUUP2wWu4vYDgUNewyy4WE
         Vrcp1Yuu/UV9RTrV0C1Wa8eEyNpsrjTT8qOs1bs1qnnlzJJijY4Rmqp+V9E/K4t3NU5t
         Z80A==
X-Forwarded-Encrypted: i=1; AKwUvBx0jR0zk9Deitb2HZDtPDfMB7KiD708LSsPSJ17Lz0R7dnretHX7712/O22c64IO078tnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8Eab/jj760O3Mac1zZWRJIZvaBI/wtPcOzm4t62y7rn9h7Y6a
	FOoEM0EniYZVB+mLt9v4jxpbztZlP9mBUjtLghYpYP6IKzwVsTjMqu4eMWszEw44eBQWftCg+Gx
	1tQVpKKJ75LqWQS8VxiRMtwPwY7ogbpACcLMZM10=
X-Gm-Gg: AYBFou0SsaaSU0etpdjGn3JeBvXZohEiWfnxV9f8BmArNc/k3O8jEgaI4CgTvZkCv5t
	dIwXHgAAJie6zrnN530wIrxv2UrYie+ige3SVrYD4KWV/LfIRDTQDIrPXTar59JFSQe+G63fS10
	LF2+8KkIqYpWT6X6zQ8uMr8ikwR6cUA2mheTRciNAKUwyzKEmxqaEeUatuEN1JDSGewuJrptRLg
	lgO7kQGyU+fQx7IaQH/RW5wcKwjL3biVRZ92duSQNlBpqiHxP3uYb9Re8Zj/fwoqHRde9yA3Baa
	3K+EbC8KBQu11o51q+k7Xqs8kQaANqYrd4Z1b5kqIVi1r+hdu29mW1jRr8tSgd0IeWbWxNWvbXO
	OkkE4KrgpzyqsmDA7b8Ln5tyQ7twzGrkgQOeLD1eajIuhhuaDm/gl7JuusR/ZflDRFYwKfTAK/H
	3Uw07OkfY=
X-Received: by 2002:a17:902:c411:b0:2e2:b624:54b7 with SMTP id
 d9443c01a7336-2e2b62454f2mr9723075ad.17.1790598806327; Mon, 28 Sep 2026
 05:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <xmqqjyo6qz3z.fsf@gitster.g> <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com> <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
In-Reply-To: <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 08:33:14 -0400
X-Gm-Features: AclHuK8QQOZG3B1_q00gM_EhlenOVB6VDLWM9dm0vublOg5UQqzfPumTmQ_AMlM
Message-ID: <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Thomas Bachem <mail@thomasbachem.com>
Content-Type: multipart/mixed; boundary="000000000000c979ca065c8a45bc"

--000000000000c979ca065c8a45bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just leaving some breadcrumb notes=E2=80=A6

On Mon, Sep 28, 2026 at 8:05=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Mon, Sep 28, 2026 at 5:50=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> >
> > On 27/09/2026 20:21, Junio C Hamano wrote:

From my local version of the branch, the following script points at
4f65642eb0 (Merge branch 'tb/rerere-lock-grace' into jch, 2026-09-27):

#! /bin/zsh
HEAD=3D$(git rev-parse HEAD) &&
git merge --no-edit bk/autostash-index-reset &&
if ! ninja -C build; then exit 125; fi &&
meson test -C build t5520-pull # no chain! need to keep going no matter wha=
t
code=3D$? &&
git reset --hard $HEAD &&
exit $code

(using "git bisect start --first-parent origin/seen @")

[Cc: Thomas Bachem <mail@thomasbachem.com> in case you have any immediate i=
deas]

I don't think the bisect log will interest anyone, but I've attached it any=
way.

--=20
D. Ben Knoble

--000000000000c979ca065c8a45bc
Content-Type: application/octet-stream; name=log
Content-Disposition: attachment; filename=log
Content-Transfer-Encoding: base64
Content-ID: <f_mul89xmi0>
X-Attachment-Id: f_mul89xmi0

IyBiYWQ6IFtkNDFhOGRiYTE3YTAxZjhiYWY5MTAzYmE0NmMzOWM2MDRkYWI2MzU2XSBNZXJnZSBi
cmFuY2ggJ2toL2Zvcm1hdC1wYXRjaC1yYW5nZS1kaWZmLW5vdGVzJyBpbnRvIHNlZW4KIyBnb29k
OiBbMGUyMWZiZmY0YmQxMGFjNWQyZWU3ZjQ3MzQxZjcyMDBjYjFhNzkyY10gYnVpbHRpbi9zdGFz
aDogbWVyZ2UgaW5kZXggaW4tY29yZQpnaXQgYmlzZWN0IHN0YXJ0ICctLWZpcnN0LXBhcmVudCcg
J29yaWdpbi9zZWVuJyAnQCcKIyBnb29kOiBbZDM4MzUyY2Q0M2FiOTc0NTY4NmQ2OTc4NzI0MDhi
YzMyNDlhMTUzZl0gQSBmZXcgbW9yZSBmaXhlcyBiZWZvcmUgLXJjMgpnaXQgYmlzZWN0IGdvb2Qg
ZDM4MzUyY2Q0M2FiOTc0NTY4NmQ2OTc4NzI0MDhiYzMyNDlhMTUzZgojIGJhZDogW2IxM2Y2YTJk
MjY4NmVlYjE4YzQ3YTVkMzFjNGE4ZTA0YTZiMTE4ODhdIE1lcmdlIGJyYW5jaCAncHAvbWlkeC13
cml0ZS1za2lwLWVtcHR5JyBpbnRvIGpjaApnaXQgYmlzZWN0IGJhZCBiMTNmNmEyZDI2ODZlZWIx
OGM0N2E1ZDMxYzRhOGUwNGE2YjExODg4CiMgYmFkOiBbNGY2NTY0MmViMDUxYzU5NWRlMWIwNmQx
NDhjNDZmNGUzMTZmYWZjM10gTWVyZ2UgYnJhbmNoICd0Yi9yZXJlcmUtbG9jay1ncmFjZScgaW50
byBqY2gKZ2l0IGJpc2VjdCBiYWQgNGY2NTY0MmViMDUxYzU5NWRlMWIwNmQxNDhjNDZmNGUzMTZm
YWZjMwojIGdvb2Q6IFsxOTFmNjExNWY4OGI2OGNmMDUwYzM3MjMxODVjZGFjNjQ2MDUxOTNmXSBN
ZXJnZSBicmFuY2ggJ3BzL3JlZi1zdG9yYWdlLWZvcm1hdCcgaW50byBqY2gKZ2l0IGJpc2VjdCBn
b29kIDE5MWY2MTE1Zjg4YjY4Y2YwNTBjMzcyMzE4NWNkYWM2NDYwNTE5M2YKIyBnb29kOiBbMTM4
YzRkMmIyZjdkYWQ5OGZiNDk1ZjlhMGI2ZDg5ODNmMzM4NjUyNF0gTWVyZ2UgYnJhbmNoICdyci91
cGxvYWQtcGFjay1zd2FwLXNoYWxsb3ctd2FudGVkLXJlZicgaW50byBqY2gKZ2l0IGJpc2VjdCBn
b29kIDEzOGM0ZDJiMmY3ZGFkOThmYjQ5NWY5YTBiNmQ4OTgzZjMzODY1MjQKIyBnb29kOiBbODBi
OWE1MTMyOTZkNTFiNTE2MTM4YzliMGRiNDUyNzQ2MWQxNDE4N10gTWVyZ2UgYnJhbmNoICdoZC9k
aWZmLW5vLWluZGV4LXJldmVyc2UtZml4JyBpbnRvIGpjaApnaXQgYmlzZWN0IGdvb2QgODBiOWE1
MTMyOTZkNTFiNTE2MTM4YzliMGRiNDUyNzQ2MWQxNDE4NwojIGdvb2Q6IFsyN2I4OGM5ZWEyODgz
ZjRlODE5YTVmYTQ4NDZjMDJiOTJhZDU4OWE0XSBNZXJnZSBicmFuY2ggJ3l0L3dpbmFuc2ktZGll
LWxhc3RlcnItZml4JyBpbnRvIGpjaApnaXQgYmlzZWN0IGdvb2QgMjdiODhjOWVhMjg4M2Y0ZTgx
OWE1ZmE0ODQ2YzAyYjkyYWQ1ODlhNAojIGZpcnN0ICdiYWQnIGNvbW1pdDogWzRmNjU2NDJlYjA1
MWM1OTVkZTFiMDZkMTQ4YzQ2ZjRlMzE2ZmFmYzNdIE1lcmdlIGJyYW5jaCAndGIvcmVyZXJlLWxv
Y2stZ3JhY2UnIGludG8gamNoCg==
--000000000000c979ca065c8a45bc--
