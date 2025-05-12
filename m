Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC7296FDF
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076753; cv=none; b=IoYcHQBltcXfpjchBPNVCgf7L+sduiil/L+0/+gLMhCuiC7XJIaXjGFwylAX77/ns4VFqEwj52kNcbbpoYdrXvaIHuUyC10gjvTavC07c0e/RMD8JMani2+aicE3TD/MdXsoqpJEw8oDIGTZofHW/HFQI5z2CWeiZ+AGvxpwVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076753; c=relaxed/simple;
	bh=YY5Qn+JKDGRQZlK0E2KVis/ep6q/qG/AImxiMdvX4AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8vd8pQlcMidHJ33Pz06u2ABuxwRcgD8bpcyNXAaAKG4am4EUyqzSLG1Y1JmukhQwZaBYo+QHkZYZPQX3nB5hO1nMU/DHRCWE3UQiRQL3H9Xg9GfYwG/Wk/p7yTTMDjkhGP5+SNA9wjHmLefrxUv7kVMCwIfy+E2xAjuk29tPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7caeeef9629so52127285a.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 12:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076750; x=1747681550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2GioJkEhSp0d9PbapBSsf767klhZ66L6k3xeXCckdc=;
        b=sQ6moaoTMDaZ+QjnvJ3eiGnPzHSMrPo06GvHlNcvzPPJvHpzKRj7Dyrdd1NEBoXpgL
         fuR+sTogk263t3qdAgjz34dzyunIgpKx9YQmEnQNIABYCthyur9nXZgstweGdaVNJVRb
         dBbQa7Tjb8ZJ4psOguqZmGcWHcVMQDOUbYaWRPbvqkgSFfOkK1oQsMioUf/5vDNRVnI/
         c1AZ0d9ezIKEXtUEmCNR0+EdMcy7gvU/rlW3Gc3vqOptGKTnlZDm8U7aWd3rHAjCirxv
         DBKelN7yUi8bVNs+Qzm14gE0Qs4ASuvTvNWoqF8aX+R1V+4r2L+PpyRxdxy3d3gy7RhF
         tbtg==
X-Forwarded-Encrypted: i=1; AJvYcCUCF1feVpuU0YU4bsKRT1H3K0TZopvjM6EHoY9/O2IrJTGaQCJF4x3d6wgHWZlIkwYQ1iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJygJP4AU+/qRwWDGeub7ai/++l50zV2L3XhXc2nE5AQvjFNC
	ILvIcncAu/vCmx6vpLdRAMHeOO/6veW/YLdCXdybMXQ1ZyzSPTbQJbgtIDoqkLibwvaki/qtbQv
	mVJ7spo30xXxveSVbGG/N0uuP7pA=
X-Gm-Gg: ASbGncvjpl5H8mnTAaIt46FvmRgh2UckjR/7F8S80O2LLGAB3nGdI5Gnj4IhHXQnIGl
	vD9XSoh7BzvWD+2xTIEVP/gtRoIl6K0SoGsOPyGN5txjk2DSCmgKVOn0aCqvnP1p1z7er+ECSqs
	PX2xrUe+7D70fKr0TgaJi2nHC3H/cJgQY=
X-Google-Smtp-Source: AGHT+IEs4+LrCQUvg3zoq+eKnPZOdOVTmdgyrSv3HYW2OXJAK5aoa6Xci+nhWInNx3/S3Nn3DKfE4XBdTiYO3eR66Go=
X-Received: by 2002:a05:6214:4111:b0:6f2:c10b:db11 with SMTP id
 6a1803df08f44-6f6e4815c38mr82836286d6.6.1747076749934; Mon, 12 May 2025
 12:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org> <xmqqa57hvl0f.fsf@gitster.g>
 <PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq5xi5u401.fsf@gitster.g>
In-Reply-To: <xmqq5xi5u401.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 12 May 2025 15:05:37 -0400
X-Gm-Features: AX0GCFusmeiO92e7s7YrzSk4YaAMx-ooFb61YlOISkb4chYlTGZQa3fj4AZzAfQ
Message-ID: <CAPig+cQCpWhJoouuzZu9HPy7Fj-T5RcNnAqryxQ=ATn37Os49Q@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Garg <gargaditya08@live.com>, Julian Swagemakers <julian@swagemakers.org>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, 
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Zi Yao <ziyao@disroot.org>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> >> On 12 May 2025, at 10:12=E2=80=AFPM, Junio C Hamano <gitster@pobox.com=
> wrote:
> >> =EF=BB=BF"Julian Swagemakers" <julian@swagemakers.org> writes:
> >>> There are multiple implementations of the hostname command, and they
> >>> don't all support `--fqdn`. For example this will not work on Alpine
> >>> Linux as well as macOS.
> >>> ...
> >>> All seem to support `-f` though, maybe that would be the better optio=
n.
> >>
> >> What makes me worried about such a proposed changes is if there are
> >> implementations that takes `-f` but uses it to mean something
> >> completely different from fqdn, and emits something that looks like
> >> a hostname but is not.  At least an implementation that takes --fqdn
> >> without erroring out would try to give what this code wants to find
> >> out (or it is simply crazy), but -f does not feel specific enough.
> >
> > What we can do is use `hostname -f` for macOS, after all its the only d=
arwin based
> > OS used rn, and use hostname --fqdn for Linux.
> >
> > Although it still leaves out Alpine Linux.
>
> As long as we record the reasoning behind our decision to use `-f`,
> with an explanation like "we can add a configuration to disable this
> if an odd platform implementation of `hostname -f` truly misbehaves"
> to suggest that we can, if needed, easily give an escape hatch if
> this change breaks existing users, I think it is OK to just use
> `-f`, which would be the simplest ;-)

The problem is not restricted only to macOS (and Alpine), but more
generally to all BSD-lineage `hostname` which does not understand
--fqdn but does understand -f.
