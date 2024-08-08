Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E018E77B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131503; cv=none; b=Z8i0c+U3OB7sgqzSfD35m2t5dLBYqIPENGzzR9Pvu5UjWTeYUMCe6M88MTHVOI0RFEYOQyoxZ4l0NN9DwJbl4jf78o6qptIbOeM0si8VxLIBk8897Tq93IqLAb3b/DRgc/UZUaI9YB/gQsaaPI/m/+esQRylr7ncLRYVyfLCtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131503; c=relaxed/simple;
	bh=c7/gEm49qclnFwl9o1h3ribyGRs5d7b+0Z6oczL46Gs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tve9QBHtNnTLtubRBsoOjt6WcOjOr/OWEDSRbmi20fUouH83lJSWMJcrqGQcq74ALbmZk9Ez9izf2rlKCmz+Z+9tItwId5ftUeA4eJ3eDjeGOHvoHs0h3aEfVEOtciMFgx/PlgzC7Q2JizwHs2Mjj+jaRAhfsGkuW9RMdSARmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 478FcF5M682683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 15:38:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>,
        <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>
References: <cover.1723054623.git.steadmon@google.com> <ZrSxLU-7rmlvdTHC@zx2c4.com> <9fbe5ca8bf133db8f614c0e90ac5fccb@manjaro.org>
In-Reply-To: <9fbe5ca8bf133db8f614c0e90ac5fccb@manjaro.org>
Subject: RE: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around libgit.a
Date: Thu, 8 Aug 2024 11:38:09 -0400
Organization: Nexbridge Inc.
Message-ID: <009101dae9a8$fc66bd20$f5343760$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAG+uwu9AllupQCzLbUtoA==
Content-Language: en-ca

On Thursday, August 8, 2024 9:59 AM, Dragan Simic wrote:
>On 2024-08-08 13:51, Jason A. Donenfeld wrote:
>> Cgit maintainer here...
>>
>> On Wed, Aug 07, 2024 at 11:21:25AM -0700, Josh Steadmon wrote:
>>> * bikeshedding on the name (yes, really). There is an active,
>>> unrelated
>>>   CGit project [4] that we only recently became aware of. We
>>> originally
>>>   took the name "cgit" because at $DAYJOB we sometimes refer to
>>> git.git
>>>   as "cgit" to distinguish it from jgit [5].
>>
>> Indeed, please find something else. Cgit is a real project, used by
>> many, such as git.kernel.org, and it'll turn into a real hassle for
>> both of us if there's ambiguity and confusion.
>
>Totally agreed, naming it cgit-rs makes pretty much no sense.
>
>> What about libgit-rs? Or even libgit3, where the rustness of it is
>> simply an implementation detail, so the name won't feel dated 15 =
years
>> from now when everything is written in Rust anyway and -rs is so =
2020s?
>
>Well, there are still very active commercial projects written in COBOL =
or Clipper, for
>example, so I wouldn't go as far as _everything_ being written in Rust =
at some point.

There are hundreds of millions of lines of code in the NonStop (TAL, =
COBOL, C, Java,
in that order) community that is actively maintained to this day, with =
no Rust
involvement (not for lack of trying to get Rust ported). Without these =
projects, most
of your credit and debit cards would probably not work. =F0=9F=98=89 =
Many of these repositories
are more than 500Mb, with a couple I have seen exceeding 2Gb (just for =
source code).

