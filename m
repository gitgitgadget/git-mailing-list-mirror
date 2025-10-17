Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5A2DA774
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694789; cv=none; b=GaG2LMODOEx40pEF46jQi+LqaSPT1l+0fLEWPGV3Tx6dWIZOCmKp8G7sbDbDnj3ubZozjUIVUJwo+OyW5gCmd4kW+Kb+aZhe7V1nB8/54c9hn7LiRtl6F6ONmyHDCUmSykK+GYqOeI/qfDbPBBejfnipwJYFVpFjcuksMpdyFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694789; c=relaxed/simple;
	bh=0/MUiHXdyl65AHa9aeJunZ+c5QWyy+rnyxQgJvtZOaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUKNIVYq+YT8HGOr8ZXTT1KEiOxxjyfxH9usPjCqGLLW6z2Dqg62L7iF+DvA7snyiUkwLuriBqHGl6Ic+YrQVMSFEL5/bi4+vwV4xneAcQiwW9Y77IF/SId+OfINBcmpcx3SOSLWA8pYBVBEVCZtUTNxZ7rra/ugs8YmLzMnpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=bI4c0P1H; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=wmLatOO9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="bI4c0P1H";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="wmLatOO9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=0/MUiHXdyl65A
	Ha9aeJunZ+c5QWyy+rnyxQgJvtZOaY=; h=in-reply-to:references:subject:cc:
	to:from:date; d=hacktheplanet.fi; b=bI4c0P1HVRDMiWPuKtjIf08XcAnIIM86vZ
	R3m4x0UmjYdE6OJx+aO/7Lv4hairolHH34E+/x3j6r7heITH82FdeBX2Y2pNzFxjRd4OeT
	WF+fwUxYMNPR1b4/0H5NDCepOxc891G+VQNwCcKDNhj0L6bo2FSDxcw7dkpueJEW5JhhuG
	bSKEhlSS/nD/wiWehi5sYnSJT/ap+CEzuuleEp5MW4zTe96eE+a5Or96Bz0yYOey09y5ss
	C7W+SLLeCrDmaYwVMfbG+qqKWT97YzOo5Se4e6cS7I2mCV7V7FB+WaFUMjx19pW0F5pfy+
	g4XIrbLJb8Gf8JOZxmV1gp2CecPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1760694780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjbHILuI9MrGURY0quuKwuTxC/mRJDAWUrMdyCsvb/s=;
	b=wmLatOO9u5nrmBgoQbwCbuKSf3m0uSFtbFcvz/tvoaCfFmyd3XOCwUSuZTQ5EEsHbdUI8+
	shR40DFcHG+TwD/RQTrvWRzL+ZTN4AsN+JZ3TIyq3GHkh1i9CiiWLV2jgBTmXEX6PiXpIb
	03Gu9alVMGYOGDpLsou8j9YAi+1WDKAal37n1ADtOZpm72Dt7jM6EA12zeUgtKuFTyukAI
	t5WPBvqlHih6SUfhpO1k4s0FzvhvTIJxCZ0bqq2YMV3dic8HMoGCQEEM9XYHrT9ddsegOn
	X+kbqExpC2Q5SYlx2QsRLl74JkPPqHJOSbfKQIM1GEJ3MwkGLKWLWtu8/RaPPw==
Date: Fri, 17 Oct 2025 18:52:49 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Jeff King <peff@peff.net>
Cc: Collin Funk <collin.funk1@gmail.com>, Xi Ruoyao <xry111@xry111.site>,
	git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <aPIR8fB4w5Jkeiq2@mail.hacktheplanet.fi>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
 <20251017070912.GA4068463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017070912.GA4068463@coredump.intra.peff.net>
X-Migadu-Flow: FLOW_OUT

Hi Jeff,

On Fri, Oct 17 2025 03:09:12 -0400, Jeff King wrote:
> But looking at this test, there's something even more funky going on.
> Our $HOME will always have a space in it, because no matter where you
> set the root, we will create "trash directory.t7582..." to work in. But
> AFAICT, ssh-agent does not quote the path in its output. So for example:
> 
>   d='/tmp/has spaces'
>   mkdir "$d"
>   HOME=$d ssh-agent
> 
> will produce:
> 
>   SSH_AUTH_SOCK=/tmp/has spaces/.ssh/agent/s.IcPuGe26YY.agent.6PtD3uhM4O; export SSH_AUTH_SOCK;
> 
> which is nonsense to eval. And indeed, the "working" version of this
> test (without a really long root path) produces:
> 
>   ./t7528-signed-commit-ssh.sh: 1: eval: directory.t7528-signed-commit-ssh/.ssh/agent/s.IcPuGe26YY.agent.sOzoazWiDc: not found
> 
> I expected that would cause ssh-add to fail, since our SSH_AUTH_SOCK
> would point to truncated garbage, and we can't talk to the agent. But it
> doesn't even do that. The extra space turns that line from a variable
> assignment into a one-shot variable attached to a command that fails to
> run. And so we're left with the original SSH_AUTH_SOCK from the
> environment, the one in my real $HOME outside of the trash directory.
> Yikes!
> 
> If I unset SSH_AUTH_SOCK in my environment, then the test consistently
> fails. But I'm somewhat amazed that nobody has complained about this
> before. Surely somebody somewhere (especially CI!) is running t7528
> without SSH_AUTH_SOCK set in the environment. Which makes wonder if I'm
> missing something.

I believe the issue surfaced only now because prior to OpenSSH 10.1,
ssh-agent would put its socket in /tmp by default, not under $HOME. See
https://www.openssh.com/txt/release-10.1

We saw this failure in CI on Alpine Linux and worked around by adding -T
to the ssh-agent invocation in this test, but I suppose that won't work
for earlier releases of OpenSSH.
https://gitlab.alpinelinux.org/alpine/aports/-/commit/81a159c8a371c871c1cd0f212881a757160632fb

-- 
Lauri Tirkkonen | lotheac @ IRCnet
