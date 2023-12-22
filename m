Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30C20310
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="TS3dUrFL";
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="bZdUEKCS"
Received: from localhost (7of9.are-b.org [127.0.0.1])
	by 7of9.schinagl.nl (Postfix) with ESMTP id 6C1BE196BF72;
	Fri, 22 Dec 2023 15:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1703254002; bh=MW7hXdEZOP7sI1PxGmlLM1rRjGTycJ76Yi5q7kQQwsE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=TS3dUrFLW86+l6gTKuSxYUHDNVSO6QRyp9dug7Zw/6AeeiXmHRpp4WkG0yv5Etpoo
	 qckxeYCR/FhEbOTbt6E44qzpV8TSicfsqByBtWWtYt1iigNAHOM5ZuF6h60mf3OqPE
	 S5RKVEcalZCeUpXDa6vVu+Pk9Q4Xb9Knf9O/+ylU=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s27GZJWVFRhi; Fri, 22 Dec 2023 15:06:41 +0100 (CET)
Received: from [127.0.0.1] (188-207-108-162.mobile.kpn.net [188.207.108.162])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 11422196BF6D;
	Fri, 22 Dec 2023 15:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1703254001; bh=MW7hXdEZOP7sI1PxGmlLM1rRjGTycJ76Yi5q7kQQwsE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=bZdUEKCS1Js3oUUHySUpG1pNG2N0NaucJZms1jDAv9Gqxlo5+kO+DvIV9XMOHCTuK
	 FZrSjBJXe9grSv74wqk0BnGk4Ep6+PyHsCcMKuZMMt4t45AJ2Maq6wG8/gNsK7tq4w
	 2eba/2Q5JcbhHujJ9IBKwu3p7tPLT8+bTzzqKNUc=
Date: Fri, 22 Dec 2023 15:06:08 +0100
From: Olliver Schinagl <oliver@schinagl.nl>
To: Patrick Steinhardt <ps@pks.im>
CC: git@vger.kernel.org, gitster@pobox.com,
 =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
 psteinhardt@gitlab.com
Subject: Re: Git mirror at gitlab
User-Agent: K-9 Mail for Android
In-Reply-To: <ZYQl_G-S4vQibHWn@framework>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl> <ZYQl_G-S4vQibHWn@framework>
Message-ID: <1D1CDDF3-E0D2-4059-9C9A-796145AB6E24@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Patrick,

On December 21, 2023 12:48:12=E2=80=AFp=2Em=2E GMT+01:00, Patrick Steinhar=
dt <ps@pks=2Eim> wrote:
>On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
>> Hey list,
>>=20
>> For years, I wanted (tried, but time) to run the mirror for git on gitl=
ab=2E
>> Actually, the original idea was to run a docker container ([0] 10k+ pul=
ls
>> :p)
>>=20
>> I initially set this up via docker build containers, where docker hub w=
ould
>> pull my mirror of the git repo=2E My mirror, because I added a Dockerfi=
le
>> which was enough for docker to do its trick=2E I was planning (time =2E=
=2E) on
>> submitting this upstream to the list, but never did=2E Because of me no=
t doing
>> that, I had to manually (I was even too lazy to script it) rebase the
>> branch=2E Docker then did some changes to their business, where the doc=
ker
>> builds where not possible anymore=2E
>>=20
>> So then I figured, I'll do the same on gitlab and push it to the docker=
 hub=2E
>> Thus I setup a mirror on gitlab [1], with the idea to work there on it=
=2E
>>=20
>> Again, I never got around to finalize this work, mostly because the doc=
ker
>> container 'just worked' for pretty much everything=2E After all, git is=
 very
>> stable overal=2E
>>=20
>> So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add supp=
ort
>> for GitLab CI") landed, which started to trigger pipeline jobs!
>>=20
>> Sadly, this only worked for 3 builds, as that's when the minutes ran ou=
t :)
>>=20
>> So one, I would very much like to offer the registered names (cause the=
y are
>> pretty nice in name) to here, so people can use and find it=2E
>
>Not to throw a wrench into this, but are you aware of the official
>GitLab mirror at https://gitlab=2Ecom/git-vcs/git? I myself wasn't aware
>of this mirror for a rather long time=2E
Not a wrench at all, and no, I didn't know=2E How old is it though :p coul=
d be that git-vcs was created cause I owned gitscm :)


I had chosen gitscm to match the official site, git-scm=2Eorg=2E the hyphe=
n I left out because afaik it wasn't allowed on docker hub=2E

>
>I also wondered whether we want to have https://gitlab=2Ecom/git/git as w=
e
>do on GitHub=2E I don't think anybody registered it, but it is blocked
>from being registered as far as I can tell=2E Maybe we block the namespac=
e
>out of caution, I dunno=2E I can certainly check in with our SREs in case
>it is something the Git project would like to own=2E
Yeah couldn't figure out who it was either =2E=2E=2E hence gitscm=2E

Sadly gitlab doesn't support aliases :) I'm more then happy to hand over t=
he space=2E Whatever name is decided to be best=2E

>
>> Two, hopefully get Patrick Steinhardt to help out to get unlimited minu=
tes
>> and storage on the repo :)
>
>I'm sure we can do something here, but I'd rather aim to do this for the
>official mirror which currently is the one I mentioned above=2E If the
>project is interested in running builds on GitLab then I'm happy to
>coordinate=2E
>
>Also Cc =C3=86var, who is the current owner of the mirror=2E Would it be
>possible to add myself as a second owner to the project? This might help
>setting up the CI infrastructure=2E But please, if anybody disagrees with
>me being added as an owner here I encourage you to say so=2E
>
>> Three, see what the opinion of people here is on this=2E I'll do the wo=
rk to
>> get the dockerfile (now containerfile, we're inclusive after all) merge=
d,
>> and the CI file updated to create, store (and push to docker hub) the
>> generated containers=2E
>
>I don't really have much of an opinion here and will leave it to others
>to discuss=2E
>
>Thanks!
>
>Patrick
>
>PS: As most other folks I'll be OOO during holidays, so I may only
>    answer sporadically=2E
>
>> Thanks,
>> Olliver
>>=20
>> [0]: https://hub=2Edocker=2Ecom/r/gitscm/git
>> [1]: https://gitlab=2Ecom/gitscm/git
>>=20
>> P=2ES=2E I'm not subscribed, so please keep me in the CC :)
