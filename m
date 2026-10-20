Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522382;
	b=c2QtU2c5w3Y7IU/1PTbmFcTsb5fWvIMWkWPUJkndaX8/nSHYvqVr8Gyp0WutqNgkCASL
	 UKj5w10v/fBgSew06XChQ9snmlJa8nReJWauDtYC+dCn93eLzcExlCZybBvzug200WL1O
	 5y27TrCdq5av9SzWDPz0fw5KNLIpkb8RgG5+/kmbRvZu6WUh9CdM3+vfLejwnf7uT9U6J
	 bupyPtm1E3EY9Lxd6SkwhFOLzWG0w5AM6XqHrNawZ4sIZaVe9EC7W//os8qMKwoXlwgT7
	 9sUb1H9D55lBbLyNIqdNVHcBgJUZuJVFJM74QV5KuvJ3ufIe4jd4CV0r7SSsZkngWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522382;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=VXWOjOjtyGSHqfac3WUkD3gclmh9WlULWmXBNgI3Yxg=;
	b=b0Ui1t7iUq+LjrbLBjnX0NKVY+XlkzjOVLznuYMdS1MCKUAbeNENvEL7TWUcviWXHkql
	 J5x+0EimNS9/54V20nycMy9u2Aocpi7NHSJQp4e0zGLBQvKShpiwFbSa8+mAl0O4EtXU0
	 aVaGVhSAIzYeB1KpwllFmmEc+1MQ9GSRoeidNanp1TqsKs0OlCAU+Z9C8zbluKae6kxBo
	 4zYQwfsrPP/swQn+1mBWOZea4IGRiUjNSArfRYWhiWx/C4ZEZrjjOigPEaB0AhSzYksYK
	 +/41hlE2MUVxmJAa1ZtgJsV08Rcxc6mqKNXvD/lvyYKV94+UH9cDgO2rgZ5Ae9flx/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DST1WSmO;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB33606A31C;
	Tue, 20 Oct 2026 18:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DST1WSmO
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CC619A7D75;
	Tue, 20 Oct 2026 18:52:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 1CF1B20010;
	Tue, 20 Oct 2026 18:52:58 +0000 (UTC)
Date: Tue, 20 Oct 2026 14:52:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jonas Rebmann
 <kernel@schlaraffenlan.de>, "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?= (SUSE)"
 <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
Message-ID: <20261020145256.411985b3@gandalf.local.home>
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
X-Stat-Signature: k4o6ky89fxzi4y1biud1jdfyeqw6sxr6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1CF1B20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UJ//eROQyk78s3v59QzlNVuYdRXh9M2k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=VXWOjOjtyGSHqfac3WUkD3gclmh9WlULWmXBNgI3Yxg=; b=DST1WSmOjO0rpgbhRZKtM89lanYYNMecfSeTubbc5i/VEwunITWz68LSB5wY9DNE5Ew3Aohtr2J1Me9jbVHakRdHv7UDjVDqknl14pYJl4fq99tq0KhxxBq18hPAL0vo9Ab5aUGHzUYA5V95bX044Xvpa3IQhDC29sLQ7I01TpA=
X-HE-Tag: 1792522378-109630
X-HE-Meta: U2FsdGVkX1+jqi1LXBG5uOAtRl8ObGivKzMtMUNV+FQ98YsZKK/Mo/Jeadn3VGmekualh4w87j35WTHSbatxi9YINdnGyyxb/Nzjjv4srlhmQOdbPRVmfBUJkTbGov/IqS4Nbufo8ghSOHVlpoEjog/Mx1rG/JUYtU6IgecF8cjaukC1KSkVsJU7wBCcpIN/5Uq7aj8l1lGKqxw2X5TqsYuc19sZgk5Hb7Tkv3Oorh/4awfQj/C9ZvNr+dGTCvWUuvwoQkAPWGoxLqWK1Jywo/DXnGWrOAd/llntblBwi8lqPa4UI74NGqTmO0BOQFbhIsu4PpOeszleCjRa3vIYRYM0esCBo/Bs3COd4tujmJ3vwMRzWEXh/AAvW/aC0RSssXDmwMYU2jQ8Rf7qM5iauX7THBMLUX1OjMxSF7syCqq+kr0Vr2dxTJZKhK1WdqkOoxItXn+380c6yCINiufebXr8n9CLqF0U11Lg7B5DoEys3DLYtOCD+2ioMDnl1gfx0eUEBJ7/Cpo=

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

I could look into changing it. The code was written in 2010 so it could
perhaps be updated ;-)

Thanks,

-- Steve
