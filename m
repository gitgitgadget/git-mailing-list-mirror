Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795785205;
	b=oKQasv3SomnKE2REq4wyPNK20HkZUbDNRBzStLxTbzFX2nddqEUAAzm5OHSAX6PzwSqW
	 S+da1lc9y393LWgRPVI160UtEV4zzwmL8HgTrM4EarvdTtVsjpyOM61ajY2pC2iQI5Ku1
	 +A11DBmNOM1XlE05vaVpPGACNktqpB9Os6U/Nbgb4MlT6zmEIevPOM1t03fBOGvHP5T5z
	 ATMsdljrOJiJyw04sach5O1O65c4mXidv3UvZayS1ii+CxjuN6opR+0RTwEfxYdwT2GIR
	 +9iRlLUQ/zT87DQOktYPkpCAZhQFRZJNWWScPStZXkCJIM0xUMRNDFhQf3sHMpvFv+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=YMEJFbUdPL02vJWxG5ohVroPI8YNXVt3AkF+A9HIgjU=;
	b=zXn9VUfdZZoOsbYq3u3x6UAt12Sn7+8+G6qOAr5nt2tdkWdb0OnzH9gJH98DWUwXEV1M
	 Ppa5s9jyZ44IgSUQJTmZq7TxuNhBCFl8KkbWgZrbM8QP3WNncXo4hJeh8XiIwjdZBY5Nq
	 +EX3HGMx5tV9crjTxOj/BzJHJXuto3fxe5zNJg6CWyRV9Sg9w2IRrTTZkUkyA9fvpDSMc
	 nrqPcR8ra0Ob/Setj3R39o6Pzb5/Xtf1yWKO/e3Q1oBdITLMPQop9pJ95pT71C94lZqw5
	 Gx+fVTeKafrzekhMwMk/cY5S/c4dqFpQ0CaGfaDTNh3mD5+XeZlgd8XUDOMhBLZuIpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTcNxxfF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74161606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74161606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTcNxxfF
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so2079490c88.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795785204; cv=none;
        d=google.com; s=arc-20260327;
        b=buGld1QLNnVQQRIgArkM9iXFVADEXOJPyfAhOVAvC6vSQ1BAG5kYs/nsES+5jWNH/o
         ad2h7oNnWqj9F8xjvQkI+zHFDS60ObPDdjzb9ZlM32efBs2qrOegIl27pRsLs5nbpwzK
         8FKLdbndSoC7hRwk3tp+KF12iEwA/H7kfvtXM2rC6O0x95ihoiJqNb6wr7RWiD3qQoGC
         hWp6G54W/1DbPrVJXUZz78bMuiIgsYEEOyEouNgRF2lyi0MFRhF9RZPTrBxOSmu8tzuL
         ylbYEZJhhJgGwLFfZr6AEoNWHBec512KU4LxRLu1YTsdIRLSMmkgTpPdTbtWlB8bdggx
         QC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YMEJFbUdPL02vJWxG5ohVroPI8YNXVt3AkF+A9HIgjU=;
        fh=hR6g0PZj4gmk5O1buRcj0bk98L5Fb/wLh+fT4UKaQ6o=;
        b=iDP1e1ZhWKIIdjEJA4b+iaMy4YBtqDvnqhguHRwPXyZDDKswDJHKBLi6fKVD+0JnRa
         TGiE4xhGyfMn5J8NPIwVbzvzxUM8GGoGRosEPdnIQtchbJnqz12+Id49IxTtbMDGI7If
         VTlGW1247RwCqCTDXdGJ+FHtNglOHXxRmn/iolanwNx1QDx0LHI9HB/LJLAL2QBMKQl/
         VKB4e/DHCeBUHqeYTvuS3e6gB6kfzxG9c3Nm4/TnvAQdrrnAgBAvExZVSIqkEzs57vSF
         NyxmfAeEfVoD6nQsAjhJ2G7du6N8dkkYrxsyCMjuEXneqvL/p9O2QpKYcTP1JFnxAmFy
         Huiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795785204; x=1796390004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMEJFbUdPL02vJWxG5ohVroPI8YNXVt3AkF+A9HIgjU=;
        b=BTcNxxfF8zZ6eplOtlGML4SGEGn0cMr3gtOgkHiE4ALx7A0kcfQ/Cr9DTOMErCgWbH
         EqIwHkFnS6lG4/eJMf/4BjhqsaixtUfsk/IdX5LJtJezWoj/4mgGH91iRQdicBahsSss
         DAjUyPaNKvI4DtYbXCn5lHUaOQMSphgANl2XqunS4V2a41nBnqFam5RlNnWlrmOndUql
         6E57vqNfALGQ5yPaCae5ZkMwfqpVX7IotYkQGpNNG6EKnVpuXMIn5Nti06Luffr2SWSx
         YQcLri7KgyEMSQqnheKJ77KIOscqKzqiC+kgWhACvz4RWxFNOn6sBAczkvNw1mCpzJXR
         sKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795785204; x=1796390004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMEJFbUdPL02vJWxG5ohVroPI8YNXVt3AkF+A9HIgjU=;
        b=ZH8RzEOvlpO+IzwCfXhBTnL3tYsZemkjeu89aDlZSQt0BOvm+JgK53qvsKT4qTeJEQ
         O8DqPTUuj/ppgD76ca9u6pfgCQj4sDzt0m/ubbrpoCdw0lezLlPF773EfCz9Kl/K8qvk
         3FWBhfUZnTR7FwyrH2/tHEOxl26EeqBJlg6Kl0obxX194oV+CByBCA43WGc4QXPTGXz5
         X9eoAIiM08b+JsGNZH6hupjFfGwXyGtXjHmlAdvaq6M09+Q0CwSjaE6D3wiOfzzGsbD3
         LBWGI494WnHEMMJTiTBX8OXeGvq1/qfJCl+R1327w+8IGTYBCf6L9xpnoawK8RNEIKyK
         PcwA==
X-Gm-Message-State: APuU4Z8yGytvCiQj33sXsSPean71NX1lQUw7Le2GclLhbIjGMiR4KbWf
	oWvgGFMemg8n5NaGCpzDGaZGZfdofbCjR7GIqJGQi4EBybWcz1i0uq9Mlxa8/jLl4f+5iEI/8yn
	GE2ISUEVn9y8u5aTUB6WBVsbSDf3WlWM=
X-Gm-Gg: AZFdTZcRiWyQSyY2JIidu6raHVs1TJ5+3xNcbvD8QRHeTmbgiw8maCL8vqlquvh2dbW
	3PCTxDgNYTng3oZmhLG2CHUaW7sdyQDJ3BEigXw4W1obQ41un2FBIYcIyfQ+qDZ9Jj1SotbQojo
	EDzX3rqD9yLA5+Kf4ciw+qobh230jtucIa+OOX4dBR1wFnvxA8B3QDja52tUUN4BQCE//DPlZ/7
	OBYq+1Z1659xvdsA8funjbO2GEuHYfrDKOqo61IueHy3M/ibcH/skE/Cz3VXcn0cCtr93LuYhh6
	OVEBJ7HH9gpYE6t2WfJD9yGjaN4cDmc+J8ZwdluDij/wz6uNdbXwlGf5+QYba1pkGUu/eLRhpBy
	inVrrmn46qigSMTaYAImuvQkFkSqsOlW5Lhxbl/gucwwHzKFgub6TVrBP4UYduneZIOvVzwMD+g
	kXFCha3rKeB19Et+iwpKlPfL8PjI2rshKte85LCve90HU4U23X11IHeHWIzQbJkoggCrDIux2fL
	TCCag5Mvn/3DklYmAtjRFZo
X-Received: by 2002:a05:7022:ea8a:b0:1b5:3819:f8a with SMTP id
 a92af1059eb24-1b5569050demr23732285c88.38.1795785204482; Fri, 27 Nov 2026
 05:13:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261126213306.87466-1-okhuomonajayi54@gmail.com> <20261126213306.87466-4-okhuomonajayi54@gmail.com>
In-Reply-To: <20261126213306.87466-4-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Nov 2026 14:13:12 +0100
X-Gm-Features: Aa3M54qYAklVqkncj1zKIQ6hrBDVb6wNQs82IYEH_CurS5yJnzGLjc9FH-7vMFM
Message-ID: <CAP8UFD3qNBYUhm2zyqQLp_Vv8mawekTs_Bk7E4U1T9Nr3gxfLA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] notes: use the tree's repository when reading notes
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 10:33=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> In the previous step we added a '.repo' member to struct notes_tree
> so a notes tree records which repository it belongs to. Notes trees
> are passed down many call chains, but functions like note_tree_find()
> still read objects and hash algorithms from the_repository.
>
> There is a catch in the notes API's NULL contract. Passing NULL in
> place of a notes tree is allowed and means "use the default notes
> tree", so a 't' handed around a call chain may be NULL and 't->repo'
> cannot be dereferenced blindly.

Looking good so far.

> The high-level entry points cope with
> this: add_note(), remove_note() and get_note() replace a NULL 't'
> with the default notes tree via notes_tree_or_default() on entry, so
> afterwards 't->repo' is safe. The internal format_note() does the
> same swap and initializes the tree if needed.

As notes_tree_or_default() was introduced earlier, I think it would be
simpler and a bit better to just say something like the following
instead:

"A previous commit introduced a notes_tree_or_default() helper to cope
with this, and ensured all the high-level entry points (except
copy_note(), see below), as well as the internal format_note(), call
this helper."

> The leaf helpers
> note_tree_find(), add_non_note() and load_subtree() do not check for
> NULL themselves; they rely on being reached only through those entry
> points (get_note() -> note_tree_find(), and note_tree_search() lazily

Maybe add "for example" before "get_note() -> note_tree_find()" as
these are just examples.

> unpacking a subtree through load_subtree(), still after the tree has
> been resolved).

Otherwise the whole v6 series looks good to me now.

Not sure it's worth sending a v7 for the commit message improvements I
suggested above.
