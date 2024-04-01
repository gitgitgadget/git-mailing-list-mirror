Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042A4778C
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986649; cv=none; b=FDHLIn++XyonxgLfXCF/65ZHxpXnumx2cxFsQ1t79WE0bbFChtYvL34wBPaMEKnu2qJspoBDtuvbe0NQzlgLw+4IAYZdB2OASAhSj67orM8VzDHr8jJEccqHDzQrEkSZvrSKicN9MfwcC1eeCVa8UYelQHmWYIwIUTEJOojfK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986649; c=relaxed/simple;
	bh=pILgl6313JcSjxFQBzuifqmLmR9OGtP9+McP42RULv4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fE/uWjWWgENKkWCqSc/Euf7azSY+kiWwz5TK3l0BcgA2y1Me/ySr8iEzeyNwOb5UoQ9Md3DHVa0iSkBj7NX1MOqnAb9hEHFfUKrg2xz++Mxyn9EEKmc898tjHn7srbR/dYWUDJnfrsv07dtjn7OwmAJFrRzM2ZC2biNhuN2Rg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=afSIr4P7; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="afSIr4P7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zs3gHccCy547mU7dBYdF93LtjTVpdYBRLoI2mscgZcc=; b=afSIr4P7qEYw6I7Nb6f5H3j2Jj
	pT/iee5cfRrK9STSuZfLA8Lh6eHMs9C1srhq8P3TOid8PtzGfzWWevmamHIk50U6ZJj9laSiiYppu
	zppmi/HzfrSEAeNMazs20hlT6C+tebv1mcYyBAZZwF7MYo4XpS+mFpM3BOgenFbKPObtIzxHRrkUC
	/dxaq4nj/ELV8wDHM+HTB+em04suoJcWzQ5th/jpAqNj2l8J18GKCp3A066TBaBVqYFLftv3nt+Bt
	CKjL4zQDZiCO/2sWej2TtdP1r0N93sRJQXK5+V65WKgTGDhCtZ8wKGHrWajirsHXe/MXf1UJOmGwM
	zLoDintQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:60412 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rrJvd-00000009Imn-01cH;
	Mon, 01 Apr 2024 17:50:33 +0200
Date: Mon, 1 Apr 2024 16:50:32 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
cc: git@vger.kernel.org, 
    "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <20240401023225.GA2639800@coredump.intra.peff.net>
Message-ID: <c13c0751-0758-e068-282e-eb43496213b8@softwolves.pp.se>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se> <xmqqh6gni1ur.fsf@gitster.g> <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se> <xmqq7chif1pu.fsf@gitster.g> <20240401023225.GA2639800@coredump.intra.peff.net>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Junio C Hamano:

> Yup, that is semi-understandable, but especially given that it is 
> one of the options used by the original "diff-tree"'s invocation, 
> and that we are trying to replace it with "show" from the same 
> family of commands, it is a bit of disappointment.

Indeed. I will make the necessary adjustments.

> FYI, attached is a comparison between the diff-tree output and 
> output from show with my choice of options for "show" picked from 
> the top of my head.

I am trying to run some comparisons, but I'm not entirely certain what 
the parameters are that were passed to "ls-tree", as it doesn't 
actually run it through a command line. I tried the v1.0.0^0 and are 
seeing discrepancies in the line count. I need to check if it is my 
configuration that causes it, or something else:

   $ git diff-tree --pretty --stat --summary --cc v1.0.0^0 | grep clone-pack.c
    clone-pack.c                                     | 153 ++----------------
   $ git show --stat --summary --no-abbrev-commit v1.0.0^0 | grep clone-pack.c
    clone-pack.c                                     | 151 ++----------------

(these are the options I've currently landed on)

> I do not think I personally like the --stat output applied to a 
> merge (--stat and --summary do not work N-way like --cc does for 
> patch text), but I think these options are the closest parallel to 
> what we have been giving to "diff-tree".

I don't really have a preference here. I usually only look at when 
something changed (which is why I initially targetted the date format; 
in Sweden the YYYY-MM-DD date format is the most prevalent) and the 
commit message (for bug tracker and code-review references and so on), 
less so the actual diff details (those I can look into later).

> $ git show -s --stat --summary --first-parent v1.0.0^0

Hmm, the git show manual page doesn't document supporting 
"--first-parent".

Jeff King:

> I guess that commit is what brought me into the cc. I have not been 
> following this topic too closely, but generally I'm in favor of 
> using "git show". I even suggested it back then, but I think 
> Christian preferred not using an external process if we could avoid 
> it.

I saw the code that tried to avoid calling one. I don't know the 
internals well enough here to figure out if we can do without, even 
when using git show?



That made me realize, if "git show" runs things through a pager, 
wouldn't it then lose the "%s is the first %s commit\n" message 
printed by bisect_next_all() before calling the function to show the 
contents?

Is that fixable?

> The thread from 2019 is here:
>
>  http://lore.kernel.org/git/20190222061949.GA9875@sigill.intra.peff.net
>
> which links to the earlier discussion about "git show":
>
>  https://lore.kernel.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/

These two seems to also get it to honor settings (one to not colorize 
output, for instance). So this would be a step further.

> I do think keeping --summary is important; it's the only place we show
> mode changes, for example.

Yes, will fix that. I hadn't realized I lost that, since it wasn't 
something I have been using myself.

>  - "--no-patch" is doing nothing (passing --stat is enough to suppress
>    the default behavior of showing the patch).

Indeed. And it also negates "--summary", so I have dropped that.

>  - "--pretty=medium" is redundant at best (it's the default),

Dropped.

>  - I'm not sure what the intent is in adding --no-abbrev-commit. It is
>    already the default not to abbreviate it in the "commit <oid>" line,
>    and if the user has set log.abbrevcommit, shouldn't we respect that?

I think I added it because the diff-tree command did something 
similar. I can drop that as well ("bisect" displays the full commit 
hash anyway). I guess it mostly is for merges where we show the parent 
hashes?

-- 
\\// Peter - http://www.softwolves.pp.se/
