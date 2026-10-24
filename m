Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792823132;
	b=I7ZW+vY9NXGGObe1wYEA8gLG2oO+QjTHGzpE5MIta9uzWnXi+po/2cymwwLuvTUFQ8Jq
	 ia66rV2sSji4uLNBeTHS0wTJdyM+W/mpoGeHIS4i8L3771VbqyDzojran2FP5aLoLsAb0
	 8Dz9dJ9An3dgbmc1MQTP/wj9O2PqPSA1cefkkD5q+X+8alpVT+reQ4U7Qyx1BUcNvcped
	 ylkSoH9J84kXnTOOJjxsK0r/JLdCX1mobV81bE5/0TnkCLsGxWTbXKf/YunNZuBYNaW7L
	 TSCGuiNmZqceAsIquguj1/b5UJdOiJg7Xozi56nghJ2cjj4tmJ6v3gAzdpDr+vPFwJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792823132;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FOPYuu6RmtryrFGlLZR2UlYlKBckh4CWkSZ4RAnm2FA=;
	b=bD9ojBGtvikBL8Q4FOphEWkl+/jRHnwNRSPWaoEI6NM4SuEJheueGPOP1Th3jmONIVwK
	 bTQsVhODkGK+wQ1y/wtjCjQ6qjqk25uQAVz5fE+SXAmWj592iREUI0LN/kC5hJaFWO/0i
	 Tgla4cgJ51O5KR8laJWNywaZUibY49sC/PLSujIsVeJ7N/qExHd4uXxA0N1hlX7izYaNo
	 o5lqWZzUWjRoJNEnne2hMhV6ZOcP+oTz+Uc1p769kLcquEtdSPnw1uXw9dFBttx6dB4J3
	 3M5O6GGFuQqGIB9DOrimuHYeQ8FKlqPhIz/3vs6TLpPoF7L6wLkA0j9fBjOptZcKDgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=sunshineco.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE1606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DCE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bb5afa736so251363eec.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823131; cv=none;
        d=google.com; s=arc-20260327;
        b=LBfVaH8137H1eEKxq6sKqr0+GnVZ/qmX3Hx3PnEj2V6zMVm7ydUCEsOhO6ONZ7BQB9
         Lr0IDDw29Ts3zAU3I/BVMwZsDynxcP/xe3ih35m2H/35twMGLMn1qUweHif44HWWhxhv
         uSVAtD6fMAnBs1R5n1dQui+N3PFlYZdOmH2niOWq33gt//yWTc3Zz+InAFp2HWPIqsXx
         kT81AHTzUfWVrRiWiuVJIrrSR6iecHFDRati2p99KFHuERyzbvqm/+ymIc0QxDpLNGua
         KwCog1lQYuMpzvM66vKLsaDfj9IjDaDgBLW+/uxRMywwko9Az5YcPNuTm0UsCvB8QCAF
         6niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=FOPYuu6RmtryrFGlLZR2UlYlKBckh4CWkSZ4RAnm2FA=;
        fh=n13vmhwHYd5fjMlxtKKaB8SqeBD6EHkOjhIzItr9dJU=;
        b=bF77486cnWM+wpkNSjQe0Z2QXW3/bwGKOH0vkPcxqOTh/ADOCKTcmURQc30Rp458CB
         cCbW6KKe/bYT5XAkxILgOfgjb9IjWF/Sp+pI2hpVHLkzoGnR3axjUwurAJlh31UTs6Gg
         eibm6Tc8xgWvCBWedhYYWLOVgFxc/K8DbGNo8beA3P26J80AMT5ZCHwEQJIskRaGRm69
         WEXgzbIctZB/wDdgD1f1mf346xjvfF6JWyJvP8M+qRkW5BtBRaPj5Kt2SJ/9fzlarPYk
         nXJYKaUqfYzpidP/Sw2aPiAWFR121aw0yRIzSi4M7hVKuZUw/QcvldS8srWIkYbH3Qvu
         11Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792823131; x=1793427931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOPYuu6RmtryrFGlLZR2UlYlKBckh4CWkSZ4RAnm2FA=;
        b=JUF0RX21pYx3TUIMpDrcn2SpqdcU7IJhf6xpr9hz2x7LDGEoBLqqkamp6daPlb+Xfc
         noJ6AupnDwNEd1vYR1sW79/9Rn67aPHo/8vnJg4UBa062+Rpw/tV6z4MHrm7NT1flUo8
         /S72Vac8NofRQFn7h5g04wqR9Hv9u5kHz/AcpsRsorX6kIZyu5QwqMcY+ayIYgEIdl/s
         5/99NmmxQ6a92NO7q0oW1gOyr5V08BXY7vMAb97SifplYv/EI1lHSKy7l9wPjMjVl3cK
         XRsbR2nuEOkiK3+dgO4uQ2qCcXrJ3wFUEej1Q9YkGMPjF5PEaJycIQZ9w0ceiPkBHvna
         vpyg==
X-Forwarded-Encrypted: i=1; AKwUvBzdDrbtQ4yBOcWK0oocu8osv3xCbgme8KFxMa7/Yx8mv6gshTfvnQYZ+PLSTAiyFBxo4P8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYpno72NI9DCcWCVNnZDZvOqQF39TYqZiYi1bExDKV0k8UhDC4
	vzB0h9xJFw8uwEsSfrvbMOMcbKxbLD0UGZLF0hZKWQF2jS/yr6dm1tildpC2yO9KmJ/WepOs0tF
	xmC7pBEqT+ubHKbcF3IyJkR+aMk+g7A8=
X-Gm-Gg: AYBFou2nmav15jmlkdrWUFNXPbGtqZyQYPr6uh7dcgf0s/T1Jdp4fiEg14ZgeH6frWY
	1EV3rSFmP/dlDfikJypjMVRu8ppRD9eTEjMTBNbZQpSDsmNJA3axWcIm6vIG0w3zs0nizsiqc4w
	iSvc0/5AVJYMMqlMi9zTvLasxLQ4X1KACSu3wbgPjvQmC49CmoEFBWqZiAMnXJSfTCZO1uytITO
	HS+HkCs1Q8txJ9Izw55lIPzORMEvsk8/5919SOOXxRnTSL+sgmWYHA0FIK4oH4ulIK2yw0Jw1pS
	pw1es3fn9abnFNB9O1GQQsRtRe9fYy8jIEk8guLRtMD3b/F+DOIP6uF33boQwLUV+hhJkARq8+E
	IBmIs/ogvz8mBSrMN6U3u/IhHkLsuRTTt3T+mvIfue5d3020nr6mGte93wY8Yyeo+lbIQWNs=
X-Received: by 2002:a05:7301:4288:b0:351:6d7f:e2bc with SMTP id
 5a478bee46e88-369e84220bdmr3258320eec.2.1792823131356; Fri, 23 Oct 2026
 23:25:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021173350.67854-1-me@jaspermayone.com> <20261021173350.67854-2-me@jaspermayone.com>
 <xmqqqzhg5kyd.fsf@gitster.g>
In-Reply-To: <xmqqqzhg5kyd.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 24 Oct 2026 02:25:20 -0400
X-Gm-Features: AclHuK-Wg_xxClvm9kjMFnT5DlJuNbaQOROu-_ihT99bArQ3oXcJnAXkGVM0tDs
Message-ID: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] worktree list: add --merged and --no-merged
To: Junio C Hamano <gitster@pobox.com>
Cc: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org, haraldnordgren@gmail.com, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Jasper Mayone <me@jaspermayone.com> writes:
> > Users who keep one worktree per topic have no direct way to find the
> > worktrees whose work has already landed. "git branch --merged" lists
> > the branches, but the user then has to match each branch to a
> > worktree by hand, and a detached worktree has no branch to match.
> > "git branch --delete-merged" skips any branch that is checked out in
> > a worktree, so these are exactly the branches it leaves behind.
>
> Real review on this patch never happened, it seems, perhaps because
> a discussion on a side issue distracted everybody?
>
> It looks like the intro unfairly narrows the problem space.  Even
> for those users who do not use one worktree per topic do need to
> find worktrees based on what branch they check out.  While I agree
> that among the criteria to choose these branches to filter worktrees
> on, "--merged" and "--not-merged" may be two of the most useful ones,
> the feature does not have to be limited to them.
>
> I wonder if "git worktree list --branch=3D...", where --branch=3D can be
> given multiple times, is a better primitive?  With that you could do
> something like
>
>   $ git worktree list $(git branch --contains HEAD | sed -e 's/^/--branch=
=3D/')
>
> to reuse the same machinery without any extra code.

I've been too busy lately to allocate time to the Git project, so I
didn't read the patch body and only quickly skimmed the commit
message, but I experienced the same reaction that this seems overly
special-case, and immediately thought of a more general "for-each"
sort of mechanism. The analogy which immediately comes to mind is `git
submodule foreach <command>`.
