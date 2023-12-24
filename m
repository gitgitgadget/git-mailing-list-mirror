Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9423C3
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="j+oB1KWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703410219; x=1704015019; i=l.s.r@web.de;
	bh=DLClHvtFAH2KthkwTDvh/H6k6qyDSZoloHI85j4lnSk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=j+oB1KWpTUJ7bY6Tipy9M0nF0/BSkhW00n7CU/YbOuW/d02JkW3Wl8f6KkmdKEOk
	 b0fOYOvbWKkZaMW5qiqC2hyJ/frkmERN7s2pbvfljOErORH7UUUVaqN3TJPB00HYB
	 WFpcHEWvwV5kZmfVkhQsPpYESQ+18rsfTtfug6MhBUM+iSt9tM9kJbRu4SGZ29LIw
	 kktCmRxs4c72iY2SYcBOOLR72g536s1+Byt1EvRC4hzcKRGJCG20tnRUb7O3/xCU2
	 ome4UgajkRNk81wItJYTQ6DcxOjj6GfQJvh5YbiL+KrPRMg5uvota3LcH6XfHYFkh
	 T4WKcoDY+erxeHRCww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1rXlle3oZQ-00Isf0; Sun, 24
 Dec 2023 10:30:18 +0100
Message-ID: <290b20f6-ce3b-49b3-a61d-69277fd8c430@web.de>
Date: Sun, 24 Dec 2023 10:30:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1006: add tests for %(objectsize:disk)
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
 <20231221213034.GB1446091@coredump.intra.peff.net>
 <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>
 <20231223101853.GC2016274@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231223101853.GC2016274@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NxWzOgdqAlnJm9By3xz7Ik6jDba6PqC5bV0+K2Y4rnS5AA4Yxgw
 s5zrr/lLNSzoAQXQh4AIBagQl4ajatPH+c0PByI0ksQY/KKlyZAl9IOPY19cocCu/npDiAu
 DrduQvfYlI2X8e3z/dnbkZhUOIiBIbMLQh/IsO7qX6Von87z3sCe7FsionLVtz1YOGgjTdR
 bUp4ixODEmfkUT9IxiP7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NFn/chfSwzM=;Gog2Le28xnNesrKpza6iyHpF8sA
 N0Fmph3DwIIgyc9/PZhdgLFFJzhghwOw8o4qSKgOx9DkIUQx2tETkG3Z59YMLELXgp1t/ZSx/
 GGsvyjJS3EhOnNoPcLyt/KVs37Tf4j5bSTxYLYjNpr9xkgLUZUeHByMRHeHpYRpKhIprTDwfa
 QRmlLgZOejV8i9LP2dfgcdT/sgWSk8/kkFBMSMMBOnkrP3iCdeK3vyxcwANSoAFpsTZKLRYCt
 YlEFMvmuqjz5K+1bmbNS5oo5cHGAQLhiWTIkzW/nOIlPxwcftNYtMXGNgvsXtUOdhQ58omHA8
 U1JkYU47vh516xhBJsgWPRbagG/doeI1PCZG585+OiYmZFIuuEdcmf4n9HoLx2p5WOrlBfq/z
 hJbP68+DsnK4vBlLb3p0vh7A6HcPfxvcPySLwVqMmVS48ic2XvFZ/lj91uxoaChPayZii2sFt
 FZwXprCqHqHPOjdXjoYFGiPcas9EfO90HvKGkP84n0Wj8EE9Fuj8JQHK+OVMolum16px4OQzD
 0oJBdEmyYnLc6/tKNHjzAo/lhpXQBvoiirHTXCHWv0iKwe0mNqvVOy34qLcTO9wN43Q2FdWCB
 DhuYFfxo8yY2m8yAbyz/LE+ocTW2f3TNFpPQ2c5J+ZVvd95tyw37Xkag+ZRcDFwgiCL9dNdyl
 coHJM1Rk71zGKiYvdEBufvK1t1fNFDBT8rHMt3mXEiUq5u7xZZlRFIoV91ME2wn5QKwHn12zN
 KrQGpr0UoIxZdh48US1XznUUlNhhBBhcgb6ZT/Eqn3mwUgQzc09JL0trflL6IzR74QzydD1Qk
 IsSyZ4uKQPj+RZnTBJds9/OWdCl2o1qjBAOwR+Xf/JmxIe6r62F6pQXCv2TwsRIc4F5+sc+QB
 HPvxOsVWUIg+RcmKptjIHAH+PncvWKUpfU/KjZDHfzZw+D8fs6oHPMyxkohKbte/3Pw+1FSlU
 Xx4Hyg==

Am 23.12.23 um 11:18 schrieb Jeff King:
> On Fri, Dec 22, 2023 at 12:13:10AM +0100, Ren=C3=A9 Scharfe wrote:
>
>>>> Should we deduplicate here, like cat-file does (i.e. use "sort -u")?
>>>> Having the same object in multiple places for whatever reason would n=
ot
>>>> be a cause for reporting an error in this test, I would think.
>>>
>>> No, for the reasons I said in the commit message: if an object exists =
in
>>> multiple places the test is already potentially invalid, as Git does n=
ot
>>> promise which version it will use. So it might work racily, or it migh=
t
>>> work for now but be fragile. By not de-duplicating, we make sure the
>>> test's assumption holds.
>>
>> Oh, skipped that paragraph.  Still I don't see how a duplicate object
>> would necessarily invalidate t1006.  The comment for the test "cat-file
>> --batch-all-objects shows all objects" a few lines above indicates that
>> it's picky about the provenance of objects, but it uses a separate
>> repository.  I can't infer the same requirement for the root repo, but
>> we already established that I can't read.
>
> The cat-file documentation explicitly calls this situation out:
>
>   Note also that multiple copies of an object may be present in the
>   object database; in this case, it is undefined which copy=E2=80=99s si=
ze or
>   delta base will be reported.
>
> So if t1006 were to grow such a duplicate object, what will happen? If
> we de-dup in the new test, then we might end up mentioning the same copy
> (and the test passes), or we might not (and the test fails). But much
> worse, the results might be racy (depending on how cat-file happens to
> decide which one to use). By no de-duping, then the test will reliably
> fail and the author can decide how to handle it then.
>
> IOW it is about failing immediately and predictably rather than letting
> a future change to sneak a race or other accident-waiting-to-happen into
> t1006.
>
>> Anyway, if someone finds a use for git repack without -d or
>> git unpack-objects or whatever else causes duplicates in the root
>> repository of t1006 then they can try to reverse your ban with concrete
>> arguments.
>
> In the real world, the most common way to get a duplicate is to fetch or
> push into a repository, such that:
>
>   1. There are enough objects to retain the pack (100 by default)
>
>   2. There's a thin delta in the on-the-wire pack (i.e., a delta against
>      a base that the sender knows the receiver has, but which isn't
>      itself sent).
>
> Then "index-pack --fix-thin" will complete the on-disk pack by storing a
> copy of the base object in it. And now we have it in two packs (and if
> it's a delta or loose in the original, the size will be different).

I think I get it now.  The size possibly being different is crucial.
cat-file deduplicates based on object ID alone.  sort -u in t1006 would
deduplicate based on object ID and size, meaning that it would only
remove duplicates of the same size.  Emulating the deduplication of
cat-file is also possible, but would introduce the race you mentioned.

However, even removing only same-size duplicates is unreliable because
there is no guarantee that the same object has the same size in
different packs.  Adding a new object that is a better delta base would
change the size.

So, deduplicating based on object ID and size is sound for any
particular run, but sizes are not stable and thus we need to know if
the tests do something that adds duplicates of any size.

Ren=C3=A9
