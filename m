Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C14C8C
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066763; cv=none; b=E9SAe/PR917M917gfZXia0WC63ewcIONhO2qV5ARmquPjisFTcwQ4WdtoTcOcLUfaRdB4HMMqpphMuQJFU1i+SV7novYB0VpHiQf1hwQOgTxV41UjWtnNCqxbqvciKRDc3Xyzqr9Bkm9PnsdsM5OedbTXQTDEtOqwOqRtU22BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066763; c=relaxed/simple;
	bh=NGjxhXYT+2Sunq49RCXdIo1kQx7wizMjfMbykAueHfI=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Dld4N9kJjWxpebQftoHr5ifu6qP/MR3H7MLRD8qVwcJKRX/CQrENaBsSEghDfIfv4ynD9FsnlcD0TvaRjpCj30l6dbyIGuTX3jwBnDVQKWenyFfHGhJx1poRcSrc3bIjLlECsNrdaU9ZLKjT+1IoSedCXQJjyXd4TlWWPfIV8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=TZnuAUgI; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="TZnuAUgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=fo2k9st3GrClBvknQvbo38I6BKuct7BMGDK/nJt3UWA=;
 b=TZnuAUgIQTaNx7nfhHmRy5gf+i/cNJXK7GB+6oF2s0APSZmHqgnYUd/Q14qNrMwZkkR6jHFzblw5
   vIx4eyVFKrreRArk2WfbBjGugx6tdN3cjcKpu4fi4yvV25f4uL7tJ31gVR8pUeBMh4AaOWqsh4u1
   45J/CX57Mm7b590U42887ZH9GaL2p61cbLd4pVSTZOseQvzBcdj3M1aVh6ZBRLdo2P8XF2yqifob
   ZXbzCNe86hxDAL0V4RSQ+YULpbn/mMy4nnouQL5zTpqXO5RfiozP930IGml9YZ2vyOs8Kk84KuOH
   DrRUDCJgTGEWgu/pJD2KV+jAZ5odPhQJQ3b6+w==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLF009VDWG05QD0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 16 Oct 2024 08:19:12 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 10:18:44 +0200
Message-id: <D4X2ZZAT5LKS.1FZ375SIMBV2F@ferdinandy.com>
Subject: Re: [PATCH v8 0/6] set-head/fetch remote/HEAD updates,
 small change from v7
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, <karthik.188@gmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com> <Zw8IKyPkG0Hr6/5t@nand.local>
In-reply-to: <Zw8IKyPkG0Hr6/5t@nand.local>
Reporting-Meta:
 AAFgNrGQOcophDT9Kxs9Wg2VDXRq/wEUtD/lXQjqxP2G82fz/QdU8yq5wI4VW3lA
 V+lUCTrj6a8OwnSFw1q+4qWuGg+9aEeoKz5+KOB6+OUOJCFGC1raQbHty5H+sdBQ
 uZOI9Uw9eZy6eddDAVraklvltBO/w3IckXOLY7gGIEAc6NOxsLndvh29Qmx09iy+
 4Nne9Pnv5UXWqmd3eZgKQCqZI+0KheF+7fIQPF71LYBRyaA/jGpwQqJmjA+VHnO7
 eHaLCj/ClNR+/Uv9GJAgJwjJXqjQvieDe6hewkgq3uvqgX35DBCCyrhhqx8gi9Av
 DejpQsIiBleHoCYu+lGLY3YFWDBz7T72u0p5wlPsUhNcthZUKDej2Ff0fUTzF5Bi
 wSfeMgbMUJU+NFtPQSOnkiyY3rKEotlSeJ2EGkZFXrSwXsEycqx131l1uwvgEFRX
 p/BcK1TB+kLRjr62cB2bsJw0mng+P8dN9cC6h/+FnibHZqEHQp8RISfW


On Wed Oct 16, 2024 at 02:26, Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Oct 15, 2024 at 12:53:09AM +0200, Bence Ferdinandy wrote:
>> Bence Ferdinandy (6):
>>   refs: atomically record overwritten ref in update_symref
>>   remote set-head: add new variable for readability
>>   remote set-head: better output for --auto
>>   refs: add TRANSACTION_CREATE_EXISTS error
>>   refs: add create_only option to refs_update_symref
>>   fetch: set remote/HEAD if it does not exist
>
> I integrated this new round into my copy of 'seen' today and noticed
> some test breakage in t5505 here:
>
>     https://github.com/ttaylorr/git/actions/runs/11356267070
>
> I'm going to temporarily eject this topic out of 'seen' until we can get
> an analysis of what's going on here.

Thanks for the heads up! I see that indeed the failing output is different =
than
what I have locally (e.g. no "apis/HEAD -> apis/main" in any of the test fi=
les
I have). On the other hand I can't reproduce it so I will need some help wi=
th
this I think.

I tested with both a rebase on master and a rebase on your seen branch. I'm
using these to commands in t/ to run tests:

prove --timer --jobs 15 ./t[0-9]*.sh
GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable prove --timer --jobs 15 ./t[0-9]*.sh

Everything passes. Should I be running this differently? I'm assuming the t=
est
do not use any global or local git config I may have?

I'm testing on Ubuntu 22.04 natively and in WSL, but the nature of the erro=
r
doesn't seem like it could or should be related to the OS.

Thanks,
Bence
