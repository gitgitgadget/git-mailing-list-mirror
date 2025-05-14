Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2634C6D
	for <git@vger.kernel.org>; Wed, 14 May 2025 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257277; cv=none; b=W9sUjo9NtI/eDH8gsNrM5zHVbo1h7OAkDuhyVSztAAI5TY9eXbfoeC6qtGvmucC7X78l13UGWIEAFbUxLH3Rw/+0+RtGKTpR+kmx+gkKaDbkNZkvVyK6HA+GiHKRt/hlkoOag/yvh2fwloa6Yvv4ftJKoz8kApgluFdgpG1oKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257277; c=relaxed/simple;
	bh=hgoM/4PU2JTdtqaFBUwT8LhWQyehz4VZhR5+IPKu2G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMjy4nJTYm3oJ1L7YdN02yfpxuzCgM8bOPQ0jh992zoWZjUmiWu2g9j0RxAtYx+OFYcyVJbP1oK2/ypYuFMdq3X6FczMsEjKB/+NVblNHDp/m7z4CULy/SbwSBrWC0t+B7D3OltTC7evX1QfbFtocE3npqcdLs7+QBJHW7MiWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R7lRkRfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0ZSp/p2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7lRkRfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0ZSp/p2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E003925400E0;
	Wed, 14 May 2025 17:14:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 14 May 2025 17:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747257272; x=1747343672; bh=/qAUs83je0
	q8H6BC0ZS/mBxGPKKx78zisu1jYLPyvRA=; b=R7lRkRfrGsYH/bX24eg0IVYX+R
	E5RYw/YH281yNvQp4YYXz/Hes8UzPmavpl0xt8+BKV1pwTAf4YYuMQDomKeZ4pWF
	6KrUqkjwX84fsPUGIapkiR9PlPcv6KIRQsTJPabkXA4dwt1xrPYF+aLUciQLVXxy
	TPBnfQ8JhvzSaqUB3iUd2TH1K66dgQvV5J+cmF/MuxsOWseXJH7FHDyBww0g44G3
	sbJr+OJZEMY5qzh5GgQS4nWOop+4eFIvDrXbfVRBgcYE4oH7t8W1G3wVSIUJk/qt
	fUgjddjIigxS7xMSB52WmBypgBnS9JSgD+6SlMpNO8u6xJ+45U2iCzOWoTsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747257272; x=1747343672; bh=/qAUs83je0q8H6BC0ZS/mBxGPKKx78zisu1
	jYLPyvRA=; b=j0ZSp/p2xzXsg7aTKvpKXpG29iLcXC7LZ6Mn5nmqPc86+j9YJi3
	6hAh/d77uky+WKBLWSq3CTed4e/RzylDbLU9GAoMTJpk3bBfba84u5YItwp37E3f
	jQea7WTlJX+axfzygovPEh0wXIoTk4nGHuXL6p8PPphLyX7f7z/w2WR61LSI7K98
	/dPp7GBs/jzIyufAtvLYhapUdm6/zXLf6L85fGCPEDsOhkxC/96EnAdfLQS3b8CH
	rs6ffudciJ9v4UjnrvGLCePYunp09vOV9zEvYLnyQrktpt6RMoIJb/290oXYknA0
	YMDXEwZpZsrooEgXht8A/NyFgUhjpxDV8Dw==
X-ME-Sender: <xms:uAclaKKweyjQEUf8kC39TilpXhn8gbd7vuaEbcnz2BKksxUwwo46cw>
    <xme:uAclaCLdqfawqiO-7lSPB75nudxY-xoAcSs2M3GW6Zq5FR0HhmXaALQWG0fGNklRa
    QQuM3HLumwt_RsB_Q>
X-ME-Received: <xmr:uAclaKsLuPF5jvQw_ejx2iKt1N-ol_Uhq9gNhT5ZFhmggiV3B1scuECRfiibSA1kMk7dnTWnvFFJIAEmBoB_EoeiePTNYgKuQzvFuUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhig
    rdguvgdprhgtphhtthhopehgrghrvghthhhfvghnnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uAclaPYFYJZsVj5L3Vbtm907j7EN1sIEys8ERutc0CnRroMDclp4Lw>
    <xmx:uAclaBZSSVvA1sISPfPlaQzFGAqxT9wRDibLj3TdeCkAF5xdsIvwCg>
    <xmx:uAclaLBTJv859XuJqEbHkflghzJAyE3Cvp291FZq03NXuzKQfgbw1Q>
    <xmx:uAclaHZTX0sOe5MuCugm-PFcZ7uWNnmJ_-d8EwJKp-WRrxni0_Du-A>
    <xmx:uAclaGJqWLVTJpvIdtzyZ1DNWM7M6mIuwwRek-FGQD7fCW70zPiXWN93>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 17:14:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Gareth Fenn
 <garethfenn@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: do not end the commit message with an empty line
In-Reply-To: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org> (Johannes Sixt's
	message of "Wed, 14 May 2025 22:50:05 +0200")
References: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
Date: Wed, 14 May 2025 14:14:30 -0700
Message-ID: <xmqqv7q27v49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The commit message is processed to remove unnecessary empty lines.
> In particular, it is ensured that the text ends with at most one LF
> character. This one is always present, because the Tk text widget
> ensures that is present.
>
> However, we forgot that the processed text is written to the commit
> message file using 'puts', which also appends a LF character, so that
> the final commit message ends with two LF. Trim all trailing LF
> characters, and while we are here, use `string trim`, which lets us
> remove the leading LF in the same command.


The above reasoning look sensible.

As git-gui uses plumbing commit-tree to create the
commit object, it has to be more careful not to have extra blank
lines, as it cannot assume stripspace internal to "git commit"?


>
> Reported-by: Gareth Fenn <garethfenn@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  lib/commit.tcl | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index a570f9cdc6a4..f3c714e600ac 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -214,12 +214,10 @@ You must stage at least 1 file before you can commit.
>  	global comment_string
>  	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[^\n]*}]
>  	regsub -all $cmt_rx $msg {\1} msg
> -	# Strip leading empty lines
> -	regsub {^\n*} $msg {} msg
> +	# Strip leading and trailing empty lines
> +	set msg [string trim $msg \n]
>  	# Compress consecutive empty lines
>  	regsub -all {\n{3,}} $msg "\n\n" msg
> -	# Strip trailing empty line
> -	regsub {\n\n$} $msg "\n" msg
>  	if {$msg eq {}} {
>  		error_popup [mc "Please supply a commit message.
