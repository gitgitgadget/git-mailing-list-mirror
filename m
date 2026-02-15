Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B423F417
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771197670; cv=pass; b=DTk7jR2ZduXHjsfo+TCoWBuNICN6PMoq4LbmlIRMfFVTjgYuM5DKrfZynemWuHjhiOmj0ZLJCW0y0kYFaNn9+TZ8NYCLWn7qIFGQch2f4seS+ci6J9OoN/mImEaELuoMZR8NDUcREzWJh0gsUPQUKoD6GymV1TBtz/mSxceQtlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771197670; c=relaxed/simple;
	bh=NVhZJQHQUwBaOenCZqHYq/o+0jHHaeZoybkOFgjkxuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1ximP/ZEzYdp2xnj8BCSYSFnEydb3MhFKOceMwR1HgWTBvVDAqQuuxx6CfmW0vAchLsRyO70xGofB0T5QvaJkpu1poj1TS/ZCqQkaoPGefd50jBnUz/YSPh5r/pygOK58uMcwwfrMhdkKjVqcqK4KDPyISG0p3yUln6YtwK/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b86a9613d8so221756eec.2
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 15:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771197668; cv=none;
        d=google.com; s=arc-20240605;
        b=KWmKt0VxXFlkX2pW/O0qUhniiWSshHpbAQDFB5OIngkDfXcgUwjdy5T/c488tU9RwV
         /qsRtD5pkAZUlvf55PpiP6cdJF8SCrAmHnaoyIIvcMPIVJwJwpQF/KDUfDFiORsG07nX
         3k/oEVdocdZoO6SzjlRDt1YdlZb1exJnaoWDU9BstWJ4bhbj0sbNapNHQ1ELkwc2tCmU
         w1HKTTsDUzxKr5161K/oHsuEjLRuoOF6rMjx+eYJ6nuLtxhvP5wZd/+OZ9n//fHjwfAs
         V/IGc1D67M87EBVpWQjmAulFcSIWBYwazYvsHpO5bQ6T2Rlod2lxf/Cbs3qhi8df+HML
         5x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=JI1EjMnOy6rnxRrq1H3Xu+aaJR9LfCu7Rbq11sb2M3g=;
        fh=VhJ3gV/8rdgwlkGnxk+MslABgokmfzWj/oFUn+q6hH4=;
        b=OSMRg+ap2V2cZHyXDiuLwR0P32Dn03VwW+Gfb3WcHduM0Gg0hm+CLx7ExPNjaoXiJ0
         o+CrmOZ7z4Ey4MsZJ/NQltL3DFJTMTy44zOrOpJLyvY+sOBuzNo+Pa7crFGwxP3vFPIr
         hGOIWicMnuyIYYdtw5vRY8QyoYL1guYAdjfGIgNb7qCblxcdfegpcBRCHILJp0jb2peH
         ozm1/0k6ssLFliCnzGW9Ez46+MsktFXpgT3dm8vSlOfbervB8tByxqoiRc9ergtfwJbf
         6tMe7T5iON5aK22S6tWzD+RhZgmxvyH/cVBzsWST9APoQlED+w2LeVb/X3OeHxv8fzan
         Kr1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771197668; x=1771802468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JI1EjMnOy6rnxRrq1H3Xu+aaJR9LfCu7Rbq11sb2M3g=;
        b=erWXEVV/h+WUEwMatVEvy7eMRuJB2Mmj//ENdNDn+2S/lTfTL1Ek9sSgmIz8Dk25WH
         XvOUOzJPtPEtpwSg/1+FBxih28l9LYvyY4gPnFxaJvQe6TIiVBtm6ervoawxEYF2eRRp
         EUEYFIq34hmBQlCi1HtcR+X7/36SNdDF9Eq8d0ealK5/RD7cmU4ifkPCbXv2d1KIFsgM
         XfMNKK8NOWNLZ/ZECibkeis/IRJADOYnOgN5mmzEaP/cLhx/XXA+ZpssQml1NREWSqEP
         mOLMNZIVmLIZhdL3HwPb7/SYgfU0NcnaGXKrMFYZgEQTjjA7Ln87lrXkbt59Ond3w3Nt
         v9CQ==
X-Gm-Message-State: AOJu0Yx992ODPkp5uJL+jsSj11nEa5gC9ToTVxALj1G5vN4Q6ngyTPjL
	6x1CUg6C8Or2sWorEdrrNXk7u9eTncLVqnWLIoBfeY4dt/hK+2g4MoAzC+IDdImuEcV9+6C9IDp
	nz1U7rVhX6iINMr+dRtNKpIUITjh4Gsw=
X-Gm-Gg: AZuq6aKmiG5Oi0EuXU13ZUeOrN+ghII7OUM2iu99NN1od32B0JnEtZVb/KwBH1VwmGE
	wV3BEy4RPfNUgh2K4pvkStMGR5gr0I1GwtLAZEeg94JRbhpD7YPJVrN8uJprmUueUNTf6O6jErl
	K2gNwOAB3ChcTDsHYFnmFjTkJyYmGeAqCDgsxvUf4SeetsYYiMEzvZxXduadUmHI2tMA4ZyE0/t
	byRg9iP/hrKq2iIa5qm21sGbk3qTIg5263yk125L7Vr00s6G98NUIHyP05YDgKsVkTvwnEojpy5
	Bxtyffn1Vw==
X-Received: by 2002:a05:7300:fd15:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2baba0f2857mr1854665eec.6.1771197667671; Sun, 15 Feb 2026
 15:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com> <7b785b6064966aefe6883ce3c45e80bb74fe79f4.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <7b785b6064966aefe6883ce3c45e80bb74fe79f4.1770679038.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 15 Feb 2026 18:20:56 -0500
X-Gm-Features: AaiRm52lL151ssoQqstlgDuZ6Nah4RqYB7Kb-7iYivfAAgBq1HclJzPldtl9Es4
Message-ID: <CAPig+cSb=zzDJCoo91detBgfAi9p4a3R8sVc6iTXfzpbNxsNrg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gitweb: fix mobile page overflow across
 log/commit/blob/diff views
To: Rito Rhymes via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Rito Rhymes <rito@ritovision.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 6:17=E2=80=AFPM Rito Rhymes via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> On mobile-sized viewports, gitweb pages in log/commit/blob/diff views can
> overflow horizontally due to desktop-oriented paddings and fixed-width
> preformatted content.
>
> Add a shared mobile media query to rebalance those layouts: reduce or cle=
ar
> paddings in log/commit sections, keep header/search content within the
> viewport, and allow horizontal scrolling for preformatted blob/diff conte=
nt
> instead of forcing page-wide overflow.
>
> Signed-off-by: Rito Rhymes <rito@ritovision.com>
> ---
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> @@ -537,13 +538,6 @@ div.search {
>  div.projsearch {
>         text-align: center;
>         margin: 20px 0px;
> -       padding: 0 8px;
> -       box-sizing: border-box;
> -}
> -
> -div.projsearch input[type=3D"text"] {
> -       max-width: 100%;
> -       box-sizing: border-box;
>  }

These lines were all added by patch [2/5], applying to all viewport
sizes, but here in patch [3/5]...

> @@ -691,3 +685,66 @@ div.remote {
> +@media (max-width: 768px) {
> +       div.projsearch {
> +               padding: 0 8px;
> +               box-sizing: border-box;
> +       }
> +
> +       div.projsearch input[type=3D"text"] {
> +               max-width: 100%;
> +               box-sizing: border-box;
> +       }

...they are relocated to this @media query. It seems a bit odd to add
the lines in one patch and then immediately relocate them in the next
patch, and it's not clear why the series is constructed this way. I
could, perhaps, understand having separate patches like this if the
idea is to specially call out the existing "broken" behavior, but
considering that the commit message of both patches talk about
restricting the width of the input field to fit the viewport, I'm
having trouble understanding why the patches are separate.
