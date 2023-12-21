Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E178E90
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MbTpECmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703200391; x=1703805191; i=l.s.r@web.de;
	bh=p9gshi1yI9s4PqSLqJwm96LmA89yDFPMfQDrcAFLJOw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MbTpECmzaYVhZ9+sZOhwJyl9Rt4Bz7Ti3+hmLQq+F72dNyYxYrDAJQgpyfDXyu67
	 ATFMl/m7kO+mtS2R2O2awnOr5zBoTMoxEJx4xRfy0cewRCoXtdMP9rHrzkAiHZzrn
	 jx1WyVKF6bRpbA/N+c81KKamTmRikkZbFzPSnKgXoXAvGglQ+PAyDUotgjtTRMnWg
	 GMrD2kGtb+8u9qYD6/s4e8gTY52TWZFyFiT0D73mxfUgYkUor2LLkzDbvWkXICVTs
	 nqjvAASgXAHHYwmp0Bq8sXoLViRNClS6bPgFWxeB4bwoJsjzmVnriOtEqm4OpiuFM
	 3JZxsxkJ2RCLREnWDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1qjsIX2WGw-00cMBL; Fri, 22
 Dec 2023 00:13:11 +0100
Message-ID: <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>
Date: Fri, 22 Dec 2023 00:13:10 +0100
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
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
 <20231221213034.GB1446091@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231221213034.GB1446091@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xtO1wtlUKi7yeoeucHGoNdxM3oc9kgqkp9umgH4ss+4KysyS/90
 tPZ3M4CW60dAsXYaPAbVtlPrswBbiwmvH/KWpASRQg/yV4SAKlQ3hb3aJOyI0VnJv3GNtfl
 a17RaEqqkpLDqkrOOjDeoYAY/MDuzvzov75H73W/pQ2VmX4NsLwj09GAMRJaWAMq+PwEKhw
 jesRBiEDB77wAvUMlzfUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wtkK5KUgEk4=;W3aSUqFjiWmF/TY4vFAObJkJ8bj
 GQePqQyq7nc/c/xyA45hGC2YRTMGS7WRVY/5PuYZLbKjozBr0p/inErrr4V7277aXyl/WAyuF
 gxkjQ7hK5AD33PWmauVjzsGrFu1z8YUZFpIVJe7XAFBHuL6yyvJcy20QK6dPnoClSyC/BC8BD
 Y2CCENrrTpR+tEaDDAsDfxEe3RtJF/6MHDlCWmT585iGcGuhBliyu86p7aGokI6mPexzuwI0j
 y+lnC4MGqOd0TIAz4gZApvd92W93ovWVbbZ9riNHjC2G5KIoS5KOF7R0t9ZdDlESQiSan76at
 L5h/DAXDiLQU2Cw/I44pmVELretKYNocdYnhHuEiBH4MD/iUWfXJAbMJlbGN19vaavuhGBmx/
 MTQBVN84ntZ5cpmDnDh2rP5+ez6IffS740HvZDLS9nt9o5PmgQ2mxftPFgv43mQ6S0fuyB+Vk
 ZjgkLSJjOsbPNp6oOaSTsCM4uXfxDb938OTDktFPAfwGLQAHRw+BRGp1zzPar0En9IV4Vhdin
 qjf+nnh0ENiSB0CKTx7H+EtVjvaP6OQ3LCY7DyM7obiK/OGRW70ApR1WJtlPcGgzBW4miCHBk
 v+amtK98n+BtWRSY4a68prZK0lZta/4kFKWiEscAFcqYk8YwqaxiaIVr5Rsk73k3EGnSNvnsq
 ea64wTMhRdCRt/qzsUEGLmuwh57BRi7KSvlt3/U1OP7G86X1Q7Pi10uKlWLIOR1FD8PCNzhmp
 8YTX0gAOgTx2DS8i+wL+zUpPcfwrk74agoJYmy+Emw/b5WQA88d8dMtM++YCdy9ow5rhbQ5lE
 bEdnEeMqJv3Oyf/AXUfEQAs008eMtA9kKyGK8q79RPRZT3A0sHWQtiyMCiY4eDEpAczSPU/2V
 CvGa4up6JOX68MnB5mZeIY9fxZ18bS2Gq5qgxm0mrNA/AY3aEMoVohRBFDivCjwea5/wqXmxT
 6U2rzg==

Am 21.12.23 um 22:30 schrieb Jeff King:
> On Thu, Dec 21, 2023 at 01:19:53PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> I think we can do it even in shell, especially if...
>> [...]
>
> Yeah, your conversion looks accurate. I do wonder if it is worth golfing
> further, though. If it were a process invocation per object, I'd
> definitely say the efficiency gain is worth it. But dropping one process
> from the whole test isn't that exciting either way.

Fair enough.

>
>> (sort -r), then we don't need to carry the oid forward:
>>
>> 			sort -nr <idx.raw >idx.sorted &&
>> 			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
>> 			end=3D$((packsz - rawsz)) &&
>> 			awk -v end=3D"$end" "
>> 			  { print \$2, end - \$1; end =3D \$1 }
>> 			" idx.sorted ||
>>
>> And at that point it should be easy to use a shell loop instead of awk:
>>
>> 			while read start oid rest
>> 			do
>> 				size=3D$((end - start)) &&
>> 				end=3D$start &&
>> 				echo "$oid $size" ||
>> 				return 1
>> 			done <idx.sorted
>
> The one thing I do like is that we don't have to escape anything inside
> an awk program that is forced to use double-quotes. ;)

For me it's processing the data in the "correct" order (descending, i.e.
starting at the end, which we have to calculate first anyway based on the
size).

>> Should we deduplicate here, like cat-file does (i.e. use "sort -u")?
>> Having the same object in multiple places for whatever reason would not
>> be a cause for reporting an error in this test, I would think.
>
> No, for the reasons I said in the commit message: if an object exists in
> multiple places the test is already potentially invalid, as Git does not
> promise which version it will use. So it might work racily, or it might
> work for now but be fragile. By not de-duplicating, we make sure the
> test's assumption holds.

Oh, skipped that paragraph.  Still I don't see how a duplicate object
would necessarily invalidate t1006.  The comment for the test "cat-file
=2D-batch-all-objects shows all objects" a few lines above indicates that
it's picky about the provenance of objects, but it uses a separate
repository.  I can't infer the same requirement for the root repo, but
we already established that I can't read.

Anyway, if someone finds a use for git repack without -d or
git unpack-objects or whatever else causes duplicates in the root
repository of t1006 then they can try to reverse your ban with concrete
arguments.

Ren=C3=A9
