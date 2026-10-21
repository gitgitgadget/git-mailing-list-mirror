Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792617669;
	b=LZjFdiM1jz5EsarsULjw1mSEwjKMcLzSZ2AxApsLxu90LtXSPwC/JEbVHjYT7J+odUb+
	 RB0guYRE/scHnxL0BOMKcFgDRWAU/o0QZJp05ZB7NsLn5dQZDZQg4+6JH7+yuvewmSFVL
	 wt7qWKG2gTCHkTV8ZC1hnAsrzSKtpkgO14lLULOBbWcglxBobcZ+QuvpSgPOUw2kEXLwv
	 A3fy5vsrjDt09rezqKCaNKKwABbZLn8VLliujKA2PeeBg5pnAIQqXdMZM4/SIX+ty+d6M
	 XNUlWe4EC2IPBspeze3FqMVaiUVnXwYz3gyKLv7bY9NWycVLJzhX852YEUbUTRQaZsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SHAAlqy1bmBfgg4hvHlOESgPdazNd74eSnwjHCq12l0=;
	b=ef+3BM//8mBV98CLnda4uA7+gVgZluc8foGuOpILNy5XbTKiYxyMxtegD9T9dRwsmzhd
	 oXov+z066Kl1tfTsmea2IAwMddrgtpU+ZaHULiT7KFtGtYmaFYWmfH4TntUgrw3Llb+VG
	 174rOsQHzEjwYxFsHOYCWU48h4NmfoLXIS0372VMxhBfK4zCe93oqJKw/Jw9yjjJHX8C8
	 Zel5Gqsec2KD5aQ97+SY11o71z4DOLQlGU2VB5/zVBjSHVXBtOtH5hGaEtVngM3KbWcNW
	 6ee4g1uiko6NDfkxMjUF+j9oqbXjFEy8m/sx8+TSyju5xa0e5PNNfWSLGQC5h5fn1PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fEkeVsHu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18DB606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18DB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fEkeVsHu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b10d24345dso11816007b3.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792617668; cv=none;
        d=google.com; s=arc-20260327;
        b=pJYrX77q0D+j2Ycx02IF5ooB6dqIbgrpY7Mv5XO2bj1YvyuQHJN7XcF5EIKXaN6fth
         8aOcD4NqMULMMbRlSpT7kiq942FrtbJ8UQRAoi0A7z66DWhV81D07OHr26Y0AopQYgZz
         d9RYRp+Pqdh01Hum5H4qWPHl55huIx8paWKD6Y4ZUTudargcxRbrLIESI530hWJ7/Yx9
         3JjWz4+8JlFz5N2PyieoqOqlyflfCrwplmMFOzPSG9SrFnXzIxipQMBIQ6i+O+kZbz51
         4p4+Q9JPSF1DU3mrvaN8SRUlRR/Yu4eug5QVjt4f8sjbhW79SEFmo7GzTadeKCxzqyW6
         V7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHAAlqy1bmBfgg4hvHlOESgPdazNd74eSnwjHCq12l0=;
        fh=IeFnzBTmwIJp8Dv/+kFoBDJb3gHqZ7ypCOUNkSvfZ40=;
        b=kewZOLHYYyi3DGHJJYCjcm5KGgKG42BgKtshKH76TgbWuT0j4d41bVke3PfbZbx3aI
         jn2d1BCqrpvjENctQob4Tzey0qBTVNjYUylrXXLVg7D6zQZ8gOHR08cm450MSMErySRj
         5KXjVnBmk41mfCI7L9POSCwX/0K8/RLrbOGIAEPLtAw1yyLvlxnbz7/SMla3cgyndUfd
         j1e6C/NRoefLcyUV7b/MyE+rTInnBvmW1/B3W7y3wVUM3A32KPpWBRK/8zyleqw38V2t
         cULcVgSeWIZrnejRxjrX9e8dsnHGfNK316WQVvUpRzTBCItkeGnQK7tSErlUp9DdPaza
         OXBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617667; x=1793222467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHAAlqy1bmBfgg4hvHlOESgPdazNd74eSnwjHCq12l0=;
        b=fEkeVsHu59vSofDwSx9NmmZkxZEdGb9dhpK+2V7EU5kPdHmJEZ8T/Be2yJRluDRNAt
         iyDAuS7DDTZEynwRjZhSfCBiVu0qOw+MM2pdN0NyHTjMrHe4c6KAHcho6LjkBQVLI1Ot
         MSipcPHxwS1RDTQOvW+7AW12E+PU7JllWb05aGXl8OzOc7amzzYGbRtnsE85fTUMfRXP
         EzkGtW6hf37eSjnvCoMX3UXuCTWT/Li0jhn2tsb1joD8OvdQ21nKifApUXOciz2V8Z6B
         rQPTUvb2KVbwdG2kuobgh7QMQKMynQ589TpLeJ7ntR3AmYUbtFMK87P1SPFwmy6ujFpo
         ac0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617667; x=1793222467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHAAlqy1bmBfgg4hvHlOESgPdazNd74eSnwjHCq12l0=;
        b=uNZcFrQPTwRxCQIsNzw1QKKtoeTWMQVI20Bma6zOs7soQGxJr/z5fif3K3JIksx6Ct
         XlSooa5SOiMnbh9csqwgw95dDIyKWy0/ZHpniZswBEMCVM4juDanmJMw73dVkjchrqQJ
         A5ySyQMbxMm5JIyrOE171f+zOyXYNnhuW3DkmE2K5jRaQTg5JElcqXvE25HezUkPw2pv
         lRqglNvE20MdgSZihtnp0c9mxADCRPN72TJumUNQl3jmV7sL5OcLy2qdUPxQqXb6tjcF
         sXGncDNIn/bXvbcGavrxL2V1G9LB2cT538RmTCAL4Dnsj4BljnqCZl2ljjUUxzdkxjcR
         Nxpg==
X-Gm-Message-State: AFq9FYJbxXH/iSyvj+09a3i1DcACjr3HCsS9CdEo91Noaf0RSnqxvQv0
	nGYsMNSO3QMYXsKc2FlNmjFKJ8f9KAOhC5xZmy8U+tiOtcaE3k60kzzvJSCgIH1ThnoYU0oQCYt
	HfYfwEYDxTP/1XHzZqI/aGHCkOcRYTkE=
X-Gm-Gg: AYBFou20gDXG39KELaXhc+3I370x/CI/uECVamMBN41wUMcUgTjq4RCKnPa4qf6sNLo
	D5FiqhytnnYVwRkG06GObgKUCh3cVo5ZNFECGWmU+UlW8BVDcAOVpqbeeQLWeaiiZSmKDHgQY12
	5N8g9vfCBAr1l9qkW/a984sn54entNgQzUh4aBQQKAV5mWaEqWWH29sSQqsUFtj6DPtai93pw0C
	q6tA3EQqRUO5mRiOj3U6LzVxGOhrj1Hq+L38JGauk9j7UvOWj4NwYV6IwBUjGDqnBXcE4H7v2SM
	9lX6iHAEc+Nc9RReI0yj2GexneP8yKUzt4x7VHykzn823iG0QeJ9soUoGYrLwWfDPuw8oak5T4E
	JnDXzp2cB/hxmaddjCtDAWpqz6W7LRRqYLiTbwgmehk0/RvGWxBIVzxziG0/qbG5rlvoBcZuDkW
	Q0yQiqQONq4zZHvGC+3bF1oXANHWmW3bAPKqkWeA7r6NXLeSfwKWiU2jI/xCUggjZve6qVswVXh
	tIX+RoNj5f+h18NkRSc8+CNPHH8iwCeVyzIsQfq
X-Received: by 2002:a05:690c:13:b0:8a1:781f:4aa0 with SMTP id
 00721157ae682-8b1340c3928mr20900757b3.56.1792617667555; Wed, 21 Oct 2026
 14:21:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155608.58509-1-okhuomonajayi54@gmail.com> <xmqq33tyn5qi.fsf@gitster.g>
In-Reply-To: <xmqq33tyn5qi.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 21 Oct 2026 22:20:56 +0100
X-Gm-Features: AclHuK9S9eTK6gc-9LEdSa_Kkpfk8V1zwmZTh2mDEAa3wQm0u09NNXhd2Ai_3Hs
Message-ID: <CAFpMFfCZdz4WLcwJFefXTQ1v_g+mgFQOHxzkf0aZoPqTz3o-=A@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move commit_encoding into repo_config_values
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> I do not think it is worth contaminating the repository configuration
> with it.  Instead, shouldn't we allow the functions that use this
> global to take a "const char *git_commit_encoding" parameter (instead
> of a 'repository_config' or a 'repository' structure) and pass it
> through?  The callers may need to query the config subsystem to learn
> the appropriate encoding for the repository they are working with
> before calling these functions, but there is no need to pass the
> entire repository structure down the call graph.

Thanks, that makes sense.

So for v2, write_commit_tree() and commit_tree_extended() would both
take the encoding as a "const char *" parameter. The callers of
commit_tree_extended() would look up i18n.commitEncoding from the
config and pass it in, and commit_tree() would do the same for its
own callers. Nothing would be added to repo_config_values.

Does that match what you had in mind?
