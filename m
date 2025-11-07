Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5828725F
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504224; cv=none; b=JhkPMeZ6mkYjRo/Ouhiqc64rAwbfGN7sIHryO+Ap/5+rmDGrAt9DhqhcdTXU610Y9P3dEDZOZtU/OnW4rkEs+HNwpss+SBO07cL0jK6/Y287WDcyJ0RWzQdv5GnIVeBqlBUaj1W1K55/PcnYstA38E7xGWNzYODFotDEDywaR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504224; c=relaxed/simple;
	bh=yopozltK0FZxhwsLQu+f4PN06o+M+qXzeHJvirf0dJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxTnmj8a+yTU4yhUswOTMsmn15dMVHaw/hEt7kw5QUv2oYFtzR06+RxD2XIOZytZxAJ9manlCpky8pr6QwaLMpwtd88jqpUla21HNrJcAYgRgkJe8vYcnUYCkH4m/079crkRRy0KIflBaf4PvQ79B5dXrMiZYh4KbP3WXknSPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=thl5JAAk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="thl5JAAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762504216; x=1763109016; i=tboegi@web.de;
	bh=vB4KVMQKiB9U2BFwr/t/WMQcEYNLSGmJ63WjTU7pa0I=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=thl5JAAk7gUBUflzz8UbaUM4af++zNldbQk7pFKAtdGRKVqSkNRyWivPW9/Jds6V
	 zm0eXb0f5BfiyylZ0kJsyiMgJ7pWGxMnkGbMkplopK7SPAdmtiFrt8CG3XP6xu7dS
	 LQW1OAzSeaupDyUbPTxs6jQfu6G5h6Fy26fKz1BiFcpkoVhKo5udOB+BaA0iavjox
	 bAtlMSywRYQ+30NzeSIj1fdyK+6uhLC7VEQRMjUApbEAV/7p0FwktDIaet98nDmAM
	 ZIyz5sjrLKJcBAik35cZwerjtoO4Lbhqdl6dUF2KMciM/JfYmZnqAg9lQXXhZo8C1
	 QKpVRsbwO/nFYwZx8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk0k-1vg3kY20d8-00Ldfe; Fri, 07
 Nov 2025 09:30:16 +0100
Date: Fri, 7 Nov 2025 09:30:15 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Message-ID: <20251107083015.GA18670@tb-raspi4>
References: <20251104021455.379807-1-jltobler@gmail.com>
 <xmqqa512sfcj.fsf@gitster.g>
 <xmqqzf92quen.fsf@gitster.g>
 <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
 <xmqqtsz8nbwv.fsf@gitster.g>
 <z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:uwTENGoEMykMal16bEBH4PjSjcWDYJToAaQuoXAia2wUIVu0PB0
 GMq9ISMB/tMI/zVJJ5aI70qNOs75DNBL0EmEpKd3/a97yCoRU62Jdf5LVH1h9aYKosKBnVE
 oycIZUYIxLREmFzsi+r/FL9l2vCZMA08tG1txXT2mznCOE2WnFvuNLOnHK3wndFJ73X/z89
 dZ2+sr1XmMwskV8DLbgJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DpxIbPEhevk=;/jK4P7xB31sIn/+/i502aPi5ruo
 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
 bOGrQV7ONlhhjVoT1S+wGd0Fas=
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 03:42:49PM -0600, Justin Tobler wrote:
> On 25/11/05 12:04AM, Junio C Hamano wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> >=20
[snip]
> Currently the output in the next version will look like:
>=20
>   :100644 100644 a1961526 e231acb1 binary=3Dyy M	foo
>   :100644 100644 31eedd5c 402a70d7 binary=3Dnn M	bar
>

I think that is a good solutution ;-)
When I once developped the
git ls-files --eol option someone (Junio ?) convinced my to
use a TAB as a seperator.
In this case just before the filename:

git ls-file --eol | xxd=20
00000000: 692f 6c66 2020 2020 772f 6c66 2020 2020  i/lf    w/lf   =20
00000010: 6174 7472 2f20 2020 2020 2020 2020 2020  attr/          =20
00000020: 2020 2020 2020 092e 6369 7272 7573 2e79        ..cirrus.y
                         ^^
00000030: 6d6c 0a                                   ml.

This makes the output both human readable and machine parsable:
All info is before the TAB here. (And may be parsed again in a second
round, if needed).
Thoughts ?
