Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963559;
	b=Sazn1Q+rj9qWpuwCOq1UTlXTQP/Br0+CsAWhSHIcXhgGyKaPGfgN64a0hlKSJ8wzVT0R
	 kj7YjQlLd0gPWklYq/5GjqyUk2ms2bMQNH4axDCjlI0+Oq5bG2ptecnq6tpFUCpBK4oJj
	 zIt8yJQICYqHK8rQjaeLG0YR/smlrf/+yiqXUHwnLrtQ4azruKPZUi34D5TTFXajdmK1j
	 IgrR1kdxPdxxhKjIC+Z0EKT/odxQOpnt9Kc13ajiDnD0lxzqCKJWEkgzi2/fj5fIr1bLr
	 l4gcvvhd1ck72kcVGP49gbPOxRm3ItBlmYTRB0Y7XA8/2Hxa1B616s/0Ix7UTKjhMGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5tO3PHykZDQxU8F6I4Mt5DUYu2xQKml7DY4mAkgKmi0=;
	b=iEHAnswLgA1S8bopMl37Qb9I/rKkdMkAJXKVQFZCU/7CCT+W8GnlWtAINpswTfDNG2EM
	 XIZmLi6NN5it1TERowLIR47osfa5bDBC2an6DipBHq3f4BB5J9eE8XBV9i/h1kR5g+KGg
	 rfXKLRyERTlPP3FVwdJFpKHj5/KXs1Y72SDIEUw3ApkmDFtaE0fQfFhpkvepEHgrrlHBB
	 hmM7qmowhTQo1kfrqNz+8Oi1OnCtYLHIK6R5x/jF7PcPM9WZ4Lv10nM4ddF0QHSEWlquz
	 amTup68zkYBGDNxeFYXdzmynF0pz8oN2Ii1umlc8TJ/LzvDfoFdmNksgEjJnoLTn8jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="oS/JySl/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FE606A328
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 21:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61FE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oS/JySl/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so13670525e9.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963557; x=1793568357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tO3PHykZDQxU8F6I4Mt5DUYu2xQKml7DY4mAkgKmi0=;
        b=oS/JySl/Wsh68X35IvuWimDOUj5Vz622WuRJWjc2XR41EUrhlv9SBTFywDU/J4T0gA
         /cEJvxc+Z1u9GAiStDJmkiarvoqvI8AEMjnKzNb5JO3cF84dPvoJn9jTY2vAwPsZfAgQ
         tmUbpMgs333fOlyJoHmgWreM/xED7xqzc7pKi9Czb/HV0MtUGJ9Zd/kuhbPbI3dR7C/V
         yyrRnz2SsYXLa32GtdYU/ZGTxNuoO4gyLSK7aZ1wrVwVfmHTmCwLnnFxBglBbk0X+I31
         CDnDGZBpobn4JX/2rhmMz14fqZncnoubBAYpe21hcl8UylG8+VVjzAE3KRpz2lBCU24R
         0OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963557; x=1793568357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5tO3PHykZDQxU8F6I4Mt5DUYu2xQKml7DY4mAkgKmi0=;
        b=zAFzuiVfmixxcj04ZzF+EDnCYwFgaiFnYvdHcVsN0YGhsyLp/8QC7iZ9kJdHbnILXC
         ojMMRdP+F5Ju4PawH7F+aihi73HxYbu7nW55mc6qlPmYlIr+iv+vKcWEtJBhsupyEvYH
         zmwppQnBHDReFl1VpxYVGH8a2QGq3jcInEkj44mxbuJCPvaKTxhzdY96B6PtFPf6nJ0F
         QGE5tCXIQCn6Bvn4fMI4oXj0gmss7ANtLLIzY0484ldh5MmxdrVL+AILD7NXKTxcRXJL
         H0odPad1zQ0RkwioU33L4RhQhpIKiv6o2FGVWB4Cky1+bQatu/NfTnUIQ+8azZ9kWRYC
         mgnQ==
X-Gm-Message-State: AFq9FYJ+ahny2mHYEo2J/VdkXVXVFaPnRsEGfvaSA3WLiuED2ZsTrqZt
	mvaAoWsELKFp6w4KvgfD5xZfEFPTmY9zERg7MYegqXJFHJYwzkJzBMIr
X-Gm-Gg: AYBFou2STx/vSMxfcfOucCqA5+v5lYHS3rkG3lw9uFBEvwhIQa+xcQhqIOQ8uVcgVs9
	M073jPGC4iAhiMESNk7zpBiEyJOzqdXr74twVIqkKAjQF7OS7O/gZwG3TLoxOBnzZZnoDhFIcvp
	htI/tOZ5bRDR+epphG8dS/xGXzRaKBIFCue8p6XXnnId34AgC7gsawArqHPmA6ap1LQYKwGV+TD
	dP37BCQrApjW/KUUNDEnzMfCeRIS5hn4s1xtnlO23vqOxoZarGckmgdObaMcIKsmojp6bLNsdd3
	jZ0wTgW0vU9rgmysD4wkkTbpQdBOD7rfc1heJ3JuLlLyf13W/oWPeWklLpO6Zm01kxhKG7ri/CU
	yIwPxDsxOljDPaWycOBTDgEY6AZcXAO+Fd2L/Qjqr9cHgkDogUUmSOzdhvQB/nYVZT2rIRaBq/s
	GBIT53LMVA8ak8QFLf8oFMH7dNhqY9v36+x9SoFHono2mkfATglV5QxvmbMscZof9V68l3A+HR6
	jb4zfH8YNx3vjopKFQBjWgtOg++j0DBq2gQ1iZrxUWhfdZbFAcGHQ==
X-Received: by 2002:a05:600c:19d4:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4a35acbbcaamr85538305e9.25.1792963557068;
        Sun, 25 Oct 2026 14:25:57 -0700 (PDT)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm114723975e9.1.2026.10.25.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:25:55 -0700 (PDT)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: jacob.keller@gmail.com
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an absolute path
Date: Sun, 25 Oct 2026 21:25:17 +0000
Message-ID: <20261025212517.479922-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CA+P7+xoSd2rsHpw+n5vCrcqXRibG6zH+SKCsVXA0OW-VZN_+=g@mail.gmail.com>
References: <20260929185122.3127574-1-lightofmysoul@gmail.com> <CA+P7+xoSd2rsHpw+n5vCrcqXRibG6zH+SKCsVXA0OW-VZN_+=g@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 25, 2026 at 12:42 PM Jacob Keller
<jacob.keller@gmail.com> wrote:
> On Tue, Sep 29, 2026 at 11:51 AM Stanislav Aleksandrov
> <lightofmysoul@gmail.com> wrote:
>> - Why not url.<base>.insteadOf? It has to be set up on every clone;
>>   .gitmodules cannot carry it.
>
> Could .gitmodules be extended to carry this information?

Not as a rewrite rule. A rule maps one fixed prefix to another, and
.gitmodules is the same for everyone, so it can't send one person over
https and another over ssh with their own host alias. What differs per
clone is the superproject's remote URL, and that's what "../" and "^/"
resolve against.

We could add a separate "same server as the superproject" key next to
an absolute URL and then Git would ignore the host written in that
URL, but that would be really confusing.

>> - Compatibility: a local "^/..." path needs a "^" directory in the
>>   superproject and protocol.file.allow=always, and "git submodule
>>   add" refuses it.
>
> What do you mean here by "refuses it" Is this character already
> refused? I.e. "^" isn't considered a valid directory, which is why its
> suitable for converting to a special meaning?

No, "^" is a valid directory name, and today "^/org/lib.git" means a
repository in a "^" directory of the superproject. By "refuses" I
meant that "git submodule add" rejects it, as it does "foo/lib.git":

  fatal: repo URL: '^/org/lib.git' must be absolute or begin with ./|../

So such a URL has to be written into .gitmodules by hand or with "git
submodule set-url", and since 2.38.1 it can't be cloned without
protocol.file.allow=always. It is possible, just very unlikely.

> The ultimate goal would be to allow users to specify what protocol
> they want to operate on.

Relative URLs already do that: a superproject cloned over ssh gets its
"../" submodules over ssh too. The problem is that they also follow
where the superproject lives.

> I guess "insteadOf" even in the .gitmodules wouldn't work because you
> wouldn't want to apply that to everyone. The issue seems to be caused
> because of the URLs on Gitlab changing such that relative paths don't
> work anymore?

The URLs don't change. Forks are the problem. A fork lives in another
namespace, and on GitLab often at a different depth, because groups
can be nested.

> Does doing something like "../../" work to allow the subproject to
> find the root from a relative path? Or does the current logic not
> support multiple ".."?

Multiple ".." work, but the count has to match how deep the
superproject is. Let's say the upstream is https://gitlab.com/org/super.git
and lib is https://gitlab.com/org/lib.git:

  - "../lib.git" gives me/lib.git for a fork at me/super.git, which
    only exists if lib was forked too.
  - "../../org/lib.git" works for me/super.git, but gives
    group/org/lib.git for a fork at group/team/super.git.
  - "../../../org/lib.git" works for group/team/super.git, but for
    me/super.git it climbs past the root and eats the host:
    https://org/lib.git.

"^/org/lib.git" gives https://gitlab.com/org/lib.git for all of them,
or git@gitlab.com:org/lib.git if the superproject was cloned over ssh.

On GitHub every repository is two levels deep, so "../../org/lib.git"
works for everyone. GitLab and plain SSH servers have no fixed
depth.
