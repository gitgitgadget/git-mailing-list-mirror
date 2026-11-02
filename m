Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793634289;
	b=MhO65kk8csKMxBB5SIyt1CRDBGkV+nd37rP+C2/1c/oqG8HTAFXchDhQYIqBaHqjX7bu
	 euKJAfcc7MjUsjzXx754li1box/CunelJmPibK5eqmoub0twfyWZg166pw6trAqIihvpA
	 oE4BaWyu8UWf4ccgvMA9KdcdB+M+XoRw3+L/cpexHkYfOped9wCzvq23l7ExwCCiPr/te
	 gLG7CZLZoqlJx178XzY2kaWjMn/f5ileJcSkFOaUt7RWM9Wo5odjZ9b+rJGaR7REJZ90m
	 P8mi40BuHNdG7kTxdF7Qoq72k29zv6j/8dyi+0PTs444Mo+PKDlGVRcyRpp4Ui1PrCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AcXpfOR5cykprlaHffBAbKOnaD9vzw9755T/yHHw94o=;
	b=jg4DFAF6n7BuNS/eW+yqt58mXoi5X/eNY08LDFzCi0NicyYsua4JM7ZBhs3rWU9bOYHF
	 C6Uq+PPL9ZAKNnkfJAFauZixYJXSX7IJqJVJYkZBFXoYEsX1Bwuc/wKC/JCEX6aRHvb4z
	 9AyH39S20YpvnKnTZ3RI/qB/M77+AP+ZHmWEjsORKarobQTNLRyoTkfkO/7ApWXvScX4v
	 FYAx7944pNoWvH8+h+G8pOh62kvqQ0V9aEoGNFmyRgH34u4QZCuuFG9kmLbinQO3faZpT
	 yYcMVA0OStTEw7exy85+aIMzhYH55wZn6r1XveiLC90t/jRpHYIRo9AfI9aetFAUf9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RjD/G+zK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1315606A32C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1315606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjD/G+zK
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so5106142a12.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:44:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793634287; cv=none;
        d=google.com; s=arc-20260327;
        b=aoAkf2q/eIBhb5lfqC0VP4sg0iu3k9x4RPy1tYaG2b0yAFBL5Y0NRXvPuNuIhhDGoH
         lPBpfX52UtTQzYpOE1rX2QBBnXQN8B//xKR2d7E6+t1lzhuOG8hocXXshCt6DIz9znI6
         wnK90ejPdCyaSg7IZvnsM9X3qHvQgd/HMTNBMCogjH51SMlezJIvPgJ3JsSliIS+BK8d
         S0yrAJjJKBNLb/tKBuHEz6RTayom/x8Su5sxuQdPRYyn1BEt31B//PA9Chw08zHgO9PU
         5DLk4RvnPwULjbRB0ESaXcOjntzxOFdEPcUjN0avYFjLDpgxRpLQb0HedCWMnsaRcH2W
         QQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AcXpfOR5cykprlaHffBAbKOnaD9vzw9755T/yHHw94o=;
        fh=LrpCnZCoNbdARdfoSTNeqYGx9yzoW79/9vJyQsozmQk=;
        b=haoCrjbX7KSo5YO6d5Yhzxd2s2LR+WFtyWTyT1T0IQ7IiqshAJdtscmZfZbrhYfSmY
         7UR2N18IaRVmjxBVaeea3KVGM4DaaNiA3nTTA++b3mf4+sLns4Tmqq+FZhzUfaqUj5u1
         SCh/aTvgJ/jwp27MIwwJkb6aCfhbBqXTtcrkfzqPuyB7TpW146+TK09568MjJyM2FkSz
         1KzvE4tMnbeydliTRb7+R/HZNoTF2WDnwlbzRhk/+SuGtDnrwhGMtTONFSLMvhWkaKLV
         jvcPLZyADLKA/sS/5hjCvNoehi7hVvYstPAD4u1QjSjU6QjjeTRhn35rfX2HseG5G/17
         1oSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634287; x=1794239087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AcXpfOR5cykprlaHffBAbKOnaD9vzw9755T/yHHw94o=;
        b=RjD/G+zK3bKqE70GW/6YTUIvX/3MmOEjKN8KOuQSTLpoNt6gfIHo0LoaZXfGGbefvk
         ZNrVU2ie5x8lCHbbvF78L9SVxTxcXyPBxFMMIlO981qWVQrnGImkHaF5PGqDpoMYojPd
         abcjwthBMgIkNHw+fir6a7ZLkiYrUhubtMT4bkkBIzGMj32aC+6XsHg+t+Y0+OR4LfJK
         5e1cRkd7vF45D6+joxSTEi0lAGSZJRGGY6H0SJ8vQf1vBgt/s+jc/RPd89+E5Al4JM9c
         0BGqRmXqyCvyKlY6/kWLACM8EkkRgBzTKX096sgomq+D/ut2oMKasBc4uetQqBJCmee2
         v3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634287; x=1794239087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcXpfOR5cykprlaHffBAbKOnaD9vzw9755T/yHHw94o=;
        b=Hn1yawPu5pZl3ruQpExOwduzoHYSpDemQtiimSmzk5c1OZXpZkt5t3toh5Sc0KTyxr
         Y0qPN/0EW/HpX2ySous6dmuyS1QbdYgw7+jEImEJ+SUuk8v4BZSWZkr9N6rOWUmCO0SP
         XcuAswQ0vJIwEk/aVjF4jrYAoBrXEBIhyGc8JmIhDjPzfvISv2+JI6We6iFjHSk4GqZm
         xM/5dGOcUlIMHPmTj3Y1KxG2ODiLPNp/556KZwzBfxt/XBXc1VC5qCmzDR8fCFTgzm8h
         +J8Y7s2riL+dgTwU+feydF48TBfBq5uxpTrPhPOL/hOWi5wfs/UFMva5u1HpmTWbpLZj
         Va1w==
X-Gm-Message-State: APuU4Z8JySHsx/g86fbJUc8E9Z9lsasxFEgSaqyiKT8tyHQvm5EUoElZ
	L013hl24eLJy9PWhLR8wuu2XNxlOilm2juKHBVB0UFfFv/camWnOD3vktOBcM/aTIyt0312dJPt
	jXQ9LkkINpPLBuwHwit/kwmxVaa2rS8o=
X-Gm-Gg: AYBFou2NqMnAukk2Ll18wZQ8+RMtHuCIIQYJbcfqI1aM+xrJCVj/vUDNSr53kWLfZ5I
	BX0ItBE2rfhvkBsNEfnGQtkC5TBYz/wtgimOwgq8MEF1GwyH+GJqGRtJo//tEE4ZZ9qsZbN2RT+
	sdJmIwcV2/bf/0kvC3jFqDVMjQOLs6rpQZ57EgNalQG8UEnF+OpW8FqvQfTrlYR7MDTtXMPOe0Y
	Bvotz7fPD0deU4/XoGExLRrmC9wYXPKz74CktrnPvmyd+LTmxFtHBTRhhZ3eND0z+Eh4daCEUKT
	IyVxw6BqC5SYZhsGywd65f5yYPHo7Vj7/VsrJ7Uq5PCemMIGA0/WeFpOGx4jneCPltvDe7Smg4O
	BZIUNoDkuFVwOX+1jskRLJ0u4Tuji+U68IbR7EVVsgNkowLCvRwjH5/QBqXQ=
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id
 4fb4d7f45d1cf-6b4d438bdb7mr5392929a12.9.1793634286902; Mon, 02 Nov 2026
 07:44:46 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKUOgLzP0CSwOwLeoSpM94A+XCT2X_cVojHsLugDfw+tBZk9LQ@mail.gmail.com>
In-Reply-To: <CAKUOgLzP0CSwOwLeoSpM94A+XCT2X_cVojHsLugDfw+tBZk9LQ@mail.gmail.com>
From: Priestess <herroyalpriestess@gmail.com>
Date: Mon, 2 Nov 2026 16:44:33 +0100
X-Gm-Features: AclHuK99So4qx7w_ENBOBEvnLarPH3WOhy1v6TmND0S5HON9uhEzl8sX609l6HY
Message-ID: <CAOcE0wLn5tU6Ok90EhPfyQ0f_atkaFPQyWFLh7JovRGjZ9aZAQ@mail.gmail.com>
Subject: Re: [Outreachy] GIT_DIR inherited by shell aliases in linked worktrees
To: Immaculate Mecha <immaculatemecha87@gmail.com>, christian.couder@gmail.com, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, kaartic.sivaraam@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 2:40=E2=80=AFPM Immaculate Mecha
<immaculatemecha87@gmail.com> wrote:
>
> I'm considering a small Outreachy contribution around repository
> environment handling in external shell aliases.
>
> I reproduced the following behaviour:
>
> Create a repository with a linked worktree.
>
> Run an external shell alias from inside that worktree.
>
> Have the alias execute git -C ../TestBaseRepo rev-parse.
>
> The nested command reports the calling worktree's Git directory and
> common directory, even though --show-toplevel correctly identifies
> TestBaseRepo.
>
> I traced this to the inherited GIT_DIR variable. Unsetting GIT_DIR
> before running the nested command makes all three results point to the
> target repository.
>
> I found the earlier 2020 discussion about GIT_DIR inheritance in
> aliases, but I'm interested in whether there is still room for a
> focused contribution, particularly around regression tests for linked
> worktrees.
>
> Would this be a suitable microproject for Outreachy?
>
> Thank you,
>
> Immaculate Mecha
>


Hi Immaculate,

I reproduced this on git 2.56.GIT. From inside a linked worktree, an
alias running `git -C <unrelated-repo> rev-parse --git-dir
--git-common-dir --show-toplevel` printed the worktree's git dir and
common dir, but a toplevel of the target. Running the same command
with `env -u GIT_DIR` gave the target repo for all three, so the
inherited GIT_DIR is the cause.

Note that with the main repo as the target, --git-common-dir looks
correct either way, so an unrelated repo is the better test. The
correct --show-toplevel seems to be just the cwd after -C, since
GIT_DIR is set without GIT_WORK_TREE.

handle_alias() in git.c has a comment, "Aliases expect GIT_PREFIX,
GIT_DIR etc to be set", so the export looks intentional. That makes
this more a design question than a microproject, and a test locking
in current behavior could age badly. I'm not a mentor, so I've added
them to Cc to say whether it fits.

With the contribution period ending soon, a smaller microproject may
be the safer route, and you could still raise this one afterwards.

Thanks,
Cynthia
