Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428011;
	b=XoO0bM5WB/54pdiLrUZmDGHzcdrpKBlSsyKJU2YoSRXbMR8zJQRi7DFdewTbGlnUkDO1
	 uMN26o2fXVwTBWArTz3Tk9uegWp9tySTGmrKGs4cy43cMlj/8bsHPvzA1Za3j39LyfoN+
	 5MkKpzet239Gvhxfy03zq8slRdARM7bsP/muQ+hESAxThwOS0g2ECoiecM1achqpFd4Of
	 oj6SmiKCeysbB/JfqV5u0ssh7E8QWGbGDwDgKTtsSL3vQSjQ3nK6jRf6Mmymo6ZzoZZZt
	 6f9IdwAJGck9/MBn4J99GGbX4ztjGf6CZp+mh3blOETAEeUqy6n6Gs3B+d2MvaoKsZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=2ld4A6b6IxpfKOLN9u6oztIrat5rbf798wjSTS3UAbI=;
	b=vc1j+1cv7Wo+l5CGfrCPNTb1aDEtp9cIE/seWUvhk6UbS6h+Ja0oV5fJkOEnpRIUJgHz
	 3/Roc1Diwz9yhJvXYh9w60bqbDhQGuG3NWxhUo8YlzBQ+02p4NvMuJpM9lxSaB+RU+RRY
	 fDMk9VDpCulowkG/uSSmYP1azC7XQ3DcTFLGovmJdqatEIiK0CnJmtBNezYNxr9q/Ex1I
	 Yl1xpuK+FEt6AgLpuUkKWaRohZ9/pTPJDpXgCP+4Pe7oKyoDcCKzn5lfGReTTthJ9qvFw
	 Vjs6++nk5FbicKwo5nSKZSI1KzOR+QdQU0ee8LPpriW/l3GIZi6HiUDTyk+rAAqkHQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=slTYyPHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75213606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75213606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=slTYyPHH
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2acc1e170cso331198966b.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792428010; cv=none;
        d=google.com; s=arc-20260327;
        b=OvlRJRUmL5DZD7brqv3CpBglgniOyr8ZdbqRiiEzIzfr4l7z/BsJmKzb3tkwapIsPA
         brghYwCeA9LFk6zqVJUaGnNZZ9e6k2CQmKt5irtIaSQPFjI5wTsiEV12Yd6qJQAMlios
         XwritlYzwyZ5I06EEbgKE3YTR6qEK5twSrI4eUNRvI3NvFsMLGFUHELgFuUEP+Bxku/4
         FKZDgrSLyr4T7UM7BFNcArHKy8CpstJtbi3DPN/0+Kak0NosVuM8skfgh0kM9R5r4SFB
         X6R5rMEzp+fnb8V9rHPFWFTDjDl/JIsZck84tyPrRYQONBxXO8wG0P3P1nopkZFwVxia
         48zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2ld4A6b6IxpfKOLN9u6oztIrat5rbf798wjSTS3UAbI=;
        fh=j6AuQClRG69WjQIXF1Mm0aGyVueVpjif1hGP9XW+JIQ=;
        b=Gi4B6WhxEM8Ia1a0B+Nje13k3Qz6kT75LAh5Cp6aEn+4ucmTvX6BFQa/pADnSlvITm
         9W9fS3SPg1IxQmqRb9STGWqphQGGy9DxW8gnSbFhVlZvB0jf73FqwHXOZF7dtZrn6WBf
         0jJ+uBpPGB5KzCw52RBeJETuLNRfQPcF54z4UucN8fsEGTYKH8mj3rgAiMyFDJkFIFlx
         7atxRw1o4CeQGsrb7cbjPWi+nLStWLRN8j71/tkJm5m/zkUyw1jtzoRDDt+xbwB88pCD
         ucaNXmZMmhAqLIN480WgU94Jf1I754XqwrrH2nsxhmho1Gc37emRbpYGFRXAWq6NHpXs
         6mmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792428010; x=1793032810; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ld4A6b6IxpfKOLN9u6oztIrat5rbf798wjSTS3UAbI=;
        b=slTYyPHH07A5QGCqw2g6f5/HqSaoaJILGhVm/zOSMHJGc8rb9dY8ntdjFYbdyAOx+r
         8SyX6N7r+qcEDEXpwY3lWz8xQ0bZA5GgzYX+tk4z13gXYormwYvjRISvhN4ENZE9BtG5
         TfOBvacQw2OvHdO3LCqJXtecuD0lLFcEstHOqCvviEUKk78u4kC6/YqngqIQA0qDDttn
         Drb1uJAIms1hYopXcLGYt+/ncdT1ZJx2+vdIhKXihkOMAnyWRftgaw+MV76Bj61ajcyR
         yhh6YACZkraRdlyx0vqcLiDKmnOwuEYnmb4AZzBB6afwiaS24Tf6RimHbNmnZBcKQKHj
         S9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428010; x=1793032810;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ld4A6b6IxpfKOLN9u6oztIrat5rbf798wjSTS3UAbI=;
        b=IblK7IbYvMXXZHkJsaTKWKZ3977wY90aMFKyFVpTdWT/thkSolMq+mfeTjKc+vb5gI
         UYBL1T1Ummhaw6FHj81shAzDcAgW8BL1qxeAcFPSSBe1ozGjqY5v/fKd1tWHuT5GOwG9
         xQt6su2S36MtVl/C3y+0Mhrsc3OPHR6Aabzkntth13vXljejAKdBeqNOQfrFKwtIkG+3
         6kbdMD/f5JIdZ0WiiztcrPi676wAOL7cv521lwh6gz9PR3HI4JWoxtLkvy8OO4uesmq7
         I1hvLyiOi81slpfnb1DhSbUNQfEXrABJiOyfbMZwigE+GAAvXd+qILHCW3Qjcd9jPLDy
         ND7w==
X-Gm-Message-State: AFq9FYKK48PieGvsbI21YyrNJJouRLUVk42LSG3rSCb6Jb4jJZBUa8WX
	YeP71ep4JoFfbIjCWaq2tr+GHGHkXXMX/U9IhOdk1h5AQA3mjA5rE7C4yOcw9Hm3A4Io8YREZaA
	WxE6cmBfbWDNH/qLsL1mCKAGV8jw10Vs=
X-Gm-Gg: AYBFou11NMXCjuxIRKtxwR0+fo5AGujrKlzNt/PWXKcQ2m63Qkbr7Shs2paC92ZM89q
	Yckln+dwKXGCahPB8lTj9BkqjMv83rosTCo48LPwbbBwZXmHQ3SQuTgRT/ddeqDh24ntsmDHaPA
	k9+dXc9vytESshSiANIkdg4ZVgcth9arpOXjHoFCVAeaGq8IHV1I2ZX+3mjttq93RgruenmaJmb
	CbrruIp+1hZVB+oZmgNEm5JLcq7c+ul1CZqeF75EFi3FRt7ROIPwHvv9aOLAagKPyzjF57EMGg8
	D/M9wAjKb//6bzF4BOH33H9FhxdbBjKdWBe3BldBWvxWZXmmXTR9bMwQqTL8zpF2y1yN21/2T2U
	2c4YLQbX0RU/fNA5nZVxGgQ==
X-Received: by 2002:a17:907:c1e:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c4199e5de45mr564511466b.2.1792428009453; Mon, 19 Oct 2026
 09:40:09 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKA8Uu1oLhdhNC9hGwMvQSC1+jzJqXnnWPGHLZUm5ZBdPkEM0A@mail.gmail.com>
In-Reply-To: <CAKA8Uu1oLhdhNC9hGwMvQSC1+jzJqXnnWPGHLZUm5ZBdPkEM0A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 19 Oct 2026 17:39:57 +0100
X-Gm-Features: AclHuK-ehxoaFEd7TrxS_K50w3hr2mML8PA4_eu2SlQYONmIpieNH9OqxJ8pEAs
Message-ID: <CAPSxiM_5J-LzAx6pkMrH1L08QX2hP5KgqWbmc6b1Oa2thboZBw@mail.gmail.com>
Subject: Re: Outreachy: request for a focused global-state migration task
To: Joy <cryptocurrencydiva@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I've set up the Git development environment and studied the available
> migrations into struct repo_config_values, including push_default and
> has_symlinks. I also took a look at the abbreviation globals, but
> found that minimum_abbrev is used across several components, so I
> don't want to introduce a broad change without guidance.
>
> Could you recommend a small, well-scoped follow-up task suitable for a
> first contribution to this project?

Quoting Philip, this is the best approach and what you should know:

"
There are suggestions for microprojects at [1] and some additional
guidance at [2]. The test conversions are a good way to get familiar
with our test suite. To check you're not working on the same thing as
someone else you should scan the mailing list archives [3] and/or see
what is in the "seen" branch. In many ways the main point of a
microproject is to get candidates familiar with sending patches to the
mailing list and interacting with reviewers. You've shown that you
understand how to send patches, respond to comments and ask for help
even if this particular patch (which looked very sensible) did not end
up being merged.

Thanks

Phillip

[1] https://git.github.io/SoC-2026-Microprojects/
[2] https://git.github.io/General-Microproject-Information/
[3] https://lore.kernel.org/git
"

That above is relevant to you. Also, if you look at [1] above you will
see good issues
that are good for the first issue.
>
> I'm happy to investigate the relevant code, implement the change, and
> run the appropriate tests before submitting a patch for review.
>
