Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067E1A316E
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857609; cv=none; b=f43keDqTk365JFuur+p45zXPS+5qLCHcr8AS9mqOnNQRDXI5+WdlaUJoxZ3HsWKmUXC4vlzNEdb3pc8ozCJVP5/q6cHA5ezC7QDAU0ZsXip4SGjab+rxWisZ4rsqQhP3FeJ1juSvpEZVPzNa2IIbBj94s8R3Dc8ubN941kpAIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857609; c=relaxed/simple;
	bh=9mrlScaleH+E5/9OElREbyMDf1Q662RMlltJrIirYho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su0fgyF5IkNdQXLi2nLxqWj8Omsml7h3hjx/m+r7fhti1/q88TrDNtIV4psQj8qrRhACkxyOejj9/zwo0C95MM+RzjtzpDSWLUfS2p7BY+Adm9YwBY7KKtlMQIZ2neb2RXcEPx+68pJqh9wHwCSkw9U6OgPxYJRm4oFVLtGVKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-184.bstnma.fios.verizon.net [173.48.114.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 567369NZ024848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Jul 2025 23:06:11 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 516472E00D5; Sun, 06 Jul 2025 23:06:09 -0400 (EDT)
Date: Sun, 6 Jul 2025 23:06:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
Message-ID: <20250707030609.GA13852@mit.edu>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <xmqqv7o4ajq1.fsf@gitster.g>
 <2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>

On Mon, Jul 07, 2025 at 07:27:48AM +0530, Ayush Chandekar wrote:
> >
> >Where is this reference to "Linux kernel" come from?  Shouldn't we
> >name our own project and adopt this new language for our own rules?
> >
> >And yes, total anonymity goes directly against provenance traceability,
> >so it is not a passive "unfortunately we cannot accept" with regret;
> >it is a lot more active and positive "we must not accept an
> >anonymous contributions."

Well, the SubmittingPatches originally came from the Linux Kernel, and
the policies and procedures that were adopted by the Linux Kernel
comes from a lot of hard won experience which the git project might
want to consider.  In addition, it was also informed with a lot of
advice and review of lawyers employed or contracted by the Linux
Foundation.  (The Developers of Certification Origin had quite a lot
of input for lawyers to make sure it would work in multiple legal
jourisdictions.)

So for example, it's not just about copyright concerns vis-a-vis
anonymous contributions.  It's also about OFAC Sanctions[1], since an
anonymous contributor might be someone working for a Sanctioned Entity
trying to bypass them.

[1] https://www.linuxfoundation.org/blog/navigating-global-regulations-and-open-source-us-ofac-sanctions

(And note, it's not just about the US Sanctions; there are very
similar, and in some cases, stricter sanctions promulgated by other
countries, including Japan, Switzerland, Australia, the United
Kingdom, the European Union --- and this is not a comprehesive list.
For better or for worse, the Russian Federation has managed to annoy
quite a large number of countries, and many of us either live in, or
work for companies domiciled in one of them.  If you work for a
company which is a member of te Linux Foundation, Mike Dolan or some
other LF lawyer should have reached out to your General Counsel; so
talk to your legal department.)

Cheers,

						- Ted
