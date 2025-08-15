Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FC244669
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264897; cv=none; b=jCmlKh3RvryFBUzoxNiIgJyLZbxlfxRUI1A1S+OTiFtT+2U/Td+b6AlwVB4rW3lczuW8jiujOVRiAvDPX3mHeWjhaC7ASyLRNfkLOY8UrCFXTAMFvKLvgGuJ/WXeiXbe2L3cTPxx7EFXPsJDNzcWmox69TIhdJP+t+76qIQLszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264897; c=relaxed/simple;
	bh=mr+pqolV7E8QLH+j2xQglYSZsoY14V33xu/GGlBVdZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNsoKE1/DDOx5GABfdhXvypZy1HTEwjbs1QZ0R8gkhndpX7KfsxZ7fh9C3lvoMUAd30hpilPVumn6YSWDijnQxkSrllTZouHZ610LzGz+0S1To1iPuysauXVf2t7SBTzoqXLA6LuzBqyz7JyDTMfZT7LBO/1EbPn5MU23l/lLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=qLDPzmMk; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="qLDPzmMk"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c7e9:a084:69b6:f082])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3CE6013F8A7;
	Fri, 15 Aug 2025 15:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755264887;
	bh=mr+pqolV7E8QLH+j2xQglYSZsoY14V33xu/GGlBVdZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLDPzmMkYQ7zZ/Ln6qksNDh59NnwUWaAMH1z9OoBcMVhTL+phGVv+iVAbt5I7qLOL
	 RFz+p9m2t/CdL7agTTIL2kaKFfGRQscmeqM0LpYS0Gwh6ShCrVmRJVv1/0MaqrMRlt
	 HMRaIUTVDvLEeusxeTjIQ2NKzKh0IJlZpncjdCqrfSFihympl7Ub33CpNO1vPqGqah
	 1V47eGyUHZhYmc23HAClz7VXKVWGmYgpX5IyeXDxGVLzlkXsqRMCOjYO2aak3KXK7k
	 CooiMIsfu53IofFQBiOMkFjk30hF/4KUFdhD2SQoRIQAgkRNwAm5K137HM1MQiYxMT
	 xO8mLgomrlEIQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/4] doc: git-add: start man page with an example
Date: Fri, 15 Aug 2025 15:34:41 +0200
Message-ID: <5004213.GXAFRqVoOG@cayenne>
In-Reply-To: <xmqqikipv2p6.fsf@gitster.g>
References:
 <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <d041d09589b51734a8cc257f80cdaf210c6676e7.1755127218.git.gitgitgadget@gmail.com>
 <xmqqikipv2p6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 15 August 2025 02:38:45 CEST Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > -git-add - Add file contents to the index
> > +git-add - Add new or changed files to the index
> 
> Does it add much value to say "new or changed" here?  The command can
> also be used to "stage" a removal of a path, e.g.
> 
>     $ rm tracked-file
>     $ git add -u
> 
> so if the updated text is an attempt to give more details on what
> kind of modifications are captured, it would be better to say "add
> new, removed, or modified files".
> 

The way I see it is that git add *captures* a part of the current state of the 
working tree (be it addition/removal of contents of files or subtrees of the 
working dir) for the next commit. A commit *is* a snapshot of the state of the 
project. The concept of snapshot is central to understanding the behavior of 
git and its internals.

> > +Add new or changed files to the index to prepare for a commit. The
> > +"index" (also known as "staging area") is where Git stores the changes
> > +that will be in the next commit.
> 
> I won't repeat myself about change-snapshot duality, but I do not
> think the new text is the best we can do.
> 
>     Update contents recorded in the index to prepare for the next
>     commit.  The index (also known as "staging area") is where Git
>     stores the contents that will be in the next commit.

Particularly, the "stores the changes that..." part is really not what the 
reader should remember.

> 
> > +By default, `git commit` only commits changes that you've added to the
> > +index.

I do not understand this addition. I may not be missing knowledge, but this 
behavior is not only "by default", it's the only behavior of git: commits are 
made with the content of the index. Let's not make it more complicated than it 
is already.

> > For example, if you've edited `file.c` and want to commit your
> 
> > +changes, you can run:
> Likewise.  "and want to record the resulting contents".
> 
> > ...
> > -Please see linkgit:git-commit[1] for alternative ways to add content to a
> > -commit.
> 
> In the original, this comment does look a bit out of place (as the
> text around there does not talk about `git commit`), but as you said
> that by default 'git commit' makes an as-is commit above, it may be
> a good idea to move this sentence there.  `git commit <pathspec>` is
> a handy thing to know even for beginners, and making your next commit
> is what the user is working towards by using "git add".




