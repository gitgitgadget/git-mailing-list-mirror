Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92602D97B7
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836821; cv=pass; b=nq+pSm5WaMIPhqVRiziyaAlztVRh19h2NXBEQoNHgkqbv4/E5bkGDzgu1vwAklc74D8GVXzw4Hx8usDuoAHXjBGG8xfq8Dwrh4ZT6HvdxPR2n5nKSZ3VZUh4qDnUwHrqKqA0xJox8vK767b4QNsfsWnewOy3PI8Cue0APcpQDDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836821; c=relaxed/simple;
	bh=/FRIv/f24CRdxTjIbS+OWW1AYB57CHZSM5aI1JETqZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ko3C1r5tI8nEnC9fywQ5m1sW6ziJYU/x3ArTXaQrMVYty7vvTFLLCzNu7fAzx8v3Jnh8iHTwB+YjarcS5Zm3+H2oJPB6EB3sI1qLr52oWA0gRoQWZcPQUocJaK3nx0RfGZuO7IHhdL9GPhMgbAYNBphNrwJJcymRQjvh74DG2VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE5x1YTd; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE5x1YTd"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso16360856d6.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 09:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789836819; cv=none;
        d=google.com; s=arc-20260327;
        b=GukwyyRgGZ7ZDJ/1Sp+fYCK1TWqfjoowcMVAnT0g4ao1EGX5c39rOvKlXx272cj76t
         yGYGoOqDaqgkkoTofdCI5KdHPU58K6MCdWw3UHgIz9VdoEv6r913rmIQrcTzVMpSId83
         Tee/HGflCQDIg2cqWYM/8DmyrIJknfRanm2ACexi2edyKj8lABzRJ7BTmS3eqxySjUMd
         HZitXZHfXcczCH4usL1PS2tciPIc5J2+DoZCGjnI6uSAIc/iUE5zS8kjid9D0orUJnv0
         SEsXLQ61IS1U2+UQy9tAs+hGtM9qjT4vV1J98uX3RDshfs/QiPcu+bu+rpNZRnK+bCmz
         o7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n43s2c7Jmt+bHphbhoLW6LRgyimiJKX7q5PyznFHRAA=;
        fh=UiIVr6DhLp32598FrU/QvnQuS9tmAvfCD46UwBauFTI=;
        b=oie3uJ6VYZPvYexi1bLukZBvvQb/pz/iC3bYE/9Hl3RZ35IXg7jtWsJ7lsbri0TK+R
         65MdVuNdz4STg1B0Ag45WMl3qsOnLzkPQVM9sE3RKpHp3yj7mrvn2YIDtfmq2yWlWE60
         B1QxsaoHLTZcFDCNCM8pHTcKlu0ifowFByGvJJAalj2Vwiu8OUnoHFmXlM6xKLv8dw1H
         v+cHn/FCIOxpVsP+aY8N1Z1d7/x95pduOinJauDBApVFh6AchrBm9ZF/bJ2mZKCiRQLu
         eluWsMX3joLdwpFwsw3dJkr4Fkc0GoHvFF3Hm/gVZMgSD3E9+k9wg0T0jsDjbRsZ2dtB
         adKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789836819; x=1790441619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n43s2c7Jmt+bHphbhoLW6LRgyimiJKX7q5PyznFHRAA=;
        b=SE5x1YTdyARtLW3S3vvB9YLwJ1yuCTzBmak44xCvKq5ve/AnOG1h5XhTuY/vxY+AHO
         b7hRa70RHeeYnlFop5YtRCxSaqZyxZNMnaAv8z80FAEGY5WltvEHA6iSPDLewGwVX3df
         JZ4fn4jteyLv2DwBk1aWv/jRHKd4mRAILQS8wbz3daH4YWml7yMR3Y6K9szbTX51XUBj
         AXEuNvvfDUcmMs6sF07Y3fO1S6IRxfcSYYVz1ZXF18OMlpTZCcGG3BaFCkvfeMYduU61
         XzxzuwvI3LQ3+gtflMMGjAmLZUMR1N7OrTbEp74YSTIm+foEHTcvSfBFD441GoSq0dXI
         Stvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836819; x=1790441619;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n43s2c7Jmt+bHphbhoLW6LRgyimiJKX7q5PyznFHRAA=;
        b=RWZxZsiQMJiGMpssXP+xu1q4/UZD100GXZ/Dicz59nw71Cnb8E6GwwlEQt/+h9XCCU
         6guI8NQJfcITxVWkVr5ZFhBXuUONkyOCBaUgd6vr4i+1nlm0fwKwJB9J5evTcIuXObPY
         b/uRPdlCRzY2Jh08er3w52GihifyTUEuIGOL023bzSuFw+DPT8E8ag7krezfd9/7HpNA
         rrSBO668aRwqvKy7vbB57gFm1xQ9tgc5QKAeya8kX1HawoGOQTpKcZf9YMRFgpDgDrax
         Otuu5oy2B9iE0KKiYsZKRXDcBDuZBRhbA9MNCxH5st6bzfdhc6pnxNLg9mp39oazqVT0
         gZ4g==
X-Forwarded-Encrypted: i=1; AKwUvBxebLnYOU3C1EGH2zZY0FLpZOJzfpENo6UlDqNSOPu2FbFQMgWGXXynJpVRVssmeW2zR1I=@vger.kernel.org
X-Gm-Message-State: AFuF++nC93TFna27ORaZYZQrP4r6PR5KnCbQDWGYAUCPVfoH5lqynKhr
	p40eClkCuto2cv2VajXiVfG+5VoM4cjzy7cKxZrcU0aBZ29ygf3jSq83DID2WwggvqhG3tRZShC
	dagCtDJscx008BFnu5wGkXK48rromcfNfhLtwbKo=
X-Gm-Gg: AYBFou29vorkU3VSVVE9iZfa65XhLZ9jXtCP5xvQNCJ82YQbnL/6JUFohR7aER7HNmF
	S1/Rvk/iEGl5Fi4W3DlwyorxHhop1XLU0XjNIEJUNpTeGtvdCIfwbdSiq63g2vFeycWuflXfkUA
	WBbLBmdYQf1O9MmUIRj+XdnQgHO/90PRnHEtTEX1UysFM9NlGJqm7qE08lCMZ2+9pFy/SsNuSFZ
	hR9lHGh6kDPuSd23s44uTBl4SOjSDuT9D9GJ10SRbLQ2d3IQj7g1pEJUAz2ZTjblGrsCnRYwmJU
	HYX/5Tt22eqXeZ4UjzcJLzGWBHqb/i4QeRS2PENHVIgxxSJuFMD7/4tJfl1dQk62wNLOMalenyr
	xvLDWaZozKrYJpg==
X-Received: by 2002:a05:6214:518e:b0:912:1799:6c8c with SMTP id
 6a1803df08f44-912a7fb6e36mr27951136d6.22.1789836818816; Sat, 19 Sep 2026
 09:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKNeS+mFS_VCs_tQeFb8jBx70FwQLW0LtuqhSk4xSdbWdqDR=g@mail.gmail.com>
 <aq6utXAQA-rRoKSm@fruit.crustytoothpaste.net>
In-Reply-To: <aq6utXAQA-rRoKSm@fruit.crustytoothpaste.net>
From: Francisco Boni <boboniboni@gmail.com>
Date: Sat, 19 Sep 2026 13:52:59 -0300
X-Gm-Features: AcwNN1Vq9VWgGgZvwjzWu02T2To0sksyxvtJw92XxcXa0Pq4CfVUSVNzqpCY8KU
Message-ID: <CAKNeS+nxL6HncxKN8WTasB=CfEf85Vi0yCABrB=OGojVwAwBtA@mail.gmail.com>
Subject: Re: pager: consider revisiting automatic LESS=FRX with custom core.pager
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Francisco Boni <boboniboni@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 12:48=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-09-19 at 12:19:40, Francisco Boni wrote:
> > Hi,
>
> Ney,
>
> > There is also an unintuitive distinction between:
> >
> > ```
> > unset LESS
> > ```
> >
> > and:
> >
> > ```
> > LESS=3D""
> > ```
> >
> > The former causes Git to inject `FRX`, while the latter causes Git to
> > leave the pager environment alone.
>
> Yes, that's because Git sets the environment iff it is unset.  In the
> latter case, it is not unset: it is set to a zero-length value.
>
> > I realize simply removing the default could have substantial
> > compatibility consequences given how longstanding this behavior is.
> > But perhaps it would be worth considering whether the automatic `LESS`
> > default should:
> >
> > * apply only to Git's own default pager path
> > * be suppressible explicitly through configuration; or
> > * otherwise avoid affecting arbitrary custom `core.pager` commands.
>
> We can't know in the general case whether the pager is less or not.  On
> FreeBSD, `more` is less, for instance, and the pager command allows
> arbitrary shell commands, so determining statically which branch is
> taken is not always possible.  Notably, Debian has `sensible-pager`,
> which is the default on that OS, and may (or may not) be less.

Hi Brian,

Thanks for the detailed explanation. The FreeBSD "more" case and the
arbitrary-shell-command nature of core.pager clarified some assumptions
I was making about how feasible it would be for Git to distinguish
"direct less" from wrappers or dynamic pager selection...

That makes the compatibility argument much clearer.
The suggested LESS=3D"" delta override is useful to know about.

Also, thank you for your work on Git.

Best,
Francisco Boni
