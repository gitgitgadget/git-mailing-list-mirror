Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF549482A
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045470; cv=none; b=jw8EN+pGMKv7nYxTo7cwOOUBKJaMw9ENepEiIX1Elk9eGlppyGfpxygt5builc06AFR0Wy89/Zs7lx2zSSfSV6esmVOHvqlcKbLFY8Qxr7Rw0OTdxoidoz7fT4nDCDlxoBBqYj8a2aV3xHtcfbuyT+yXyIYZxfpANNjsIHE61Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045470; c=relaxed/simple;
	bh=U+fJjn3gcTla+XPIOfJPtcYeep3RmI5HLpzjdLk6Vf8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=mhEuS7HTSBlMDu9NhbS26WcA6tAYXVc51YdQJbJihgmpkNl+YcXd7U04m5mDnFzxufL7mv0/yAcTtpPGpo53oUewLlsRfckDURafIjvo1tSUNlF8eBKN+8Gupvxuzs12hVzFFXVfhqI3BSL/Z43dfBdAmQ0zFyiojxPCHT3MCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD7klpsc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD7klpsc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5d6f35c1so212125885a.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786045467; x=1786650267; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPRd0pxiuBt4+9q97U6vGmhgbpgz8ylFoad2LMVXUrc=;
        b=XD7klpscgQWHl9wNgjfjOhqJpoXYVkRAUcJBU3nDA4iJl0q5McAN5o8z9YemPRiHAs
         TFm2R3Uj9MS3tUadVbq+Jr7BuEdrNIKWq9OVclK3DqgJo48/kAxYkf/4kPsdTQC9VgyJ
         2OlH+ViyCTKtQpXKlVsrqHvJTLBc3n67C4NlsI6XfJ420+vPLNjJ3aN/I+LnV4NtqA/7
         DPdiNS6dztOGl1CvJXZzxzlngO/sylB+H2Ngo7H895H/fiPc7fkQQA9V6cxEXFzztw5P
         PWJl+/RW+V2w6zjuVh4XDH8nZBN1Q+LT5eSNYsy2frKWZ1CXbdHXSKH7yveMRUt2pBoM
         uFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045467; x=1786650267;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:content-type:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GPRd0pxiuBt4+9q97U6vGmhgbpgz8ylFoad2LMVXUrc=;
        b=VG6Jx9DYIjxiwsL2WB3CjStHgYrvlSDnJ6taxb6i1D1zojdI1ls7Hy6QeXNwjMYKrS
         huFLKN6G9n/7yv8Xp4SLeVkoSVOdUsh1AkqFchasTNgx55LEc8nS9piEqbTuZhaz/bcX
         7504TBUab9SKG2MNIjsQXDEWaf6TYDC4oCJr5YtYD0wiuyW7uxUCm7pCoFAcXVE7EEWI
         R6a6XLKuZPYFiU4tZSDM5BWwtZndIAK60K8zxZpX91RTnDRUm6fTq2g8VzEv77Pg7zem
         AJUZVh3OBGDOPTtk2zZ3LUUnRYI/P2D8NvmxypTplGik+ybBThRrfdDy+Wo2CX2pvl2b
         n8dA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+zFd9iKRYM+jGs248tMZMhTB7TsDtlljAJmZliP5hAMq3RjgwQtIy1FSxTdYT3m8kNWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrw/3ZlSQusaJ3Vt9knyJnCdB49bpmF/p/5GYsSShFT0BY1oJ
	DoeQp/6j2OokuL2/XPMJNz7a/2yvmdzOUBl/r6AoU7gQXbe//NxK+x1n
X-Gm-Gg: AR+sD117qPPmPbn7HC2qzB16/qVXxceBDU1q2sQZJ6MQyChZNnNGJclSLQzn3E3dqvQ
	NBFy3Llort0zJ+3/VEtyHXD8NaRMIULqLPGv5RWsB/hhetX0h/6JDWngXKzXAHeUIpJBIChk3mC
	HHP6ACAqtOn1z2zs1qj18SbZnl5TnCjduJ2b1B2ieILiUWwZUlcyx1lbp4F779WrvRDSLewzdLH
	pl3JshY0Cb+fboCk1O8QoVnVll6eDP1mpPDfMgfoNX7Ilk4gqboFLL/GamSZWnLettUHRXsoFsU
	9jiHZaEygZSk8cQds/NIB5i2/PINj7h/ZUPIS5VHJjFYotxA+GZgI0sBcWRjG8I9qTQGDYh5iqX
	xsVdszxogPiudjdmYC+UWKaVja/HuY+KqOKdYzFkpA9l4bbHTANo/rvCpD225OH0n4U/M69zFPg
	mmQJhIbdHfRSkPobkcTh1yeKPZQ8B6yrv7m6jZrDu00YD+kbrrDK+dSlwGymH4AyOccXmn413C9
	nTrU/o/wneW0Kq/hHgD8VqgYBA=
X-Received: by 2002:a05:620a:28c7:b0:936:6911:38ed with SMTP id af79cd13be357-93669113909mr264184685a.0.1786045467210;
        Thu, 06 Aug 2026 12:44:27 -0700 (PDT)
Received: from smtpclient.apple ([204.48.93.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936582d9eb5sm320520085a.34.2026.08.06.12.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:44:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 6 Aug 2026 15:44:25 -0400
Subject: [BUG] "commit graph is likely corrupt" on git rebase
Message-Id: <4983BE1D-4099-4CAF-9374-459F7913982A@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git mailing list <git@vger.kernel.org>
To: flosch@nutanix.com
X-Mailer: iPhone Mail (22C152)

Hi Florian,

Florian Schmidt <flosch@nutanix.com> wrote:
> Hiya,
>=20
> Hitting an issue during git rebase. I am starting to suspect git is=20
> possibly getting confused between main and submodule repos. I noticed=20
> this with a self-compiled git 2.54, but I compiled git v2.55 just now,=20
> and seem to hit the same issue still. Full bisect at the end of the messag=
e.
>=20
> The first-order issue, trying to rebase a work/foo branch which is=20
> tracking origin/master.  There's only one commit difference, a commit=20
> that changes two submodule pointers:
>=20
>> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git show --format=3D"" -p
>> diff --git a/rpmsrc/kernel b/rpmsrc/kernel
>> index d8d411244..17006b605 160000
>> --- a/rpmsrc/kernel
>> +++ b/rpmsrc/kernel
>> @@ -1 +1 @@
>> -Subproject commit d8d411244cfb3463ce09b9577970f7955073ed14
>> +Subproject commit 17006b605eaed1820ae1c717d4782728b9afc6d3
>> diff --git a/rpmsrc/qemu-kvm b/rpmsrc/qemu-kvm
>> index e7d525d0f..8bf4019df 160000
>> --- a/rpmsrc/qemu-kvm
>> +++ b/rpmsrc/qemu-kvm
>> @@ -1 +1 @@
>> -Subproject commit e7d525d0fdc42fca65c2b70bb5f56adc5aa1d7b1
>> +Subproject commit 8bf4019dfcb320108a0f014d92d926320a4c8058
>>=20
>> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git rebase
>> error: Could not read 157b7492624beac3ac667dd3a84de9969377866b
>> fatal: invalid commit position. commit-graph is likely corrupt
>>=20
>> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git cat-file -t 157b7492624beac=
3ac667dd3a84de9969377866b
>> fatal: git cat-file: could not get object info
>=20
> git fsck reported no corruption, just a bunch of dangling=20
> commits/trees/blobs, no warnings about=20
> 157b7492624beac3ac667dd3a84de9969377866b
>=20
> Now, hint 1: the rebase *does* work when disabling commit-graphs:
>=20
>> devvm:~/gitrepo[git:work/foo *%|u+1-116]$ git -c core.commitGraph=3Dfalse=
 rebase origin/master
>> Rebasing (1/1)
>> [... thinking thinking thinking for a long time ...]
>> Failed to merge submodule rpmsrc/kernel
>> CONFLICT (submodule): Merge conflict in rpmsrc/kernel
>> Failed to merge submodule rpmsrc/qemu-kvm
>> CONFLICT (submodule): Merge conflict in rpmsrc/qemu-kvm
>> [...]
>=20
> which is fair enough, the submodule pointers moved.
> And hint 2:
>=20
>> $ git cat-file -t 157b7492624beac3ac667dd3a84de9969377866b
>> fatal: git cat-file: could not get object info
>> $ git -C rpmsrc/kernel cat-file -t 157b7492624beac3ac667dd3a84de996937786=
6b
>> fatal: git cat-file: could not get object info
>> $ git -C rpmsrc/qemu-kvm cat-file -t 157b7492624beac3ac667dd3a84de9969377=
866b
>> commit
>=20
> So it tries to identify something on the submodule? Maybe it gets=20
> confused between submodule and main repo(?)
>=20
> For good measure, I did a git fsck --full on rpmsrc/qemu-kvm, but again=20=

> only a few dangling warnings, and no change to the issue.
> So I went to bisect and noticed the issue appeared somewhere between=20
> v2.53 and v2.54. v2.53 also complains, but then continues:
>=20
>> $ ~/upstream/git/git rebase
>> error: Could not read 157b7492624beac3ac667dd3a84de9969377866b
>> error: Could not read 95d676ad199191d81a000761733ea25c17172d8b
>> Failed to merge submodule rpmsrc/kernel (commits don't follow merge-base)=

>> CONFLICT (submodule): Merge conflict in rpmsrc/kernel
>> Failed to merge submodule rpmsrc/qemu-kvm (commits don't follow merge-bas=
e)
>> CONFLICT (submodule): Merge conflict in rpmsrc/qemu-kvm
>> [...]
>=20
> In any case, to figure out the cause, I bisected it down to commit=20
> bb5da75d61 ("commit: use commit graph in=20
> `lookup_commit_reference_gently()`"), which makes sense in the context=20
> of "it works with commit-graph disabled".

It=E2=80=99s usually a good idea to CC the commit author when you bisect a r=
egression (I=E2=80=99ve CC=E2=80=99d Patrick)


> At this point, I wonder what the best next step is. I notice that there=20=

> are two errors listed even when the "git rebase" works on v2.53.0, which=20=

> are not there in the commitGraph=3Dfalse case. I wonder whether that's a=20=

> sign that something deeper is not as it should be. I'm happy to provide=20=

> more details as needed, but I didn't want to touch the repo at this=20
> point and possibly lose the repro.

A good next step would be to try to write a from-scratch reproducer :)

Cheers,

Philippe.=20=
