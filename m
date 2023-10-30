Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711833ED
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwy0GFny"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC1AB
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:14:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5082a874098so4600983e87.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686095; x=1699290895; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brmV05OaZJHkvbwsDoJvNqj7KKP3jmgcUm50SC1M8pg=;
        b=fwy0GFnykdOVwWL3CqiVpTWlYCEqif2M2KolM9hT10oKfGEYUdXEFfkqyccj9ivXF8
         s+QaINV03og73rrN9m6LhljF4DRpPeaJcrI9LJ/MEynRbIEnnCgq6c1ip1rT+6BjANf0
         6gTIKW1KuM8jJPeN5cW5LAseuKQWGxS+bN+ofxf0XQkiDtdDWXi328mH+W1doJUQto7o
         eJvrkDapSewyToteuVXjkk1857EMZZPqLt1QQov/yCI81bPQyP73uNLdEpwyi6ifB/6D
         C/UwTdsVkuzs5b+CZY5wlSOrOlgcAPPuZAuJ3I8UgwPueD7oRtlmdRIsAmDQFFstfJxM
         FlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686095; x=1699290895;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brmV05OaZJHkvbwsDoJvNqj7KKP3jmgcUm50SC1M8pg=;
        b=q23zJBbQypKuvlztIn0/+Jm+oL0ufGxd+H6Ni0Rz76Z0iwIVVnFVRxZxTXRlDQO3Eg
         7KNc2PFOuwib7k24/pjnB+FdhP2Eg6jKdvoDds7abGOlfdq/3iz+jsxFqc3UW6XCgoMq
         F//5quESxn/J5fhAcb2vkjk9+VipowEYpUaoHiXyOFjbEOb0jIPSsq3QVI1e10KQmTeP
         F1sgAXlUxzQ7DFk2IxdqztDi5D7bKZvKC6JO+G8y062DxCy6UJ9wUKPwQgvuZcArB4SI
         8cT51ONCLl4vqEdbeVIAXmBPu9x3oMMNcC2a90eP/sOwrYTw7agPAmVgfuUZklN1KBJX
         Byxg==
X-Gm-Message-State: AOJu0YwQwvBhK/0UT8PSXkrroDTBtoE/c61Zii0fT8iWekt0+/S57QtL
	LZgwb8JMC+CeCgyIpi1sdBl8OHrM8alRSnBe3d4=
X-Google-Smtp-Source: AGHT+IHBrYI4COWjmRUzc6YGKDyegA2F9RbEAJcpY3j2y5Ug11Tpl/5WdUrpGP7GIWNEWNzaoV9y8setvf4usHQR6jc=
X-Received: by 2002:a19:650c:0:b0:507:9996:f62b with SMTP id
 z12-20020a19650c000000b005079996f62bmr6249931lfb.56.1698686095090; Mon, 30
 Oct 2023 10:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
 <ZT/RpqvfQyx+uzxa@nand.local> <ZT_YuF4g-8P9fc4t@tapette.crustytoothpaste.net>
In-Reply-To: <ZT_YuF4g-8P9fc4t@tapette.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 10:14:42 -0700
Message-ID: <CABPp-BG6HqX9CzjjJrPYyS=AvmKF0gMOQT7f+jXDHOGFTXFU0A@mail.gmail.com>
Subject: Re: [PATCH 0/1] Object ID support for git merge-file
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>, 
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 9:24=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-10-30 at 15:54:14, Taylor Blau wrote:
> > On Sat, Oct 28, 2023 at 11:24:06PM -0700, Elijah Newren wrote:
> > > But...wouldn't you already have the conflicts generated when doing th=
e
> > > merge and learning that it fails?  Why would you need to generate the=
m
> > > again?
> >
> > brian would know better than I do, but I believe the reason is because
> > the "attempt this merge" RPC is handled separately from the "show me th=
e
> > merge conflict(s) at xyz path". Those probably could be combined
> > (obviating the need for this patch), but doing so is probably rather
> > complicated.
>
> That's correct.  They could in theory happen at different times, which
> is why they're not linked.

Maybe this is digging a little into "historical reasons" too much, but
this still seems a little funny.  If they happen at different times,
you still need multiple pieces of information remembered from the
merge operation in order for git-merge-file to be able to regenerate
the conflict correctly in general.  In particular, you need the OIDs
and the filenames.  Trying to regenerate a conflict without
remembering those from the merge step would only work for common
cases, but would be problematic in the face of either renames being
involved or recursive merges or both.  And if you need to remember
information from the merge step, then why not remember the actual
conflicts (or at least the tree OID generated by the merge operation,
which has the conflicts embedded within it)?

I know, I know, there's probably just historical cruft that needs
cleaning up, and I don't think any of this matters to the patch at
hand since it's independently useful.  It just sounds like a system
has been set up that has some rough edge cases caused by a poor
splitting.


> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
