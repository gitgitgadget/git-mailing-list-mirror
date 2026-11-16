Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852419;
	b=lQUoxHk28ucysQfcpjE3Jv8lC7LS0C8dfjaEsdteyfp6dSnVPvvmDXlSV2HEw1C9bq6U
	 h3Q2ym4Ll4nyIJpka8CEkbb2XuD1JaHiqF/WVepJrs5/rr1Qzv/qyjNnCgDtZKN1rvwFa
	 MYtI1CZipGUSIvagdNJvbSw1Hl/HKQUJEy8wPj3T0NZsqnteSF3HGTqqpbrnJV8JMZxS7
	 CYGpnCfBdqIq2QCfS3M1Ur4+XKxN6hNNrN61cHZOUEnSvpCDzp5s9IbMWg6ZXcAHgx1UU
	 4NGdPZXp3g1nxTbQXZ4eqtbg14yVf/XJ7gkWyCRYv7099UqjThqYnrraaPWLzVCTycA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gT69NTGdw2JkR5SJ5RJv1dLjAv00uHVwp8TieWMtIus=;
	b=prADIa27uv1BTT6Pu/hipSiZ0NZeQJQqUT1QEH+jXnzyxsBu640HA9b1rwX2RFK9VPP0
	 nn8pzf0Lm3fcSyCcamypqUzRjxBtdpgDjonhusA2aBZuqdRVnu+sdQevwlkqz6vxWlZIZ
	 diRDQ4GRVYj+7y9zRCFIhwvOhp/VE2L7ytR9oal3tUYJfe7xKV+qW4+psiyjKu3/B5BZ+
	 6lqKWkNtTnlgX7rfDgBuTkDxPnJjwkvGPo4YViHgP+XEoY2KNVxdtmX8GViBRZKvNiRbV
	 A3aKPGSW9jMX/Jzkl4qzSf5CKj1PLp5ANhy25TFgW9iLugTO1uUs/wYH4aBA/jYbBXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqUW2sZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7755606A322
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7755606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqUW2sZ4
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-847ac7ccd85so2965979a34.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 10:06:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852418; cv=none;
        d=google.com; s=arc-20260327;
        b=gFTfk1Iik9JqDV9P3Uv65gI9sn5b0oJm4qS+s1Ax7w/Jq1L4PeJXnvCVQyoHjEAWxd
         c8zrJhAjk/rc36rRg2PC36vQPiWL6xifLhAHtdVryLzLfY8d/Oj83j2ImXQJofL0cgCe
         TJ0YpSdr9AXUTOuLwsGH7e9XSppfn/qe+DxCSu0HHraZmIokkr+nLrYpYJpYJn/JAZi8
         NDLns4/ngGemTjZI0ZvV2wIY6Bc7byW8EkIQrr5tG8J0QrVglIAmKTsDhv30f3s0geHq
         PrBvhfzTKYQNww9uLe+AaIvA5gBLK0ZeF3XjKfak2hxzt+nyN+SukDPUwgRfT3hnFpy9
         YwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gT69NTGdw2JkR5SJ5RJv1dLjAv00uHVwp8TieWMtIus=;
        fh=QjMtnAHJBqEoCfmF4l0Tu1fFI58znc4t+52Pz5WleO8=;
        b=SzhQvcUiC7A7bouma+uC2M/LjVhjgKitqkUveV9j/v6zRPE2cyUnDRlMJFnJbQdfuu
         g0kppzF0nv4oSI5bFxnc/wTtVZgIePujacJzSilYvojS+ujWOu52wDyXWg2WFMNoq2fu
         WQmW4wvXp/Zn3JMpP7Tfhfcw1y8X+Sc0FJo66mjWSo8ebObve6YsTEPSlcwE0F4XMjPu
         PbOJF/B+fix78yi7H6WWI2wTKAqxAZeghN8jT6JUq2nW94MYmPv3jo6EOAkJXqYnLnwa
         K9QBZpD1JWFO9X6DnnPoBndBP+USBVL3BbfY9RCBvdQmjR3WfpbitROaYKmLgyGcJgqj
         exuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794852418; x=1795457218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gT69NTGdw2JkR5SJ5RJv1dLjAv00uHVwp8TieWMtIus=;
        b=BqUW2sZ4kQCnOa5Xhb9wuDXKGTvN1QOCnZB4AKLMTXbD6lSadQ8Qdcm4b8ared5Pr2
         dgWxuN/vENnQOu2tfR7DWv8Uwts3RqEU3IlZbUKyVO6/mYmlFYRwjq4OweJn+lF+JaF4
         6kWX0i6hUFby/SkyGNzax9QmUPyfQWi9NNdhCA4Y9+tM5iQNx0221G5qWs4c+wBWi4EU
         Wprku7k2v+FwFlchUKNLoeqvdgQyyKZ71KviUTo5aGycMfCqKz0cYFmPzgoFZwZ7aPaQ
         JhQzJTcuEenMM3+QjTSqofobn1ir8ax3A/c/UUaKrSsiUbfVKXbDD2voL2gF8xkF47jc
         FAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852418; x=1795457218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gT69NTGdw2JkR5SJ5RJv1dLjAv00uHVwp8TieWMtIus=;
        b=nxdEzW8JHdfrDlLSm+JqXTR5iLESH6oiPfChEJR8EEWHs8U3ppML3enRqKa6ZNt9Lj
         TmfRq++Eil+NyxgKbjqcF3TedVnTL6bEc3wTTam2DjzEzRVxmL6da19rO/9HAKVlca/Q
         eBFO4UZ66JbbSrU53iGSkNLqiZj9USDzt2ZK0wDZorguFoa7jOIa6Yhlw6jH8B6XF+lw
         DgffinhP1gVR9TdBLi8k0cc5ncrq3VMxklUjGMA+iaZ1DCnAMsZ7EJxSzlfXOU4li1JX
         8R8yg0X5cC0BsdiB7RSnAOGDnrGjcNjbWvJDofWjQbbxm5av4R1YdPBSr0SLSJjvBh2c
         LWUw==
X-Forwarded-Encrypted: i=1; AL+hErGeBY4oBdN0Rc/Ly7I5T62fl/dhb/gHgV1pda8EBU4kjemS2NdlKQkDwoqQyW8LsJoH4VE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Js58nZ6N7LfCpzySpvKQcE9Jul//iPSslHIikAi7G8zlAmwNG
	ZtgBw5XjGnyNVrBYjCry9AqjofkqfRs/VTe98VgPpGRFkvxLxgY5NsTk6cF2qcKcLqGluIymYWt
	wArDivZVFK/pMOW82so4lHRYpsi7lTvs=
X-Gm-Gg: AYBFou3+fw7pABnHnfqqmQva5Za3Atrq8Ty4S74hFES+FlJbIz3n7SWg6YTHA+AYggQ
	1gr6uGBzpageqf1whQm0+N1LobsFYqhlm710Vo6QmtgONhTQzz/JhnnZDwRp0bQpDM0K2QSkXOA
	It8T+NmfEq15ZLbJDjMv0vC3f/8uxFDv41gxQCbkNhqqDY0V8sOhO6CqGaKzumjB/dilAS3wsU5
	jznfAPPQISrKFTARU0JCjdpyE+IYyf6d4PvkYRbHmAjsc8w8DXY4+3PcsXetulxh/vxHAOwWk1J
	46F8G6YrpT55lwxBUFj/VZZJVXftm5DqeVJ93MdVhjIABzpyVrsEcfnJfSJyw4D4O2FOCKY0qbh
	70rMmQ3c9nc8fQdu8tdZbTJP53MvoGH+xo2VJnPms/CIDq1lWJCYubzoiXmoLPMSsD0iUgbXOeH
	nGVNV3ZuFL4t1BFni/v+zhk96ljXADoronNEAe21Nu4eOciLRu5KLEdw==
X-Received: by 2002:a05:6830:2701:b0:862:b4c2:d180 with SMTP id
 46e09a7af769-862b4c2dd0cmr6098077a34.22.1794852417760; Mon, 16 Nov 2026
 10:06:57 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107195429.96842-1-tangajoris@gmail.com> <20261114012055.127905-1-tangajoris@gmail.com>
 <20261114012055.127905-2-tangajoris@gmail.com> <afddef38-8a8e-46bf-b31b-ddebaf39115b@gmail.com>
In-Reply-To: <afddef38-8a8e-46bf-b31b-ddebaf39115b@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 16 Nov 2026 21:06:21 +0300
X-Gm-Features: AclHuK-6z_nqvnm3TsOr4PPESOSwzX6EepqJRabK_lL__eoPpu1JwsXLSAhznF8
Message-ID: <CAKrRMNonCJmc6YzHY-77vsOm-ELXo0GO+p0oKJfOBmmFL_WojA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 2/2] apply: reject new and deleted files that
 have both names
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

On Sun, 15 Nov 2026 at 15:47, Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
> Nit: for "--- /dev/null" this prints "names an old file dev/null", but
> the users never write "dev/null", that's what's left after one leading
> component is stripped. And "--- a/f" gives "names an old file f". The
> only way to reach here is a "---" before "new file mode", so can't we
> name that instead of printing the old name? Same for the deleted case
> with "+++" before "deleted file mode".

Alright, in v3 the error will name the "---" line before "new file
mode", and the "+++" line before "deleted file mode".

Thanks,
Tanga
