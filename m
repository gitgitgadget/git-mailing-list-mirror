Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E61144D39
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063884; cv=none; b=ChPZZj33TXOh1dtdQoBsJNn8dBGdPW2SHwukyYeMkiwX/R+2tr5FO99vaLhs553HYKcuy6/fAzdHy6B43ehRIJu/fvlRL6x5/wTDhnTQM1g9CPBAD+Diqa5pi4EMEi8TrEb55vUwWJgr6/i6ZG8o2qJ+rbJ+uYbTP6tfLu4NWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063884; c=relaxed/simple;
	bh=A6Nc4oQIN1zbhseWYzUNWLAdVA2SBIQO/qZrvpQ4NsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl+os14BoOPaiFcW17qk7TH5h/Ty5d09BSE7Da1H36h6UEhBAk/s0NeE2svmm/hZMbMDY8ZF5DaI4ghXOK7/yLCMtICN0qWZGO7jJAlVP/DWhwNIvDMX8xoxCkYu9b9PGuQrvEhvbQutDXp/ntFZt/NmUqR6s6Hb9ghHyaHE2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fcpDpw6O; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fcpDpw6O"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 1448BDF8F72
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 22:43:45 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:ccf1:ff0:5d9a:763a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8B62E2003C6;
	Wed,  7 Aug 2024 22:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1723063416;
	bh=A6Nc4oQIN1zbhseWYzUNWLAdVA2SBIQO/qZrvpQ4NsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcpDpw6Oe+2qKaaKzYeL68jZDXmH417txAt2p3ePBADueoFVlVdLecaZo4QcrgXwT
	 7a8TgeFAnivdhgLGvcVJ0jkXE3z1pm5xF7QFBLbYABrK8xx0esk+ClB8B39HjNT0zQ
	 Rl+oIRTA17ct7yD+25joR3y0yhgP6GowUzVUoOzdEQGs52PWX6CLtKyf7p1MN4AZSh
	 YEQaijXbQHuEk4JSCG5Bq5iWQoKgmiicGhvrJphaYoEpSs/NTcM8EvCI0GnLMAo4aZ
	 wjIY+Q5IhSmo9LYV3mZh0fWB1saqFXcRct5RNbWun1hC8UJyxS6XB0tTbdv6sQMXMU
	 nEB7aJIxUa+xw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] formatting macro
Date: Wed, 07 Aug 2024 22:43:28 +0200
Message-ID: <4617471.LvFx2qVVIh@cayenne>
In-Reply-To: <xmqqcymn3qc8.fsf@gitster.g>
References:
 <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org> <xmqqcymn3qc8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 5 August 2024 18:08:07 CEST Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > I've a strong aversion to the formatting that this series applies,
> > because it introduces many (IMHO) unnecessary punctuation that
> > vandalizes the perfectly readable plain text. And this hunk now shows
> > where it goes too far. These lines under the new [synopsis] header just
> > aren't syopsis; they are comamnd output. The updated version abuses a
> > semantic token to achieve syntactic highlighting.
> >
> > To me this series looks too much like "we must adapt to the tool" when
> > the correct stance should be "the tool must adapt to us". If the tool
> > (one of asciidoc and asciidoctor, I presume) does not cooperate well
> > with out documents, then it is the tool that must be changed, not our
> > documents.
> >
> > I understand that some compromises are needed, but with this extent of
> > changes we give in to a sub-par tool too far.
> 
> Thanks for placing this into words a lot better than how I could
> have done.  I share the same feeling.
> 

I'm working on a form of macro that would work almost the same way as the 
synopsis paragraph. You would have some markup, but it would be surrounding 
the text to typeset: 

s:["--ignore-matching-lines=<regex>"]

In this snippet the macro part (which is recognized by a regex) is  s:[ ]
The inside part is managed the same. If you need additional markup, it is 
possible:

s:["<commit1>`...`<commit2>"] to have the three dots rendered as <code>, 
because they are part of the tokens.

Square brackets are possible inside the double-quotes:
s:["--ignore-submodules[=<when>]"]

Is this something that wouldn't repel you?

Best regards,

JN


