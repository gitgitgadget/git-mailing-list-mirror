Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF22EEE69
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687514; cv=pass; b=V81Zc9W85JQ14JJKpMsEtGd0Oy+Ux2mFUlNvbAOnYtikRHSqof5oSZMHFsMK9N8WQcp/F3w0KBdFXPTycq5ncEBayuGTMUoqJIN+6iP6Rd/ilCGVV+FISgbrK2mVoghh+XlLurOJB16DyI3myFpKAGoSMPD6aZSlXcmrxrH0c9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687514; c=relaxed/simple;
	bh=pgmQYJiWWafrJPn+zGDEG8E10+DcQ775UGsxQCOF26g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3S86YRI890U5NwpCOCK7idX889SFQ3J97eJMNEFTwjim5AGVRooH16S1dBRz4ko24BYgeTFSDOstDo4RqygzNaXpxTN7CbgJ1W0N5qxNUHC3ksc1YW4vIM4d6lwWV3CdRoJfjVqs+PLYeDD2wmgJevOHLjSVPKOlzq1f4xfcZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEaNjq0b; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEaNjq0b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec423a5265so1005801066b.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 02:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781687511; cv=none;
        d=google.com; s=arc-20240605;
        b=eyaQYdZCXmRFU+c2qbkDkowScKelhQbMhTUY0slU+l7aS8L4YdneTR1CVR2TpBZahu
         W0K3t6FtF1gGqS5dKr+4+hNWkN2c4OZnnJNNzL/h8nv3yidDsrKULGkOwq4nt4M7iHYM
         JF1CxdozizXvnVNdYsPEAG1lodV1v9wFfxNU7jmDa/86opRm16fK2TDbrgnYsQuwb/sf
         NoYq/TfGCUiTOpq3shg5fU8YYB2esO/nreCVAFF0cYu8W72Wduxo0xWMIlwNaSODK77H
         5Ob6JtG0svxbPwApjvtEv6ZzKfh/UaQVTR5eWJWH6fkajsZFfgr/i7xatIm5FM9v62yR
         s6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgmQYJiWWafrJPn+zGDEG8E10+DcQ775UGsxQCOF26g=;
        fh=yCg0i1jnv+idbvYlsSfxDZpnDI6kVjIbhUPxYqEjGWE=;
        b=Sl3eyFgiqoY96OYl7ZZMMQ3N1dU1lCp4aDy6q+3QyeQgZemMAildtXlw+eZB4IOP81
         NcpVi7+GZ27ZciDaR59Z+X4sDzh1bcBt5LrH3GTab8YojzhV74qREw/vmkJOWaYCI8ou
         zNIBR037uZfyAC1NknpfRPY9D0GwygkU6LtQMfgSvttU+mnb12JXHQYCnLdWBR4RxkjC
         d4RzzUpmwVDXiSBbTKoS4DFWQOBDaDxHeEGnz0UwSnrx0HtYL7vJxHn6ya7sQqxj42/x
         VdGVOxmfoioqsGWOiCCWoXPU4g+LLtlSBNqTt5YR0SbCDckoyzNnQOxmdhnzH4l5V6CH
         T6lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687511; x=1782292311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgmQYJiWWafrJPn+zGDEG8E10+DcQ775UGsxQCOF26g=;
        b=XEaNjq0bUhuU9K2TVoXmFs6e6RjD7u1DCOgB1syi8/98sEaPqdeInqih9NJwRVKRBb
         0KfzzpYUdGWmq6b20XdwDq0aU7Z/nPm1ExJuenlhk4CHO0f8CW4+L0y5PWGk5S48s0Lj
         Zn0oA7oR1CwLFa5Dej6AjARAj3TpzbZBMU0AtXy5bLZZw4UgnfQSp2ElDcZeylkRhlLI
         911/5yv2B0ItbtKHYSwcLPJXxfEVvkW19nTDFZ6AD0ZJdyPo1CqD+MEProdndvwFIEA6
         GvedWT5O0lUDdrqMzvYK95GPMRsOXGPJlat/yJGgpf/a9SWfX2OVJ2Wh8TsjyWfDkQdM
         0IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687511; x=1782292311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgmQYJiWWafrJPn+zGDEG8E10+DcQ775UGsxQCOF26g=;
        b=eqhjRzyH3l4BKpD3FI6obgfKszcYCYZI0S7zP/kX1rwjpg75nApWF2lycGtlMVQtMR
         hAzVSjHrBnV960hH5/PCUsN5/ZBTwk/UzeVYbzJdb69nejzPeN0+OIFGP20Z5Z/OYNRI
         M8+s5N6xDqnUQMsADmTIm33mlSBEK63owGVtVkfuPu86qaQl590bKLC8Xb7iENW2CbcQ
         D5XDoHvozPCRoIVSTn2cbAcSVGtGRZYopwqZqcIwsZ0CnROJQdI+wCz4cuupQFB0b9Ah
         Rk9rfGag4v5ZFGULhB4vRvxn+WldWRvn4huF1KM/AYJuGde+QWDKHo0UO5WWmKi2yppg
         nRuw==
X-Forwarded-Encrypted: i=1; AFNElJ+xejELi1eRG3duxkeL1K+mUEfhwoWtoN6eDI6khZ/EeJxMwU25sNM2P/znJt0SKrnxKzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQQ8Xd5vyh+sjT5xuxmBQ0JV7vhCzieceotYPt1zXSCd2ySLr
	8lJ/k8/RssGIUrjzgCV1Ay1lVaUSVRYntiJ42NDjzRxAsIcqRp/fithUFb5Cwd4jOGvb+PQs+zt
	BGwGbXmGQoepUKDQ4Jv7kICyj4G4uPzU=
X-Gm-Gg: Acq92OHoSTwEK/u9oaZ3Utfa8jJntIPMQT9RtZf42pEQJ49eMz0pL3SHbCLUKC2lOPo
	bokO4OC7V+CkyBkDwC8q5CxgmcXjyrqaGpAHFrBzYnDotj6FrhSSHG+UXrHyqpEDAXvqY9nKrF8
	5sulYJfwtjY9SiRiHGJtDdKeN4Ikwkqus/aE90C2SAxdpasbsNjqbbg9O2n7lZxqR4gYggqIcpR
	NX7VskvnnlLRQ1PH2DaDAFYy1wcUZAJ76jA/opSLpC6GBXPAYNsWVG6G6ykgLa5WuQbV77r
X-Received: by 2002:a17:906:fd86:b0:bfb:1e1c:3197 with SMTP id
 a640c23a62f3a-c05a4f06fb4mr229076566b.41.1781687511138; Wed, 17 Jun 2026
 02:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com> <d55b6600-50f3-4e81-a6bf-d270cd7abd2d@gmail.com>
In-Reply-To: <d55b6600-50f3-4e81-a6bf-d270cd7abd2d@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 17 Jun 2026 11:11:14 +0200
X-Gm-Features: AVVi8Ce_m9B48lhFtmBXSvtT2aTfXvgX_7NTx4h9MlCjzZ_TUOKiAvI-QJ9lkPA
Message-ID: <CAHwyqnV_pt1fEhUGPyGtXrJAwhjpQHOyX9juHRv_88T2md554Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rebase: add --squash to fold a range into its
 first commit
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:10=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Harald
>
> On 15/06/2026 09:37, Harald Nordgren via GitGitGadget wrote:
> > Rename to rebase --squash.
>
> Please include the original cover letter as well so people who have not
> read the previous version know what the series is about.

So you mean this one, should that be included in each version, and
append each subsequent one:

```
Adds `git rebase --autosquash --fixup [<upstream>]` to fold a range of
commits into its oldest one, reusing that commit's message.

Related idea: https://github.com/gitgitgadget/git/issues/1135
```

Or make each message a full cover letter instead of just a diff?




Harald
