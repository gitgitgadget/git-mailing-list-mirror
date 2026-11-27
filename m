Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795785744;
	b=NLS8UEJVbzeFQaMEiffHpADuGZ6U6f+Q2H7KezHiFh9ZIEoyAkuNrnPGndOWJW4RjANW
	 B2zxRUpeVAVUpNdZufX2/MsdmSsjErYybEpUQRvdkBa3ImvtgJKuL6CU3NWJ7Vf3Ce566
	 yKeCz38lHLFKHZwUTezQ+y6T3lIXjjZw93lBfouzbBUPXdDQH1qRq2VeeWMH3kIVMgbMy
	 VfuxelCD9GB0xxyUa4QnMD/bWTTo4/pyVjptTtN5MwpfAZxWWKxpZ7O9md2anoBpKy23H
	 EPi7qPv/DHClJSmW3GPRqZ+k9Gv3+yy0LXvSCjLo4VawTB/lJXMswF2w8AEE8qZAq2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=BA/Q5hJL0kfV/RB/AIf1reDRzaynyh7R5w+aNk3rgSU=;
	b=cWgLDfHD6aRDwdV3j5dhpKRU7C3CaFre7LYNmmXshdhlgF/h8VyOUFr007ayT7DM4PHi
	 r9YYZASXnxziP/IsLyZYBgb/cS98FVeQZrHc8sArw6tbCYMR6MMPwL5XU6/qqMQDKqppq
	 ZnZQ0jU2Div03sLsjZ+OoRnYaGA93YF9dPLtKsjHP0ZsKf5CvCNOTrWXcRsRB8lHDmAg7
	 GnCshI0+Dt0gVcNH+eczCziPPFw8wd6ittLPN+C1Q/T8VLHZMc/GJI8Xqiw2xgprIZ1kp
	 uqKfAiVOOB10naPhBBQU+6/az4STlf/wNImGjSxgqJsQ+H3SecZKNQioC8MM350EqXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mlsn7UXG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333A606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E333A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mlsn7UXG
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b59dfe466bso423525c88.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795785743; cv=none;
        d=google.com; s=arc-20260327;
        b=EwXkoPnV1u0j9M9TKS44hCF9rb6RqFfEykCSKCmPfcV+RmsPOuMhSJyrhy3r6JrtiZ
         X/uyShfUkgJeexZT7A7UY5cbjKJghgWBqMRAc4CaW8+N8ElsDxf3KahmkH3FOJsKyGwk
         tu7hJvW2YDl0ku5mgwtVGbww3EA9bzYhnfA5O3RI5d0n2iTk0aQtosLBxqgcgYxJb1vC
         ++EtPbal/ua0gL2M+oVfUpvkuajCJ4Vefs77VmQyRBNRmcCPrGj+LOfkJs0fGm8O0WNi
         cLKRbwuCqhioHM6h1T7mJ0JmqIRABYp1y147b1mNikkXFYfFrnJOKfor4u2KD0ietxFX
         Uf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BA/Q5hJL0kfV/RB/AIf1reDRzaynyh7R5w+aNk3rgSU=;
        fh=hR6g0PZj4gmk5O1buRcj0bk98L5Fb/wLh+fT4UKaQ6o=;
        b=UL0GGTZKmx03d7WHi1cyLKGVO8bRZHWV89RRykIiJUILl7fvGS45yvnUcMWbG3qBon
         11Xik4Ctez4pcJkqoxOwtEmJSUXBd9c9XaTBmJ2ttidy3MyLcWTx+RuKPrBF2AvQhCWs
         SUUswoY/0rB8JkDkI2YiSsX3qEeLJN41wgFEy6QlDw3N59Kf2UWIOWCNF4asDS645hoD
         c2lIDO716cbGWtboUbztQhG8zwQSVnspPCJLpe0EPaUyc6nJxHeAcW4RT9uw8NHiNMwa
         1Dodiv0lRaZSKgOt6zMTXfSwb7YLorI+afxsHlMlujUEUiMTHrXK66UIqEA+x4tbeiq5
         TbYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795785743; x=1796390543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BA/Q5hJL0kfV/RB/AIf1reDRzaynyh7R5w+aNk3rgSU=;
        b=Mlsn7UXGArNku6/FA/ZReNu2PEaiNDzKBqBUhzSODyoS7ZikUhdLfn9Aj33pFAaZhz
         dXrxez52VyVj3jju0YjWGn975hQvmBCAdvbZcwKMofX3ZiOCjMvNWU0D5yvR4gbdUoRu
         Tc0vn5v+uPl1Z0XRjIoGbmZ8qnjFNah/8CIOZnGSf9VOHeGU9o+B30DLJB+GGrkWTw64
         rKcx7/14kQOAA+mK4DKqRYOUkhYzrQ/BeXwbxi/wN7EmJd+E6IVbPrlC6O5rbCOn0Rl5
         ByULJyQ7vH165MgcM5LSnECJPvsG97UMOWh1pCH66IevteQklKolmMxPPNHrQV10tbLI
         AhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795785743; x=1796390543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BA/Q5hJL0kfV/RB/AIf1reDRzaynyh7R5w+aNk3rgSU=;
        b=MKeZ7tj2w72/cLr/f9vu335KCv4LEwD1lvQjO9GK0aYhw8YA8DeSzqLIeIbrLwNK7e
         p8KSsJcKF2D6tKCLeTCNwIzZeMuEI9maxhaidADET5gLbiOLlFtGQH9xRzJ2UqoCaynn
         biITMzwbTIU1exr3eAtMBKTWqiqjDY2UqRoBrMLp5/zosGZWKEY4dtm58d1z6K9tpeN0
         cEIv+1dBv+eA3X/ezrye0WgZ7ODqXB26k/O/2jzQXIVlmneADXMEPtrUN60CfQircGfo
         mQ0aYvMlGyQmViOhE77ItR092oWg+vHqVPToD9CLVYQ3mshFMaN9CApyXE2KU71frfro
         0A4g==
X-Gm-Message-State: APuU4Z+XORWt7hk4A2C5JOHDIkwpcE0Z/X/J1845jM8xXt7u0fTrkCP7
	b2HlRsP3QVuHKR8alDb3xdAAqhu5biT+CGsDgrVdNwvWBs6JAYW8ctLr52TM41661YmbEW9iPZl
	2c8LybcwdcE+YIAbA/nYaaWseyPUj0bI=
X-Gm-Gg: AZFdTZeJqYVutBBaMnfAJHCLhnclQL4ozKih19XpYHDJW/L803OJM5T5cw3fM9Shgjm
	yImAsi3U38uilUaQJGyrjgiykrJSdC7TYQ2hLR6ld5Smz2r2pX0NMATHVssqwIu1M6QgQdT4nX9
	2QGcisoMsQb5cf3uPNOmQKisBcNDuTVpdZWOElUI49slArSVuNeRZFpXyy/fHuqskmlAMX8qcpa
	9y2Nux4cpblIc0TPt6GWQh11AxVh5BvPIJwyklfHTtG0f5aaDiQnT//4JGGj1J+jPsd6exOmy1T
	yuJbnMtsVQw1Q5Y6nevRT8dF1Ytp2A8orpHYZPv+xM1bshxuGGm81b7YIJApPYA4+80zzIxyvw2
	iBOPvhAf+nCVNF20WyetbqK1XAjxKAWQn5gktVPppH7YtENG7jK/PgRv0H1s2tzDKb+EI6kgTmS
	Zs1ld1K4V2NShjDsFuUwFTXCb/cYbVTPKtP3f/VPBWGTT2cZqSdVHwUWHcD1hhBjubLiLS7pd0c
	fpxZs8uOBqvJeyh4IcqvlTQ
X-Received: by 2002:a05:7022:906:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b556904c50mr31658050c88.29.1795785742932; Fri, 27 Nov 2026
 05:22:22 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261126213306.87466-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Nov 2026 14:22:09 +0100
X-Gm-Features: Aa3M54pQLBix_Kd750MriHzq-slbHMTD6Qc_5NbdD_EsC3g0JwesapUOwtqbU5E
Message-ID: <CAP8UFD3wt=at-HEg58UREPio+SVbzEL-G8YF5E++Td+fuW86cw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] notes: start passing the repository through notes.[ch]
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 10:33=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:

> Changes since v5:
>  - Rewrite the reading patch's log message to give the wider picture
>    first (the '.repo' member, the NULL-tree contract, and the entry
>    points vs. the leaf helpers) rather than listing functions, per
>    review.
>  - Fix the helper patch's log message to call the function init_notes()
>    at that step; the rename to notes_tree_init() lands in the next patch.
>  - Note the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros under what is
>    left for a future series.

Except for a few small issues in the commit message of patch 3/6, this
looks good to me. Thanks.

This email has the following "In-Reply-To" header though:

In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com>

which is the message ID of the v2 cover letter, instead of the v5 cover let=
ter.

So in case you send a v7, please make sure the "In-Reply-To" of its
cover letter is the message ID of this v6 cover letter.

Thanks.
