Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067685642
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818180; cv=none; b=JN2NjjOFo97urAyuJ1S2AWlgQer6lWlP6OjP3JmH5r6r+sEo+8SHVlO5Z1CCI9JcJwhqNvzw0C/6sAe1LeSMH8vU60aIh/8BZx+PJPYNPmZ6qEqZqYaTk3Jk/zAECBKv+z2HlZnzrgUrGPF9XTl7kFUwg+Ziuvn4DsBSGvW8PmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818180; c=relaxed/simple;
	bh=DG8aXXFkAUKB2bv6+2G7m6V6/CXbnMRvNKpYZ1kv/cE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ar267Aifwh62BA9lduZrFngWA0gF9+2vIrmP61F26/1JMviVEGV2vL3XRaNdrqr/j0lWGzFl08CD9Rr4nVBw7mC7P2upPHMRNwd4HmwY7oLTABjwpbzXL8p8gX1ynI19hPGN07C2M1Ok/BKyL8HMI2vf1XchC+Mc42HGK4ZiTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 411K1Mo01582340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 20:01:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Hans Meiser'" <brille1@hotmail.com>
Cc: "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>,
        <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM> <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM> <20240201-primitive-aardwark-of-contentment-aaabb9@lemur> <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM> <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org> <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM> <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
In-Reply-To: <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
Subject: RE: Migrate away from vger to GitHub or (on-premise) GitLab?
Date: Thu, 1 Feb 2024 15:01:17 -0500
Organization: Nexbridge Inc.
Message-ID: <060d01da5549$6e93e250$4bbba6f0$@nexbridge.com>
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
Thread-Index: AQMTzlW4975feouBsT254Lv1BIoWdQGhQd7aAVNiZS8BbXS0WQGm69duAVRHZx4B89kghK44awdw

On Thursday, February 1, 2024 2:00 PM, Dragan Simic wrote:
>On 2024-02-01 19:36, Hans Meiser wrote:
>>> Could you, please, clarify what kind of git documentation are you
>>> referring to?  Are you having git man pages in mind?
>>
>> Yes, these in particular.
>>
>> From my point of view, many of these are quite unorganized, hard to
>> read and =E2=80=93 as I believe =E2=80=93 need a fix-up. Markdown =
could replace the
>> currently used language, so editing them would be more easy, proving
>> support for preview and lint the documentation.
>
>Please keep in mind that editing the git man pages requires very =
intimate knowledge
>of the related git source code.  Many times even small changes to the =
language style
>can change the meaning and diverge the man pages from the source code, =
making
>the man pages useless.
>
>>> Quite frankly, I think you've missed some important points from the
>>> Konstantin's message.  To sum it up a bit, not having continuous
>>> support is simply unacceptable for any kind of a long-term project.
>>
>> As I wrote, once installed on-premise, no-one will shut down an
>> on-premise git server except for yourself. It can run for eternity.
>> You just need someone to administer it properly and publish the
>> website.
>
>A git server?  I was under impression that you proposed running an own =
instance of
>GitLab or something similar.

Git is unique, as a project, given that everything (! Not everything but =
a whole lot) is managed using git, including the enterprise git server =
platforms.

A huge advantage of using a git server is being able to mirror the =
repository. If we went with a GitLab host, we could potentially mirror =
over to GitHub. The drawback is that the pull request history (and =
related discussions) id not (currently) preserved. I think this is a =
situation no matter what, even if we go GitLab/GitLab or GitHub/GitHub. =
The value of the discussion threads is the most important part of what =
needs to be preserved. I have high confidence that the team could move =
to either Pull Request/Merge Request structure reasonably easily, but if =
we had to move again in future (count on it), there must be a way to =
preserve the community assets of the discussions that went into making =
decisions. Without that, I am concerned that a migration to a GitLab (or =
any other) instance would increase velocity but put long term decisions =
at risk.

>> In the end, it's all just about git. You may create your own git
>> webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
>> or just use an existing one, like the GitLab server:
>> https://about.gitlab.com/install/
>>
>> In these servers, everything is configurable. Moreover, many plug-ins
>> exist for plumbing extensions to these providers. It's possible to
>> establish your own workflow, rights management and automatic =
handling.
>> You just need someone who is an expert with the tool of your choice.
>>
>> Many other great repositories already are using one of those
>> providers; Meta, Google, Microsoft for example share their code there
>> =E2=80=93 just to name a few. I wouldn't consider these users as =
being known
>> for being exceptional risk-takers.

--Randall

