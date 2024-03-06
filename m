Received: from ra.horus-it.com (ra.horus-it.com [65.108.3.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368F1369B7
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.3.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745915; cv=none; b=HxZ1n73mvQ+gn0wDBVUAflpbGhDjf3CgJVWd4hxO8xfTa7XEewU6DRMMGDGMu14CI/PJmrr+7Uj83LAx4DzZnfN+yy715qfyD0KOBuFDzcCflqlGAe2zg2Dn3oY8HlLYyJ3Wx8NHfFRHgaFmFFTYxQCwluTtxk173+dGuzWP/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745915; c=relaxed/simple;
	bh=HnRV/1NlT0mT3C/rGLa5QJ6UND0ilB1wDA0CPF7/KBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/9/zKEG3jStYIkN1/2GAFIUQi4FFPHyu+KNLgECz5qr4WtQL9XHrCedOFVKdzaHN/aAWxlvFnTchUdBuJgCbcNjqvQ0W4cjfxMkqYR6rU2fokTfPzOr+MrfBIqsXkhRPnDL4H01e8xPOpROSEmmztmMfU5b956qzaKRgooP+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de; spf=pass smtp.mailfrom=seichter.de; dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b=ast9Kip3; arc=none smtp.client-ip=65.108.3.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seichter.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seichter.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seichter.de header.i=@seichter.de header.b="ast9Kip3"
Received: from localhost (localhost [127.0.0.1])
	by ra.horus-it.com (Postfix) with ESMTP id DE044BE0038;
	Wed,  6 Mar 2024 18:24:59 +0100 (CET)
X-Virus-Scanned: at horus-it.com
Received: from [IPV6:2003:e2:d711:e600:65d5:d70:a603:789d] (p200300e2d711e60065d50d70a603789d.dip0.t-ipconnect.de [IPv6:2003:e2:d711:e600:65d5:d70:a603:789d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "Ralph Seichter", Issuer "HORUS-IT Ralph Seichter - Primary Client CA" (verified OK))
	by ra.horus-it.com (Postfix) with ESMTPSA id 87D00BE002A;
	Wed,  6 Mar 2024 18:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seichter.de; s=k23;
	t=1709745899; bh=be2MmisGgNPxEjpo+NaKKQtScVuwWmcOGoUFX5yngfE=;
	h=Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type;
	b=ast9Kip3NlmFiCSqyys2OPcMf9Nlm3DINPKLcB3B2+mDEmLkS1CIZwlp9ZCgm8Icw
	 k+SMP8omnVZYJp4sUkEC3XKoblHZHIA1md2mOXT/BRAF8nnzsqsNLBDem8uPo3oD2U
	 KPc1oj/YszRc+dN/vsWoIKNn8O+DYhD6vTbJmYFNw9VsVUbbbp95GhVMd21uiJDCAx
	 byxR2yV9jRNSzXorlJQBg0OMTg8Wgp0DdaZAJJJagNLOHAJdBG7QaqAQMlejZTnc+p
	 LMCxjGW4sRG4/zOm2H9t4CuHX4ZW/5pJ6kIZZdJC1PfRd1h1jh3Crow6TR0/hDW1zq
	 IuTP+TGZuV50Q==
Message-ID: <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
Date: Wed, 6 Mar 2024 18:24:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Allow git-config to append a comment
To: Junio C Hamano <gitster@pobox.com>,
 Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <xmqqttljtkn4.fsf@gitster.g>
Content-Language: en-GB
From: Ralph Seichter <github@seichter.de>
In-Reply-To: <xmqqttljtkn4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

* Junio C Hamano:

 > Make sure your title will mix well in "git shortlog --no-merges"
 > output from recent commits by other contributors.

Thank you for your in-depth comment. This is the first time I have
ever considered contributing to Git, so I have a lot to learn. My pull
request [1] on GitGitGadget has been approved by Johannes Schindelin,
by the way, and the PR is based on an issue Johannes created [2] after
a brief discussion him and I had on Discord [3]. I have updated the
subject line, as you suggested.

   [1] https://github.com/gitgitgadget/git/pull/1681
   [2] https://github.com/gitgitgadget/git/issues/1680
   [3] https://discord.com/channels/1042895022950994071/1213052410281467906

I don't know if it is the polite thing to ask you to please refer to
the information I linked, or if I should duplicate the information
here? The short version is that I need to be able to distinguish
between config entries made by automation (like scripts, or Ansible
in my particular case) and those made by a human.

 >> git config --comment "I changed this. --A. Script" \
 >>   --add safe.directory /home/alice/somerepo.git
 >
 > If you are illustrating a sample input, please also explain what
 > output it produces. What do the resulting lines in the config file
 > look like after you run this command?

The result of running the above command looks as follows:

   [safe]
	directory = /home/alice/somerepo.git #I changed this. --A. Script

 > Why are you adding "# comment" to your config file? Who reads these
 > comments, with what tool, and for what purpose?

I mentioned human-readable comments in the patch, and humans are
indeed the intended audience. If a human finds changes made to a Git
config file, and a comment states that the modification was e.g. made
by automation, it adds beneficial information for said human. I can for
example create a comment with a URL pointing to a website providing
additional explanations.

 > Now how do we find out about this comment? "git config -l" would
 > not give us that. Are we expected to look at it in our editor or
 > pager?

Yes. I routinely use cat/vim to inspect/modify my Git config
files. They are suitable for human consumption, after all. Also,
comments can already be manually added in creative ways, and are
ignored when Git reads config data. Comments being read only by
humans is pretty much their whole point, in my opinion.

 > Can we come up with a code that reliably decides when to remove the
 > first comment we see above?

Your examples about difficulties removing comments hinge on there
being multiline comments, as far as I can tell. My patch only supports
single-line comments, and only as a suffix to newly added key-value
pairs. This is a deliberate design choice.

 > The above is an illustration of what I want to see the author, who
 > comes up with this "wouldn't it be wonderful to teach git-config to
 > add comment?" idea, thinks through. The first patch might be to
 > just add a comment when a variable=value is added, but we want to
 > see the vision of how the whole end-user experience should look
 > like, in which this first small piece will fit.

I don't have a greater vision for comments. Their use is to provide
information for humans, no more, no less. There is also no idea of a
user experience beyond pager/editor in my mind. The patch addresses
specific needs of mine, and Johannes suggested it as a new feature,
and that's all the motivation behind it.

 > And the amount of the change required for that tiny bit of
 > "improvement" (if we can call it, which is dubious) does not seem
 > worth it.

As I mentioned in my PR, it also does not seem elegant to me to modify
so many files. Alas, C does not offer expanding function signatures by
adding parameters with default values, like Python does. Adding a new
function like, perhaps, git_config_set_in_file_gently_with_comment()
could be a remedy?

-Ralph
