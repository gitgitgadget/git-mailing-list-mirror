Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983A2E06E4
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511859; cv=pass; b=c5NPb4oGClgMb5kOaw5UjYHn7XiRcOJHnzI/GEBzTDin2/k4NTgBM+LCaXvRvZcKVd3RLGoJlwZTCNKHz39hGRnKeFk370vYVpOaAw5F8ps9tz/Y59eivL9zhoHdrt/bPrRJiLlkn57l63+ptLVWrMd0kfb+tWxY+Zi8Cwc4orM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511859; c=relaxed/simple;
	bh=cqrk1u/XQkN2FLj9hTNqMip+C4td/LPtMH3PizBpeQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtPcImESH7Vk4WKJsk025UxA4o0z1h1ncX1SaIGHHD1Z78bYGuYeVUirEsGXaEbo6v6V5YXJJBaYVLgkAK+TMSnUKVCs4HcTjFBCHOQ2vJ1YlbFO9AxWpYriMTXHc4wqlNBeU8vw0a5p02bSRvkBGQ2zSp73iXc5452QMknIbww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSUDUXek; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSUDUXek"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-68244d317e5so1844751eaf.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 14:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775511857; cv=none;
        d=google.com; s=arc-20240605;
        b=FhHs+H/D8cp8lZccgNeVuOl81NydS8RoUX4yUQcocb7QPpO8kHujxS/CjTXDBKpWpi
         1o/0ncs2Xv6ZmGn5S9TFfjiPvjb6JcaQH01cqfIqkTf70W23Hr2sUGF8rRbH7GChhPS2
         kUCBEUuni7MhYtEwsDn8H7o6lM4TCKrJctDVzs2D72n6NauK10u6lJPO45v9G4ccueqR
         iLKvvDCxSAcxgITxW9jIypAvPHIHuSu3f3yUvz/ehzf/8dYzG2pOcdBkIhVZ4ZGOIpnx
         x0k06JqPaLe1ngWFjkoKmb46N1WwsI7TOBqLZd+RY9pjSSsMO3MWjWW7tNJ/6gS9npFl
         F0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ic5feQEB+4HwlfiP3dMC/SBpHwyif6IfXDrk8H/Y/E=;
        fh=+Gicd5/BhQinV34j9vNUZ31bBwHBiJdK+yBRWVmXfr8=;
        b=AO9qJG6XMXp5ljDaugWbinTBdQYxIOI4X8lRmamok17XxwravGGF7GCE5a5zo4fUs1
         gpob+koXAKk11lJAN/dRUobhIZTfBhnZVWcB28MTdgLex71D9c8Rt+f6AoAufrgjRh92
         TYTSqlStZW6MWs0AZ5zGIpOx5i+cVS1pvo7mUrP/t8+pTmedIK9fIlWg9J+KIoeMALPA
         09k4ndxDS5qWxcFz6uz0uIUr9YZOrQWhWShybw1xpReI8LdG96atYeIBSaZmYLvpHCJW
         u+J7AJvkcfgfnENbUyM9nJiBCRV4j1BKF0oAqPAwSBpEu3foR5D8FALBmSDbFvwX5K5B
         9/lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775511857; x=1776116657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ic5feQEB+4HwlfiP3dMC/SBpHwyif6IfXDrk8H/Y/E=;
        b=WSUDUXekVBVC6EQ8cZjVL37asmOpVIgZisNci7sTaEA+b1awlLD+cuMpiAt3WdaWDj
         7upm0ejk4g0Y6s7f+hAnhGHdnzPAxAlJ/IxFjFzE/ILFUSgehhFiPbWK/oetOQjg38j2
         8XAyan6aIgvyK8w45uDIprSeiNvRT2YjnWM8a95o1o6B+CFqmp0t7WJv83xQe9FqGfGn
         I6JRKpX+SfNTr+Cm+4NH0ZLPQAlSH/lg7N5bZIHnCx3jakGX3g0bVWjccapKogjdGZSp
         BevrWSJfXT/pu+uGTt9gMkgCb938taTqVlEdFow5rN3hOTotKXLWxfId5LlXv83EcHw9
         baSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775511857; x=1776116657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ic5feQEB+4HwlfiP3dMC/SBpHwyif6IfXDrk8H/Y/E=;
        b=fKeh1LR+BFuvsVbDBpf3hRnNWUv5aDkGOphx6ZsFUhV6N+G5lnL4nIDVQ2JeT8NSuM
         Oasleln81Z3oahZ1FDNQckvf7RmVgxpJtiV55IfxAEnrWgG5rrUXHtR+n/rFuXTJ+m9Z
         qaW5+44Al+bJ8T8B6BSHUv84WPSpnawnc7mHnru8G+rIW48tbyZr7Rr76ZGnyREOAkI1
         4fkbvmflU8CYQtBOSUnIHLCQch3d8HFhkXKyRvqWXAEhx6LE+XIX/Dw/lON5ZfBILCw/
         IS4YF7vSGI48gna2efNxAJhF7HByr/H9m7PrS207d9Ri9Eu2141oiU2jio8go8PC80Fo
         KhIA==
X-Forwarded-Encrypted: i=1; AJvYcCV769erxRT7oK3yB1Dai3KQ6Dx4/srrUzUDDGfIS6giR2QWh7l3QUq16leHrHkpqmi6sTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzC+SC/ieKRqMK2/zSR++hGzl/DhUL5oEIG2h6thiU3I7U4++6
	sIBPyrUuI21RfAatJmifRFdM8xD603LRCcamjkiR3CVDCpM80cBWDBQjNWs7oveLLmUYz+Sw3vV
	56NSFI8rq+XOlMClM6RYai6m/2Rb/ly+gBkhb
X-Gm-Gg: AeBDievBkcF5IfSCyxQyRUicPNeMWRN7kOQe2QTHlb0Zqan03GGv/LWhpaP++htt/0F
	tgsw+5wCIp48xAkltm4byBSJAH3SmByY0JKIan0tmyhAu1MMwEgleNNwkR+rHHEtKdBK+19O4Zt
	HG/B1+X1hbDRqIlIajjheTj7/5a1OjaOenAKL4gTbj6ObtpprhFhuk04L4zBwJ9AYpaCUzSauxn
	/GPS2CfwaXVus33mefeq4LoICK17ptzAf5pnmpPlBMie4p4498nhRxYIUl3ksUDBeDPNTUdyTdw
	HzpWYXJcS8a2ybKpnY04Id9nrJwbrHIGss+8d1WhRadNU4OyjUU4e1C+iRLMOFOSwPjPN9AGzWv
	U0q96emFIp+qfyuRIBBmS2JIApw==
X-Received: by 2002:a05:6820:618:b0:684:ba40:8cf9 with SMTP id
 006d021491bc7-684ba409805mr4239484eaf.33.1775511856940; Mon, 06 Apr 2026
 14:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406063607.15353-1-ray@ameretat.dev> <xmqqo6jwau34.fsf@gitster.g>
 <20260406212937.GA30202@coredump.intra.peff.net>
In-Reply-To: <20260406212937.GA30202@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 6 Apr 2026 14:44:05 -0700
X-Gm-Features: AQROBzCEvMfBtcml7mUGle5S_SDKlYu1a7OZab7JcMh1UKriKKbLudfIQLju-Sw
Message-ID: <CABPp-BHhXQc-s8rF1n+AQ0VodX2KuiahcAOcg2msR1eZrUSsCA@mail.gmail.com>
Subject: Re: [WIP PATCH] fast-export: emit deletions first
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 2:29=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Apr 06, 2026 at 10:15:27AM -0700, Junio C Hamano wrote:
>
> > In any case, it is a bit surprising that fast-export survived this
> > long without having encountering the problem you are solving.  I
> > wonder if fast-import handles such an output with some smart to
> > avoid the issue?
>
> I think it has come up a few times, but we never actually applied a fix:
>
>   2015: https://lore.kernel.org/git/alpine.DEB.2.10.1508191532330.31851@b=
uzzword-bingo.mit.edu/
>   2017: https://lore.kernel.org/git/1493079137-1838-1-git-send-email-migu=
el.torroja@gmail.com/
>   2023: https://lore.kernel.org/git/BBB169A5-0665-47C9-819B-6409A22AB699@=
lanl.gov/
>
> Looks like discussion got hung up on ordering other types of
> modifications, like renames (which can actually have cycles). But I
> don't see anything to contradict the view that putting deletions first
> solves real problems and would not harm anything. And the answer to "it
> hurts to fast-export with renames" is probably "don't do it".
>
> It's also possible that sorting should be the responsibility of the
> receiver. I.e., should fast-import see:
>
>   M 100644 :blob_label a/b
>   D a
>
> and figure it out? Or maybe we want both (to help other consumers of
> fast-export, but also to help fast-import when consuming output of other
> sources).

Would re-ordering on fast-import's side introduce bugs or violate
user's assumptions?  Right now, fast-import has no check to prevent
more than one command for the same pathname being given, and has a
last-entry-wins ruling.  Thus filemodify PATH followed by filedelete
PATH gives different results than reversing the order.  Most probably
wouldn't care or want to ever do that, but I could see it as a way of
allowing you to change your mind in the stream and override an earlier
directive you sent.

Further, from this paragraph:
```
Zero or more `filemodify`, `filedelete`, `filecopy`, `filerename`,
`filedeleteall` and `notemodify` commands
may be included to update the contents of the branch prior to
creating the commit.  These commands may be supplied in any order.
However it is recommended that a `filedeleteall` command precede
all `filemodify`, `filecopy`, `filerename` and `notemodify` commands in
the same commit, as `filedeleteall` wipes the branch clean (see below).
```
the comment about ordering with `filedeleteall` does suggest that
ordering matters to fast-import and thus perhaps that we shouldn't be
messing with the order the stream-writer gave us.

On the creator side, I agree that fast-export would definitely want to
sort its deletes before modifies to avoid D/F conflict issues.  That
doesn't help with renames, but I agree with you that the answer for
renames is probably "then don't do that."
