Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775521CB304
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624199; cv=none; b=As0nRUr+9zUwQV0n35eC1M9XaJiOyGl20i4pXPLM3cVjrgtBkTj/oo4y5qiqEjGVKk8v5MY2xPqXY7AnJzFUDAbJPwSJiq9UBbqZQAi2n8x3B8lNVoDvsRb/0lX+jr69P1QLSgs1oRG9ynpJfNtS8rpLfW/4iWkNCUkfWrsFhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624199; c=relaxed/simple;
	bh=yn70fLxQupcL/7OGARY79darDqwC2AZhFoT3uTe5Eus=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=QnmNnz8NJu8jFiQPeKC02/g+ZVjP7C8upqdQ2Lko/c/xWVi1qwubTxkuj2D0mdKxtxSxLjt8LFfFAneyQVLUe51m6iKqmmlhVHIvdeazBf1DpMPpNbY3qqzr3V8d9r1PdqgaasNcOsmEOrA7EJn1mmUF38XDZGLvqgzUTpK/CE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=aJ59Oe0Z; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="aJ59Oe0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=q1WMCe1W7jvRrmlO01no9xl5fuSW8zCCju9UT/7AtJg=;
 b=aJ59Oe0Zo4zZ5kd6TFZDd0hRAvYOpZ01W4geCmNEWvLJhh3m9yMcpldjjUP0yb+gIbeKK8c61/lE
   ubRfAqEnWcgrQM0ROkoRGpOTvaSvqxg6qMh/Bl3RGaoRzdnN86RCZoUBKhy1aF4t+EVAJ6dECl7c
   g9foJeoUVhH+ALafyjzAgYxFQcx+0xxBHUk2vnDd+8rJ08MmHFdbf+wQM8clwB1OF5ZA2prrJ0zA
   //wRj1zwAjy+vjBIbl+z3jextFlyZuNC8w1tz4Nw/icoTPX5XdDDZzZbazrglZ3Fckr+BSvmbbAh
   uhkvCp0wH4yyktkE7RpUHUOnb3eh8GWe90CtBg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00MBMUKEWSD0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:09:50 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 21:09:04 +0200
Message-id: <D52KL6REL1RF.29CBKCMCJOD29@ferdinandy.com>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Cc: <git@vger.kernel.org>, =?utf-8?b?RsWRdsOhcm9zaSBWw616bcWxdmVrIFpydC4=?=
 <noreply@vizmuvek.hu>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com> <ZxfjWnZF4EbtVH12@nand.local>
 <D52JTXM32QOS.16IVFGPEJ4AKN@ferdinandy.com> <Zxf3JBz0u+ZF90tb@nand.local>
In-reply-to: <Zxf3JBz0u+ZF90tb@nand.local>
Reporting-Meta:
 AAEaY43CsX4NS5gnX13mxeflHPj4BoTX7uiPTxCe+2EPNdQOKX973DeBaZxpBN4U
 b0AA7+5xFQF/if8asupyVmPxeYf7X5xNvrbxT8CDmVkeAfiH5ib1FiMIkjmSJbcA
 vo4/ib4PoF5Ao9VlYDECtKIq7SjHJy+OUBbQo3hf90utZCdPLzOoCgnJaA6Tvh/c
 PG/NKK/M3GRN6kf+DCnSizBOQ9DLPsoHsdZwZP/DCCTLzhg9eNNbDi80loZ4VleU
 mQYBEXb4KlBTPbxoBCuJYubVNA/RVc9QmnLJidBmGYawxfedLFHRgBehdUxYk8rm
 PeVID3bifWqRdD2EuN0jQ4UR+1mZfh80YNoU8o5VKNMtMpMEHUnwzqC6qNQgpbtL
 rDv8b6ZAbecMhQK1sBHiiN7Z63gDfsjFH3o345y9uYe/NeTced1h0eSwS8fBXVB7
 0I4ARXZTTUGWoSPfMdkZATdMZNoe8IXaeQ2pT3Ds5PKMf3WTdX4now9R


On Tue Oct 22, 2024 at 21:04, Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Oct 22, 2024 at 08:33:28PM +0200, Bence Ferdinandy wrote:
>>
>> On Tue Oct 22, 2024 at 19:39, Taylor Blau <me@ttaylorr.com> wrote:
>> > On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
>> >> Bence Ferdinandy (8):
>> >>   t/t5505-remote: set default branch to main
>> >>   refs: atomically record overwritten ref in update_symref
>> >>   remote set-head: refactor for readability
>> >>   remote set-head: better output for --auto
>> >>   refs: add TRANSACTION_CREATE_EXISTS error
>> >>   refs: add create_only option to refs_update_symref_extended
>> >>   fetch: set remote/HEAD if it does not exist
>> >>   fetch set_head: handle mirrored bare repositories
>> >
>> > After applying this topic to 'seen', I noticed some new CI breakage th=
at
>> > appears to be caused by this topic:
>> >
>> >     https://github.com/git/git/actions/runs/11449483611/job/3185517151=
4#step:4:2506
>> >
>> > After dropping the topic locally and building with 'make SANITIZE=3Dle=
ak'
>> > and then running t0410-partial-clone.sh, I was able to resolve the
>> > failures.
>> >
>> > Would you mind building with 'SANITIZE=3Dleak' and running that script=
 to
>> > see if you can address the issue? Thanks.
>>
>> Thanks, I can reproduce the issue. I'm hoping there are no more tricks t=
o
>> testing things :D
>
> Great, I'm glad that it was easily reproducible on your end. This one
> should have minimal differences from the setup in CI, as I think
> building with 'SANITIZE=3Dleak' will suffice.
>
>> Let's see how fast I can handle this ...
>
> Thanks for looking.

I'll send v11 to the correct thread, hopefully with no random companies in =
Cc :)
