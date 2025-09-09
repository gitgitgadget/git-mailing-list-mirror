Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5300350D45
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434677; cv=pass; b=P80vv0O/7ZA1T/KdhZ6iQ4DzGigs+ulVNyAWPlsvbcGsgTxuNH+Gn0dEDUOWHooYTMMqvuZ+3o9iAVJPiISuKYGFsV3QdTKDa2XJO5TI9LniAoxmj3uQ+ZUIU9WKAME8WBTECMdXOpL1Us4dOSy+dWYZOB0IHlssg2yl0Anp12A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434677; c=relaxed/simple;
	bh=qmqSaxMO8m9Lms+BLxc35ID5D0sqNKEajsgBiRwpR+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocMs/2uQeQdgrTUKgfMG5t3kkcevSmqDaK3TnJwNyemEVE/uTN+lfDWxh0gbExkMEb1uOxRcVoBvxLQURxLUcZTGCDgBxrS/GjaQDRF3RtPmSwrTgmB49+3kS/flHPscoZP5wy2YY+t8rLiCf5m3Jk5WJ6+SysOZ2NphQUBC6gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ZPg5FxHy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ZPg5FxHy"
ARC-Seal: i=1; a=rsa-sha256; t=1757434657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z55YWl3L5858zuT4vLO9Ai9lWDs6Y+Wm1Tl5rvj+Tcub+SMY/MgSW8J41ELJTLalCv0zousxapoOl7nw6izUXrpAC5RzDZHU0kXmxSMHD8phoDiq9i34D4n0VrdKV2uFCTI3BjkDufM8WsjkXkT5ctHE3Cczw+/GYte9hgRjOzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757434657; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Brj0J4jI+ESzQryZzrX+GQtCiMF99oiZFHjkybTbANc=; 
	b=n0XHSixBdNAxch8OM6aWGDx9jDk08OmAcn7maX1PvfcuaIGFwFM1rgBrUKC4jHzLrlCIwZu63QhlAO3gQ4r1RewQcQJxu7B5D8QIaFqkZySO4NlERxaBpN/AR0sCe3dLLRwe5w6CfdtVHusS3tbDkLZ5iKALW6MG4LWWbHhrtwc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757434657;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Brj0J4jI+ESzQryZzrX+GQtCiMF99oiZFHjkybTbANc=;
	b=ZPg5FxHyrfLGcMb8S7UkkijyQuJfGr2qesL5foYQnqf+bF4pSGvpBW1pPrrvaPug
	+tfEZI5OcPMjxsvd7/nODprv1+sE7/Kri+LR4SNPp0e8rRGItUFpADL2Jlu8i0Drl4L
	EO279LX/Qz1A6lXlN+kwKLvmEYxiNHYcYoC0fU54=
Received: by mx.zohomail.com with SMTPS id 1757434656234642.6752967867909;
	Tue, 9 Sep 2025 09:17:36 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 02/10] submodule: create new gitdirs under submodules
 path
In-Reply-To: <aL_Z6z1XZBEbNGV1@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-3-adrian.ratiu@collabora.com>
 <aL_Z6z1XZBEbNGV1@pks.im>
Date: Tue, 09 Sep 2025 19:17:31 +0300
Message-ID: <87ecsf7g84.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Patrick and thank you for the feedback! o/

On Tue, 09 Sep 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Sep 08, 2025 at 05:01:09PM +0300, Adrian Ratiu wrote: 
>> This is in preparation for encoding the submodule names to 
>> avoid conflicts like submodules named foo and foo/bar together 
>> with case-insensitive file- system handling and other corner 
>> cases like reserved filenames on Windows.   Backward 
>> compatibility is kept with plain-name modules already existing 
>> at paths like .git/modules/<name>, however a clear separation 
>> between legacy (plain) and new (encoded) namespaces is 
>> desirable, to avoid situations like an existing plain-name 
>> module containing the encoding escape character/  Thus we split 
>> the new-style (encoded) gitdir name paths to .git/submodules, 
>> while legacy-style paths remain under .git/modules.   This is 
>> just a default directory change with the accompanying test 
>> updates, in preparation for the actual encoding additions in 
>> future commits. 
> 
> One of the questions here is how this move will affect alternate 
> implementations of Git, like libgit2, JGit or Gitoxide. There's 
> two angles to this: 
> 
>   - Git needs to handle that those implementations continue to 
>   write 
>     submodules into ".git/modules". 
> 
>   - These implementations need to be able to handle the 
>   new-style paths. 
> 
> The first item should work just fine, as we make sure that we 
> handle both paths. But do the other implementations need any 
> adjustment? I guess the answer is "yes", so we need to treat 
> this as a backwards incompatible change as they wouldn't be able 
> to find the submodule repositories anymore, right?

That is correct and also applies to older versions git itself 
which do not have this mechanism. Phillip Wood suggested we add an 
extension like "extensions.submoduleEncoding" (name suggestions 
welcome).

I'll do that in v3 of this series.
 
> 
> Ideally, the way that submodules were populated was less 
> fragile. For example, we could have a "submodule.*.repoPath" 
> config key that gets populated whenever we clone a submodule. If 
> Git clients knew to use that field they wouldn't have to 
> second-guess where a previous Git client stored a specific 
> submodule, but they could just read that path and then use 
> whatever is stored therein. This would even allow for changes 
> like using a hash to encode the submodule name.

Slight tangent (I'll respond to your point after this):

Junio asked to please keep the name human-readable and that's why 
we use url-encoding which is also widely known and well 
understood.

I guess we could add a config to change the name encoding or 
hashing mechanism while keeping url-encoding as the 
default. Likely in a later series because this one is big enough 
now at 10 patches and keeps growing. 

One of my Collabora collegues even suggested they would like to 
use a pattern like "hash_name" to get the best of both worlds.
 
> 
> But to the best of my knowledge such a key does not currently 
> exist, which is too bad (please correct me if I'm wrong, I'm 
> definitely not an expert when it comes to submodules). 

No, it does not exist. I've added something a little bit similar 
with the gitdir path config option in this series, however it is 
only used to override default paths computed by git-submodule, 
when necessary. 

There is also a config clutter problem, if such a key were to be 
added by default, since most submodules use default paths.

Phillip had the idea to only compute the path once, during the 
initial submodule clone, then reuse it from the .git file inside 
the submodule workdir in later actions, however that is not enough 
for compatibility with other implementations or older versions.

So yes, to avoid user confusion, multi-implementation 
inter-operability problems or risk any repo inconsistency, I'll 
make it a breaking change.
