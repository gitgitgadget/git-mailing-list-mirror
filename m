Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B424446F4
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672485; cv=none; b=kKErPrTEiU+4eScwIzg1GjVqBSDD93P5Cihx99MBa4YjaNwqXxfVdhRnV6NlNPuS114pusU4HL/OHAkgiHUo34leolWOa8TyJvteqwQOxa/SgJGcMDjkwta5RfTUlWcAkJrqUC11Usy18rgk6o6xFiUt7uXUeUsZB6L/ZqoEtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672485; c=relaxed/simple;
	bh=ZpZ44T0rSR19hOImJZswH81giyKAC8UcNnZhfQcC/ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOp8YNjlQq7SKei4ET4feycJHqNKxzJjufPKcoc4jqp1WCLgagGFfS2ENHTKwgQ/oC+KI7trSdOCbMwljDf+Cv1x2T1l3r9mT7AVQsFKXCJ9sywS2Y32ncIgN3/Ave/TFRqrAuC7yNtO24yfmpLc6mj5CvfWikDxNcBNru9RKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG7hTzv3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG7hTzv3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15b33f7b23so1729182666b.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672479; x=1785277279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyQeKm+Hbb4jmey+PB9WFih5Y0fv1no1I/iU3jR9Q0Q=;
        b=PG7hTzv3JE+KyLWhSRlBKuZR9j/2Hawrhegwl/iY8n5mjapS5dnFtAUUut8akp09zA
         irI+x7GUi2QH99JbrOey8lDQraUoIz/US6Kl9qvFJCUVLKYypwc4aCPOBcCoTklPuCUC
         jmVAYNu0XK3TikM4B3wuvAjcBB2jiSJq8PPdVm3GTF649BsEjqEPknVmYbLY2QKyM49g
         LmA+PnXLEP0tlabHCkkC+Xuo0HjIrRdv2JOQ3xkscZacs5m5hubWO9Mozk/EOfCrSecL
         ASRx2bi3xWxWNhLg/OTCFW7AOHhin2CNue9bRmwEOSM/kQNiqQHDu3X7vUgFSiS8cM/F
         1IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672479; x=1785277279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qyQeKm+Hbb4jmey+PB9WFih5Y0fv1no1I/iU3jR9Q0Q=;
        b=l1/w6F8ecPATIBW0FzaiYnkaw91yRDs8ovJTJQSbprDS7RJfPXHVIIA5k0QJk9F/Ck
         IrHV+Mr7uVV3FtLNLxAd/XLADzmh/TMVe5CkJiuNBaCfraPrEWrw4i1mTTJtl2odO3vs
         sO84lVpdfQOfeLOHCmm1c2HcBFX9SB1QqTuHJzHFl9CPj86RlmKss5evgq3ZgOlWcn76
         h2YA7vHBNh3GOQAX+UD6YdMjBPnjoXqhw6An7Qza+wIbIHoi6Ov+W2VvpBf3+52Udbge
         yj3hJSJ61PldO392RmUWuOwmPQ78n14jKyGRYQUfmPCtxcAeEfDmVmXZocgROtPHwn5H
         SulA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9E+G22KHKlGDWQp3KdK88/1yk9vK9RRgl+CmndjBQpMdiT6MRbbFePetah11GA3Y2e44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodGzczq+cVLnwWB55/FRxoXtNCL2uNJrgcsjAj88MdEKtPYcH
	iXsy50bEiqtW7Ntj88UICi0litPcLN6MHhWMvS79tJDlsbkK6+Ubcd1J
X-Gm-Gg: AR+sD12IKVRACJaHKSoWgsoL/HOsu4Gs/StbQvaF0arXvOWgPjwAwUGymz0j7otW3xa
	ygzV02R0jNFzX3VnDx00w877mX5Q2s7nvWEfM5tTu/20Fc2ZDIMsV9OYqOCaUXcPuNg48X1LoWu
	of13f5K0E9f6haoj2bHKXBqYCbWyk8M7zcV0mAkcygwDWQ/wdASeQs3Qzr36gARFZatWqNaZTVI
	ZUnKLyjLcas4HXISuMMVxF597t9IkqF551hlKAIKouPGAB3aYFrQxUJLka2H1E9B5c/QzFpM2Rn
	xRFoPLs6QYWr/KLZPWyAT88WOrL80xXdoiLyXUssp/Nlk/Lp7zx/HM/NjP8c69PVEraKJyhwaav
	EGDitF/xeim7yYBsNf4W8pzp76C/tiTEPDeEVk+46ql3W2Yucngkx6Y22uxza6tZfSn1LY58NXN
	ushbYapupazRrSK1fOuPjoNcftJCub
X-Received: by 2002:a17:907:9625:b0:c16:101d:7afe with SMTP id a640c23a62f3a-c16b46d34f2mr830437866b.23.1784672478307;
        Tue, 21 Jul 2026 15:21:18 -0700 (PDT)
Received: from localhost (94-21-29-149.pool.digikabel.hu. [94.21.29.149])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af45ecsm21879266b.28.2026.07.21.15.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:21:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:21:14 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>, git@vger.kernel.org,
	Thiago Perrotta <tbperrotta@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Yury Norov <ynorov@nvidia.com>, linux-kernel@vger.kernel.org,
	Codex <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
Message-ID: <al/w2qgBfhe9qMg6@szeder.dev>
References: <20260719134447.381835-1-yury.norov@gmail.com>
 <CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
 <xmqqcxwgz2u3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcxwgz2u3.fsf@gitster.g>

On Tue, Jul 21, 2026 at 10:09:56AM -0700, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
> > On Sun, Jul 19, 2026 at 9:45 AM Yury Norov (NVIDIA)
> > <yury.norov@gmail.com> wrote:
> >>
> >> From: Yury Norov <ynorov@nvidia.com>
> >>
> >> git send-email accepts either revisions or paths to patch files, but its
> >> Bash completion only offers revisions. This prevents patch files from
> >> being completed. It can also make a prefix such as "0" expand to an
> >> unrelated hexadecimal ref even when matching 0001-*.patch files exist.
> >>
> >> In my Linux tree, an attempt to autocomplete the standard-named patch
> >> brings a random hashtag:
> >
> > It is unusual to call this a "hashtag." Perhaps "hash" or "object
> > name" (or id) based on the glossary and datamodel docs?
> 
> Very good point, but I am not sure if the author truly meant object
> names here.  The reproduction test uses a long hexadecimal string,
> but that is not an object name; it is an unusual-looking tag name.
> It is like naming a topic branch '012345' and complaining that:
> 
>     $ git send-email 0<TAB>
> 
> completes the input to the branch name while ignoring the
> 0001-changes.patch file.
> 
> When you have a branch named '0-tolerance-policy' and:
> 
>     $ git send-email 0<TAB>
> 
> completes to that branch name, you would not dream of complaining
> about the completion.  IOW, I think the complaint is somewhat unfair
> to begin with.
> 
> Actually, I do not know if the completion script really expands an
> abbreviated object name to a full one.  I tried:
> 
>     $ git rev-parse seen^2
>     179eccf0d01729c19a3238905b951b1880aa4ba1
>     $ git checkout master
>     $ . contrib/completion/git-completion.bash
>     $ git send-email 17<TAB>
> 
> and waited for some time, but it did not complete to anything.

We definietely don't do that.  I'm not sure what the use-case would be
for completing full object names, but considering how many objects a
repo might contain, I doubt it can be usable for anything.

> In any case, when both a '0001-my-changes.patch' file and a
> '0-tolerance-policy' branch exist in your repository and current
> working directory, running:
> 
>     $ git send-email 0<TAB>
> 
> should offer both as candidates, I thihk.  Since I only ever pass
> filenames to the command, I personally do not think it is a huge
> loss if the completion script stops looking at refs and sticks to
> filenames only, but others may have a use for that feature.

There are a couple of similar Git commands that accept both refs and
paths, "diff" and "log" being the obvious examples, and our completion
script doesn't list refs and paths for any of them, only refs [1].

I think that's intentional, because:

  - It's easier to pick the ref you want from a list containing only
    refs than from a list of refs and paths mixed together, because
    the list to choose from is shorter, and the unique prefix is
    likely shorter as well.
    The same goes for picking the path you want from a list containing
    only paths.

  - Even when our completion script only lists refs for a particular
    command, it's easy to trigger Bash's filename completion via one
    of the following methods:

      - git diff ./foo<TAB>  # No ref can start with "./".
      - git log foo<ALT-/>   # Bash/readline's keybinding to trigger
                             # filename completion.
      - git log -- foo<TAB>  # No --options or refs after the
                             # disambiguating doubledash.

    Although I'm not sure "git send-email" supports the disambiguating
    doubledash; its completion function surely doesn't.

  - There is no similarly easy way to trigger refs completion.

[1] There are a couple of (sub)commands, like "git worktree add" or
    "git bungle create", where our completion script lists either
    paths or refs (but never both) depending on what's already on the
    command line.  But both of these expect a single path followed by
    a single ref or any revision arguments, so we can unambigously
    figure out when to list paths and when to list refs.  With "diff",
    "log" and "send-email" this is not possible, because they accept
    any revision arguments followed by paths.

