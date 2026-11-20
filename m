Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795133883;
	b=DZVDGFyCgeHZ8y1gt4aHrI6vrHISEZtKtSI2WeNIuCidCZzDjGWfp1Jo321g6ydox8NS
	 dHjl70crcB6NocaTA+Yteuk4mSIw515DNff/610evRp8R+4vE75LmpXWIVycd7cg7uUuC
	 Z4aIICPJBrg7KygLIHh4g4dZGfKBiLEuqW5QODgkp23fl1G8NoJV4P7wqCBboR40eN5dB
	 74FaflHKuAXFMo2ilKFu+81HTmSSPxaUrkMsCJ4d71qJANo3b4FwOONuWRB84AUK4JnQG
	 /8wJ5DhM4Buc+PACiHV7WVcJgTHhN+MIbWhfEaU4HAZM/IKPrgA8k9eAqIayTPNtzfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=tJH+9gLqjudzQeSCJc8HQ5j/UWezs4+eJBtB1zhhUrA=;
	b=UCyrnh2ZQh861JqmQMOWPUeKKOEbdT3ii0xiZU22//hOXSPZ3nUHh9D7IrdedoNWnF07
	 3xbW0BPrQ6gnnY29YAA+JUbuMKrE42Hxs18djwWPOW2GmydDp03BALxKEP/R5YKj49eDS
	 y17GYfegOm8MmuyE/Zq4IvdfuvDqyH790FrVEKJdsa0xkJgpoLlQVNnITGE477O+lehjp
	 2GfCaTVKNMUlcvBn+vouAbaez4LMDlX4AOXEp49ymvT1HnZcMavZYADaJy//vbiN44Qus
	 HahPjn8uYqGcTJiuPxAxQsTxU0zpjnjScq+AVpFduMCBPWQ3yrM6K0tOaT5gxT5mYTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kf8vsbQx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C6606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 00:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031C6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kf8vsbQx
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-706113e92f9so220385eaf.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 16:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795133882; cv=none;
        d=google.com; s=arc-20260327;
        b=Gq49e77uKOzFtdC0Ht3BrkMRzBelE6V+gjalZpLx7MQsfSCW7WPBryLLTmmbAH42eB
         A6wBp9DbUVMaOm6U1NsDTMob8Ex3VesigK9DLms0ztsVmOBdPH55nNUgUBYOd3bYIn5r
         gwSNwIGu64aM1VL7tU6M9V3aego4TbkQ0dnDnWuQVYDN/y/S4vWditu7Rl/A8Kfh/o/p
         ResK+Zv6xAIs/Ct5Z9hNUpHXemIMdWwUprVbr800TeLGnB4YsjzC/ZgMYu1a3PwzsdQm
         bBg3m7D0C07Si9YDGjc4Ec8DJdSJtrWsDmV9m41T9UYv8RO4eXxbaagOiyCAcWk85RlK
         YRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tJH+9gLqjudzQeSCJc8HQ5j/UWezs4+eJBtB1zhhUrA=;
        fh=DDRQTb+wnbVU9XewO3U5V3gIkTzYR5f2/P6jJ9Y5lRc=;
        b=kS5n9Oc1Kh4BkWjJBW5NmSUFsSBzSVIHcRRY0iA+9HJeUPM4ewMfbPQ4PsXmh7V/0I
         8Dlq49IMZ3iVsj/HLhoUHdl+OAOFAqE185i8ie/A8e56EXUvDoJwweFs8UCveui0dNlI
         oTLy9xYsdWSdk8iTsRAwbTHgzeiZS8hwtHVQSfJYjTXGfwzEQnRI/ebM+rxqBg4PvaQt
         Wr6KiSFrDeqj1lxc5UdUpEb4/xAagJ9X7AbFZbv+TJt0bOQGM25DvplkhARI6g17VINe
         NQn0Suk+U/uCcSm9cSPfsNA3zcPVv4KopjacIsCNPnncUXeQKz0zFCqCRwKVEXkzmy2f
         /Mkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133882; x=1795738682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJH+9gLqjudzQeSCJc8HQ5j/UWezs4+eJBtB1zhhUrA=;
        b=Kf8vsbQxRD67j8KENp7BDiQG+2GmngzTIG13gWmWZZjx8OoqW6uUfxhyV7tbh5TezC
         4L894wFHGKPBc2StOklG85NFupAhtE2wKcOoVs6LlsCGh4oiAJxHveS4mEMuuYqGXpTC
         aJq2CGZaxo2XXczJNCgDJrW1JY/S7+JFTEgOhC4sK2QvBwXSyp8FGD1HVIOlIZirsfLW
         liTnnDcvCltYdPv4SZXxA8P8sKNVL1wz21gchPTuzui5a0XH/Sfild2vn+eGatYQqI4F
         J9Wa6e4OkjYu+RYBDFn46eZbIcL8UZLfgS6juuzJm2UoRrkwg1TSZWxkbZ2nTBb9Q4nB
         4Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133882; x=1795738682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tJH+9gLqjudzQeSCJc8HQ5j/UWezs4+eJBtB1zhhUrA=;
        b=bH1fD8NTzJhvItIny/YI4Iw/WPK9iS24wS16SV9UZ/OPgYxeHCa6F1E+on75OJAtWx
         aStPmOAxu8RTxLe1rD8A6RgMlXeSIrPVFJ/NYBIhfZWjOna9sErLG8saVk9Hlw6nygJF
         4MByQu3nlbmVN4BqOOci/dOw5tqk6v2pW9FSPx0yBMv5G1jxRSJy1vczqo0mQJAXFSoA
         KZyvoUyDT+UoyxrvPC/Tw8wF9ceb5B7WvwYA31Xu0pz26VXarFNZGJG7nSZD1GO3smvp
         CfIFa1MZCb2HD1pz5JLuj3w43wL/zVPMNLjbLVeNz1d3VwUQC9jESg4LnOpJJaJdtiPx
         9aRw==
X-Gm-Message-State: APuU4Z9aDoatYwEoZp9ntsXboUxTIj9cWbesDwmlevPjsH9gEOjPeHdQ
	nFDCHcxkhEtUtJ46hntsjfri3U1RvMyN11H3lnfrMZvbuEI2KLOmQzn+VnU58MzzQZpI4WajU26
	QLHgXenR1RFfkd3hDCCHsn+m5kL/nq78=
X-Gm-Gg: AYBFou2G0hOhUXex1fUDMCXSaoVRiqQEbQfeNC2jN7zQZWhUlipqUGHdux3QRhkODTh
	vQgHzByouLNs0GxdLd9Lgyw0SBo6LdOY1kcZEFngAiqxTyIodb7DpV8G/kFPxjD8XPCCYv1vrdD
	uvPSkSQZEkd2QDqHVo7S3cmLliYk/uYY0d+dUkjtwbMO5/91YZ8fPaIz4VksFPYcxOW9GVI2xLP
	0WrQw0eUf9HFVdCybXBTjIP0NoKXEVMj1juNLZxaDdgOeVAVz2zbr5DwciLILw/r3b0dw6mNH5a
	IZGavKsq95r+pDDHekoRiv9IZp5HTJfn6dTbahVjlUIJe1r23dmbuc3KHHsFUP0eWc3P6DfAFlH
	CmDokcMiUYme8Opa32ulbmsoxp83y5+OgY62YKQ/zMBX1/bM9Qf8JVOi7VfQoVpmPGIBuBFbn73
	n3sVipULxs5vZDkKrVhq5ta9u3GFJEZYG6FxJjRndCjkAs7jZrSdBo
X-Received: by 2002:a05:6820:a508:20b0:6dd:5306:d1a1 with SMTP id
 006d021491bc7-71b391e8826mr1045749eaf.3.1795133881749; Thu, 19 Nov 2026
 16:18:01 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114012055.127905-1-tangajoris@gmail.com> <20261117004348.806694-1-tangajoris@gmail.com>
 <20261117004348.806694-2-tangajoris@gmail.com> <xmqqh5hd50e2.fsf@gitster.g>
 <CAKrRMNoB-4==1EPLAAXE4M1J6bUwuWj=p32CedDvOTi3tzO7=A@mail.gmail.com> <xmqq5wxswoph.fsf@gitster.g>
In-Reply-To: <xmqq5wxswoph.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Fri, 20 Nov 2026 03:17:25 +0300
X-Gm-Features: Aa3M54ooPOumfzwZaADZCEMhnhvxOCjO4smNhbWeVoenuZAkT6XgwdUdDE6VIJ8
Message-ID: <CAKrRMNqG2tEpX72pDBYzgnkDjAaJ-OfYzDcYNWmVx8035W3cAw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] apply: free the old def_name in parse_git_diff_header()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, siddharthasthana31@gmail.com, 
	phillip.wood@dunelm.org.uk, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

On Thu, 19 Nov 2026 at 23:28, Junio C Hamano <gitster@pobox.com> wrote:
> Have we ever produced such a patch?  That is what "anymore" implies,
> and I am curious, as that may indicate that our above assumption is
> incorrect.

I think Git did, but only back in 2005. When 206de27efa (git-apply:
ignore empty git headers) was written, diff.c printed the "diff --git"
line before running diff, so for a path where nothing had really
changed, the output was just that line. ec1fcc16af added the "index"
line a few months later, and I couldn't get today's Git to write a
bare "diff --git" line. So I don't think the assumption is wrong.

> We should be strict in detecting a malformed "diff --git" in our
> input.  Silently ignoring them is simply wrong.  We do ignore
> non-patch material after a patch to one path ends and before another
> patch to another path begins, so that authors can add commentary to
> e-mails they send their patches in, though.  We shouldn't be
> tightening the parser rules on them after the fact.
>
> Patches that begin with "diff" that is not "diff --git" are a
> different story.  They are parsed in different code paths, and I
> would prefer to keep parsing of these third-party diff outputs as is,
> to let the sleeping dog lie peacefully and silently.

Makes sense. v4 won't change which lines count as commentary.
find_header() already treats every line that starts with "diff --git "
as the start of a git patch, even between patches. The only difference
will be what happens when no header lines follow it: instead of
skipping it and reading on, it will stop with a "corrupt patch" error.
The blank line and the indented "new file mode" line from v1 are such
cases.

Patches that start with a plain "diff" will still go through the same
code as before. The one case that will change for them is a bare
"diff --git" line right before such a patch, which v3's commit message
already mentions.

Thanks,
Tanga
