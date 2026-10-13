Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA954DAD9
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923557; cv=pass; b=gYBJcxsO+y2yRUVe8JbI7KKcWJXlVJKzfYQYcrVVr/GLNn7EhQWIT/2eLpTgwli1+2UTU6amV08mZnZdfcHOBVEDQ7D7nSRLE/abQkcGsj6KIubYZKAKHDKElRlpji/aJBAEqkcVGrTrD0QS/cAKEFgDR7tX71Qm0ODLznMg1fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923557; c=relaxed/simple;
	bh=NYmQqPELTstMK06OiEDZ8O6DGBmnXAyBisnlU4AAuqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpBHCEgLh4jpAEU4w7UYROyG4ia4VZ61+/4Rm8hYmTiX0FQQp5Wd78yhrdShmsHVtOmlw9JGu33f9eErzGU595blWiPoQbKBdhJFpL61yJ0bJdPU2f5TYrYtiqgoqyV6ZdOP++VbYvJ69IuIYHGIywDeWZvJWP+wpqO0tlhqkTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qU/CIdrI; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU/CIdrI"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-677af43eed4so3078958d50.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923555; cv=none;
        d=google.com; s=arc-20260327;
        b=osdqN1jsc09ds0YUxoYjCuGRdSLtnGkV26siLejtccucD0nGKkXp3gVz0KEkgrEom7
         a+Rrx3z0AY8Pak6NezTDei5BHNDJyxNKxqB4vNLXqSwHvifibOoXsbJS66vw5+ygzsc5
         c1ZpT90WVfPF3VGum5BoVIC4B95N2//Nsqjv9TZQod8CJSEQU1bVWNDNfFyyBzVsWPl7
         vH4BSEKEsW2PixmYChOANMmJ+3nPLY2blA5h3sM1t3Bt0fAwnlKjLHxsrR0t8Mf143Qh
         r8+VzltfPN3fk1bbGgiP29Syo+VjLxhC+7kPkenbhSuuweUviCEWDn66gMAefphvwuhQ
         CcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYmQqPELTstMK06OiEDZ8O6DGBmnXAyBisnlU4AAuqw=;
        fh=VV3oqeA/wKg8E/MQlaee9LdKyybTp/4JbgI2GUt/VRg=;
        b=hrE4gtW1Ua+D4D7Uo+bxPxkdrhIXX7ABZGsqV6SxeuKXa1p9IyoIaqQ+tTS9qeD4eZ
         gKreKvqNXKW2ltgpwGRdxotrqgtfYe99Ii7+WN86KaIBNtq3jbub726BwMO7oMLbMZw5
         tQY08v2bUeHc7f+x6OdqysR4VglGYcKRgA8VjHa7HGnTunLC4BARwHcD2B7R7cHH0Mw6
         JnLEu8Oc8zcaq5on1W9sNLqcb1yz+eKIpgruD+nX5m+oHJhx/y/bdihNl7+L4RdhTuK4
         fquiLyDzIT77hJLOhlqRXFi7URnj+G7Z/FsQls7MwQbrFkLEcsAGzNcrwjGLP8OH/pBB
         bNFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923555; x=1792528355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NYmQqPELTstMK06OiEDZ8O6DGBmnXAyBisnlU4AAuqw=;
        b=qU/CIdrIKdTCM9CqrUvue6uH/sSoTo4OqDR+/sYFCGC75T7NUXZUdfoWpC9iX8qguR
         E5L9LQehQQJjqM+5T9ENFXRDUNkEHHZATEDEf+wxKbyo5AerMyOkwZqzCUhEh4csH3+U
         nN/f/fMcH/RWUqMFhCTvqeL9/K3KSac2zfJRDrhN9qJKwXLwSdJoyHEoThXfM3rjoNb7
         qwNVH8sxTXa0UmwNW2meSacewJoI2ZJBNquWADmHefUNmSYz/8Zzp1DP4jcr1BC79Apz
         Vi10KiZWkZHgAic2ZSXDj0FlpSkSH78XExF3nMCxpK0pexOYI4iqS35jkkwRMKHoo47/
         f9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923555; x=1792528355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYmQqPELTstMK06OiEDZ8O6DGBmnXAyBisnlU4AAuqw=;
        b=eYmIzW3Fkc8hw4kGqR6DMZXMVajHAqS4jlaw1GDsCSONfEktgXV5Zo+2Li2G4ACbNd
         zf5DoS3oXxg+fmjpDLaOpgYJpkhyDxSXrDSK1B6rm4paZUZoHLbjlRlHPaewl+h/gf7z
         f+3HOc+r2tOPtVYGThxK3zg5yyjzoaooHnO1YREkOenVkrZji8ljzHo30Vb4r87h4QHy
         HoqkZ6VO66jOK2+uA3o+oGbgwaMswklkrGVRrLp79fp61qwyMf9jW6fxeZnyxND2vUmF
         mR8sWcJzEiKSeYQaJA76rLN0PKIus9BNiwqIaxThhaDTrklvEUU0e62VHlL/QMnf/q0q
         OBVA==
X-Gm-Message-State: AFq9FYLl744khqap0KrDZK9q6YEqxegUdDA4qHeKOKM+guq3R/0qH+Zg
	XyUc4YaVfFuKfQOauqPFok7nSHlIX689pwt9GWz79O1hftEE/+Dea3HC1guysma5iw0Js/AeGAS
	lIzTRHmACX6fbFMHDgkf5b+4mEImzLS4=
X-Gm-Gg: AYBFou3bpk1hlDhDD/iB0g7DKNQneoXG/HHufPvgpdV/pLpkuORX428l8ac2qgI0A47
	C4FfL+WPjT6UekHGevH8aWQx9vOE+jzrmL2M2TxDS/0UCKL1z5H8PLaFQcubeJiQreJilXot5cx
	RGEpnADO0qf+9GfEo7yj9J74Dhs0Jpucb79XVUhTrkkf4ofJ43UcPcfklut8vwuMdZ7q6t06JlO
	6PsWm4kfBpzZsCZddDPVU7BFIIa6Ggw0AM6/hIZ9boLaxedo59Ph56ugOC8a0LeaGxBq7Zez3rw
	nN1iKLe4p1dHnAfQ9I8MpY9QvE8vfsOYi2FqUmM+OUUQjUvz6aj+9J/LSXNyy00z6Hd55no3lVk
	8ZSvoxpemJ2MsgcHgnxbblbQj1YqvaIimUEx+iMvDzi6NHUhtjgFnf2d1RiepaQSMWxsh9HPZSi
	tpZdqPNsAnCicmAqmPxPgFj4qjmtydiWB9n/Njz6mVXJXKly2lvRTx0IN4TPxWY78a8Q==
X-Received: by 2002:a05:690e:1406:b0:671:5818:1591 with SMTP id
 956f58d0204a3-6793698412dmr5728911d50.20.1791923554996; Tue, 13 Oct 2026
 13:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
 <CAPSxiM-d7FHQVjKnyRu4GJF3hkauyr6Jw67B7W0hLSEyamBFwQ@mail.gmail.com>
In-Reply-To: <CAPSxiM-d7FHQVjKnyRu4GJF3hkauyr6Jw67B7W0hLSEyamBFwQ@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 13 Oct 2026 21:32:23 +0100
X-Gm-Features: AclHuK_QL9YLXr3PDPUn_ewqhk8sh1ePlf_YKoieDSZ7q-cwCiHhKmY-3glUw8Q
Message-ID: <CAFpMFfDKH0WaHTogWBrsic--ryfuMtLmJtFeq5GwYfQCsHnx-Q@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Okhuomon Ajayi, microproject in delta-islands.c
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:13=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:

> Thanks for your interest in the Git project, I saw that you already
> sent the patch.

Thank you, yes i sent a patch already and junio replied to it i just
sent a v2 patch
> >
> Usman.
