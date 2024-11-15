Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F07346D
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712492; cv=none; b=gZdQee7DqzGLVf6hDYuxXPBwbvITDxpGtRE29VcYg1eRLZaowo9LUX8iaYQmdXJW3i7C7SzemMlAiF2+0/2xpJdGjFrC8BRYN9yb9wnv9eavdqZFpq3XRHf9dv5D57DwTYcPXsH5vhAb81kbG8C9mUjDzYOoWDnwXfXywpjsc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712492; c=relaxed/simple;
	bh=ddDnftIE+0zH6ruYqSDI4xf4ARbjANdph/obnGKHTeM=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=DKdsGdoyBrItGt5hwX3he1ISFFKKU1OidQMWJfs1SWONg/q532qMdyU/OLvN3xXvVK5HpJvXIY3P12BQX2HWSX9yN9JCIb8kMa/oyNNpwHAouE/RIoehTMyMWhvoeivjXAAHshFhwnQ1HhErYnKLX93TqqX1sLqnCQXECWebvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=I18193zd; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="I18193zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=koaaYvE22o9DudtS0toDRy0BPyjppWUU7aw4ubgizkM=;
 b=I18193zdnnaPsMdCG8lfCyGZt3IiAwAfhtUtnMMEZGd0lUXT80TozBOiVNX+yN+VI5twbJ4OjMyp
   Mnuif+l9X1BUQ0sJEUw3Am0FRPkNif/rKLXvc7sO7Wbvt0W5v3/5JnUWAL8oPZ2J9esFmkTFs7+K
   ac3v08QAqLekXZVBDd8G7qYtU5BY6r6Ua4GbwXWJrevGw6Cdf+N1WwmGxzA5VIXtx4WGtryKnuQY
   NuGX+cjtmSjmlmoGdGN5HR7WPG/6RkPMt5qfEajK0WrZF/sjFVAtiVFq26nGqCGKW4s/siihMd8k
   VMMVQmbxy668F9hspyB0v+41hrrwZh5G/LI7DQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN000KXVLWNL970@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 23:14:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sat, 16 Nov 2024 00:13:48 +0100
Message-id: <D5N4TN6WX65V.JJKLX5ROS8NN@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Junio C Hamano" <gitster@pobox.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-5-bence@ferdinandy.com> <xmqqcyix11w8.fsf@gitster.g>
 <D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com>
In-reply-to: <D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com>
Reporting-Meta:
 AAFLrooIivhn4mS5hdUDcR0uEaS0PncLSm00cWoHIVZ2R8oRK46qRh2QmK9Mx5pg
 Y5brOwqXSdRo+KQx5OK+5D6ycNxWFkG9SrM3/43++cEMVW9mBfkx8CGDpRu5rfjr
 HCXw0Eaq32CKN/pni64+unaa8hXmtpx8kovNNF6npwG562szN0si+LYDGIXVpkiS
 qhs2ALLFGpyRYe5uV3uZdrnsU2cIV8dKjqH4q4790G3ZifSrel1hsSAUKXnDEkCV
 XmLi8ygau3liI+cBkQ30+A9ZMOrcYRDAsnOzvbfh2/tyYSM4XTjq6tK8xLd/a0nl
 m+oaWX71tVBZMaYBuZlZib5Mmtn13E2G4FkoupfVa2zlYliywemY5yGnddtPVNTV
 oJRQc+KfXaWwqFqAAs1its7P5tyT4/DDGBzOL4mJk6wtvq0XUOm1P6xIBw3maAGY
 zDZyi13GP2bzq4E5BX3TzA5VI834Ywgvk4CLKm/+uEyBFomBBNM2eWsK


On Fri Nov 15, 2024 at 23:49, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> On Fri Nov 15, 2024 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>>> Currently, set-head --auto will print a message saying "remote/HEAD set
>>> to branch", which implies something was changed.
>>>
>>> Change the output of --auto, so the output actually reflects what was
>>> done: a) set a previously unset HEAD, b) change HEAD because remote
>>> changed or c) no updates. As a fourth output, if HEAD is changed from
>>> a previous value that was not a remote branch, explicitly call attentio=
n
>>> to this fact.
>>
>> OK.  That's sensible.
>>
>> There is a slight variant of the fourth case.  HEAD may have been a
>> symbolic ref that pointed at an unexpected place (which you
>> addressed), or HEAD may have been a non-symbolic ref (which the new
>> code would mistakenly say "HEAD is now created", if I am reading the
>> patch correctly).
>
> Good point, and yes, that is what happens. (Although I'm not quite sure h=
ow
> valid that state is where a remote's HEAD is not a branch).
>
>>
>>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>>> index 9b50276646..0ea86d51a4 100755
>>> --- a/t/t5505-remote.sh
>>> +++ b/t/t5505-remote.sh
>>> @@ -432,12 +432,51 @@ test_expect_success 'set-head --auto' '
>>>  	)
>>>  '
>>> =20
>>> +test_expect_success 'set-head --auto detects creation' '
>>> +	(
>>> +		cd test &&
>>> +		git symbolic-ref -d refs/remotes/origin/HEAD &&
>>
>> Are we sure refs/remotes/origin/HEAD exists at this point in the
>> test, regardless of which earlier tests were skipped or failed?  If
>> not, perhaps
>>
>> 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
>>
>> is a better alternative.
>
> Ack.
>
>>
>>> +		git remote set-head --auto origin >output &&
>>> +		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${=
SQ}" >expect &&
>>> +		test_cmp expect output
>>> +	)
>>> +'
>>
>> Here, we could insert another one:
>>
>> test_expect_success 'set-head --auto to update a non symbolic ref' '
>> 	(
>> 		cd test &&
>> 		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
>> 		git update-ref refs/remotes/origin/HEAD HEAD &&
>> 		git remote set-head --auto origin >output &&
>>
>> I'd imagine "output" should at least say that we are setting up a
>> symref origin/HEAD to point at some ref the --auto option figured
>> out, and if we wanted to report its previous state, it was a non
>> symbolic ref that pointed at some commit.  In any case,
>>
>> 		echo "${SQ}origin/HEAD${SQ} is now created and points to ${SQ}main${SQ=
}" >expect &&
>>
>> is not what we want to see here, I suspect.
>>
>> Can we detect the case where we overwrite a non symref with a symref
>> without going back to step 2/8 and doing a major surgery?
>>
>> 		test_cmp expect output
>> 	)
>> '
>
> I agree, adding this makes sense. And this also takes us back to the ques=
tion
> of what we should do in 2/8 when refs_read_symbolic_ref exits with 1. I n=
ow
> tested the behaviour and if origin/HEAD is gibberish, git already dies be=
fore
> with=20
>
> error: cannot lock ref 'refs/remotes/origin/HEAD': unable to resolve refe=
rence 'refs/remotes/origin/HEAD': reference broken
>
> so refs_read_symbolic_ref -> 1 only happens if there's a valid non-symbol=
ic ref
> in origin/HEAD. So maybe if we put "Not a symbolic reference." in the ref=
erent
> (which should be an invalid symref), the caller could check for that and =
then
> should be able to distinguish this special case?

On second thought, it would maybe make even more sense to get the reference
hash and put that into referent. In that case the output could still be

"'%s/HEAD' has changed from '%s' and now points to '%s'\n"

but with a non-symref after from.


