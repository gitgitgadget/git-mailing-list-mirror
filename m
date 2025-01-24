Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521723A0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733161; cv=pass; b=ZMzfI1Ky3MfAicBh//cbOafKYFWwkTx9kBrve9ubVyhrXpcH7xyK9YApk9o6hGV5vKYed+17Xnd1Pv6GsepfNob6uhIl9JnarSkUT/gw3VrtJc4pd0/X4HA56guglMNRBCnwHxEVUCYwl2xabAoRWM+/mcfsTBWWO8z9azNvYk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733161; c=relaxed/simple;
	bh=t9MOZSUD4GDE0VVvlRxhI1SWJPHXtYrvtuJgh2stGXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVjOT+t4K7uxsRNxI9EXUCyvHm1ZdyGQ+xM9FxFdsk3ws/+id1qtdhpP+gTNoUb+5+qTXQKEaQvMZBQEMBUe9YEzK/eaweFPwWM91QVzlxTQs6fbIa4c5SLhKjCVggKT3P+07R0KbaaV+Jdy8XIxYWvPAXhq/k4MC8goKeQnFU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=druckdev.xyz; spf=none smtp.mailfrom=druckdev.xyz; dkim=pass (2048-bit key) header.d=druckdev.xyz header.i=@druckdev.xyz header.b=o1o4TvSe; dkim=permerror (0-bit key) header.d=druckdev.xyz header.i=@druckdev.xyz header.b=YHE3kZl0; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=druckdev.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=druckdev.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=druckdev.xyz header.i=@druckdev.xyz header.b="o1o4TvSe";
	dkim=permerror (0-bit key) header.d=druckdev.xyz header.i=@druckdev.xyz header.b="YHE3kZl0"
ARC-Seal: i=1; a=rsa-sha256; t=1737733151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e8rMeXX6KVf+TbRuIdLYluOUlZJdOCH+GoLNqb/dAEsPutYTbDD+8vjmtEH6FVgJHc
    GiSQzIqcP45ypXiYFt+J3DN3M6hYV6b085t7d7yP079FsTbNr4/AUz8XdM6Jg+POruU+
    jtCqe/Lh8T17UMXmzgksu9+vZpHvtI/ff9cmVlmwaRzudQkTn+/rs9aR+qexjwFOZlwT
    1l/i8BGCcY/om1fKl9+naoHg6H0oLrSI5cTAYftd+VLNSocZI7O1egG1Am+D+6ljnbBy
    DKLQ90ltHHexqznRGpjJRi7i7ayRD/NSe5v/eB9hG4f7A66RphjfVmNKalz40BR/RrLC
    0yDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737733151;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nPFlVTO05Gt1QUyMoq4QK2OmEdve8mL0nBmcqjZj/zY=;
    b=H4Fu1oS9GbtDiVzrkeHokHZRM80/sY4au/uOudPa09Cv894w8QFbykmZagfR6yt0sw
    xj9wrb/h2+Zfhw2yqkEyXE5gdLz78+b7iUPPR15+A+/b0ddWSgaItuxZtR+k837TJwwT
    gvHUIpNVaQNB656YjYWhVtsrXuczutcN2Apo+kumHu28t4cMA06S/Q+Wq0KUjFM/iAlu
    lasvzMMjhaBHotFLUCshIXWRLxgP7wL33tu6UvjY/eNronWWASHLFLjDvM3ZIOUM5R6W
    UUmJ+x3uIdXH9vwLtFWYaEmkqVImi8l7EIv5liWatrFeC3hwbJp7s8UQ50zn1cYz+w5b
    nhHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737733151;
    s=strato-dkim-0002; d=druckdev.xyz;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nPFlVTO05Gt1QUyMoq4QK2OmEdve8mL0nBmcqjZj/zY=;
    b=o1o4TvSeckKm7kIpdWDzgAt7M8oRfW2Z6IBjjztcgWy4TF2/HsYq5I73olIFGE/S82
    R8jV8eBLSqbFYLPj4iz1ljbjbMm2w53d2GusseFqmWs0pHeSRU7tzETTJJkHXTro5WEu
    ubhIWf1ewgRF0qkcWX/QWlZJyYG0oLReiprcr4fyD7gbX5w6I+7w//OxR4slhLOg/Ief
    VY342jQTXFzSCE/l6BQeo/Dkax4B1LqijMkmY+Q4MP/Ls5Dh5FD2wvaHRLGnh5nCv0e6
    8/01GBWfObjOznEJ3g9752zRAeBjBu2Y6wntAMJAbj/XzI6JEFZWRXtuCHH5YNh7Y4gY
    NUVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737733151;
    s=strato-dkim-0003; d=druckdev.xyz;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nPFlVTO05Gt1QUyMoq4QK2OmEdve8mL0nBmcqjZj/zY=;
    b=YHE3kZl0+quvwV+AL/vuPVUzIb4UTTD7UwCV6OGHpEb3iriCJopgbNxYWmEcpAFNxh
    +rCOCM8qWN9B+3d3zdAg==
X-RZG-AUTH: ":JnkIfEGmW/seMrxmWVd+x7RM4PVX8ZiQ+hfSn8fqWajQd+FGXzHces4NmdTRo+jLqhwh"
Received: from localhost
    by smtp.strato.de (RZmta 51.2.21 DYNA|AUTH)
    with ESMTPSA id efbf3a10OFdBrTR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jan 2025 16:39:11 +0100 (CET)
Date: Fri, 24 Jan 2025 16:39:03 +0100
From: Julian Prein <julian@druckdev.xyz>
To: Julian Prein via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.txt: add trailer.* variables
Message-ID: <7igsgrrvt7rvh3p7xa5g7r67ksqpmkgbrbqdpwng42hcqyrvln@3eumorcj6my3>
References: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
Content-Transfer-Encoding: 7bit

On Thu, 2025-01-09 at 14:25 +0100, Julian Prein via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Julian Prein <julian@druckdev.xyz>
>
> The trailer.* configuration variables are currently only described in
> git-interpret-trailers(1) but affect git-commit and git-tag as well.
> Move that section into its own config/trailer.txt file and also include
> it in git-config(1).
>
> Signed-off-by: Julian Prein <julian@druckdev.xyz>
> ---
>     config.txt: add trailer.* variables
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1871%2Fdruckdev%2Ftrailer-config-vars-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1871/druckdev/trailer-config-vars-v1
> Pull-Request: https://github.com/git/git/pull/1871
>
>  Documentation/config.txt                 |   2 +
>  Documentation/config/trailer.txt         | 136 ++++++++++++++++++++++
>  Documentation/git-interpret-trailers.txt | 137 +----------------------
>  3 files changed, 140 insertions(+), 135 deletions(-)

Hello,

since it has been two weeks now in which this didn't get any feedback, I fear
that it might have been lost in the void and thus wanted to bump the thread and
kindly ask if someone could take a look at this.

I am also aware that a patch to the documentation is probably very low priority,
so please tell me for the future if I'm too impatient with this and should have
waited a bit longer.

Thanks,
Julian
