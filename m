Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793575138;
	b=e5jkzHVT5RWqSOPNAmbjmGM/72ORFietYhejTfooL/q4loEZG588asgoijkU3Fr0hCRs
	 bORByO6ecBr8/r4mZ0MblXUhQ7tzoGXCByJlvpGUXvAJ84EAZmNXicSnaVbKbfkms8oqG
	 Y1r7EA3IUd5hzrCLd4xTJ0F/IbZOzW3YU+pBDWcahfd8qLsCcHG6/feZ10uKgj63xnVFt
	 61VVtU/oWLZ47nsvL4+JCoY0g/ekVSZaE7rUd7G26hFHj0Est1lZt1PCucYtXByRGvYrW
	 J/rcVwK3JMvqnTljunT6ZuKnnAwiF6MYI+Ol9V4SQ8Ki6IrIaH5EJ51mCSgOUwF1RiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=czk6yHFTy/kp2dkz9VeiGHwYbT1aWYq+a1aBErtGh+8=;
	b=Gwvt0NzVyeaU2wf8IW4E5hIDsju7ChXrnCWwUc3HpJUQYk7VBRnf0JeEx2qgDSLKK7Sp
	 VYCLfG5Lx2D74DcQnmimLpVi/wDI+brKNAT8Sy30K6IZsro6OAbrWoLvXLdjJRjqjzOlW
	 CQnFk1Vt75ZZuqOvn1E7Be7u/zRXH+cptOZ0/MZGOH9t4dU/Pp3MJEVSPZG+U/ibObDcA
	 cvKGHkqUMOAAyQmWA17hU/iw7Hyj/me48MaZiy1bFlOSYFiv/dQ/64//Hg98KQguz8w1O
	 hRg6XZROm1/DvHOQr9U7nZu1DUqseKpalQMlt4xj1IxMru5yUqPk9zQE5VfQhAqPiVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPksQ6zr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14843606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14843606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yPksQ6zr
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-49de8ea072cso1105992fac.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793575137; cv=none;
        d=google.com; s=arc-20260327;
        b=kS9GZf9JpMXmguHX/6Hn+ehcpdMUOmW/U5+r4j2h1WJNZf19vTACcdD0VmA23k43Va
         WdjqBndFMI2XfEx1hvS0qTUQhS1foyt89i4dlKWdwO7He3bTgID7gnVsnny+B3RkbYmT
         +EPjZg1/OAWKO3lrWBde5am51Q/LtnvYOqhElrdIum+IBvYxv2JD1zk61NyIiT3k0wKb
         9kIn1orDkPBTlI4ck6ifip/kJabKMAJ/iuNJyYhpEjcuWZkgBtnCXBFcvjGyaAL/eMN0
         oYCBx0VnEwirRnAkkII+E1i3MrN6QKwz1q+HXJ7QKjNBkl487g/W5D7fIJa4ZLQKfiJh
         pfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=czk6yHFTy/kp2dkz9VeiGHwYbT1aWYq+a1aBErtGh+8=;
        fh=+Ve7dG4yAo6b6IJAJcsfAVXuA3IHmj+18im/3KFY0tU=;
        b=AXiQtkFQDuXUli8Z+II2xkaCKM9Qxm8Sr/vhk1UhTYEENubOH++wCF8xDQjoKrP4D2
         Ccv1l7ZUY08W7fAa0e0yvgrcPzBQqsg2laVLbS+JsXsMug7o5nRN6CUEL0I4cC8NyizU
         pkAiVM22Vfp4bKCSeorsT1UBaqfVJV55zx7POVNYPhVbL+Pgl1HkV6ncDJ0ej9eQZ52s
         N9niXBl7bDsaBBYAMEzO8UuNPy1cGQNfvDvX5vzJdgrtOmY4HYTBhUVu1KbP3b+bxG0h
         A3E4vzL6xUik+OHHXVqcC2ym4KC534QxaI/czNZhGv8OKHIHFAFkIjTnGqIFa3uDZhPY
         I1Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575137; x=1794179937; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czk6yHFTy/kp2dkz9VeiGHwYbT1aWYq+a1aBErtGh+8=;
        b=yPksQ6zrWQUYdwWIBXChhMaOveJX9wdjAus5Vuqf6lMHIKoZhx1c57N8pEEo7RIlCF
         SY0+DlnjXAMnurzwh2WfYwWx/LSO/OlXFKOwmfumIOM4mSM/x9C8YlqlWhHnaI3l+142
         Y/3jF+Q7klRdJzNyFK+3/BrNwRP2ijdRUICRoeyoEtihkLhJkP9iVMfmPhzCVo2cEn/i
         WLroli8qMG7HSh+NrodDZFhJGryWdTxxWcHwT1kyJDI9aHi5BRwB/VZYc0TFM6mFIxd1
         7MP7hKo+vXTgbW5qG5zt1cdyBLVAROaZBFKN5oRmP5je97q8CAKjxxd34/WVnG06C1sw
         Mupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575137; x=1794179937;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czk6yHFTy/kp2dkz9VeiGHwYbT1aWYq+a1aBErtGh+8=;
        b=srQpAMAxkhM/V+xJA3GzVcPEyLq+Yf6rnIOPwyeptnSCDhuwKd7ssQXVevNbgnGZsR
         OJP1f1pSNGcCuiM63t9ZWwkC8UUPwAUClPcv1TmkRP4Xdvbk5K+QKPvXUakieQaiSZ5Y
         OErhostkx20z31yDfjbVrPoUtP8Yb2+Q4c3/Lkh5cVAq8ei7v7lOmrcJIjW5Y/l3jMam
         jFhRjwrAMXyUJQE9aDImQKOxFu+RjXO6T+JXewyhC3m3Vt6PQ9AbniSB4heY0D3xeM3X
         2OUQsfO6WXtGKGqMLobVqpVz0GA9UCroSQGWwItcq2NSZhDJC6aGjQNkkvq9TgkX3jCu
         gtIA==
X-Gm-Message-State: AFq9FYICvo/t16C8MCGUwoiMv2hPjshBuXI4M5Mp3l2jb8P8TGMCBLEO
	ha8tv9DY5XNwnEX/i6tu9ziKuvAAGjT9Nk9RozQohibFD6Uxmnif7Ca3ICA8eHbP94klWVUxmNi
	9j0i8Ar7v4J1hbqh2n9Dj9/ibl/yON/Y=
X-Gm-Gg: AYBFou0b7+v/lki4qJ+/AgfaQrborm0mBM0NjembNygrj1npANEVD9IBfWtiXsRWlIS
	KljNJrfRCJRDdtyOi6SuqWwPW7Pjr5ThlO9FrLoFnemLr5aHjuokkLb8oAwhVWMTbRIWnrqcB3B
	v1OumB78dBkY5z9CAhiubiRCp62a4CjNdsUFLey+mw0Dvp/+RenO6wpc1mJCu2pr6X8Q59119bU
	+PabNDeKQahl0cZUXfSpQNLX46BxtTeFKy5O0OYkKc9y3ypRn58v19Vr2+FFDa88tocoqCbR9jq
	4hnTZ50RzhK6pWCsfkJfH48wEkmGNozE7fkAU4/ZEhmmF3kXbK4kZmenaZJYyVJjHMjhNtaroR0
	13srVGWTRfcu/69gj9lQEh0xBAl7wGdv4iss=
X-Received: by 2002:a05:6871:210d:b0:49d:e1d3:e6e5 with SMTP id
 586e51a60fabf-4a9077891b5mr5181540fac.43.1793575136844; Sun, 01 Nov 2026
 15:18:56 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261022212903.177261-2-andy.koppe@gmail.com>
 <atsPsFnb5mrneAMb@pks.im>
In-Reply-To: <atsPsFnb5mrneAMb@pks.im>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 1 Nov 2026 23:18:45 +0000
X-Gm-Features: AclHuK_dbalox883Cz2akCqRFRMbnJwpSRoiJau6QOLAzHF--eOfywZJ-vRrEhU
Message-ID: <CAHWeT-aC9D0Oa0pR00rKeHNpMqfWhY5-vicASHwPRZn+J7vWaQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: glossary: add root ref and clarify pseudorefs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 08:41, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Oct 22, 2026 at 10:28:49PM +0100, Andy Koppe wrote:
> > diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> > index 52301a56dd..b2c582254b 100644
> > --- a/Documentation/glossary-content.adoc
> > +++ b/Documentation/glossary-content.adoc
> > @@ -500,9 +500,10 @@ exclude;;
> >       unusual refs.
> >
> >  [[def_pseudoref]]pseudoref::
> > -     A ref that has different semantics than normal refs. These refs can be
> > -     read via normal Git commands, but cannot be written to by commands like
> > -     linkgit:git-update-ref[1].
> > +     A name that can be used like a <<def_ref,ref>> to refer to
> > +     <<def_object,objects>>, but that is not stored in the same way as refs.
> > +     For example, pseudorefs cannot be written by linkgit:git-update-ref[1]
> > +     or listed by linkgit:git-for-each-ref[1].
>
> As Junio already mentioned, I think we should retain the information
> about different semantics.
>
> I also think that the previous guidance around how pseudorefs can be
> used is weakened, because now you only list examples of how they cannot
> be used. Previously though we explicitly specified that the only
> supported operation is reading the refs directly. So instead of giving
> examples of how they cannot be used, I think we should continue to list
> the few operations that _are_ possible.

Instead of saying that they are different, I tried to describe how
they are different . But, yep, I struggled a bit with that.

In v2, I have added git-log and git-diff as examples of where
pseudorefs can be used like references.

Thanks,
Andy
