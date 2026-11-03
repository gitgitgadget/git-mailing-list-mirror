Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793707546;
	b=mRsHI5aky+FgMNZ8AQRV7Jc/k8Ks4jsU1nIh8ZtbWy02nQeWXvnTng0mx/BJHkIKoqhv
	 MAebNMwpQfLwDOtUGPTPiQ6rQtR057E/ak18cPzzQnuJ2qxfK3T67Ss2YQgKJPa4jsQNQ
	 Gs3Ic9W4EEU97mTRfwDCurjZctqgRmsdosDmu8e8YC1UDMFDQcEv2tRk7hR9e6nSAOFYV
	 Z2nobeqsaqu0ixZ0ABSwaap3Wpy/9GHdyg7VA2FEx2abmTDVNKQ5QMKhH/U2Y48kPlSki
	 NnA5tRYNocBUJ29syA6w/4KAVAnR+54R/Wi5zpuGaYVZ7FLzdogNFVYjiwV5lKkma+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PdnbObIuzkavxgmniaGOcLvqTzZyHpgksNmFNLmJwNI=;
	b=AGOzfjcwILu9S+YRjt8Io/8LhgvdlyZNBNk3ydLCFuxXKh2SQ1vmixeqq7QF1P7sWcsU
	 XY09eqZLZfrxeWQz/+p1oUVM2VcTZh+e0KIDyog1Qps9Ypbe2mciZAdzg9gekXsEVubVt
	 3+4TqMh4+gO7hkMJCY+R/DWbLLTc0doMjbLnkIkpdsp30cx8QB3VZQ9A/lN2cD51LWL5C
	 m4F9pFyl7X4QbUsFCT/PVIdLR7+OgT+L05/2ggLNhr2C5rknGBEBx+0rWSiy5cw3kFLkn
	 /4syy9yemvOo1GKfXcHlc18FPtD1QJFqbe79RON1jAc/FjbKd8nyBajsJCzODtMXt3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=DzFdijOY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37729606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37729606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=DzFdijOY
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c434376dbebso140178166b.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:05:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793707543; cv=none;
        d=google.com; s=arc-20260327;
        b=dULdWPyXP1PawXT5N0u0c+0UqvTHRcm7u+4JU4N8QnjZhvx+YFogwMrzw7gCtMsnKd
         eheqNLOksCwZOJw7iXuC9clBTZrWiWSYeqOIqG5dQt7CsQtTtjEVxqBN14Qdl8oE5g3d
         C3JWjsMg70qVGLM/ERo/ehuXJGaDdA7D9QmP0mLPMgOOk6VFD+gBNDzVjdGxFxLMQywu
         rT/5WiF+SHcF6tph9NhBbFUICltlgwLFPgWLXRhaIxqqGbx12cGXQF9uBqhWfu1AyndV
         oRFr/Ontdgmp1MidCq2KmoQigJWEng7YiePFD5ox2S1/juwedGR188maOC+B16iUc+zj
         xleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PdnbObIuzkavxgmniaGOcLvqTzZyHpgksNmFNLmJwNI=;
        fh=kWJL4kofnD6Te/kKq779zYe6pxVPBtDpYoK/WoMqLug=;
        b=Pywk2EgkxidCqLkBUNeCyECuAnzhgFZBHyqAoSHUvDyFCX/kSHqvAj5DEdZhMFBsmC
         NV66OlnGuFN+boxKM12xyuo0CjmHCQTLOeVTSKNpfdHSeoj89GYTyVlxrniTx+HZMEMp
         Gunyf807lbJSZPQukOXONxI9x2JnfNCX0vGuKrawiDSX3uAHCx0hAie18cWfYyHQpQ5Y
         jgSVYYXtNWhPYc+mkUIjGopYL8c6UcHF2ohXn1iDiUz+/QIBjq0BNEqij8kd9Xlj5B0U
         yMxvOFBJk9so6pSGGvB7xxIJYID2PAGdMIH/FM2rQNnpYtoNDfs4e1LMZaKN56qNh4fK
         123A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793707543; x=1794312343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdnbObIuzkavxgmniaGOcLvqTzZyHpgksNmFNLmJwNI=;
        b=DzFdijOY5EzVndwoU4BPknu77987paYZXA4r6Qg0WPWjsYEb7zMLX4+0HjfsXgQOYR
         RlXBeGx8f9B9VKJt3Oe3M7a04UX4ISYTpu/AjlOMRQm1BLZHgwFQTu5rjAP+oQKOcycB
         Cr7E4lr7GfMpoydLpsdfMPWD6E9Xd8AMDB7ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707543; x=1794312343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdnbObIuzkavxgmniaGOcLvqTzZyHpgksNmFNLmJwNI=;
        b=10FTwZhevXFP/Yaj0Cx1Wkaz4Pa0bsLqO/KJYikRut/kNsd9qZDrkj2EbSRD+WGhSq
         +HE4bCDCmZQEbqmUCcmp58p85+Q70efMBaWZO8hPOflEmuV7TVhUg8P7D3ZfnSoDuJg7
         1TlR05HvVDvpD+1BerI+1A0+OzrdqbAwmmWZBgz9urdxKimdJk8+39KxpSvcoUXqfDC3
         DypZtztDMrAH2+1gTcPmEcyyrtncV+f9Zkjv9MbsihZryvbH+B5KeT0L2cwhdrwHR+wR
         ahXRCkrYWHzmDt+eccjoF59FgtqSlcE6RwNkI1ihZurA2/3FqKRq8UfPxDkGTxXaLqwk
         yiZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWDhx5Xi9Oyp3HCElWBx2Nv6Vzk9I8AECmxqjcyS1An3Gmz6zFWZt0g8HsqHbY22hyUiQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FBs3vNa07i5VoIiXGQ+CWiRDcpFPK3VtsKxul5259ElGIw6QX
	xnJ/tUEK2Pxuvc2jTjhm1odKjKfuhBr523c2/7u9V7bQvIKk6BQEGwhgNxxYPiCt1sqtKpuJpRU
	x3wPK147b5/uVqRPADBWhW4Qgm04+LlEkBbI+06qE1A==
X-Gm-Gg: AYBFou04Uto7Z9B/fRNE5B58mIZVmyCCj/obl8OZu4i49mDIUzrvl+N6omH5PmhAq1X
	RNmZk9cLk4F/QYN93Y3hqi1vxEGAv08YJcKiGCPodgBtAOvZ/TPlN/XPIGLaxi4vOSlbrwNvo+d
	51snWwXX7/jC2Ewzo4hH0Ssg04JqUFai29vqyPYz94oof6Uy7QWdxTA24c8aAJkSOFLtv5XudRo
	pW50k/5Fspygp/cyXoTNtEdGzxRuTpAIQJ1var0mFrdLLExmwhQ6zJ9iEmseKontnaw62+13LfQ
	RVG2qrBcX8Vyi9fhRc7OZp/ZEuAFQmCIJo7+rS11qqJAl80l9ajbHIm/9TslltQrzHujd1z9uCp
	VhCJVQeBeyAmKzXJzZpGn3wI22XPRk0dEw7vBpg==
X-Received: by 2002:a17:907:2d14:b0:c3f:2:6faa with SMTP id
 a640c23a62f3a-c49d10fcf82mr1380250266b.1.1793707543538; Tue, 03 Nov 2026
 04:05:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com> <aum-34I8KZvTfDRT@pks.im>
In-Reply-To: <aum-34I8KZvTfDRT@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 3 Nov 2026 13:05:29 +0100
X-Gm-Features: AclHuK9qZSw2Z8nQHU32TtgoMO3T9jjoWugjuMss6dg-RtizSlultx5yutYUTyI
Message-ID: <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in the quarantine
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 03, 2026 at 12:00 PM Patrick Steinhardt <ps@pks.im> wrote:
> So this here isn't fully correct as it does not account for all cases.
> We'd have to read the object storage format extension to figure out
> where the primary object directory lives.

Good point.  I can rework the patch to make it easier to integrate
with your ps/odb-object-storage-extension topic, by having the files
source remember its default object directory in
files->default_object_dir where it decides it, and comparing against
that instead of hardcoding <commondir>/objects in the check.  Then
your topic only has to change how the default is decided, and the
check follows.  Something like this, if you want:

--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ static bool is_borrowed_object_dir(struct odb_source_files *files,
- strbuf_addf(&objdir, "%s/objects", files->base.odb->repo->commondir);
- if (strbuf_realpath(&self, objdir.buf, 0) &&
+ if (strbuf_realpath(&self, files->default_object_dir, 0) &&
     !fspathcmp(real.buf, self.buf)) {
@@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
+ default_object_dir = xstrfmt("%s/objects", odb->repo->commondir);
  if (!object_dir)
- object_dir = xstrfmt("%s/objects", odb->repo->commondir);
+ object_dir = xstrdup(default_object_dir);

  CALLOC_ARRAY(files, 1);
+ files->default_object_dir = default_object_dir;

Either way, the check should not make things worse where it is
incomplete.  A directory we fail to recognize as our own stays
borrowed, so --alternate-refs lists its refs just like today.  The
opposite mistake would need a quarantine inside another repository's
object directory, which seems unlikely, and even then it would only
cost some negative tips: the traversal walks further, but never
accepts a missing object.

> This makes me wonder whether the better fix would be to stop modifying
> the primary object directory and instead we simply append the quarantine
> directory to alternates.
[...]

That does sound like the cleaner fix.  Since you are already deep into
this area, I would be happy to drop the fix and wait for that instead.
I expect very few users to be affected in practice: mostly git hosts
with many hidden refs, which is the case bcec6780b2 was about.

In that case I could send just the tests, with the hidden refs case
marked as test_expect_failure, so that it is covered once a long-term
fix lands.  Or, if you would rather have a short-term fix in the
meantime, I can send a v3 with the change above.

Thanks,
Kristofer
