Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF243381D5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100382; cv=none; b=hjhNkyNRkL8aFkj7+lrmWRoiAWwZJRM5tnKX2awGQT89/YZCn4U0Fxz9BTolLaz3dKUKXPeuKjzBpwLIyX0UPJmDnCaM34l7DvEmqKK56zQwpNEMZGw+y9/HT9NDjHUQZdQm3JJtppuddeGR0T8Im9pnHWdP13JBNjIl7kJi9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100382; c=relaxed/simple;
	bh=/LGaX7lLmJy12xrMYy0hsNA5npDmBHM0id4cOfusZVg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=q1P+8cveyNkPrwER5xG1I64Ki5SMSDCC1YrvK8gFqHMa/yRa9FNKHZupbXnohv7T10E9vRUgWAYD1d8W4UcyAs5AgwxidhKvr3Vk1aY13cxbm/rFylrIcJTxYBk2J62zt+e1BgDa/brfwy07JsGqi+XP1qddvGeQu/HutBpJii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axzZ9kYV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axzZ9kYV"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515830dc79cso2100927e87.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711100379; x=1711705179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2SadI4lkPZIjiVWYCPZw5Ha6H9NiQ+yzoV7XxmLEVYg=;
        b=axzZ9kYVhYqZU70aXIfdNFk8PKwVdfaQlVqHn3vOtVjfwkcI+lcy2i7OrPq4VHtYte
         E5E6/HjjqqHfB1ojDxJ3JRNw+0CneCvo0JGgiOceJtx7d8Z1sxFXhYIvbQJSx9kKa3tY
         +FD7lFi0oxWN7319c1zstBRlHelU2ZDJXPO4fj30tIZHgTJqNh/lRnHLaWu7CuLInHvD
         nbPWFPEVJUGC4UXZDakYSdF3w9/Jj9ctHQhX/w81h3uH/RMMj2dHgMEcGVlM/2TovuUl
         3QrCK/CZaOXLyk0m3BELxZfWn0fxDPPk10pMu09hWq9quYO10of5H6B2LzXtN3FabAje
         i/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100379; x=1711705179;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SadI4lkPZIjiVWYCPZw5Ha6H9NiQ+yzoV7XxmLEVYg=;
        b=B9VK1mlh2qlrYELqG/p3B2ONXv4pVqRawhCrWEZgMYI8TfVmEKoA22SYZwXlcWZqAc
         6dwFTkYGuo2ddWKgwJZXEId53+eV8fGBELp51TDqkPrHvWvSHF5oVLruAJbDYDA0kt8U
         N62onZ3FfukYD7ddruwjHW8927KPb9PDDq4edF5aPUd69chCxAuUHG/60hkwXk1PosxR
         5EFKIIkyghcUPl2U0ZOVbk47Ra0r6B0fV3Huojrjucu13WdIrqAREpP4LBU+OGIAd+TB
         1oVEH/MP26WeBKo6L1ceC+gpxHYza2aWstfRTryjobUh6/X9oASD9TFWFJF5U/b+C3z4
         bJuA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Op83vp8lcx66EUa0pfQp1xcX9aYmFKJih+Kte4gmfNepXhz86uHEvoq1lj1UuzqA/Zx6I6tmC0gqKjGPNECR19zm
X-Gm-Message-State: AOJu0Yw07jQwbwFQwWZG19tgRqghTutVHzKfbWsuOGatu5YNWPy7onHN
	ypYOiVohqiQhLeG+vkHqpcDmNeX2i0zKbyY/PsX2xffZnaIuhnNsuDG3Z/xunho6tQ==
X-Google-Smtp-Source: AGHT+IFcqAkJm0174K8IdmfESMmJWI7v9hyo4n4rIDOuQ/Yo/rJFpsiT3p82BYgvHCpl/zxwhufd+Q==
X-Received: by 2002:ac2:465b:0:b0:513:c227:70bd with SMTP id s27-20020ac2465b000000b00513c22770bdmr1431667lfo.60.1711100378116;
        Fri, 22 Mar 2024 02:39:38 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t28-20020ac243bc000000b00513ccce5c04sm282028lfl.227.2024.03.22.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:39:37 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Richard Kerry <richard.kerry@eviden.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Merge selected files or folders
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
	<xmqqbk778oeb.fsf@gitster.g>
Date: Fri, 22 Mar 2024 12:39:36 +0300
In-Reply-To: <xmqqbk778oeb.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	21 Mar 2024 10:50:52 -0700")
Message-ID: <87bk76fvvr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Richard Kerry <richard.kerry@eviden.com> writes:
>
>> I'd like to merge only certain files, or folders, from another
>> branch.  What command or options should I be looking at to get
>> this done?
>
> If you are using the verb "merge" in the way Git uses, then there is
> *no* option to do so and that is very much deliberate, as allowing
> such a operation will break your history.

No, it won't break history. The merge commit *content* does not break
*history* in any way. Path-limiting makes perfect sense when one is
about to create merge commit content and knows in advance the exact set
of paths the changes from which are to be included (or ignored).

>
> A "merge" commit in Git records the fact that *all* changes that
> were done in each parent since the merged branches diverged have
> been considered and the tree recorded by the merge commit is the
> result.  Hence, if you later change your mind and "merge" other
> changes from the same branch, it will result in no change at all, by
> definition.

Yes, but it's not an argument against path limiting support in the merge
*command* that is just a helper to create merge commits. With this
feature in place I'd just tell "git merge" that I've already considered
all the other paths and decided that changes from them are irrelevant
and are not to be included.

> But if you are porting some changes made on another branch to the
> current branch, and then planning to record the result as a regular
> single parent commit, then there is no fundamental reason to forbid
> such an operation.  It is what cherry-pick ought to be able to do,
> even though I do not think it accepts a pathspec to limit currently.

I think both cherry-pick and merge can be given such a possibility, as
there is nothing wrong with it (see above), provided we do properly
document what we are actually doing.

>
> Assuming a history of this shape:
>
>       x---x---X (that other branch)
>      /
>     O---o---o---o---H	(current branch)
>
> such a "cherry-pick" would essentially be applying all the changes
> lead to X since the histories forked at O on top of H:
>
>     $ git checkout H
>     $ O=$(git merge-base X H)
>     $ git diff $O X | git apply
>     $ git commit -m "picked changes from branch X"
>
> And if you want to limit the paths involved in the operation, the
> "git diff" step can be given a <pathspec> to limit the changes that
> are ported.
>
>     $ git checkout H
>     $ O=$(git merge-base X H)
>     $ git diff $O X -- thisdir/ that/file | git apply
>     $ git commit -m "picked changes from branch X"
>
> Teaching "git cherry-pick" to accept a pathspec and natively 
> perform something like the above is left as an exercise.

Well, I'd argue that both cherry-pick and merge should learn to have
this useful feature, and it's much more useful for merges, as, unlike
single commits the cherry-pick deals with, the merges tend to be huge
from time to time, making manual amendments a real pain.

Do such patches have a chance of being accepted?

Thanks,
-- Sergey Organov
