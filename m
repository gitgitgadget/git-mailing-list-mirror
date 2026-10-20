Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536613;
	b=nfDjen40F+LY83uVXEzxUpArBFQ+JZmpsx30UVK7FRSJBSINYU+pDTI8ezVOYTyFgqkz
	 2r7VoqTS+ygRxCCwJnZDl+M035Mz1oThSxfskcQLzqrWSoi1B61Q8sforqvJIDZJBJvTC
	 hRH6HpXZIuW/dCQQPVGVxuRTg1qzo+e5cZZW+enAobCBNzIt/4bX2CvWgPRlQxK2LKT9b
	 7nY6Bg+HqFfo5nKmUr/umQKnZlbfYRDHqqaVXxt5fB5JqqsWggRTasT4LvAjW8L0fK++0
	 TJ6QFoebih27q7Y4YwsgCyMLJA5iNyc9JIyHV9EXlD9O6LeUsev6X1ShF+De3Yv7N7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oZiXrRKvQcXJbnmZKNbeBglyOf7giCIx7g21DfvxHeM=;
	b=hjZx6yQm3fNyxIWZSdyphpns9OEirfAH27cGrgrpikPWmOzc55sjXAXheaxzFZTQ5dTz
	 5C5nHoARaTBBpNZfZFrCoBS1dkAXt8vUQ+qmeDq2fCuWCwsFoxZm5Tc9nhGq1mlSNzAHr
	 RlLg6wSko4wQ9yyIkjzb3ljwA477pw2jDzxrT97bp9qn0diaVb+JmnqkCfHW4dz9RRMSI
	 XAPE0+Kq6/RXwBQaebhyB0oscWoh/nxgSaSE+GNTZXQ+gNE4j4u+DxE6FJ7jueTe8yhZg
	 +SbYIgRR5B7TKdR+L8fl0Ldp1lZnBxWRb9bjii/YEshGB4fZYKJIijLqmwtvkk3mh3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=KVDCNzG4;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43E606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B43E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=KVDCNzG4
Received: from macsyma.thunk.org (pool-173-48-113-115.bstnma.fios.verizon.net [173.48.113.115])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 69KMnbMs016711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 18:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1792536580; bh=oZiXrRKvQcXJbnmZKNbeBglyOf7giCIx7g21DfvxHeM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KVDCNzG4S3KuvOFjvzAKI2mVLHr+XqNSBP/1MyhAZyTHWdXKlM+d1ClZw2C2IJug8
	 HYBcBAuywcR7D/JgGFztfETkJ4ndtAyX6+OpzmG12NxJPtRUFs9IYEuj8kEiIooxCe
	 VVIQyU+KBG3XxP1fye9bt5PeZAVZaGWGkBFV+pd+opyQ9m3Pcky5qq1KBCwuAATnnW
	 +G1vcDGAjUU3OZFODM2ijPhuYv4iGLe+j2p0Ifkx8QxdmODAsSfx9T8XK++wSPgOuw
	 8gEyG7gWlLSvCRI7idTscavVdMALKTcRfQ+NcmOcuxIb8aycbXaKSW1mgZ5mICBlul
	 j4mmFiS/9Pc3A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0A5BE21C98B6; Tue, 20 Oct 2026 18:48:37 -0400 (EDT)
Date: Tue, 20 Oct 2026 18:48:36 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonas Rebmann <kernel@schlaraffenlan.de>,
        Ricardo =?utf-8?B?Qi4gTWFybGnDqHJlIChTVVNFKQ==?= <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
Message-ID: <atfmYYtUii4gWIIH@mit.edu>
References: <20261020141011.0015d172@gandalf.local.home>
 <xmqq8q3sw75e.fsf@gitster.g>
 <20261020152354.165ad128@gandalf.local.home>
 <83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>

On Tue, Oct 20, 2026 at 09:28:10PM -0500, Kristoffer Haugsbakk wrote:
> > Where returning 0 means the bad commit has been found.
> > Otherwise it keeps looping.
> 
> Is this different from git bisect run?

"git bisect run" isn't always the best way to manage a bisection.  For
example, I might run a command like:

   gce-xfstests ltm -c ext4/4k,ext4/1k  generic/245 --repo stable-gc.git \
       --bisect-good v6.18.57 --bisect-bad queue/6.18

This results in an RPC call to the Lightweight Test Manager (ltm),
which is a micro VM running in Google Compute Engine.  If there isn't
a Kernel Compile Service (kcs) VM already launched, the ltm VM will
launch a much larger build VM.  Once the kcs VM is ready, the bisect
request is then forwarded to the kcs VM.  The kcs VM will check out
relevant repo, run "git bisect start", and will do the build.  Once
the kernel is built, it then sends a RPC to the ltm VM, and the ltm VM
will launch one or more test VM's (in above example, one for the
ext4/4k config, and one of the ext4/1k config).  The ltm VM will
monitor the serial console of the systems under test, so if the kernel
hangs, the ltm VM can force reboot a failing VM and either continue
with the next text (if there is more than one test that is being run).
If we are doing a bisect, then the ltm VM will send a bisect update to
the kcs VM via an RPC.

This architecture allows multiple biseccts or test watches to be
managed by a single ltm VM and (if necessary the kcs VM --- the kcs VM
will shut itself down if it's not needed to save on cloud costs).

So yeah.  Sometimes "git bisect run" isn't really enough, and it would
be useful to have a way for programs to be able to call other "git
bisect" subcommands, and have a standardized way to get the results
from the command without having to just parse the output and be
dependant on the precise format of the human-readable output.

Cheers,

					- Ted

P.S.  For more information about how my test appliance works, and the
other features/functionality of the ltm VM, see [1] and [2].

[1] https://thunk.org/gce-xfstests
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

