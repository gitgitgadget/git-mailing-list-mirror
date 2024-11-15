Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94A1F9ABA
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708071; cv=none; b=f/X/21X8IBs5TENU05ltL3EpfIAaui+1KKVogfcevqOrEUEuf9h4bul27SZRQYZ929oDdT+uu0wfw9AbiYTN01f6eeab1ZLpgzGks2/HIZMSn8J/uyfBLx1LKr5+6VC36HpRveJKpJwlwTowiPcNJTeaXtuV3lhWcJNd63KRKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708071; c=relaxed/simple;
	bh=TPJ3ldAVy3vH7PniHzcyFt0xwSCtTN0Uo4/itM/8HFI=;
	h=MIME-version:Content-type:Date:Message-id:Subject:To:From; b=Coo2Zg2K3IjLRwL9WHLk9YddOfv8WZkIKqHqNzjcMSvjdhHcFS30avIsHzQ3hF4hasn3qFVbrH1RDWRL6pvLm0pDdYUZfsmzIpUZ73Tx8kxN09x5583Jc64OP3vY5UoHJ0JoO1ONz+zHTlxdqqHjgW9HhvMqNT/304Ag/Bt0GLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=AIbAYEH/; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="AIbAYEH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PzYvyNFw9DzO55sHeo8OxqX7mmo0Mpdn8v81x6HMgcA=;
 b=AIbAYEH/WvvDPXHgvx3B2tpiRPW2KduJ55DmQuIt66MgxGair5XC+OwezuuBsP8OnWhpxUN+Wwoc
   ThF+xIMR5U5Hf45CWduwx0bsuNZN0kgRjO3LrMHQrUYitoCBUtsxJRWI/isAWe2sw28Q8sVQ4KDA
   BpkgWuuQV6wOjV+aiJVhLJKCYSV6ta3aIGjJr5e+IXFfaxiE1LjR00lL9I6Xuuc8GrCZXbORsw5X
   NuUpkxH2EZBU3aYq2epXkgJksY1YzRqxEA4CMJ4ksU+2ZELf3E6aSYR2vwfEYDrrdE+h10Ey5ELT
   fBWoNUXSOGVsXy7zLARsYLPbLC9l8tGFHurktg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN0001VZIHOKO40@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 22:01:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 23:00:30 +0100
Message-id: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
Subject: log --format existence of notes?
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Reporting-Meta:
 AAH5dsURVtkRltt7fHCtA9v9yRgPK8NK+EwGIdE3brWl3hpDY6A4kL5ri9dUovbX
 3xt0SWfdG2mB2IkGsF75Y0PDX+JhLMXbvVcPGltqSHOsAGA8c6DReJMQok1yzZfA
 mZnHRgJDLGqF6r/UFfYj1ac0W6MeMLv/V9yinCzsvels2DBzS46HiVVsFDqWQ0qG
 8OuqkJbNF2GsvESAM4RgH6kbw5QispFUfZHWIOG44uWFljAiQIpXadLy+BCo+Es1
 HyH+14GdvLRkvjWaGbax9REWXy16C1EGaNiiJ6doUzbf8u8C/0ntPIkZ/Fq7P+WA
 v/bu1U21HuSyqnszScRxAqwb50gZLiww82FZ/GbfRXvm/aIS4IK/MlJftSjOiwkZ
 vDOhH8GkEyAqA7l1aevLJIXbJx6c+59ybamFAi7k+5lh1s9hnpq4QS3RmzhfpFmV
 wdFZK0XTF1d/63iQ6/ELAwTJQYQbVnx+D+E2JynIExtAWTDQa4Td54Ox

Hi,

based on the man pages it doesn't seem possible, but maybe I'm missing some=
thing.

I would like to put together a "log --format=3D" which is similar to --onel=
ine,
but where if there's a note for the commit it's marked with e.g. a notebook
symbol. There's %N, but that prints the entire note, so it doesn't work wel=
l
with one commit per line.

E.g. something like this, where Taylor's commit does not have a note, but m=
ine do:

eb12efd995 2024-10-08 Bence Ferdin.. remote set-head: refactor for readabil=
ity =F0=9F=93=93
a189f4e077 2024-09-28 Bence Ferdin.. refs: atomically record overwritten re=
f in update_symref =F0=9F=93=93
ae0b28db8c 2024-10-19 Bence Ferdin.. t/t5505-remote: set default branch to =
main =F0=9F=93=93
15030f9556 2024-10-15 Taylor Blau    The second batch

Is there a way to do this now? If not, maybe a "%N?" might be a nice additi=
on?

Thanks,
Bence

--=20
bence.ferdinandy.com

