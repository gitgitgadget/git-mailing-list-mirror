Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E1ACDE8
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697707; cv=none; b=q7kFaMAYMCpZFL4fDB7f7x/lHkV/5RpVRDZaAKaUWC/4i5Vcuo6Q9EqR3PAPYqamD4sYVBClZ8Ocpt7icAE2CUFxOeNjoxhh9fnh7rTNftvOcoqaHF6y2kqG3D294ow+l2q2tOdd12Hb4N51kgJk83AdDIw5ApirpU0aRLBEhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697707; c=relaxed/simple;
	bh=xidJyZdoAjYrPWN/zOa8uO3EnqdjqyZjB5zlX9Mb+aI=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=Hg4uR3rC4DYxeAu/d5ZTytcVOH5dWtlWSZ6agkp48pd67XX1qScqsxQ7j+gyCRBmF36RK2V1og1Cr+YWlPRfoGMi9HhtpvHxG24xNofT2sYmVwTOM/jvTWkWNl+kgnC8xeIe6mPCoDGALcDPB230ArclLV/3t7pD+MTU2OvqmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=jOucP189; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="jOucP189"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bO0Qu7ARP2CdIQFa19lMXOCfKerKFXuG2vk5Yln8f60=;
 b=jOucP189zeC6xBbWCEa53AtMerh0kbh7OmriMQKtJaWFQGu8/ghSczkU1fsjSR71w5jWU1KIet4K
   iRfkXOZW/tTJW5oMg1PUAx6k9K8n1GC338cGDVNavJPcdX4O+Qi0T7WgZCBX97qRtqIWJU8+uh+p
   kjte/DHPLcYhO7+3FrYJDqhibDiW83hvLbw1tzsI2/x5HjKfHEgdQCKuScFKsxhbYV0HhYM3CDsL
   Z4jsw8BWIZN1G2MbIZYbYhF9YHky3OM4SbNEKSnNvooFYB3Irqt0r62t3H5CnGTVh37QlLw2qNvG
   rVGfaxyrH22LJJh3W70O27h3VIzF9zcJSGM9lg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00ONOFAF7E70@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:35:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 23 Oct 2024 17:34:23 +0200
Message-id: <D53ANCP0WMJF.2PG371ZJS1F95@ferdinandy.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Karthik Nayak" <karthik.188@gmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v11 1/8] t/t5505-remote: set default branch to main
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241022194710.3743691-2-bence@ferdinandy.com>
 <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
 <D52LZ1W0FH29.1GVLRMGN80HPB@ferdinandy.com> <ZxkRq3GNbrO1cqw3@nand.local>
In-reply-to: <ZxkRq3GNbrO1cqw3@nand.local>
Reporting-Meta:
 AAE3E2yj7RcntEa9ZQAgXIrjzU4XcukpfUYogdhY4k8jpoCTBWTGODvDlIz70Xjn
 ssPa+a+P7IAcXylge92zagyLXr6svSzJuZSvagAFhURPT7EBpmHfLWkXJkTrbeIB
 I5KQ0dlF/uBc7FXkN+4/zgaC/ICT94V56CLHuNrGqdi8E7DFn3Sy2ebmZlgwjlxj
 y2ESM0D/YPokYqOki3Y30R8aRt+HnHPqWip3Bbja30+jxezUZZ6yPM9DTa9smR98
 HH6DDMuw5K37BViDvT4pMPAcdQZaFbnn4aTmQf3ZwjlYrrCEZl962J+BGA+5ZpsJ
 oPbVTIraGByKUeirMGVh2X53cYMdLzm45xY/p1YcRhQzuH3K8HOraRHtf9SV8WNF
 ZA6Lw48weixL0nrFSdN9C6umFVKPqH+KZ3qu8PVRavhZSA3kAwwo+JIE1AVLYf03
 65fW3P/Cw98jlthzT2WyuHC1G4SCwIMIw5MJ/9mFMUuctyfkiHhbsMAV


On Wed Oct 23, 2024 at 17:09, Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Oct 22, 2024 at 10:14:12PM +0200, Bence Ferdinandy wrote:
>>
>> On Tue Oct 22, 2024 at 21:53, Kristoffer Haugsbakk <kristofferhaugsbakk@=
fastmail.com> wrote:
>> > On Tue, Oct 22, 2024, at 21:45, Bence Ferdinandy wrote:
>> >> Consider the bare repository called "mirror" in the test.  Running `g=
it
>> >> remote add --mirror -f origin ../one` will not change HEAD, consequen=
tly
>> >> if init.defaultBranch is not the same as what HEAD in the remote
>> >> ("one"), HEAD in "mirror" will be pointing to a non-existent referenc=
e.
>> >> Hence if "mirror" is used as a remote by yet another repository,
>> >> ls-remote will not show HEAD. On the other hand, if init.defaultBranc=
h
>> >> happens to match HEAD in "one", then ls-remote will show HEAD.
>> >>
>> >> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D=
main,
>> >> there's a drift between how the test repositories are set up in the C=
I
>> >> and during local testing. This issue does not manifest currently, as =
the
>> >> test does not do any remote HEAD manipulation where this would come u=
p,
>> >> but should such things be added, a locally passing test would break t=
he
>> >> CI vice-versa.
>> >>
>> >> Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain in the test to be
>> >> consistent with the CI.
>> >> ---
>> >>
>> >> Notes:
>> >>     v9: - new patch
>> >>         - a bandaid for the CI issue noticed by Taylor (cf:
>> >>           https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/)=
,
>> >> but
>> >>           see
>> >>
>> >> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/
>> >> for the root cause in detail
>> >
>> > Why no signoff?
>>
>> Because I always forget :( I've been thinking on making it by default, b=
ut
>> I didn't want to add it to all the work related commits, where I'd be th=
e only
>> one doing it, but I just found the format.signoff setting, so I should b=
e
>> covered for future patches.
>>
>> I'll wait some time before sending a fix for this :)
>
> Yeah, I was going to suggest format.signOff as well. If you don't want
> to add your S-o-b to work commits but do want to add it to patches you
> send to the Git list, you could just stop there (assuming that you don't
> use format-patch for work-related patches).

The projects I contribute to seem to have a bidirectional mapping of requir=
ing
S-o-b and format patch so I should be good with this :)

>
> Alternatively, you could set it in your copy of git.git's own
> configuration in $GIT_DIR/config, so that it doesn't apply to work you
> do outside of that repository.
>
> Either way, I'm going to avoid queueing this round since it is missing
> the required Signed-off-by line.

In that case I'll send a v12 with the S-o-b so the series can get back into
circulation.

Best,
Bence

>
> Thanks,
> Taylor




--=20
bence.ferdinandy.com

