Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7103CEB9A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696079; cv=pass; b=CA/5V8hvyJXrC4zNlTpY9Ke96dhAcNhZ7DeuUUpsCF0pS5LvFapsYMQ3FuKthz6CbLef4HY07ep3YK58CY744l6FO7N8lMlOj744hDm7b9/dY1GpPMKNYpU8H964ITAoth5f5wTPn+SeJghl6PPD/Wni8sxMtZPAq9ScMywf3jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696079; c=relaxed/simple;
	bh=IQH8b5iB1vv5s9DOBtK24L+IAtMqiB36s0PmdbdIS1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcvOMNw7cFJgUQAXkPDN+niVA8acxi/EXeIafG7CSqQTEPYUkxLUce9FMHOuDvSD6SPRaz2RaDwA3d097IrT+qPs7Vmmrx6lpLdth1dk1phQhUQ8ImETbWnYK58ELgrTzb4g043Zj8jvruRdhNPRpTmoNVynXIf4xB4rUzncQgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6jUTdXZ; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6jUTdXZ"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b1be215736so331549b6e.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787696077; cv=none;
        d=google.com; s=arc-20260327;
        b=Vmx+AfCRKFhwo86v2v3Sw4xjczcs0vS7ZzKiyrYi6Ze4hrrk4gRke0zSZ/JC+6VckO
         YRXEUaeXN3Qg8AatI/qkWTLZuy8q2z0vCT16JVK/i1vEUX+982Uf0Nr/ZcSV02x+vD6b
         jLm/WnxdfHtoKZUjL8ef+4G54plxq4WvvJodIxcvljP7xI/C+254NgITdZs2WhAcLWpo
         ofwjTSnVClTM/RT0bwJFwXnCQ0bzYvMCveRmJ9QEeEMTTuyY+KrcUAX/D3tTKDuYQwTu
         X/W5L30M/cEg8CcCk6OKeyUAQqH60aB0vJ5R1OBogvr59ZBUHkT9C1qEZAt40t1TLbbo
         S5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D75fInvg+r09iPcPb4DMRyrNPhfp5Qo6unK6y6h/7oo=;
        fh=8kE2VkWfDdS5fLCIXYYt7RvkWfuys8Lc4lEVxWzzsJQ=;
        b=WftEKnua4EW8UrA996Oi5YZLZdb0WVsQXq5TfQ0DEhruiqXsqY3O4zQZFBzaYF/vTK
         Vok4XCw+i9XnxuPDnoJRgOYlksogcr2onAUb/y5jgWVaUUCk/pYwVjWGe7JzZWAzPUjL
         br8YREYuH2db7OW79bjiTAldYjnlJPfU2lqny5E+GI70HgJ6OTqCdSpY0KVEemzEu6Yf
         eVw6DIXJlnHX5Cam+Hj5uOtzmWTVs3zmZgScSepZ4WRBhw31UYD3bqX9feVqh3aKVbmN
         Imvw8hhoAX5XcnPhbwQA1Z10Q7ib2gFFvyqOdVqcc6H9Xkom11eYGhAu2fM8R7xIZrt+
         LVyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787696077; x=1788300877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D75fInvg+r09iPcPb4DMRyrNPhfp5Qo6unK6y6h/7oo=;
        b=V6jUTdXZrPFhS9apTdYjTCQmoDvfrGK5Dv8mgesMQCjhw8xZKnjMyPLxrIschqya4Q
         E73xQy1apuuX4Q1estpp/0nSae0MFeQYHp56PTxFOP4a/zlN1BkaQ5tJrad/NQq0WMiI
         Lfe0QIAipJwrD1w2v6JJnCWsEKmLOr8fniedZuStLvgrcgXK36Pl25rGs9UXVzxCNiTM
         2YG8BW5SNjaxdLfPNPpv/uvK4JOckIrtbPOmvlLdD0HIB+oGGBHsE24kFCjYkbwnaCG+
         n0fJsuMih9kIUdEhRfyuhcaRhp9jsjoswClwooHvVfOEB3WZgx1XOy2l7Y9n+sgpe+kf
         /Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696077; x=1788300877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D75fInvg+r09iPcPb4DMRyrNPhfp5Qo6unK6y6h/7oo=;
        b=rlOd00sWzPXL/tyj3lT7BTu/ti19SGMtE7+EhYIm8R3Q3rIuzV97CGUv2RUydFAfbY
         xWGrUuhczrAYzebZhKcXx96KoOzPXrhK0fReDyF8szjUgufEqp47RJgLWFK04OfHk5ZN
         DrmTgSZTCfv+ObeQN2xpMRoND1VjFvLkYvnE4mG//hthOtjEXMG2v5w+BFJLeXqmcQOl
         HhCLHqSw9H/XnJDJAixmNWoWyVSsPczgvwIEwD0JPK4VP9NgZbELILsdj7W+Nw9Tq3a2
         ILcIYhRIpBy27GGFc/V40m70vb1dNkeOeFhbyGJdGis/AJly7kzUFGbl0F4xnkOAuBI6
         5YYw==
X-Gm-Message-State: AFuF++kOSCFL0tbB+jqVbA067OJqCaUa0xGjHHfXc+GTyhnyji6pNPEL
	X8Aw3h0tGhkfA0hEtBKiNPBr0B7JdF3Twc+W6JMX2LGWX/f5JyYkNU7tIe2aEDsJa8U2xp++ns0
	92y6unfpZ8j8YwZdZMyROSP4pwYidbTk=
X-Gm-Gg: AR+sD13E0JEsUdH9s/4QHsC2wrSwLj4EST8SGCnXsiY6LuvgwxTxD/9hIXqWaGoKbo8
	zhARwoAYutYvyxEi1XIkVZCzzouPL4OcRGrf+9s7xGbFsqcjx6LehO0Ms4uXgb0ZlLfn/88RSWK
	O23pRwZgSp2exDOyVMTMNzYFjTAqKoEopOekYq/JurHgcZ90BbTYv4i8yF/12ibeBCqJhsRq/b/
	BEZQN+02SlOdyfXb4Ui9uvOD+8rGPNywljQ4F9AdkVTVqQO83eCpN8KjVQ487hEwnwywQ63I8Df
	swwdXIkMF9vMC9GnRHnUcz+998DPYWHBVuooQBePtpLHRzUn5U81lcwF/YSI/G71ym6nLz+ElAX
	JFU9RYMp3x2KBpRoLtlRTp8elejIHMRTXGE+xF/M1EkrRHd+1SP3dkJM7762O
X-Received: by 2002:a05:6809:194:10b0:4b3:6801:85d3 with SMTP id
 5614622812f47-4b36801a869mr1826410b6e.20.1787696077115; Tue, 25 Aug 2026
 15:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com> <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 15:14:26 -0700
X-Gm-Features: AcwNN1V9gw0tDtpPRLPrM3Zb_3yiozw-DbihnkntJce2pmtL4MEsJxCH8WHxdIo
Message-ID: <CABPp-BHtmjSqkgL+RL=nmd1VNqqZ6vDUhQxj0AnEzAHZxznoHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:58=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
[...]
> +#undef die
> +#define die banned(die)

Shouldn't that be BANNED(die) to match all the other cases in the code
(and avoid an obtuse "implicit declaration of function 'banned'"
instead of the nicer "sorry_die_is_a_banned_function" message)?

> +
> +#endif /* BANNED_DIE_H */
> diff --git a/trace2.c b/trace2.c
> index c23c0a227b..1d0ed2db2b 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -17,6 +17,7 @@
>  #include "trace2/tr2_tgt.h"
>  #include "trace2/tr2_tls.h"
>  #include "trace2/tr2_tmr.h"
> +#include "banned-die.h"
>

Is there a risk that future folks add new includes at the end of the
list, then functions in them get added to banned-die.h, but are
silently ignored because banned-die.h wasn't the last include?
