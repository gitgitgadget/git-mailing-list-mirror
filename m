Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524240;
	b=EQWgwA6USDWY6YStvvVl5IElcDsdDb1Fm3ZLVLBmLuwfgOfxh7NOHB3NdgxD5BQDdtPR
	 fZ6/QrZkh+vbMq/0HEBZLNTPAvL8++AzNGR86rinlWLWFUwvVvxAtdWUoUJ61LoZaPAuS
	 K1QDST98OH5LIHGWj6i1GEEjmXe3yNwnNxfRBlmpa9UJF0bWVcKr3QXgW+GAB9jnrHaX4
	 arJKBTQ23sU15RvP9+ZHPXmNLSh3bcW9KONxJQ6puwccqK2cxNLkyxv8M2TIl1LAkxNZv
	 85ZkaqI3J1B21dDu6ilS1VypUJvkZnljlix+bGjTlNvNp3KnFwC5h1Vfrgu38bUYmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524240;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=/tfBImnshU5NpP7d0QDXb5DGBXQWNObOq9TC0JcC5V4=;
	b=qxFUYx2h1AFI57RCYMQ8TgcCafVTyLa1VCNB5Y7QZ14wc2Dim6hQdU485ssk5ozbrgSD
	 SsxaBPyeOfaeKpAoLZ0xqKEJV3TnFpzsnr20pOuekMWyaPy3IbufFD1j46rwr7hk1R0WL
	 AUPF6L6kuNNo7XhLxrtbsMC10us8VuMUsKU7C12NM/hWX+2q+GQn15rZ4rAS6fGCDx2QV
	 NegTKwDZ8KwRk+70hnnSxlP3Pgsa+hG/vZsfOOZPAj6DjDqYQK8akQXbIjfSxJUDhCywK
	 vdrjm7NXkgwYkfqMkXGmqgN2UulLNtaU4QCsVJlwC7JnO0td9UmB+mO2c8lcc0ew/+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RFmuCuKk;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AE606A319;
	Tue, 20 Oct 2026 19:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2AE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RFmuCuKk
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5AC801A03AC;
	Tue, 20 Oct 2026 19:23:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id AD61F1B;
	Tue, 20 Oct 2026 19:23:55 +0000 (UTC)
Date: Tue, 20 Oct 2026 15:23:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jonas Rebmann
 <kernel@schlaraffenlan.de>, "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?= (SUSE)"
 <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
Message-ID: <20261020152354.165ad128@gandalf.local.home>
In-Reply-To: <xmqq8q3sw75e.fsf@gitster.g>
References: <20261020141011.0015d172@gandalf.local.home>
	<xmqq8q3sw75e.fsf@gitster.g>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AD61F1B
X-Stat-Signature: o3kmb5gptbjpqdjmyg9jgy4rpjnmx8se
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19vWj6JdH42Kv6IEwrq+O1A50WgADvckvw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/tfBImnshU5NpP7d0QDXb5DGBXQWNObOq9TC0JcC5V4=; b=RFmuCuKk5Y/bbdOniGXco2p8gqxKd0k/R9QgGiWITPpqdk54HQKmBZSiZXh+qymP2TDAqlR0lQ5rimYR7bF7z2nVaa/QQmjxWrbb1q1KTIHN8KQn6oW9yZKwGW1PZCFjAEj8J+5xSNvKeBb6fag71vi+fYcxbpVv+IDe2BznD2s=
X-HE-Tag: 1792524235-919834
X-HE-Meta: U2FsdGVkX1/wxXpb8npp62Mc9e7637Td92OcWwyy6p7Uc3EiJY5eBfR73cdqjYc1XIlub5V22opkvrr78dTLRc802r5YuAE02gXCRgsyVox2TqRAJy1JB6YLizx+ZklX5/F2Gr/T5vwyknYRzas8R1YCTN/hn/iZCnpXdaxQtz9F4I0OBbkADtnCQUSawsYaX2vytaxbiGI2ZBz052cCKVtvkgCbdMUI5ePc7bIXCNQd3KowM37OAizPZRxwz5PuhTFp+GOiLyrbCaCAIcKOLtHkyOrVK7YuTF3Gn9+N11wgtN72Wp6T7yKD5Ox59RIBHF3iQwYSvxdOk7dl3kvHtmyrLiMU6CvBw+AZQPp1ya711+UqV/DB6E07JZQLjRkpX8NfG1FjyCRRVjwXaX9KYiY6MbaA3D3o3rKDRiqPfLdgq0jT0etEnNqTl1AhjjgAliThsUS4/QXZbzFAR8lbII64NiKEFNo/0bep8LCwGgFpWIsarebmPR+KD1PfG1dhNhIj4uNMBvU=

On Tue, 20 Oct 2026 11:37:01 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Hi,
> >
> > I just want to let you folks know that ktest.pl (tools/testing/ktest/ in
> > the Linux kernel repository) parses the output of git to display the first
> > bad commit found in an automated git bisect.
> >
> > The output was recently updated via: 0c0f93e7fa64 ("bisect: print bisect
> > terms in single quotes") which made ktest.pl fail to find the bad commit.
> >
> > The change is being addressed:
> >
> >   https://lore.kernel.org/all/20261009-ktest-git-bisect-v1-1-1d1428f6cbf4@marliere.net/
> >
> > But I figured it would be good for you to know about this dependency.  
> 
> Shouldn't the script instead seeing "git show bisect/bad" instead?

Hmm, it also is used to see if the bisect finished or not. It looks at the
output of the last git bisect action and has:

    if ($output =~ m/^(Bisecting: .*\(roughly \d+ steps?\))\s+\[([[:xdigit:]]+)\]/) {
	doprint "$1 [$2]\n";
    } elsif ($output =~ m/^([[:xdigit:]]+) is the first bad commit/) {
	$bisect_bad_commit = $1;
	doprint "Found bad commit... $1\n";
	return 0;
    } else {
	# we already logged it, just print it now.
	print $output;
    }
    return 1;

Where returning 0 means the bad commit has been found.
Otherwise it keeps looping.

Is there a git command to know if the bad bisect has been found or not?

-- Steve
