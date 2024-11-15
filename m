Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1A18BC3D
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711310; cv=none; b=stQz1MaTxbhQB+vWgGdaTw9fzyHQFbfsJmsXUIiAkfVwAy/zcZsEv1gBfsGYu0wbBrukPJ0a5Mcdo1U4Viip53sfYgLTlAyyWD9EN32u9nLQ9ny//Mlsp6QXNOnMs3HWBlMwPt+SKaeM0Gm9N3RKYxehnyZIoJwcjL1NmfHaRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711310; c=relaxed/simple;
	bh=64FdWw3sU5OGR7b1ZyVCZkF/rOkU+oDn+cjA2OUpV1Q=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=gJ+sDMr/a5mCb3ThBiWmd8MW8OISagGj5diwEeEq/yu8Ne8eDSgD3jZb7CbnpnwCaMEnxjfBup/j6itxMiK9Jw6Qvr1RWot9YmgU8oo2zEHqOK2P1vwWWXKT1OEE1eMsu8LfuLP6FkCtVfq98g4sZxQXEjO3XO7uFkk2UjzYaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Wyz4y7CK; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Wyz4y7CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=HqDRlYKnP99VzqJYIvBppVnmqZ71gDTcvzZ5zjLLfCo=;
 b=Wyz4y7CKFz+Fdom+icrHqoIlEueLDK/QActGAJRoPH8oP/ertqGGexmgXfN013KIfxGdbozc53Eg
   MreSDfonIooPizjMwUPi0lJAZeM98Lw+uLqIpzNVTu3Ewk8B1ivQxxq0TjAMgTVqwz/YeYfEum4w
   lnSc4UvoOC/igVkbMNMYRKeEWvpiHA0V+LuyE4kfPx7HvKUaXNdl/15RcL+Dc/vuT7RhNKyXyNi5
   /SSYc0BH2rhoCm7yEy6cWlXI7KnJPODyidBo7ZLM7lpF9d1RHbQP+TAfLs/ZQtvAY1yMDQhvX55A
   WdRAPD9q/6hgexq/YN/VUp7Tdus1kC94Qu0/1A==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN0007BLKRBE7F0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 22:49:59 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 23:49:33 +0100
Message-id: <D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com>
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-5-bence@ferdinandy.com> <xmqqcyix11w8.fsf@gitster.g>
In-reply-to: <xmqqcyix11w8.fsf@gitster.g>
Reporting-Meta:
 AAG8dyYPLmahVn8WU7+eSZYP/dtztSN+C6RaVVwpAr+Mw50KqThW/WCmaZJvT6Pv
 lM8kUWktdUq2+19iiFWZOc7C8ECZ71CDt2P7xgJXu6aGXY0IubnT6mMVtElhc9dw
 WpJlozrwSStaJnY5dQZsOKNR1PN8DwKlPcL0nJxnPacOIL+T4CjRQ6w2OdSycf5o
 4Flxad+p6awmjjL3he5t/DMlhqvxW8hyaWW4C37ShlMopbxB8vN7WQpiXCSwR0n2
 pn5IjCZxgT7ICdycH6lYsDBTHNOdGvq/bm+nLbP7K86J3KHt1GQxmhbLB1mXu9gW
 LW7yKqjcQdg6RTrCXiEhCPdo5QVX1FTVc8MRr3Wp2GcX3jLwwTsayxRVS61qG/Y/
 kAJ5RTooXqqF8VBclRJ+xqdRw5flXixBSugPfSdvaXHj64nSYvD9qbivZWSrDgav
 uYu6nu+baWF3NESc1fEpupvM0UYF8FJyR8MmnDiyTPDyT6NzzWi0I59t


On Fri Nov 15, 2024 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> Currently, set-head --auto will print a message saying "remote/HEAD set
>> to branch", which implies something was changed.
>>
>> Change the output of --auto, so the output actually reflects what was
>> done: a) set a previously unset HEAD, b) change HEAD because remote
>> changed or c) no updates. As a fourth output, if HEAD is changed from
>> a previous value that was not a remote branch, explicitly call attention
>> to this fact.
>
> OK.  That's sensible.
>
> There is a slight variant of the fourth case.  HEAD may have been a
> symbolic ref that pointed at an unexpected place (which you
> addressed), or HEAD may have been a non-symbolic ref (which the new
> code would mistakenly say "HEAD is now created", if I am reading the
> patch correctly).

Good point, and yes, that is what happens. (Although I'm not quite sure how
valid that state is where a remote's HEAD is not a branch).

>
>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>> index 9b50276646..0ea86d51a4 100755
>> --- a/t/t5505-remote.sh
>> +++ b/t/t5505-remote.sh
>> @@ -432,12 +432,51 @@ test_expect_success 'set-head --auto' '
>>  	)
>>  '
>> =20
>> +test_expect_success 'set-head --auto detects creation' '
>> +	(
>> +		cd test &&
>> +		git symbolic-ref -d refs/remotes/origin/HEAD &&
>
> Are we sure refs/remotes/origin/HEAD exists at this point in the
> test, regardless of which earlier tests were skipped or failed?  If
> not, perhaps
>
> 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
>
> is a better alternative.

Ack.

>
>> +		git remote set-head --auto origin >output &&
>> +		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${S=
Q}" >expect &&
>> +		test_cmp expect output
>> +	)
>> +'
>
> Here, we could insert another one:
>
> test_expect_success 'set-head --auto to update a non symbolic ref' '
> 	(
> 		cd test &&
> 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
> 		git update-ref refs/remotes/origin/HEAD HEAD &&
> 		git remote set-head --auto origin >output &&
>
> I'd imagine "output" should at least say that we are setting up a
> symref origin/HEAD to point at some ref the --auto option figured
> out, and if we wanted to report its previous state, it was a non
> symbolic ref that pointed at some commit.  In any case,
>
> 		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ}=
" >expect &&
>
> is not what we want to see here, I suspect.
>
> Can we detect the case where we overwrite a non symref with a symref
> without going back to step 2/8 and doing a major surgery?
>
> 		test_cmp expect output
> 	)
> '

I agree, adding this makes sense. And this also takes us back to the questi=
on
of what we should do in 2/8 when refs_read_symbolic_ref exits with 1. I now
tested the behaviour and if origin/HEAD is gibberish, git already dies befo=
re
with=20

error: cannot lock ref 'refs/remotes/origin/HEAD': unable to resolve refere=
nce 'refs/remotes/origin/HEAD': reference broken

so refs_read_symbolic_ref -> 1 only happens if there's a valid non-symbolic=
 ref
in origin/HEAD. So maybe if we put "Not a symbolic reference." in the refer=
ent
(which should be an invalid symref), the caller could check for that and th=
en
should be able to distinguish this special case?

Thanks,
Bence

--=20
bence.ferdinandy.com

