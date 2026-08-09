Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745A34CFC2
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260426; cv=none; b=FmvIocMofEiFi+xw30c531329b/KknDB4u4jwhsnLWO/YSPJTV+5RQpsLWefLC0TurJc8Jr1+ie7v6ZjGW8PC1w7tcw2h1I824NcTBl1JehYhUwGSRBzf1wct2LGdb4SSli46/VOnXl6PkZhNSxBf0RdSAzgCtNNePTokIkCwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260426; c=relaxed/simple;
	bh=vWmF+bARWMYpEBqLi/eMjNZyOuOPLNiS9E0P6F9TFTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fubY1cfUPIOt1jfFLKHTbJlng+JqfBkU4FXEuDe5VBPZvsCgAlIo1QnDDYxkcqFBaNtc+Aac0zAx1EyRpx2MlrOLCOlUutXEZsM+YCHzhVhTL+vivUW4syujILuifzv/tN7ru374APlX/2qnzmFXv/amAUXaYxdHmDFegeY8uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hHqFx6gfrzRnlL;
	Sun,  9 Aug 2026 09:27:01 +0200 (CEST)
Message-ID: <cf2a38fe-bd22-46fb-bb1d-f994c50f0a0b@kdbg.org>
Date: Sun, 9 Aug 2026 09:27:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
 <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
 <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org>
 <433a3e74-c66e-40a3-9971-c8cb9692967d@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <433a3e74-c66e-40a3-9971-c8cb9692967d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 08.08.26 um 16:55 schrieb Mark Levedahl:
> The UI
> already shows "new version" and "old version", so using new lines and old lines is consistent.

Exactly my reasoning as well!

> But, one thing missing, hinted at by your suggestion "Background of ..." is that the clear
> definition of what is being affected is poorly expressed. A complete description of each
> item would require a paragraph, probably with an example image. Trying to compress into a
> few words will always exploit context and presume some common language we expect a
> git/gitk user to understand or be able to learn in context.
> 
> Maybe some extra words and categorization would help. Consider using a longer category
> description to provide common information, for instance:
> 
>   -General Canvas Area
>                            Background
>        Marked Lines Background
>                               Main Text
>                         Selected Text
>                               Link Text
>     -Commit Differences
>                           old line text
>                         new line text
>              -old line background
>        etc.
> 
> etc, where the lines beginning with "-" are just separators and do not have an associated
> color selection button.
I am not happy with additional section titles, because they take away
vertical space. Actually, I think I'll *omit* "Diff" from the labels,
because all colors apply to the primary panel of the entire UI, which is
the diff text. Of course, the top ones listed above apply *also* to the
other panels, but let's think about that another time.

My take-aways from your proposal are:

- The entries should be rearranged. In particular, selection, marked
lines and link text must move above the diff colors.

- "old line text" and "old line background" are acceptable English
phrases. (Note: singular "line", not plural "lines".)

-- Hannes

