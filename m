Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDB28B4E2
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931441; cv=pass; b=gWQNHWm1QLkEK6GC7XN6Jskqa9D2Ul7tqkyzdqy5aDAC9UqSXiLj3hVLm+9g3tMhwWL9fenNkm/mY4PY7kR4yR6AX0SuaT8K+Ccrz/qeyNBSHjzFVm7L7/nJTm+Myekh2ggdF4fkIPPGkMaVmw1hZ2vBqs6bhG8vMWqLkZbTIcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931441; c=relaxed/simple;
	bh=i0gqqr7+HchGZ+vZtrsSXIamKxJM0k2VsiIZLg8OdfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7frXw6mXceLDBbXhJpNcIGbF1QJxp09nlv/8zjl9M/naGhqSQeMFWsbkZmF4QUytBqtDbtOs+28DnusZ+j3heIAXncQkfun3fRint+ocAMYsUBT+J6b5prG6/oeaLHM1zcBVhqUk7I9RZJDecBGrQJZ4LePylLPHyqrit3MKck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9dHrkr8; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9dHrkr8"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-149d5ec8e96so1950686c88.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790931439; cv=none;
        d=google.com; s=arc-20260327;
        b=R1J6A/PZIuk187O/bICk+iUHDglBrbUWKzr5bGl5u+DVHXGUlIECKHQCkJjgXox/P5
         VT6EdNIomszUAkD2ytXGAZcpQ3AgpQTJ9Nr+ocrIF8WTQmZg8Gn4GBFqW8zP3wfEc2Xt
         DvxlOmuVZgjP4YTsmYlmQEXvi2LtrYYcW1T3J3ESfQ0816ejrKhvJC+uQXCknxKUBQ6t
         9UyeKr0jRKRCy6eAEBjrJu8Uj+A3c3pMV6OjF85kAX/ye6iHceSsToDf4sgt04WGPTRn
         PeRjTUPC0+TcpUeGRDxLPGe5c/YC20p2JJlI+YqVaJa8wPE7meqOZcbSDFhPtR2yC4PK
         khCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qqu5yz595XzPNLl4YOLJJ+eL0uDSicgYNxefWzZz6Vg=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=kh7O869oomolbNqfPizkz0zhEucRWtvQNXBfDAsMqTnTMCTC6VpKuH5jZpRD0qolbH
         xDlG9wNbnDHwlMEYhC9HPE/QSU8zCu7fFh1X27MCAc7vwGGmLmpB0PdBk/cJkVyyUat3
         gQDU9XIB9FDOYUuE7YsBl1CRAyQUB5SzUt72BhnHSml6VTC1JIh+4eTHcX8fB8cHgO85
         tIzs4zwS7mBe8humr3tBbDNPqAsYGt84IRkcMrUnkSlwtV4o8sogNSXQMETeBR6j9Cy7
         tsBOTy1Grl3G1l8eQLkLVpGU2Y4eKHkH0FE7z388x+AEVY9WrzwrDLwmmz8YwkV3kzHt
         kVbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790931439; x=1791536239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qqu5yz595XzPNLl4YOLJJ+eL0uDSicgYNxefWzZz6Vg=;
        b=n9dHrkr888cj9RxfdCmBIsiSBPCwOHwhbHxZeQvJgcq5g1nHAzfMP+Wx/hdqi1Xz4z
         UEHPbqY4vcY6wNEElTb/S1/ZOV6eX4pMUpkYBerVfqYZROl24U3Xz4m1I3oA+HJLgT37
         Fl2Mv28nZEnJsWRBlx/eiTBGMP6r+Ue0ifWq6iowNFpKmyrWRZ15+q6Rvn9A3RYdgqAr
         JUtr+Hds1GOwL0JpGYznbFKbFrHUEFh9uzum7BPCn++7wrpYNQNaf8HcyjEy3zF/1PLX
         /Jx4ijw3t9S3D+oSBru4gbtUrP2SIPIP5Zn4Yza30cf+UkGCHatNiwkdlS8pMDZ1Z/I3
         TVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931439; x=1791536239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qqu5yz595XzPNLl4YOLJJ+eL0uDSicgYNxefWzZz6Vg=;
        b=qlAL4geG5NYkaHlogDZutcQloeCeMmxroDQCn0TXZTyHwBKUrN0BIzuLsVBbs/xk/T
         H+X+ZRqvTdwcGs9+fhdWPdLnbeqyPv2kKC0ghm8nLRT4mvmmAC8bamdvt4DuTA0nl35V
         ZBLlScfXP+pIrf0VMfmrbdRwodtpEaEFgr9ejLPJ+R/heGo7ug/HzFqNKIBu4R5fxzMB
         d3BHeA2HdexdAdcoS/FZpdWKYeqgo6bmXzZbLVYuX6Gj4vsXbaIf0lhcVkCvA17mu3XQ
         5r6XKl9krh8tS6K13M0jJCrpgN2adtbF+Rbw9C9B4EY8iKHvJgF6SEdqGEdD1ijzh5TE
         XnKA==
X-Gm-Message-State: AFuF++k4KHo8+W8YNZfsWFTlo81lzbUhRyXqhREpG/Kwbt1i2HgXBVDC
	XffbTnnsUdQr5gxz4KnnXLP0onGNxzm826jMspa9acVmlDpTBREc5sjnMC7dTYxlw4X11RBzuq0
	eN6Q/nnq4fDstE4XPVAne86k9vYuVqiM=
X-Gm-Gg: AYBFou3MuuvTFi9hdlPDDx9FpJrobrFfV29nMylWI8y79px5xqXEwAGNm20hurcTTHD
	Rs4iqDykdwWP71tyP/FI8c7E6OyVMzEErLkfWecIbhqW8OFb02lyxThOHQCHLcTXV0EcLxBDN0f
	aUEFwxiQ7zamFIaD5rFtIqfFQi/OcqQi7qHN4kTsjlAb42CRVtGuEPglWDHxBDGD840HWGCDaH7
	5/GpXth6cYMN2rGjZPAfBRTBL/q2BZ7MpEM42K/HrQ3kIMF74Smx39ALEutIcqm59Y1PLAJPRg+
	tOivwA030H2/J7lJgxtRs7u1UcaR5AibbYLyn09E+hIQYmupJTVtsLv9c8wmGlTedZG+ZiEQ3Ba
	f9PUGNNgJl42m7WyWkgGWQ31ohO2K0OHOvMqN62l2/Q5sPQ49+2Hc57kMLmHULWHLu9OORKA3Cn
	XnexBFlB4FnTiqwOJ/CTrFRDx6ZqADVSKCMMUUUiE=
X-Received: by 2002:a05:7023:90a:b0:14e:d29d:2432 with SMTP id
 a92af1059eb24-14f5cdc8295mr2084420c88.38.1790931439062; Fri, 02 Oct 2026
 01:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com> <20260928133846.2094261-6-christian.couder@gmail.com>
 <xmqqse2sgda6.fsf@gitster.g>
In-Reply-To: <xmqqse2sgda6.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Oct 2026 10:57:07 +0200
X-Gm-Features: AclHuK_fVWZh3ao2pqXzGlyXgx1QfVfe07qQETVknMO5whQ84cDU_buLXbELQu0
Message-ID: <CAP8UFD2Ks9mJ+Gdw02VXjpKv16HTxXTtQ3_5_heP_1TOfsHb-A@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] builtin/upload-pack: don't disable lazy fetching
 on trusted repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +uploadpack.lazyFetchTrusted::
> > +     A multi-valued configuration variable, each of which contains the
> > +     absolute local path of a repository that `upload-pack` is allowed=
 to
> > +     lazily fetch missing objects for.
>
> "each of which" lacks a plural noun to modify.  Perhaps
>
>         each value of which specifies the absolute local path of a

Yeah, "each value of which specifies" is used in the v5 I just sent.

>         repository from which upload-pack is allowed to lazily fetch

"from which" would not be quite right, because the client would lazily
fetch from the promisor remotes of this server repo (using the
"promisor-remote" capability), not directly from this repo. So the
rest of the sentence hasn't changed in v5.

>         missing objects.
>
> > ++
> > +A repository is identified by its git directory, i.e. the `.git`
>
> "i.e." -> "i.e.," (similarly "e.g." -> "e.g.," below).

Applied in v5.

Thanks!
