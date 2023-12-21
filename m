Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D94F60D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="XsNxFcKM"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 6EB50196B307;
	Thu, 21 Dec 2023 12:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1703158202; bh=DgralblSX7jbrbxQ76/ximoU9t59XfN0RDkAJaAV0K0=;
	h=Date:To:From:Subject;
	b=XsNxFcKMpUS/Rmqxa+QPW8Rh9s39PeiOWdY7qnVyHv8pakBCF7nLlM/OaI9Jsl2oD
	 0wPvr4qBMC0XDUPWBPaF24qT90cZljN0eKznbFSH4ry4Y6k8UYSvuYiAGDWOMfUTuc
	 n8TwmADwy2640tDUQqKUICLq8NqLyvzctjp171+s=
Message-ID: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
Date: Thu, 21 Dec 2023 12:30:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl, en-US
To: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Git mirror at gitlab
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey list,

For years, I wanted (tried, but time) to run the mirror for git on 
gitlab. Actually, the original idea was to run a docker container ([0] 
10k+ pulls :p)

I initially set this up via docker build containers, where docker hub 
would pull my mirror of the git repo. My mirror, because I added a 
Dockerfile which was enough for docker to do its trick. I was planning 
(time ..) on submitting this upstream to the list, but never did. 
Because of me not doing that, I had to manually (I was even too lazy to 
script it) rebase the branch. Docker then did some changes to their 
business, where the docker builds where not possible anymore.

So then I figured, I'll do the same on gitlab and push it to the docker 
hub. Thus I setup a mirror on gitlab [1], with the idea to work there on it.

Again, I never got around to finalize this work, mostly because the 
docker container 'just worked' for pretty much everything. After all, 
git is very stable overal.

So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add 
support for GitLab CI") landed, which started to trigger pipeline jobs!

Sadly, this only worked for 3 builds, as that's when the minutes ran out :)

So one, I would very much like to offer the registered names (cause they 
are pretty nice in name) to here, so people can use and find it.

Two, hopefully get Patrick Steinhardt to help out to get unlimited 
minutes and storage on the repo :)

Three, see what the opinion of people here is on this. I'll do the work 
to get the dockerfile (now containerfile, we're inclusive after all) 
merged, and the CI file updated to create, store (and push to docker 
hub) the generated containers.

Thanks,
Olliver

[0]: https://hub.docker.com/r/gitscm/git
[1]: https://gitlab.com/gitscm/git

P.S. I'm not subscribed, so please keep me in the CC :)
