Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65033CA4AF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688642; cv=pass; b=Rige31DHm99fy+ymhXChJuEOcNnKrhjBPDL8iK6Jnaf5m86QfadQHnitKH/DoXVS/qlHHvJB4cTXoU2jSPSt1Ok6X1AAeceN1BjCQtO4pY5phJJcYF1KIzEKJHoGxsqXCbaaXiOrSLgg2GOTwYynJKtfvu2V3bD+9ywQzWLRDOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688642; c=relaxed/simple;
	bh=mfsNZB1jUscrwnFsTfcz4S9oP4nYQny9NpEyH8q/An4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0GdNKFPcnwNYlATNM6dCD3/lP4frF3qVZsouNQIDplrV0uSg1vSPfNj1an2v5IPgbcvXYHLk4wg7rknXWeFsq3urKcEqBP9vQFyFttjheIedHbFhCInAkW3vk6QgwnCNs2y6/jk2TggPhnYcMhg7WVWiwlykeYxdAD3hxbcGhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNCW1Scq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNCW1Scq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so1270249a12.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 02:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781688639; cv=none;
        d=google.com; s=arc-20240605;
        b=TdIyU07unmVu6AGcGjdVGVfUda+yj98gQQLrl3qx8p27DJC9dOyvaDZFegKzFU8FUz
         oTnucQhhvfHiv85iUyUWs64er9EM9YELLaQqM0KFe4mlLE8f/N1530yP3UxGjo+l0yvx
         PdCObZtW26GiduJwatDNrlPR2zjfo5SpWXxtDvGEZuCzdvn+mOSXMTNOpMunnp750g//
         jf3jnzcvAraABVp5hrV2s4M27GLNE/doBnwr7PZE1mnkVKuaKI4hG16LCvQD1cHbHE9s
         zidCX7tt8larePrD8BldgwljkcxvAA7dzVD8tn5SuyhztW7tWxbpzGFVrYbsmQuiul8q
         UVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mfsNZB1jUscrwnFsTfcz4S9oP4nYQny9NpEyH8q/An4=;
        fh=KN4kPm7lG29nRV4k6/dUYLdgQno0TmmL8PbUw4MhsII=;
        b=L4g3q4hptojAGH7a+rZTrT0idv4MHY6uCDP500iB4Cl6XAaVYdb7kfyrBlDPAfetxL
         l6R76C79fx8c9ykdTvRuIh0a1abAueJGp/8/otAnk0lBC8yt5SPYA+Xnt4lp7Xm1xyLX
         Urzix8AF2ZU1HtVlPEO2p3pPNINAROC4yunc4GQp0OBP0r/8NLcGZJmh/YerY+Z+nn8G
         DK8lJmwgKGEBvcEx/aasF4mSnzGRZCbcuADPH9K086x9PUMKn5eIwy5v6Sp4YLH50Oyq
         gwJlTj7NZjwHQGHybn9ftiBcCP3tNZuU8v69B8G1+m0kaqfW33eENfgQ4zf140PdVvBC
         NBMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688639; x=1782293439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mfsNZB1jUscrwnFsTfcz4S9oP4nYQny9NpEyH8q/An4=;
        b=YNCW1ScqlmYx4D0E+0RNeEOyd29IrKJbj35n4adIdAfm2gNdDEqvoMWy732JoykRhA
         wlj6u/drMn4IqGh3/gwY8uhvHioNyQUnPhKPLlGFGJdgx8XpPhXjkg3TfhGPbCGKqSLE
         bX0seWTpB9pvp0RXcnoLGOa3qzj9Er+g84DvmczzyXs28463WEXBBfOYcybvwO9VqXbZ
         PsBd3BRfJwyqG2sQc08ik2fRyZ66JZdKsmTEnVzmyTx0DVdik24bAAkdV3kNC6Eg0f/y
         s4gqtgFziOEjB0weYlvoOSBDV81JQIOvKC3X3KXeIAg3lNlq2zHkzNzahRQZQORyqsWp
         bVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688639; x=1782293439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfsNZB1jUscrwnFsTfcz4S9oP4nYQny9NpEyH8q/An4=;
        b=sckUqDkPNfKAKUK/cppV2aT1fPbsOzkisy+8LW667DrLIRXpij6SmPsrigB7s2Uuqc
         UxHuqn81kcq0abfAwDi/y1nND1Sxa0U2pE56agaAVg/yav0oUjemljnB1UD38n9VE4x/
         dy4jFM8ucWfSllPX3TkBAMCgVbxQD3ae435Sq/z5tRS4qpUZ/SNbGIRI2yUQWHct0Yt4
         c9mhj5PTPzI7rNHmC8mQk9StC6LsQh5wM1MijZ335rYVH/WlWB++Tjg2axO32bfQqsvl
         Fm1aK/vPNwezNdGX3LTYkzpUX/Q/IDUtwpv+/t2kvH7dsCwcI1cDM/SyVga16oUiOpJs
         enCw==
X-Forwarded-Encrypted: i=1; AFNElJ/xiCU+B7ieoK1SX1EsWb5tYmtmeAOblF0Z1tQpQRm9xuUU4ppZzwPLJ9ZPu+lxlWPrRp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fyFun77O5WFJOgvZACx026IFb54BvhglNHbKVbBy0eliaHNT
	E3i3fRJSoHgtNy3h2dPrBezxFfmB0bMM14xtGoN6zZjVK7uyE7f7fDLcWzHH/FWCbJcqsRzQ3do
	21S6VUb12SAQKHmLlAL4+dHiiv9ITvFs=
X-Gm-Gg: Acq92OGTX0TWvB1W1Q8njwZ04WF3N+Jz/0PZIclmalacc0ehIBQAmkr+HUNh/jFpmRH
	BOeIVSx6eWzdz77uWgY15BmE8yxAc1oewjgnfNXTB2sLg+NYkYtG546Yltzy28Pkm4QmbqpHQBf
	dLmbvyEKI455AWnGWTxS7CguQDBUakkQb+u14GU2XvB1QMvQSGsJCK5p3xIuBxx7qChj2G79MN6
	3ocpjZ5wtbaHxhO3x/7xdcCt47pdtqVIWoj25HzOc+QakhII7ATPSyFbcmnKCzZssZqc2xI
X-Received: by 2002:a17:907:c24:b0:bfa:9457:b517 with SMTP id
 a640c23a62f3a-c05d75eff39mr135496266b.23.1781688638925; Wed, 17 Jun 2026
 02:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <xmqqqzm8d0j7.fsf@gitster.g> <CAHwyqnWa55xbTpzq-Nf6cMyvgR1yYgg8fhvgMFkquSEGPUwDmg@mail.gmail.com>
 <CALnO6CBgHz5d5BT5gCyqyhw_HpV733msWOnrxmu-TJ0QGHE9tA@mail.gmail.com> <ajEKf-jCIDVPQCeO@pks.im>
In-Reply-To: <ajEKf-jCIDVPQCeO@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 17 Jun 2026 11:30:01 +0200
X-Gm-Features: AVVi8Cd3WwLyWQ6LmFJ3gqqWTsOzHUknBrV51Rww-bZH7VVuHdW7m6qihH801OM
Message-ID: <CAHwyqnXL8EWQ6iNPaH6b3e32vXXFwdJ5jhtkP8CnHfj9GLo32g@mail.gmail.com>
Subject: Re: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest commit
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yes, it does fit into git-history(1), and I do indeed already have plans
> to implement such a command going forward. I wouldn't mind at all though
> if somebody else beat me to it, I want to implement at least one more
> command before I get to this.

What I like about 'git rebase --squash' is that when upstream is set
up, it understands the commit range automatically, whereas history
feels more removed from the current upstream. Maybe I'm wrong about
that.


Harald
