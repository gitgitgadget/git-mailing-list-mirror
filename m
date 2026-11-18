Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794985160;
	b=Hzs+FEJLXaqQ7d3h6yrTdnbY2mP8ZdpAas2QdnHWCYEUgRYvbvmT+2r004m27KII2cav
	 MmiB/OkgUjdsVxVyUsOmhpFPWSBvh5D4//HpV5VzTCbXXYRWeokCeqblbjYg/xuYmh3NF
	 8WeBzVTwqVQbnxWhDaHvxCEldQLLfbL5pd/BqesferVPuaUn//D0ORmx8KE5DstiiU14z
	 1QhqSivK6wG5xKGyZGkTop6dUR3wDKqwd/QYZ3bu2P3kwB0RitjoB8Nkgo7YVxmEu0V7l
	 JFMnyVzjLVeuV2dOvqr/7o7kJxtD6aYyttr71VoklhLYi26AB4GFma49PKSm5vSRMqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=czcp9F0TITUXA9z/JnXSjY4jJPdKBGIlSllSIuoWwdQ=;
	b=5GmfPwCVRybI8BOnaG5VZgkl9aLVzX+j2e8B/150E+9zKkMDuAfiutoM9vHGo5xeHAov
	 YhwLn4MnHMkYr8R6CEIkaiGATfF4c6DbLRTQ6g+dXAxKCtpsP8ioncZUxBeU3zg500VsI
	 TL3LTWgE9pleDu/RP5lBm+mJFD5Pzu64BosaQx9tGHkD/omLsLHXoyxyCOZw5pIHi5n3l
	 UT/v0OK6vQdsbnFmezJbqItFYZVEPuzNG02h5ImIU6vysvwPaqN11NS/8dQUambp/PI4T
	 FgBP62qmNzCYgKmHTyQuxO1+B0UwCrAQNqL9Wj5iH3UPgERqjB2O/902iV4x2opdN+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaQy6XWu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509D606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5509D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaQy6XWu
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71ad1db7e31so1173345eaf.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794985159; cv=none;
        d=google.com; s=arc-20260327;
        b=CUgycdZU77gf+hXNCiCFVA9X+HjXi9l7nMjHvJLTcTehAjDSqiQd5GPOGi9GRfrgnd
         f5HS5S11lAYG19xGf0Yi6wEB1gw01XvHKrkwMwsXYjEzZbLZGf5iAjGQ6eLdVhdsG1XJ
         1SHCNEXUFq5UIkn3EhzCUrvwfj4L+SB8wo8gNj/P9L8sETS+ubYd8St1mnzQmg2zJOea
         8kPdlsF7JVuhXmRMIzntsnBCScCNWWUY+Mn110sH9fSZxA0MWnkzZXv3drFgWgMTArKh
         /xxGYZ/+hRONonsXEHo1IZFts05YHXEY438JZsMnMJQXr0xaQFADc1MtGGr9U38577ba
         ZO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=czcp9F0TITUXA9z/JnXSjY4jJPdKBGIlSllSIuoWwdQ=;
        fh=8I7zO8TaCirC8KntQ5qj9F0RUetxof5lNOiiQIUYwuY=;
        b=EfT4t1EgiCKrL5fCenmsJVN46s8C1R1HR9q9xhuANLeUK79FN50as2zblIYlX2YHn4
         5hQf2uZbv5p+AH516eJLb3JgfmlpavggRcAEuRiMRqdl81I86CQhYq0IM0+LdnsNdzxn
         L3HDL1CQvLetnDXhzyO9g3GtmyDUTzzBvoWRyKGABXJKGxJU7GvIDEz62NGW1P+QZEZz
         29rwmpYUD4MxxtUjus1dcAzQc92R3D1vzz2JLBOyMoz0xq393EH+PC+kWpk7RlrP1TA8
         6UKR+zLD2Jtn5OFU3DKstowSvg8x6AAAeamIhUbryjE0YeTIDP7ZuRde191CjIKSV06t
         xujA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985159; x=1795589959; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czcp9F0TITUXA9z/JnXSjY4jJPdKBGIlSllSIuoWwdQ=;
        b=LaQy6XWuPaHotZ4d9fZJTPb5nAVxszSUNr/Du0xL9kPKuKkHACp2OF2kg00UHu3J5a
         UoxRdHMuJlCkeSxKTNlYazcgpsif+TBgIDGukjyqLm2VusrObafXJ+7D2+PjaULI/Kd+
         05lqGsN2XjoTC8Sho3uOASpYb0C1O8mYa7iUPQ4Yd5qG6vtkeQ+ABGjmbORfqBq2iDgo
         NL8jNlw29bD1iN39f32a/czfj/RicNpm3LtBwM9dP+lbYwVS84nXOsKxaY78tKSORICH
         a3ZNlE7d22kJ0SoBZR7YuTW9uu+SSrAzI4PRIupR883YqPOT8Ex7q3n4xjAn5uE1Q/9v
         CTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985159; x=1795589959;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czcp9F0TITUXA9z/JnXSjY4jJPdKBGIlSllSIuoWwdQ=;
        b=JZoaEVboZZgVHyJ5G+sy6BBfeGTPT9wngIuLSl5z54dtzDUgUeOLiW7rUXhnwMzOBt
         /7CWZ/EpF9ilsTBhCViskLhxVQidAtcAZPUVe7uQ3NkBBFgx5fCJ781GeVqDDpB5tDDC
         kdxcR5IPtC1E4G+dMdHAk0qerOrdGxx+XHSv5EhkZM5ho2xAuQNycf9v2rWE4I62m9iM
         7AV9DmJUrmefcO+EhG48BpmNthGu7EktFkvbDvvqGAQS+/+DxfQ7xW2FRcL9I05K1rsU
         qXrjV0BrL5WronUOUXXNiuB9Mpmco18mFTS8VhX4nYpaGStViAFOCpORZ1LD0+OkXk0j
         Oo8Q==
X-Gm-Message-State: APuU4Z/E+BbyfbEB3d1G/kuB+H2LUrRypw9Ke8o++dBShzn8XHgvHKQ4
	lFIVGGE7P/joZEcZDifc6T9e6RLVHohUzdpz27tPduTF0LFe6vhfQXumITvpbGKLz9ZEv/0l+pH
	3CHecu9zvm0ffWtfQ8IJIaVGSIeC4KhiWcH8OUK0=
X-Gm-Gg: AYBFou2p3ye5cVLuk2bs7eB9DUAH3btL8zMDYhAKz+GslSo5Ce3f6wb+SY5otjC/L3y
	NrN5UFqLxiqYWWaQhFBqX/F7hvXzfu/5zIXAjfOhvRskC1DvLgM8BnUP1OV9lifHOYLCR1owt1s
	Fj1mYejZuu992dZGEeddU7JV1wSNEyTS5wctErkvX88pNu0dk1FjOJbHMEeGW/sU9hVCWljjquf
	VsXINs6E68Gjp07FKYWq/BFoxZoKXmJ3lPFZb+eHC64QGlidTCbw4Y07HSdDKecsP2f+DmleZc5
	K1J4BpDPnq8XZCcoaw3as3WY/4IIQPftL5HlY9RPUHKztsxaiazC71v4YLpmfvsb0PDfhFJ8mmE
	7DANN/omBFZgE6BXg0WPANQDEbbNJHi8gY3tdkMuIu6DSYq3kUaYhLYZy
X-Received: by 2002:a05:6820:8396:b0:71a:e9eb:6b93 with SMTP id
 006d021491bc7-71b1828a687mr858909eaf.1.1794985159229; Tue, 17 Nov 2026
 22:59:19 -0800 (PST)
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
 <CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com> <xmqq33szavmy.fsf@gitster.g>
In-Reply-To: <xmqq33szavmy.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Wed, 18 Nov 2026 06:59:07 +0000
X-Gm-Features: AclHuK-aNuaKhbtmlAkb1wCe0jNbGxi9BIqk7c5qEp1JS4nM67JzblVCihkCXrA
Message-ID: <CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Dirk Gouders <dirk@gouders.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano wrote:
>
> Andy Koppe <andy.koppe@gmail.com> writes:
>
> > Junio C Hamano wrote:
> >
> >> -       while (isdigit(*p) || *p == ';')
> >> +       while (p < end && (isdigit(*p) || *p == ';'))
> >
> > While you're there, could you add colons (':') to that?
>
> Do we generate such a sequence that uses subseparators?
>
> IIRC, this code is not counting the display width of end-user
> supplied string.  Rather, it gets string we paint in a buffer and
> then counts how much display column it occupies.

You're right that Git itself doesn't generate them (although future
enhancements might change that).

However, display_mode_esc_sequence_len() already operates on expanded
custom formats and message text, e.g. in rewrap_message_tail() via
strbuf_wrap(). And on stdin in git-column. They could all contain SGR
sequences with colons, whose width currently isn't ignored as
intended. (And my proposed make_line_colors_self_contained() wouldn't
reset or replay them.)

The check could be changed to `*p >= '0' && *p<=';'` to cheaply include colons.

Andy
