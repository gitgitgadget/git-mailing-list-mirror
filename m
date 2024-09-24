Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047F13C9C0
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217921; cv=none; b=GOKJbYHt5n1NQG8Z0CqDtYz20jtH8hC1CDB2g2ujjd2KsDYSp6+ATtYVbT4hfkk8ArcKV7sLa2BfMCzDLdVmX/EqtZ3DtSYJ72j7c5kpo175VwrF2kJQ6rbRIx9GhvEksv83qJinJJ8azW25Hyeb1hqOD6nZGXle0t6BVc84y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217921; c=relaxed/simple;
	bh=oyHA2j7UdBjEqXoFckVy8etK4jXN2cznrHFiHWbvRec=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESbd+QMANlh7jruRpNvRB4p8tPfir9h/8Huy24+W/NQePl/Ua8l6XZXxps1sB9sQRi/P++xSnlzdRVNK4zXE4pumDPo9EbKLdeV+vH+Z7ESYMl8aRhAUu/kIJnXYeQ2qo1UoDyPujmDYkss8BT0k2Px+RCjzmHpuQ2yK++LZOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48OMj4OS1269266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 22:45:05 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <phillip.wood@dunelm.org.uk>, "'Sean Allred'" <allred.sean@gmail.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local> <053f01db0b79$0d885b30$28991190$@nexbridge.com> <m0v7ynm7h0.fsf@epic96565.epic.com> <00a501db0db2$94d505d0$be7f1170$@nexbridge.com> <18d732da-ad34-4a45-b59f-cf2cb3c7238b@gmail.com>
In-Reply-To: <18d732da-ad34-4a45-b59f-cf2cb3c7238b@gmail.com>
Subject: RE: [TOPIC 01/11] Rust
Date: Tue, 24 Sep 2024 18:44:59 -0400
Organization: Nexbridge Inc.
Message-ID: <018401db0ed3$667bcf80$33736e80$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQF24rJ2Q0W9JcDOH4N3ZxazDM0CYQHP+YxMAoJn3JIBrepyAwFv0IQDAQwByIay6/1YwA==

On September 24, 2024 11:30 AM, Phillip Wood wrote:
>On 23/09/2024 13:17, rsbecker@nexbridge.com wrote:
>> On September 22, 2024 10:26 PM, Sean Allred wrote:
>>
>> The GCC dependency, which does not currently exist in git, is
>> independent of Rust. > Rust has its own rules and runtime. The issue
>> here is that the Rust team gets to decide what platforms can
>> participate, NOT the platform maintainers. No matter what my intent,
>> or resources, I cannot get the Rust team to "Allow" a port.
>> In
>> many ways, this is egregious and is a policy issue entirely on Rust, =
not us.
>> We
>> want to do a Rust port but are simply not allowed/approved. It is
>> their policy.
>
>I'm hearing that there is a fundamental incompatibility between some =
aspect of the
>NonStop platform and rust's requirements for supported platforms. Does =
that
>mean it is likely that rust will never be available on NonStop?

I do not know whether Rust will never be available. The policy is that =
the Rust
maintainers must sanction and approve any ports. I have tried to get =
approval
and have not been able to do so. It is not for a lack of trying. To me, =
this is a
serious problem because there is no "community" concept for Rust. It is =
either
sanctioned or denied, regardless of the desire of someone to port the =
code.

>> I agree that it is not a good policy to never add new dependencies.
>> However, Dependencies must be reasonable and give the platforms a
>> chance, at least, to adapt. We cannot in the case of Rust. The =
problem
>> is not actually that we can do without new features that are in Rust
>> but not C. The problem is when there are CVEs. Suppose a severe CVE
>> happens that is fixed in a Rust component but referenced by a C
>> component or somehow intertwined. The fix to the CVE becomes
>> unavailable and git gets thrown off the platform. That is the reality
>> of how insidious CVEs are when it meets corporate policy. I am
>> primarily trying to protect from that.
>
>In that scenario there is nothing preventing a different fix being =
implemented for an
>older version of git running on a platform that does not support rust. =
It's likely that
>such a fix would need to come from the community using that platform =
rather than
>upstream which would represent an additional cost for users that have =
previously
>been relying on the upstream to provide security updates.

This means that the community is responsible separate for CVE security =
fixes.
I have a major problem with that. It means that there will be separate =
NIST
and Mitre reports for security issues for the same case. The code will =
then
forever deviate and git will no longer be one product. It also means =
that
customers can no longer consider the official git to be available on =
NonStop
but will have to come from an unsanctioned community edition that will
lag behind all security fixes associated with Rust code.

>
>> Telling 10-20000 users that their core bit of infrastructure is
>> insecure and not fixable is not a tenable position. However, it is
>> hard to defend the community when the git team is hell-bent on this
>> particular decision. What do you need to understand here?
>> It is a small community with a large number of users in key financial
>> institutions that have a very conservative adoption policy and an =
even
>> more conservative hardware vendors.
>
>I'm struggling to understand why such a conservative community needs =
access to
>the latest version of git. I'd have thought that key financial =
institutions should be
>able to fund someone to backport security updates to their critical =
systems.

The community does not need access to the latest version. It *does* need
access to security fixes made in response to CVE reports. As above, =
being
able to backport security fixes means that git is no longer officially =
the
same, nor can be verified as legitimate once this is done.

>
>> Again, it is not the gcc dependency. We have been coping with c99 and
>> will have c11 shortly. It is Rust itself that is exclusionary. It
>> might be easier to write new functionality in Rust - it is easier in
>> Java, Perl, and Python too. Why Rust? Because someone wants it, not
>> because you cannot implement the functionality.
>
>It may be true in theory that anything one can write in rust could be =
written in C
>instead but in I'm not sure it is true in practice. In previous =
discussions multi-
>threading has been mentioned as an example of something that is =
sufficiently
>difficult to get right in C that contributors are not willing to =
implement whereas they
>would be happy to do so in rust.

My position, as a professional product manager, is that such changes =
should not
be approved.

>
>I believe that those advocating for using rust are doing so because =
they believe it will
>benefit both contributors and users. The problem we have to wrestle =
with is
>whether those benefits outweigh the cost to the relatively small =
proportion of users
>who do not have access to rust on their platform.

I would be very happy to have Rust on the platform. I do not control the =
situation
even if I have the skill to do the port. This is entirely unfair, in my =
opinion, to the
community maintainers, (me for one) who are going to end up doing far =
more
work for free than anyone else.

I am sorry to disagree, but I cannot see any way around the problem that =
makes
sense. I have been the NonStop maintainer since 2016, and feel like I am =
being
now being thrown under a bus outside of any of my control. If there is a =
way to
solve this, without this becoming my full time (for free) job, I would =
consider it.
(Note that the git license (GPL) requires me to contribute my changes, =
so it is
being done for free even if I find a way to charge for it.) Honestly, is =
that
reasonable?

