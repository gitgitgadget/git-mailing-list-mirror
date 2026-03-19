Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE638F24D;
	Thu, 19 Mar 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936845; cv=none; b=qL1ZwBnEXDqxLtosUvQz5O8TmdMvqz8al4orwMWqpjl9RXajkOodFwZ2C4hphpY9ynT0V0CLG8sxDZAmPAEIA0gXMevvrxZB/M/D/C6hCm01ipFSa3Q9tnkH/zf2Honh9dDE1dDBGOa4gx7XtI+1eyakS2s2YcbHeC2XBChusmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936845; c=relaxed/simple;
	bh=EEXV3YNzl4BcH+aY5j9/5JXSb6R7/W/YpJAKbarV9kI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCqTekkSLWCra1FSgfbc2a2MxlwRwlrFRfxcua2t+IpADYhpynigeueotSA6uwoqbVmKMY4wcoJUeoo0/u8ojQA4Q9JRbezDmyA09uSNOOwJn9tIBpgnYTmxxOwTDUN41A5HOr45mFDHwbS3b7UKq/HU+sF1KWFjzoUWGbDYvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E05BDC22DB;
	Thu, 19 Mar 2026 16:14:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 1F6A220034;
	Thu, 19 Mar 2026 16:13:59 +0000 (UTC)
Message-ID: <b69406326eceb27f5973bc0ba55366438845a003.camel@perches.com>
Subject: Re: [PATCH 1/1] get_maintainer.pl: add --cc option to produce comma
 separated list of emails
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: git@vger.kernel.org
Date: Thu, 19 Mar 2026 09:13:58 -0700
In-Reply-To: <20260319160633.1149562-1-jim.cromie@gmail.com>
References: <20260319160633.1149562-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1F6A220034
X-Stat-Signature: cog69zxhtksyn97cb4h66y3fgao56yex
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+WNovE2qywIWI7/RgywqG0cb8a298gPsI=
X-HE-Tag: 1773936839-610495
X-HE-Meta: U2FsdGVkX1+LN4PhH3AcTdr9qpzfAxHENN++xO6Lb3PDG+PfQPYGdZM7QsSLtXzSpGi9gH9df4tQWssaE34UHN07bySKENxKYnN9rfgjDL3m9AyvnLCuRIJxwsOPjBZ4C0/H0tWp6l/sFhCUzehlmhVtksRTx7UZiE3Ido7FPCwaFsBGgX30t844GllQJkQWGmhV0OCpXGW2amI+6U3XKWAAHY4GPX6F+LLz/7HSzUuN1nmOgDWlP4wnH6AzTMxMjaLgaEh/3rYPB/WSDR8qdU484tseqAdudeyYUJu1I3YbHVEsO15TaIfM486CeQe1m9Ey2bR4D32UOfZyiMS+CmoXrUvviI+G

On Thu, 2026-03-19 at 10:06 -0600, Jim Cromie wrote:
> ```
> This new option works as follows:
>=20
>   git send-email --cc=3D$(scripts/get_maintainer.pl -cc 0*.patch) 0*.patc=
h
>=20
> A complementary patch has been sent to [git@vger.kernel.org](mailto:git@v=
ger.kernel.org), allowing:
>=20
>   git send-email --cc=3Dscripts/get_maintainer.pl 0*.patch

I think this is not particularly useful.
Just use a script.
