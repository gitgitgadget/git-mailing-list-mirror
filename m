Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF40264A78
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541611; cv=none; b=uU59+WPG0nslqxDlmaGFjwg7LsRg/j5oUQAmDyNtKMgd/nR5qc50AigJVAm5+s/FjgJp84Yz0Cm+tQ9TLhwuFB1v/qeK39u13LpuNK6SS0G0UBqETE8vheunTWNIvIFSLiQND+sScdtSZW7uAuwnDau/dwPYGE8kyLPfcb1F6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541611; c=relaxed/simple;
	bh=bCLLasEbtgOJ0+d8H3oUwp4o5mwraywNqc+iXMPOuSI=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=CDbpdQ8T2Gi3VJH5hqO8FLt/InqAx4MMpL80VFZMCgcu9oDb//oNnT17UMBMprYmoQqfjdQeFPTLhmHc9U+9JvxB0Jgm38loTLCECRns8h1FtpMqXTXD9HtPHkiPSqDWdjMXq8P5c5ucDeOU8ioCMvQVZO6BRTJam+7i2VB5bZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pvV5tHK6; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pvV5tHK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=JYe8qcHOwRGTh3GLbKqn3t5eBi8j8kVqa1vPOEOBx98=;
 b=pvV5tHK6UaWYKL1zvvjrI9czPQyxlz1uo465Lo4Xmx2p68YwM8Wzhq9brDxxTSpWNVqgE0FbfgRB
   NDKKusEZvtujFRpyot7Y4RiIobhCUPPOruCw7e04uvPuzyxzK51jWNAkqwjAjaUUFYyVUJaeje0A
   o7GHxEBr69tsSc7aZ1ytedXRtsvb8u44ONvLqVWBdTjktSKhd28TtzfbTJhH2FibhtXmQqRuyjxa
   qKVa9MS+4Qaksgej9UZNth8a85SPW927KcV8cJf25FjLJ/FfXfKaKQr/b8lLlz42KurwVJ1jIQ2Z
   odSvoTypZQXzzYc7RqmyZe9QA+nPb9OH4yjFYw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20250128 64bit (built Jan 28
 2025))
 with ESMTPS id <0SRO00AOKENMY060@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 14 Feb 2025 13:54:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 14:53:54 +0100
Message-id: <D7S7WIUIIO8O.27H4PIIL29B49@ferdinandy.com>
Subject: Re: Tags are no longer fetched when fetching specific commit
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Jonathan Tan" <jonathantanmy@google.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
To: "Taylor Blau" <me@ttaylorr.com>, "Igor Todorovski" <itodorov@ca.ibm.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <Z650WoqFwCSo6svH@nand.local>
In-reply-to: <Z650WoqFwCSo6svH@nand.local>
Reporting-Meta:
 AAGwHT5FfxGX67pgXBpDEYLfOTTOWGKqdc7jXV+yFqfbjbxUJfi/StQOGXZ7uVHP
 NnqM/FXmqDiIDSNVVfS0Kn4S0HXG7WBSh03xfbrJh8dKbOix6OWtPpM0AmlnHul9
 k+S05EwB0vtv62GoSRch32dnTQaePv8ErRDEBkhxMX9L0l7CuYSf1kaauXoXsYNN
 WO03KQVPHZEI2UlpjOuzdahSiLOlvmFYv6S7+HXiokNPEUFHyu938P41QpdAirsn
 ogmGiDeuIL303lkpNGX+Q/Ky7VCo/FKJIkAFr6g+ICCJ2tSmWq1vQT1QNyBq8xn3
 c6p9YR7Tk3qg97Uw5CDDJHxOojyDtFeQfV4msp4ozz8JcgL8ca2+3aFMSl7WlbuW
 z5jcoCI9Cj0v1xaqe2NGBpXCHgMM3M74HshnbaPwSF6vm8LOY4BgcHVW2qmmhbxi
 G2BuGsXkukRQqk/hMsoJQLo8L/5bDekJkU0FTIRMq4nZYVSNHu5owkkE


On Thu Feb 13, 2025 at 23:38, Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Jan 30, 2025 at 03:49:20AM +0000, Igor Todorovski wrote:
>> Hi, we have noticed a change in behaviour with commit 3f763ddf28d28fe639=
63991513c8db4045eabadc.
>>
>> Here=E2=80=99s the steps to reproduce:
>>
>> mkdir git-test-dir
>> cd git-test-dir
>> git init --bare
>> git remote add origin -- https://github.com/golang/go
>> git -c protocol.version=3D2 fetch -f --depth=3D1 origin 16afa6a740fac744=
2e94dcd2ec5ea4a4853e45dc:refs/dummy
>> git -c log.showsignature=3Dfalse log --no-decorate -n1 --format=3D"forma=
t:%H %ct %D" 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc --
>>
>> # Expected:
>> # 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc 1734108730 grafted, tag: go1.=
24rc1, refs/dummy
>>
>> # Tags are not fetch when using 2.48.1:
>> # 16afa6a740fac7442e94dcd2ec5ea4a4853e45dc 1734108730 grafted
>>
>> ---
>>
>> git bisect revealed 3f763ddf28d28fe63963991513c8db4045eabadc as the culp=
rit:
>>
>> commit 3f763ddf28d28fe63963991513c8db4045eabadc
>> Author: Bence Ferdinandy
>> Date:   Fri Nov 22 13:28:50 2024 +0100
>>
>>     fetch: set remote/HEAD if it does not exist
>>
>>     When cloning a repository remote/HEAD is created, but when the user
>>     creates a repository with git init, and later adds a remote, remote/=
HEAD
>>     is only created if the user explicitly runs a variant of "remote
>>     set-head". Attempt to set remote/HEAD during fetch, if the user does=
 not
>>     have it already set. Silently ignore any errors.
>>
>>     Signed-off-by: Bence Ferdinandy bence@ferdinandy.com
>>     Signed-off-by: Junio C Hamano gitster@pobox.com
>>
>
> Thanks for the report and bisection recipe. I was able to bisect the
> same issue myself, and also found myself at 3f763ddf28 (fetch: set
> remote/HEAD if it does not exist, 2024-11-22).
>
>> Is this intended?
>
> I don't think this was intentional, though the commit's author Bence
> (CC'd) can confirm.
>
> I suspect what's going on here is that in 3f763ddf28 and onwards we are
> explicitly adding "HEAD" to the list of ref_prefixes, which causes the
> server to respond only to the prefixes being asked for. In a
> pre-3f763ddf28 world, the ref_prefixes list would be empty (if invoked
> according to your script above), which allowed us to learn about any
> tags pointing at that commit.
>
> One way to fix it is to move adding the "HEAD" prefix to above where we
> check
>
>     if (tags =3D=3D TAGS_SET || tags =3D=3D TAGS_DEFAULT)
>
> , which would allow us to enter the inner-most conditional which guards
> us actually adding the refs/tags prefix to our list.
>
> But I don't love that solution, and I think even that is incomplete
> since as of 6c915c3f85 (fetch: do not ask for HEAD unnecessarily,
> 2024-12-06) we only ask for "HEAD" if we have a remote in the first
> place.
>
> I think the real culprit is that we can no longer hold the same
> assumption from e70a3030e7 (fetch: do not list refs if fetching only
> hashes, 2018-09-27), which is that we can avoid asking for refs/tags as
> an explicit prefix if we're (a) fetching literal hashes, (b) tag
> following wasn't requested, and (c) the fetch is done with protocol v2.
>
> So I think the right fix would really be something like:
>
> --- 8< ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fe2b26c74a..0e63621e6c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1770,9 +1770,8 @@ static int do_fetch(struct transport *transport,
>
>  	if (tags =3D=3D TAGS_SET || tags =3D=3D TAGS_DEFAULT) {
>  		must_list_refs =3D 1;
> -		if (transport_ls_refs_options.ref_prefixes.nr)
> -			strvec_push(&transport_ls_refs_options.ref_prefixes,
> -				    "refs/tags/");
> +		strvec_push(&transport_ls_refs_options.ref_prefixes,
> +			    "refs/tags/");
>  	}
>
>  	if (uses_remote_tracking(transport, rs)) {
> --- >8 ---
>
> But I'm unfamiliar enough with this area that I'd appreciate comments
> from the authors of these various commits, all of whom have been CC'd.
> Does this seem right to you, or am I totally down the wrong path?

This is the same error that came up already in another thread, and I came t=
o
a similar conclusion as you did (also about asking previous authors, which =
is
why it is a bit stuck I guess):

https://lore.kernel.org/git/D7D031QT4HEX.14TRNKRC6FC7S@ferdinandy.com/

I'll copy the relevant part of my previous message:

	What is not quite clear to me, is that it looks like that the original
	intention was to pretty much always fetch tags, yet it was not achieved by
	always pushing `refs/tags` into ref_prefixes. Deleting the check for
	`ref_prefixes` being empty [1] breaks quite a lot of things, but reversing=
 the
	order [2] does not. That feels a bit strange tbh since it feels like the t=
wo
	should bring about the same state ...

	Hopefully someone more knowledgeable knows why things are as they are, but=
 it
	seems that reversing the order really is a band-aid here.

	1: https://github.com/ferdinandyb/git/commit/6074a9b8c88451e589eade4034282=
dd9b6c86345
	2: https://github.com/ferdinandyb/git/commit/31e3f0a6b829d6c7953bf89d015b9=
8e7edabe6b5

So there is some magic going on later on which I don't know enough about.

Best,
Bence
