Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616C198850
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924924; cv=none; b=LzyMzMJyUODPsK6XfbHvDesjkFYowvn3GuhNnDPrYHbmOfo/Vkbh93MosHJGE4dsRAYLMCu1pkF3rV/hQjUWTiSUltXmls53BXUKGEF8uM+Xb4HILeeAAJ1gpaOn0Y6YRc9jsjnCYHEokrrPNQ46IhcCOhKufFiUIhTEIy1qgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924924; c=relaxed/simple;
	bh=EEdp37nFXbvPwdgsKUrM3XgkNkdBDQi4wIMZuQdYN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV+COrCazl5Zg/B+GydSaWvaFmS21uzsbb6YV8fwN920wkZs50+WhVR3tDdASmlF1MNv1YY4HEJpUqxN6rck74Z5JGjElurkY+nKfPLCCLswNQjmifBgajHqntm2YspVoc9CLvkMt+I3jmnPndgztEDRyX6IOAwvLkYZZz1Q9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IHK4+zc6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IHK4+zc6"
Received: (qmail 22723 invoked by uid 109); 18 Nov 2024 10:15:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EEdp37nFXbvPwdgsKUrM3XgkNkdBDQi4wIMZuQdYN2U=; b=IHK4+zc6XKYYRnQUGeE1MRGZ/S8sgXZMc3iL6zXy4nIH8gm1k63VMgp0VJ8L2XG55PPre5wNA6i1kqYSvXJi4pwlU882s3nlpglplH6TjEqdfordtdmoK5V3xvAXPCYKYT9DsHeGdPr2bQnJb06DS1YnsB0nz4Fgauc3h8/+YQcnA16RcqOs0QArca96XCWJINubQwhQ47Rk+BEHFwc0ZvorbBi2DwYIT5uWNYSxLAAnpaUiBrIgRMF6nyHWA0Fq91f8hO39dIduC/Y/hJrVIT9ofQY1bb6aIb9IAaPyIScxhaL67HCRxc+wWZztOEZsIS8byyCkjBvO8NiSrQS+eQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 10:15:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18496 invoked by uid 111); 18 Nov 2024 10:15:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 05:15:26 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 05:15:21 -0500
From: Jeff King <peff@peff.net>
To: Ylarod <ylarod9@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] Apply patches failed without any changes
Message-ID: <20241118101521.GB3991628@coredump.intra.peff.net>
References: <CAGtHOOFutv6wHgoFnkZoETJwq6FDkbbBgGqzSXT9V7ESXQswCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGtHOOFutv6wHgoFnkZoETJwq6FDkbbBgGqzSXT9V7ESXQswCg@mail.gmail.com>

On Sun, Nov 17, 2024 at 08:40:06PM +0800, Ylarod wrote:

> ```
> Applying: Florida: string_frida_rpc
> Applying: Florida: frida_agent_so
> Applying: Florida: symbol_frida_agent_main
> .git/rebase-apply/patch:126: trailing whitespace.
> 
> error: patch failed: lib/agent/frida-agent.def:1
> error: lib/agent/frida-agent.def: patch does not apply
> error: patch failed: tests/labrats/agent.def:1
> error: tests/labrats/agent.def: patch does not apply
> Patch failed at 0003 Florida: symbol_frida_agent_main
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ```

Your .def files have CRLF line endings:

  $ git show --oneline 357374cfbbcb '*/frida-agent.def' | cat -A
  357374cf Florida: symbol_frida_agent_main$
  diff --git a/lib/agent/frida-agent.def b/lib/agent/frida-agent.def$
  index 7634e3fd..dc297d6f 100644$
  --- a/lib/agent/frida-agent.def$
  +++ b/lib/agent/frida-agent.def$
  @@ -1,2 +1,2 @@$
   EXPORTS^M$
  -^Ifrida_agent_main^M$
  +^Imain^M$

The email format created by format-patch puts the diff inline in a
text/plain email part. And since emails use CRLF as the line terminator,
they are stripped when it is read back in by git-am. So it tries to
apply the change above _without_ the extra CR, and we fail to find the
context.

You can use "git am --keep-cr" to retain the literal line endings on the
diff. This would work for the commands you showed above, but I suspect
would be a problem if you were actually sending the emails to somebody
else (since the mail transport would probably normalize everything to
CRLF).

To robustly send them you'd either have to:

  - send a binary patch. I don't think there's an easy way to ask for
    this for a particular format-patch invocation. You'd probably have
    to mark them with .gitattributes which would also suppress diffs,
    etc.

  - store the files in the repository with regular LF endings. If it's
    important that they have CRLF in the working tree, you can use
    attributes to convert them on checkout. See "End-of-line conversion"
    in "git help attributes".

-Peff
