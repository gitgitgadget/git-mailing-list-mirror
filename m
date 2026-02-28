Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD23423A83
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275890; cv=pass; b=PYCSKGdPhEqzTPRsuu+XUzftWyXL2L0yWvoKUpmtl0Kx19otKXWSZkW+CftsbQkD5e/qzKSUCn2xFqWdw3c6ouET/rgkKrxQ8vXtLj/Sc/BSQkb2JkkjtR7mpibCjWFHQ0QYEcNSHrGZmr31hzLauBbIB1QxwOkscuw103UPOvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275890; c=relaxed/simple;
	bh=vrVHf3IRzgEsyAQ+xpI+DinCiKHYodjxDW4sFmypOAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/NZ4wM6uv/bXnl/U+38h2BNpSpJlppd0X2IpOLbc0Em9xyahJO1Cjsxz6X7PaLb1xNU7a2wmWjLtvbSOlsmgvR8lPjKW38pksnANU6i4dXk4X7gyqHcpYaIXhncZPXhwTqRG4OdcqKelgUoNqWY8n9bUoPsQJdtLh6G9aHhU9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgNdfdf5; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgNdfdf5"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad79df972so3001804d50.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 02:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772275888; cv=none;
        d=google.com; s=arc-20240605;
        b=PE4eeC56pM+XItjKANFwWX8aIu64Uq4Fg8oKIdPFJFEsZUZj6rl7GRISbrmqr/wO7r
         8YCpeIPM6OpBT9LaCDVwl5qLKWjd8cHffljpn9Jk0QmNMxxQvozhxHuirVcBC/IfTUCc
         9eB35isLlDYCYJUwqdEifWxYgasIKEn4S46IDBleL10V5ryMm0KOQnVazAvAJ5TbgxT6
         72iiadP85nBmfRAk1MoyXVH4Ywe2c01ZNIC4mFTY7vizMw0uWdd67snsS51WjgqWdeTk
         tQrG/V+L2uaGrVcF+SNRLR++UQWkRcKzo/BkG/lG1BRXNLBIFvGg4NBMDn1deef4tJf8
         qCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aw9j2bZjstdPQy3iMLkNZTT0S/jyl84modHBtetJ2Ow=;
        fh=dyqx4q2bh8e/daHqA3J7TKDncsgY4Xrr5cVwvb8Heeo=;
        b=iZ9GxGPYCTqX3pxExA7z++55pxcQADbb+KX4P2lQcy3mkr2U3KXW25VrR/Prr7o5BP
         B82jP5mrZALQUhGNSoAduIQM94Y7CDB4BcIvdoBZioGy/vJLVaDk4E0NEHe2GMi16lZc
         rnv/XT7blHJQ+8VEzbFuh16cM+8bacLSv+BVhh/5CMx8ZcckVYlWPzTGjFjpqk2/j+BL
         +rjzhIgpj1IV7R1wrXal/VgoYKr+NNCLTrH+hHEv5Hw2kUlSSrZ4fkEJ/xJKzKkTu+KD
         Xvjhhmtb5Ee/xyxghrESfynPASrxiRW6DdKxGdj1yB/MnzU3xODZbXqjTtvdvQ4e5UUJ
         PP/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772275888; x=1772880688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aw9j2bZjstdPQy3iMLkNZTT0S/jyl84modHBtetJ2Ow=;
        b=TgNdfdf5ycfhMJd2dNt4EOxB0o7oocMhUNY7vQ7aErWrtTHeCm3j3rEsJOCigWoB42
         KGVfD6dhzPPiQT0Cq8GVV/0NShlxjDbLe/v4cM/ZNXtcDQIJLHtv0RRfxAniiUJMtKOl
         u+cvgcXuSaIgn3kksvQrE/LuiSx0aag3W4/tY42oS1vbipkjUUBpDOz8tw34J5egYqcY
         hOaQasxHF3/mUfT7k07ftkJiHkEqbKw9iLctn3J/mtCBHN2ITL9MhS02jJlPXY84XWUi
         6a8rzX4AlzXAKsypD4MV9fk5iV/1Y/902VgyflD+B8TeiihfCvSAxuuNY99GpsZjtGAH
         n6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772275888; x=1772880688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw9j2bZjstdPQy3iMLkNZTT0S/jyl84modHBtetJ2Ow=;
        b=aAz494+qBHP1a/K4d7ssoB7Bx7xs5uDfk+K6PGkTSAN3aUNgBRlSM5Nc6Y9/facNi+
         KNtgPnf3WvAuoS4Kqpyan3uiYRfNX277XmjRCGOB5AZBxwreQNJQzyRiztie5mOswXeg
         dm9qrBOdJ/IMHnQ+zOnuDaFzJ8blMS/SHzcztP0LPw4DGT0xFvYfIJUg9uK1j8VoD8Xv
         OHiTUWVjWiaANNr+XokFL8hPkrfsfzqi3tSC55UJv3EnGukd2XJI+uOMqr0QKcpxN5mW
         j/f/rs89fbItNQZuCY7HJ3iCNlIjV8oFIgxL3Zh7CKynxxmAjGBX/XQbJYzdFQeaz/C0
         f3sQ==
X-Gm-Message-State: AOJu0YzukIdOnIJGmmenA01pncCYjSlaU4vW4iRIV5SRUnluEk6qpfIQ
	H5vd0O7t/ytkrM7yew67/lut+NSetXBIGthYEkjg1XRrXMD/T/xYUO57M4z5mxaSOt3zn6TSST1
	1BgqASlz4vLvrIaH5QDN+ZZ5AyOQ1LBo=
X-Gm-Gg: ATEYQzzSE1yj0FNh+Ig+EiR8SLPfzGdTU6KMViPe+aF7cUJSdOdQzrwGMDc90FqQlWx
	qmnkyi3MnbQjEkI0jRt1zc3XzfdPoCLswnr5vMINfHJKAg/BsjaHkJgu/O63pnUMT34Kwfp7B4+
	SJLGtluXVU6uLyifYvr3Sf3clcDn+kcc3G1VdH0b3xWJLdGDfGbVtLatk/jRhigN9ttm6vuFhki
	1SD+nsHj50nuF3ESVoF+X/GigdKjeDNnpVCuD6cApYY3o90EIgSnqhc8njt8gE2S7Jr5JYoDV5X
	6aXxaVA/atYK84bppaCOAafiZl5L1gekTdqxjUc=
X-Received: by 2002:a53:d38c:0:b0:64a:e3a6:c393 with SMTP id
 956f58d0204a3-64cc233344emr3625907d50.77.1772275888087; Sat, 28 Feb 2026
 02:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260221162359.43336-1-amishhhaaaa@gmail.com>
 <20260221162359.43336-2-amishhhaaaa@gmail.com> <xmqqwm05qsei.fsf@gitster.g>
 <CAPvEtrfmgq8f2z7tAvR-oCEYoiG2B+Pj9EqjUsKuewnO73tVPg@mail.gmail.com> <xmqqjyvz4foj.fsf@gitster.g>
In-Reply-To: <xmqqjyvz4foj.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sat, 28 Feb 2026 16:21:15 +0530
X-Gm-Features: AaiRm51knxqqokbjOUDBQ6J7a3ZlEhvExGGAEivxob7hDqWDjezDp7EmAnC4j3s
Message-ID: <CAPvEtrf_m1Uae27Z9ZKsSJsu=_HAeT8fMO80cnVGc4dfVtrTBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"

Incredibly sorry for the bouncing mail once again, I will fix it locally.


On Thu, 26 Feb 2026 at 22:15, Junio C Hamano <gitster@pobox.com> wrote:
>
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
>
> >>
> >> The striking similarity of the body of the loops in these two
> >> functions bothered me enough to try writing this; the result does
> >> not look too bad, I think.
> >
> >
> > Agreed, I was also not very happy with the similarity present at these
> > two places,
> > especially the wildcard and tag part, tried to convulse them into something
> > singular. It again started to look like the original so ultimately
> > kept it like this.
> >
> >>
> >> By the way, I'd really prefer to see contributors *NOT* to use
> >> undeliverable and/or bouncing e-mail addresses when working on this
> >> project, as I'd always have to edit the Cc: list to avoid getting
> >> bounces.
> >>
> >> Thanks.
> >>
> >
> > Thanks, I will take care.
>
> Thanks.



-- 
Thanks,
Amisha
