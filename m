Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794956913;
	b=N2ScIy22NW19PajBpCPHh6JJdCu1N1wNyFhNy9LpPWDGL2n0lhU1aSfLnUsu1eExUBLE
	 FdVTb6sE1x5PZa7N3V/wllLW+lbUsly58kvOSxExLfi0zgf4X17DhrpJiPNu1ucZqs/bQ
	 ir8zxiK3aFggP25iX9AlG2Iz7kcStlyBkPbvpLwS0gbfudFnRu/lK0Z5Xa6z8u5VNKzB4
	 3xVKjRcXtY2SJnaJocQYb9Vj30nnmGn4UffrbvSsB0LeeVEveXGTtEJkA3FJBU7diiJSQ
	 qnRmdK5ZtKhc2OYy/lB8RVDoXZt1w9ZoU6nV4VqNnE9Mv90BuZeIVXrezOapAkXro+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ehipPHVhZ9jeCC+I/fiYqXWLWm7WLfOnU87OsGP4BNg=;
	b=jDEX6cTM3nl0B9heGCyF2zUQ/qVcFA3zBQd3s/6U4BHn/ShmWVt9O8KKq/8wKPI2lVhX
	 StiY9s3UbDi55YQjH8wg++dkmdcOcwaoOuock9AioGkpDxcawjoA6DTwtjJxuSPFxCu7c
	 juvDHINOB4aK6UdjehXaBytHN5k7EEgbVviFz0Tcus/PtT/ImgvzJizdBNavfxzuDcSNB
	 DHzZojWCYy8pDP3y8w7xET4WHyl9FcZ83tC9WcZIUhuD/JFfhJWQa7+U8pwrHHznPS011
	 kWKDSYM3sM3UjK4kgXccCKXCAnC9cdZjMoWfPVfTofA/2ToARLIp1XHBIPRru+8Ub4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyBqGQun;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42335606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42335606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uyBqGQun
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71ad5f20016so324508eaf.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794956912; cv=none;
        d=google.com; s=arc-20260327;
        b=Ox9rbXiV5J4wdeKXSC7+A1dQjfvwYtaTw8io03BoJojzSJck1kUENFvi0rGHzv9MAv
         C4Wjj4qQjCME22W9TSHl55U20EsbkU/Y0uOGdZ0zxKVHAzJWF7lL6Zg6VXrxVxIUzz38
         tJdrTzQVzdoCUXwQpqAjQeqoAhxRYRoayexctOWX4IXk0vDQU/2i09pPUzUe0GR/SQ8a
         vT1kfxX4lFNKva/Rz8dBjeZAIfuZ5e6VjaNIAaxwnQV5dikr7EBMXU5nkZN/dvy022IS
         2dZGb474GKY1VEJAE5YA7HbjcXj9/ZC9ACs+sK9Gptn+YgI43L1Dk2OXow8XhF+EOSdj
         TFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ehipPHVhZ9jeCC+I/fiYqXWLWm7WLfOnU87OsGP4BNg=;
        fh=8I7zO8TaCirC8KntQ5qj9F0RUetxof5lNOiiQIUYwuY=;
        b=F+q8eMZAOGMP2ZtijqImQmnKyXlJsX7UQcsS5z84jHKFR3Lwo7M4/VHNF7GBiE+vZl
         xpADHqxQ/EKcgxh1+NhD8xYWkUhtB89Uq/BZGuwt4a9PGpii2KDo3hMf6hHDrZ172lQB
         OVFl1jJR0Umvgc/sLFKz7b494ltxBGlWc0+2IaNdt7wr++ArbfYbI35o48KvSMJY5Ww3
         vkLzUKWvIzzaa0OA/sP1+31REFbxjhr+vI/lOZfkdNy9NrDHWqn8k9fr40BX6Q+kU4r3
         7M4CLtz/zxb0ebwCQcAANvB1gD9Xcljzeb4G2Ve2g4ItiTlfjRfxVYlicezcvMEbwVU3
         2dqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794956912; x=1795561712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehipPHVhZ9jeCC+I/fiYqXWLWm7WLfOnU87OsGP4BNg=;
        b=uyBqGQunKb3yMqUDaLxcW3Da3yKBZ1wu7RoHKGFQIgGl85KZ3xeVieKASBjW8jNQrP
         P+bc9t/M9VIU04Sl4/Lik50wFFXYhWphR3KnhgCFtIr42WAXMj8+VC/8q6DpTUGfHjCH
         FAGGDbVtS0BBqVjR5PJxDjDh1LcPdm0qYiBC3EltjOZFWGWfgrcHXbbJ/rYU6UoquW7n
         OwLiPE3Qr+1IVskXAWjMtdFBG8lthHmPAgp7IgpNag5wywYDuffdmuivumgttospMVx+
         pATp2y8ZZQTZXiWnPMMj7HbUv/VYWXBUfzFp0dcgYVushrWf9v16SE8tJZw0qhegwNTZ
         kOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956912; x=1795561712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehipPHVhZ9jeCC+I/fiYqXWLWm7WLfOnU87OsGP4BNg=;
        b=FQqAvaVs8CURGaZunCE0fEIt2ljxYFn5041g9m1NRDgZ6B5wPuokr+ptJEEeaxw3S3
         A8v8U5rf4mBErhJx+r4y7d4lpXvh/cYxAes91X6nG8FTiXL9nV0TgBCAeI3NpTtfc4Vv
         GZ8WUs7UF1Y9tCkRMyzXo6Z9fbYnaLVIYCQ0BNkxEhSp2NsEH2TI+nH8jxxdKPBuH8IJ
         /g7B4BS6GL7DV/lHGWGe1kDWSxonDzMmrutsXK/Wtg/E+ksZ8eCyOeuNlTFH/lI08giy
         rJJDqSVgW22+PwX+WpdqFQRKFUgyrX60Tawrwh2+UpBIhryYDX86kxQ8lrSs3iZ5Vg8R
         mB3A==
X-Gm-Message-State: APuU4Z+3e7pGEBtL6k5ae51TrWFLbQFcX78OnOTLlPkWzy+Lh750rcLO
	yqJMCIc/jJIzTuc7UyVkKGhBgqh04pYBY3fZDmiZKe7qTcGnsCfOidv4QJwgkf4Ul8WHdDGmTo5
	rwdbgwei9ci4iVEWnXMJnM5fKYGh4/eM=
X-Gm-Gg: AYBFou3IHt+sR69qPS7PYz5Z65rMDuxh4GlyQ+Qcba1PlUB2l1i3HNzkqXp0MTEO0WN
	P8Qk5HCg9RPSgxTyHnxm7B/t03lEkYc9MqMyF/nFUBMCo02QYA+SKHT7stNJJlYvbA/r3cwKrmD
	v8fEdrL4ezExqTHIDTNvW5t8PFHOj7FYykvyxubTMCw8IzBhsQEe4aV3Gd9aVU4YXYtNEyt5GbI
	4z+vlhwBPncH6yc5dKmuaI1NUvuELK1rZmA6XCw1YmdCPaf/HnDBi9tHPRwMzteSpRKmvmj4oBq
	sNBf4Bp1Hsk7/2Mpi6+SI3zu9IVDMJncw3lO6UJ9guE841nlkLYjcMnCNrLUSP0noJ0mp4xi+ws
	G60DUAL68TIai6zjAD4B99EuNX9kNjYT4QHqpod0gpJsVquDuFTJdPu2Q
X-Received: by 2002:a05:6820:350c:10b0:716:b9a3:e7ae with SMTP id
 006d021491bc7-71b1853c24emr557385eaf.15.1794956912040; Tue, 17 Nov 2026
 15:08:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
In-Reply-To: <xmqqqzgjcjes.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Tue, 17 Nov 2026 23:08:20 +0000
X-Gm-Features: AclHuK8DcaWhnfJwOMsBVDzLP-tdTrR6cM5Nnqm2gwaNNfgtQC8ENE6YpEzYNWw
Message-ID: <CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Dirk Gouders <dirk@gouders.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:

> -       while (isdigit(*p) || *p =3D=3D ';')
> +       while (p < end && (isdigit(*p) || *p =3D=3D ';'))

While you're there, could you add colons (':') to that?

ECMA-48 =C2=A75.4.2 defines them as sub-separators within the
semicolon-separated parameters of control sequences. Colons are
referred to as "3/10" there, aka ASCII 0x3A:

https://ecma-international.org/wp-content/uploads/ECMA-48_5th_edition_june_=
1991.pdf#page=3D26

Maybe more practically relevant, xterm and its many
more-or-less-compatible brethren accept colons in SGR sequences:

"xterm allows either colons (standard) or semicolons (legacy) to
separate the subparameters (but after the first colon, colons must be
used)"
https://invisible-island.net/xterm/ctlseqs/ctlseqs.html

Andy
