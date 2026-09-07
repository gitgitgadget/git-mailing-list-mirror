Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B9483BD5
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783176; cv=none; b=ZvB7Zd8wYQPqdzMtvxtkTuzcx9aOAS31Rum0LBCp3/AkrU9ZeFjSMHTCobSjFrnwkTonoLPqZ68jADQIC5tvwechFA42cJ8olXa0MpzRASMXj/fxAmYX9tUBJTrB/S0iGuBV7cXzLJWd6sbdYmsoLRxGyYdGJbAOYsQrmwidn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783176; c=relaxed/simple;
	bh=qJ+G1ydkZcAS1NmOcEWRoNAIs8zWj0zTKnY9PGR5f+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d25q8Ha0BMZeUuJE54UgLCGAlO0LX6urAdMoVroCWTAqjUMDW9XMDquUYW9Qwolt88Z8WOf172Ch8IRxfWq9ZaS9SUSIh2QdPOIVxZM05aVKWVxa2+Sro99SpLnf05Mbb8HMVVhsippIY2iD+B+NNHLqp/8ddBnVS9fFfOBdN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lZQmQ9OA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNYs7ROu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lZQmQ9OA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNYs7ROu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EB5781D000D2;
	Mon,  7 Sep 2026 08:12:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 08:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788783173; x=1788869573; bh=WJgBI1VqrI
	wPYpkohtmFlHuhL9S9aXLlSVndm4o5Ins=; b=lZQmQ9OApG2WJmz4p2qUusTluV
	o+1h4FpqebTOjEzALPudgDMHQVmxGUZ3tMUXS4WYc9AApitmoq0i8/SrCUNzgLK0
	rr82jJ8EbDXvhT5OTT/+XjRuqXMudaxxaZSLgnpO0dLZFJ537yfKep1a9/ms9lGb
	1sMKKLiZfo0Nop6zHClYq3XsQIjqxCIW6QEcGGChZkIHpI1p4EHlsxm6e2ISb19V
	HOoR590K7P6S9P2cLPx9RswP91JYS/YqkZd0nUTpq5ChkzJBRNZydcEJZTcRYHF+
	Lv1ADjHXZwRm9YoIFkLIlUhHSfp64z38x11kKMGymd8ZNQqZQ0ClHkYAtAZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788783173; x=1788869573; bh=WJgBI1VqrIwPYpkohtmFlHuhL9S9aXLlSVn
	dm4o5Ins=; b=aNYs7ROuEJyUd5pieWq+JqKDr7f1orlzL8harcV8dfl9ky9EEsG
	0R8s4714UjGIdLLlm4a7AhgYdZWd3raTsO5uiaBC3X7v7d7secNY539V1N8DsLPN
	fRUYKCfoji0dEaRAgXiQCLcn1GqcE4l4n4KHC7+8IjM7+Bp8gSwwznbdqyL/xMwx
	2lBzBXSjjVobFvbSBm8n0q5vD3QlJZBn4NnNlS/A92C0jbBfEPCSLYsL85Y6gJnI
	Z1vwlxYKND3zXY8NNS1dURUaM/zanMSXmG0ROBzhm9oUY2AfHQkr7RXr4TgpwHx5
	DPX5wSK6giIRRdVFLdtiNWC0w+6r2jsvVNA==
X-ME-Sender: <xms:Raqearu7dQa8XySuy4tGlYjM-Uavis_taJF_6IZy6rwtoAjTSn6Q6Q>
    <xme:Raqeaj7oAHNXjDfivWb8dJMVR-o3vayj6Zm8BOkfn7VkqcxCoZpH2NC68AxKxNkyL
    NH9IX-Qza8g9DiLbFIsxuXmY2tPPbwBZ0eoRN12FFNurp2En7PFcZ4>
X-ME-Received: <xmr:RaqeasKesNn_lJYrK-f0S9AN94ZOcPpFXZ2yv1AvYQkoDF7yFUR-cw>
X-ME-Proxy-Cause: dmFkZTEwnr5Y8AayyKwgwxdE7IVRuWsrw/U383jtlRhUEQpvlCp5i7ICWMRBiXusmZHnPF
    MVPtOXhESOe1kg3Cl33cTNOk3teBEqZ+z54Z9PeCDsUk8BVUiuIkfLJ8UlW89cjonmeqzB
    NAtUv9OLer2b3Oe92ax9K/i1V3yzFanpo2t6gO279qHK8RtJPCWpVY3c4B467ToRUmHQgF
    v3BP5WoAoTRU3Sm6J+wp8heyK3jYwi75wkENfJOM+9S2SSJIg+JDAV3xipt7mD+Be8qxB1
    5l6J30/BDPBPYSCYdxs5tgpCL8uWQXCn5syZ3rnrGV+Tz/9ftKpOdWWCrHsCJqEJWZH2mh
    eSmvYF1iRRpQBdRS4zRwJnOBsOjTwewhTiN0fr7m4f5MbA1MmP/84FV3It0BZBsl7GJ8aZ
    jZO8S/qNxTYmCAXYqKncuGV8h7Cq+YcRcU48W11TDKCngQR+ylOEngaDaumIGKct9l95Iu
    O76Aj1vCVLn6xLA4P/v/4RofidVcbEb0k3s1ZWUiCMh18pXcZmQPMQTLHwOAmmLjQi9S6K
    5ORq8NhLpoC7o08FJkYAHPbWOw9pV0qWxTTDDcmuPSGSxrcvryJOCiOD1XwqPlWv3EDYpl
    sDOvhq8fR6Hsav1SFHdtx5L9NBrpuUZkZ7MPbLdCsJyDPLPIlzY+vJC/R3ig
X-ME-Proxy: <xmx:Raqeaj5oeN69-hDPQuKRs19-Z0a2CfdxjBYWmTD3P6UPQ8UeavyK0Q>
    <xmx:RaqeavyRdS5t8dyBdaiqrAgv8nAcwUCOc4aAup1eHhOYVbf1Rk3S4w>
    <xmx:RaqeanYRGZCA5vu2481W1d5FE-JDkiA-jB5rOSdriDOewZ4RTtM5jQ>
    <xmx:RaqeahR997o75g4mImbfUgjc1QQ20xj2XdnkNjuyDfF8U64tmeXsWQ>
    <xmx:Raqeav4LTu1UxAWoN3jr8Q1YYx5IOZo4r-ndWOnS0y0lqGvlb2GCdM7W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 08:12:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f49080e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 12:12:51 +0000 (UTC)
Date: Mon, 7 Sep 2026 14:12:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: history: 'reword HEAD' surfaces a memory leak
Message-ID: <ap6qQPL7dPjZy1lO@pks.im>
References: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>
 <ap6cU2elXvmlLgb8@pks.im>
 <c12fe123-bf10-46f1-b369-b582a623ce19@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12fe123-bf10-46f1-b369-b582a623ce19@gmail.com>

On Mon, Sep 07, 2026 at 05:16:44PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:43, Patrick Steinhardt wrote:
> > 
> > This feels familiar, even though it doesn't reproduce on my machine. Do
> > you have "i18n.commitencoding" set? In any case, I think the following
> > patch should fix it:
> > 
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 000155ad9c..bca95b9d05 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -158,6 +158,7 @@ static int commit_tree_ext(struct repository *repo,
> >   	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
> >   out:
> > +	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
> >   	free_commit_extra_headers(original_extra_headers);
> >   	strbuf_release(&commit_message);
> >   	free(original_author);
> > 
> > I know that we've already been discussing this memory leak on the
> > mailing list at one point in time, and we've already had a patch similar
> > to the above. So why wasn't this merged...?
> > 
> 
> My bad, I suppose. There was a suggestion by Peff that the commit message
> was misleading. Per [2], the leak only happens when we get a commit that
> isn't cached in the commit slab. I was trying to identify the specific case
> in which we get a commit that's not cached in the slab but eventually got
> busy with other work. I will get around to it soon and send a long pending
> re-roll.
> 
> [[ References ]]
> 
> [2]:
> https://lore.kernel.org/git/94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com/

Awesome, thanks!

Patrick
