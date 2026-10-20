Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523453;
	b=YqDhRSm4hsO8outMx5TRe2jye0h/6fRnoN6usUkpSU8493MMlPt73HFAUSCbvMHLuuh0
	 kiOKVjEq7WiPd8v6VIK4I11yoloVFF8z23ragHdtsdZvnaP82z1I8D3TPVV3X2GM8qelP
	 Pz8BMQoH6dKGT+SflcXXoiuamoIpASL389MOmfRUUJvnmZSifgDTZT95JB9mjuWe4b9KH
	 raHp7/5BvK5YNhPHFzDqlwPD3kwXLI3r48cBSnnnsnpOyjwiy/CkAdzcRIBMUeesOCAct
	 9ESqjHSvxzauhj82ZYwdlCcaZGtzVrPADz9YKJjgfOWIdVJwRu3JSlyeX/rsyRTrFEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523453;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=83M27Sd+ayueoqSrg95jmjuzMGG8Nasfh4nrCae8prY=;
	b=c4YtAlmMzEzEH3Ogr/Xxw6PDXCfRAoRWS0Wc1h3hqlKAUWCEHfD5A0KQGoLaTPm1E5Kt
	 auXfaqB2M4L4IQitwVkRg6PZMbDjQPr0WQzQCAJWPffB/8OnGXoJoTZUXO62LKgsSAAcU
	 cXdq3m2zTI0jMspAl0U5ULWVQqP/tYdqdPpUmxe47IcGR3JcczwvIb5uLMvWDplXriEsF
	 XS52bQF4Y6ILlLVgy/d/oojOsjMMdJx7SampqCXkKqHVGPWrqsCKD2DIdSNIe3nmhD0Q1
	 6KRmcwKlNmiMfoRmYXx4e8QJJgWU1ETmeiMc1pTe+E+knDlODaKPsczXDsymeKKERFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=B4JlaJFQ;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F8606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=B4JlaJFQ
Received: from macsyma.thunk.org (pool-173-48-113-115.bstnma.fios.verizon.net [173.48.113.115])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 69KJAKto004233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 15:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1792523424; bh=83M27Sd+ayueoqSrg95jmjuzMGG8Nasfh4nrCae8prY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=B4JlaJFQb/ESjSC0Ko6IKpjWUhaay7R0oEdOudBEaEHK6yRtCCaLhWZAhy0jHYzz2
	 mt/qnsHSC2vlKW9R5+cEyV8qQdw/YZgCuwn46ck0Gdv7hEmtrEKRK4Gake3JhWWm3t
	 X0oDYsHWRbd1MuXRoDCZnKVsFSA97L/TCDFXfVLnX7mkbeoRxjSt/ONPRgW3pIQNAy
	 HFMHM1PdnUTlZk9CMwyLethCsyIS8LQ9bq6HuNeCX/ZotfqZTGxTB8JNkyUwOMveWf
	 TMcTejokt7vt8SKXv6W7MaevOgYopHd9SmA5O+fLpjxsxWyAZNQ1kEWoqCBexl9KJF
	 XjipZ0OlK5+1w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8D45121C4DBC; Tue, 20 Oct 2026 15:09:20 -0400 (EDT)
Date: Tue, 20 Oct 2026 15:09:20 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, git@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonas Rebmann <kernel@schlaraffenlan.de>,
        Ricardo =?utf-8?B?Qi4gTWFybGnDqHJlIChTVVNFKQ==?= <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
Message-ID: <ate61iEAj4HDIvzY@mit.edu>
References: <20261020141011.0015d172@gandalf.local.home>
 <xmqq8q3sw75e.fsf@gitster.g>
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
In-Reply-To: <xmqq8q3sw75e.fsf@gitster.g>

On Tue, Oct 20, 2026 at 11:37:01AM -0500, Junio C Hamano wrote:
> > The change is being addressed:
> >
> >   https://lore.kernel.org/all/20261009-ktest-git-bisect-v1-1-1d1428f6cbf4@marliere.net/
> >
> > But I figured it would be good for you to know about this dependency.
> 
> Shouldn't the script instead seeing "git show bisect/bad" instead?
>

I wonder if we should have something like a "git bisect --format=json"
option to facilitate programs that are running git bisect in some kind
of automation.  Steven's email caused me to check my test appliance[1]
but fortunately the only thing I depend on is whether the otuput of
"git bisect good/bad" has a string which contains "is the first bad
commit" or not.  If someone has a commit with the one-line summary
which contains that string, or if git ever changed the git bisect text
output, or someone tried to set LANG to Chinese or some such, hilarity
would ensue.   :-)

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/usr/local/lib/gce-server/util/git/git.go

A structured output that contained the result of the "git bisect
good|bad", and the first bad commit if it has been found, would be
certainly be a more reliable way for automated git bisection harneses
to rely upon.  It'd be great if that was something that was in git
3.0.

						- Ted
