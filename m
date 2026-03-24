Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77A23E320
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367169; cv=pass; b=HmRh84XFXfgddFEe7mhyAnR6LfQ31zToq79Gw2mbeXAO091NDSCGV8dK7I8cwjJj8Dd2yJ4pFdo/7uprCefjRLw+fC9/YZCymUZwLcPbHFwJnC0u4k6vlQg4NWXRyUoMgyvDoFYIcSn0hvNbeUDBQQpkb2PQa/xAfqUt/BUFDUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367169; c=relaxed/simple;
	bh=Grn0khOS4JAipLBkfpnFdhHs36AVmqkQCEpswOVTm1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKH3+DYwBm/C6eh2l3h+Pvp/4G4PZu2ldYQcBdmcRb9hfrxAo1Lp0m1wjUBfRW/W5C3fQAgd6om64GehP+OhH6pOpUpns4Z2qeAI+5xOtfMbvBiyDy5TTPSAPx3FgqlXSxvazaQPEj5Zr+YCjgAm59efSV01jmJ39dWI3BCHuYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv1WC14e; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv1WC14e"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3427805eec.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367167; cv=none;
        d=google.com; s=arc-20240605;
        b=ODQ7oUjgxk5kD+vBY3uBQHdVWgv3QTt5g+fU/XnD7Oicj4IuD8fjzeChxtXRLMVer9
         5WCB0ITz5go/6LzyGJWWXeF/SR6tqgyhi1v3QFAMQV7kB66h/WU3QAdoDFfuVo5Lv+0L
         V8kxHOAktnZRL7f/yDOtZiAQu3Gfv+j7T19W6PxPQbi9aCepMcENbiyYyNnicEgG0IDl
         gv9JuzAarWpnxPoGkwOfpWoKHDJi3iltxVbLDuQiBaPqGFRN/Nmsx/I5xhNKE4l2tcTY
         rCmA/yXgUZbI2hm1+AxuUIM/Gjpa5ogOwrb3b6U40Od84OWu+nAgI4Yj0M+e0kCEMYKU
         Q+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Grn0khOS4JAipLBkfpnFdhHs36AVmqkQCEpswOVTm1Y=;
        fh=yEE4jbkyo5i8oazTHT4hCUxT5On7YUISrf6X4i6bnjQ=;
        b=RF4KMZQgiNGTFAO6K9AmfOiwUCxwK0FFB5GBLRNwrLdk28yx8kGwQqcbIk5nOumvK7
         LxvsaZk9vgdF/DWugfj3V86uVD+wN4OjHzof+4WgKBHcw/xcgmMmT5z2tB9rV9/FWG3p
         FvjpRE8yy0kWSuYyKj8j+iG3QhInqKPMCuAcmdxfKM+1hUKkKFxPVY9fr3jqfCd71NWt
         0DYDBaz4s2sExAm96woBEE5D91IQuodh7If9LUzs8/MITqzWYsER5hB03caI89LiNHwa
         ugLHVN3rVtaOi4Fk54ydY23XqWDSio5mwNt0WW12FikZocOnICdyf9z7K1AP0NTGakia
         Xd1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367167; x=1774971967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grn0khOS4JAipLBkfpnFdhHs36AVmqkQCEpswOVTm1Y=;
        b=bv1WC14eXEOKB2ffAVu1B5SV0rMxKZy11E9iQ9Cnmz6M/5MuHgMOdzu28UMNfrDBQj
         Fu/GzpcxpM+anKwkke0gAwC+CqRg7oxuKukFNaZD8Q/Xzpq8pVBhRahduZZNnrgl+T0a
         cV6E2aF50kXsoG0FuS9AOYNvp7CqUE9LeZv2MRNqXSREIY/Ettu0UUodLdGsMbv8kw22
         Er40hjGYcmrMJmOUCqM9J5iGoTvtSJFhcF3GyofvTvznrXcEj3+2A9UZqpyqgh5BfPH0
         AoIlSMiu8Mkf/Qa/sRM/VHpOqbAq+YXEp7cwqpDSDLNwapRwjw2j6lvjCQ4oQwTk4fKG
         WjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367167; x=1774971967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Grn0khOS4JAipLBkfpnFdhHs36AVmqkQCEpswOVTm1Y=;
        b=HzjIHGpgHx9xrbX77IO6DCM2/hZdG3hiOj8jOuoV3jRsZJF3yr9OfP0gT1hAxAwgFg
         t4Pl6ryKNfs4z2m6+ZbjbD65495VK7fpNeNA4N1/rVbl6PGXI67WFZr7pcs1CZ853gYr
         yDQC+Z7z4M9cbY/0cpO9gMW/C86mt5DipTdZhia6XE1qm3kYXQRUNh3T1cRGIL+Off5X
         WV4HLGZ2XXSJKc7b6hGGIebFo2Aq0Dz+Vpye5Em0CKHvjLG4jJLaPSE2CPvO8hoH+nFP
         lhV7KTw6heQ5VnfQA3tRxyPqGvz2EZvyAxn8y4ysnE4Sw0vkOGvTgcQW+dOGv/mEZIRM
         De6Q==
X-Gm-Message-State: AOJu0YzXVoLfSM1Wt1D4xENo8MwHMqXDHxiLdRlQOknYJe/Yilx25aPk
	5xvn4Wztfa6Wu8j6ViRcKp8koY7TD8eN77poyJEkOJx2wZlQnAfk0UhDcljBS2JzERvKohVHgLg
	0pFR79LazQ9KwP84VKkoSyZJjFDMS9Tc=
X-Gm-Gg: ATEYQzzHdxhrPSQ5Jrty1f6jRrR7WoHPRH2NnjE6K4cosxM0he9WCM/ecWKyBQ+zSrZ
	iWxO8tqwUPIwKlXLJ5mrXI307KWpWASuBb+EOX783iXDz7OTc/TaF/DX3R5Kfc4ATf3B5s9KzkK
	UNKYmUiY9S5ljTZkUZRCOwHRBqTbDd/tdg0oG95cr9UXBQDZIEKQ+njpfASiCrE5XPFI5+hvu4e
	d8ZzDHQzyM/Vjj19Wwp2zVXg5BBxuM2b6GDaN/6co6ZAaKIIWa+46V042FcP6CPCJfpl4BuGxJ6
	uOLgoDv4bE/GEGDkDLP7GXThKs8HGYpbCJ2hqA==
X-Received: by 2002:a05:7300:5b88:b0:2ba:6c66:1f0d with SMTP id
 5a478bee46e88-2c1095ae76dmr8854316eec.14.1774367167144; Tue, 24 Mar 2026
 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgEQTPhxPeEYkm44+BuSj5GG6PWhRrqGT7Vq7zXFPKZqoag@mail.gmail.com>
 <CAP8UFD1Kirbt-j5h7NB0UcxPjz=Ger7GBK+excY4Z8X+yKtdzw@mail.gmail.com>
In-Reply-To: <CAP8UFD1Kirbt-j5h7NB0UcxPjz=Ger7GBK+excY4Z8X+yKtdzw@mail.gmail.com>
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Tue, 24 Mar 2026 21:15:52 +0530
X-Gm-Features: AQROBzC79MaW5QCWm6torwAaGQ5YEc9nfUJPNEzZg-2n2lzsEBOl2d6l-zxLCm0
Message-ID: <CAG7UgES4Vm9yboUk1nnPKHBdMu17gt-2dh9VmXD_=Lpc3o+3Jw@mail.gmail.com>
Subject: Re: [GSOC][RFC] Draft Proposal: Complete and extend the
 remote-object-info command for git cat-file
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > - https://github.com/processing/p5.js-web-editor/pull/3492
> >
> > - https://github.com/neovim/neovim/pull/33235
> >
> > - https://github.com/kube-vip/kube-vip/pull/1087
> >
> > - https://github.com/WasmEdge/WasmEdge/pull/3963
> >
> > - https://github.com/openfoodfacts/openfoodfacts-server/pull/10037
> >
> > - https://github.com/openfoodfacts/openfoodfacts-server/pull/9967
> >
> > - https://github.com/processing/p5.js/pull/6761
> >
> > - https://github.com/processing/p5.js/pull/6669
>
> It could be interesting to introduce these contributions a bit more.
> Maybe for example add one sentence to introduce your contributions to
> p5.js and one to introduce your contributions to openfoodfacts-server.
>

Sure, I will add relevant introductions for these contributions.

> > I was also grateful to be an LFX mentee in Summer 2024 under the Open
> > Mainframe Project. During the program I worked on building a new
> > frontend for the Software Discovery Tool and integrating it with the
> > backend to make the tool easier to use.
>
> Do you have a link about this?
>

Yes, I will add links to my contributions from the program. Thank you
for taking the time to review my proposal. I will incorporate the
suggested changes.

> Thanks for your proposal.
>
> Best,
> Christian.

Thank you very much for your

On Tue, 24 Mar 2026 at 16:12, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Mon, Mar 16, 2026 at 8:59=E2=80=AFPM Deveshi Dwivedi
> <deveshigurgaon@gmail.com> wrote:
> >
> > Hi! I would be grateful to get feedback on my proposal draft for GSoC
> > 2026.
>
> Sorry for the late feedback, and thanks for your interest in Git and
> this project.
>
> [...]
>
> > - https://github.com/processing/p5.js-web-editor/pull/3492
> >
> > - https://github.com/neovim/neovim/pull/33235
> >
> > - https://github.com/kube-vip/kube-vip/pull/1087
> >
> > - https://github.com/WasmEdge/WasmEdge/pull/3963
> >
> > - https://github.com/openfoodfacts/openfoodfacts-server/pull/10037
> >
> > - https://github.com/openfoodfacts/openfoodfacts-server/pull/9967
> >
> > - https://github.com/processing/p5.js/pull/6761
> >
> > - https://github.com/processing/p5.js/pull/6669
>
> It could be interesting to introduce these contributions a bit more.
> Maybe for example add one sentence to introduce your contributions to
> p5.js and one to introduce your contributions to openfoodfacts-server.
>
> > I was also grateful to be an LFX mentee in Summer 2024 under the Open
> > Mainframe Project. During the program I worked on building a new
> > frontend for the Software Discovery Tool and integrating it with the
> > backend to make the tool easier to use.
>
> Do you have a link about this?
>
> Thanks for your proposal.
>
> Best,
> Christian.
