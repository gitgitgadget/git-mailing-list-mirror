Received: from mail.kocurkovo.cz (mail.kocurkovo.cz [37.205.10.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80029CE1
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.10.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763331668; cv=none; b=bhCnIlcttkZt1V/jh4ZA8J5Vl13aPG11mOO4fX9iJgrxDdquDCFb4Y3lqfyAxXQfwIL5l6PcgEflttj+4UDKMnYPzQOhyXtVkPAQX+We8YfdBszdCazfqLPZgNWQSFF29dgfIIkq6mpcqcBarEWEX+j1IRBPO9+ArwHz4Y9TALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763331668; c=relaxed/simple;
	bh=5yr7hvrNHzrTNjg52a+0KLPWc4iRmNKmeZauo6bnsEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoB8P6JLc0lk/wrLB5D7rhHW/yq+kj1R+gWWnP55pS8hfIeVDSpzooVWiCrf+rgvnj0rP0BsxyxQpaMx/P+6CfUjtjjdI6DqQyPF15SHGcqY+6hts9ABd5iTzQ/KOZnMCHn+LKTp6O3sPbF3nmMXuJdFQPFjPdTPvLYxi7mjhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kocurkovo.cz; spf=pass smtp.mailfrom=kocurkovo.cz; dkim=pass (2048-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b=K8jv3kFB; arc=none smtp.client-ip=37.205.10.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kocurkovo.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kocurkovo.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="K8jv3kFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kocurkovo.cz; s=mail;
	t=1763331163; bh=5yr7hvrNHzrTNjg52a+0KLPWc4iRmNKmeZauo6bnsEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8jv3kFBhHf7zp3Cez/tobQmTc1uRfnCnO+tlS7h+uXj/sRN/DykQGPiUL8OValMc
	 G37RZXkdaL4OB62hrddjoWXT44/KR3OzUsBbbtbVQc5icuqr3cRsp9l81YP/VW3Lmg
	 zv/tzGSfPDsJ+IVOMQZLAWXGbRYlb8/GuyZFiRs2C9UBPOdi+FmSWGpUi61i6vbOBv
	 ZUgpxH0hwmdyJEA4j/W92oblIzECGLx2jAqI3vCoikumN5+Xz/9LQmCCPdNJSnthrK
	 aOIY3BYHPiPZOFMZKqoMo1kxECFuWbWNfloBqqAmWRePnUHWF9L8/kDOS6GgG9JK3p
	 L0CYFcSaAB4wQ==
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
	id 1D56F17B4; Sun, 16 Nov 2025 23:12:43 +0100 (CET)
Date: Sun, 16 Nov 2025 23:12:43 +0100
From: Matej Dujava <mdujava@kocurkovo.cz>
To: ZheNing Hu <adlternative@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <aRpMW-g_rt4jStnu@kocurkovo.cz>
Mail-Followup-To: Matej Dujava <mdujava@kocurkovo.cz>,
	ZheNing Hu <adlternative@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
 <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>

On Wed, Nov 12, 2025 at 11:58:02PM +0800, ZheNing Hu wrote:
>Phillip Wood <phillip.wood123@gmail.com> 于2025年11月11日周二 22:38写道：
>>
>> On 11/11/2025 13:01, ZheNing Hu wrote:
>> > Phillip Wood <phillip.wood123@gmail.com> 于2025年11月11日周二 00:50写道：
>> >> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
>> >>> From: ZheNing Hu <adlternative@gmail.com>
>> >>>
>> >>>
>> >>>       This patch introduces the --committer option to git-commit, providing:
>> >>>
>> >>>        1. Consistency with the existing --author option
>> >>>        2. A more convenient alternative to environment variables
>> >>>        3. Better support for automated workflows and scripts
>> >>>        4. Improved user experience when managing multiple identities
>> >>
>> >> What's the use case for the same person committing under different
>> >> identities? We already have a config mechanism to set different
>> >> identities for different repositories but I'm struggling to see why
>> >> someone would want to create commits under multiple identities in a
>> >> single repository. For scripts it easy enough to set the relevant
>> >> environment variables if a tool wants to create commits under its own
>> >> identity.
>> >>
>> >
>> > I frequently need to distinguish between different user.name and user.email
>> > configurations on our company's internal GitHub.
>> >
>> > The current problems are:
>> >
>> > When I misconfigure (which happens occasionally), git commit --author only fixes
>> > the author part, I still need to additionally set GIT_COMMITTER_NAME and
>> > GIT_COMMITTER_EMAIL environment variables to fix the committer information
>> > These environment variables are painful to use, requiring manual setup
>> > every time
>>
>> I'm afraid I don't quite follow. If you are amending existing commits to
>> fix them up after you have corrected your configuration then they will
>> have the correct committer automatically when you run "git commit
>> --amend --author=..." to correct the author. If you are committing
>> before you have realized that user.{name,email} are misconfigured then I
>> don't see how "--committer" helps because you have not yet realized
>> anything is wrong.
>>
>

Hi

I use includeIf pattern in a config to separate identities

~/.gitconfig:
```
  [includeIf "gitdir:~/.local/src/personal/"]
      path ~/.gitconfig-personal
  [includeIf "gitdir:~/.local/src/companyA/"]
      path ~/.gitconfig-companyA
  [includeIf "gitdir:~/.local/src/companyB/"]
      path ~/.gitconfig-companyB
```

then each
~/.gitconfig-IDENTITY:
```
  [user]
      name = ...
      email = ...
      signingkey = ...
```

>You're right that after realizing the misconfiguration and correcting the
>repository's user.name and user.email, running `git commit --amend` will
> fix the committer information, but the author remains unchanged. Users
>then need an additional `git commit --amend --author=...` to fix the author,
>which does work but requires an extra step.

For just one commit, after you fix identity (update .git/config or move
project so includeIf uses correct config) then `git commit --amend
--reset-author` should get right identity for both commiter and author.

>
>I see your point that this becomes more cumbersome when dealing with
>multiple commits. In such cases, users currently need to use something like:
>
>```
>GIT_AUTHOR_NAME="..." GIT_AUTHOR_EMAIL="..." \
>GIT_COMMITTER_NAME="..." GIT_COMMITTER_EMAIL="..." \
>git rebase -f <target>
>```

In my test ^ (using 2.51.2) did not set specified AUTHOR identity, but
using:

   git rebase <target> -fx "git commit --amend --no-edit --reset-author"

is close to rewriting commits with new identity, but this will change
both dates (committer, author). 

If --reset-author is not used but either GIT_AUTHOR_* are exported or
--author '...' is used in a -x arg, then author date is kept untouched.

>
>This is indeed tedious and error-prone, especially when you want
>to quickly fix and push commits to the platform.
>
>`git commit --amend --author --committer` or a new `git rebase
>--author --committer`
>would provide a more user-friendly workflow for correcting identity
>information after misconfiguration, eliminating the need to manually
>set multiple
>environment variables or run multiple commands.
>
>> Thanks
>>
>> Phillip
>>
>
>Thanks
>
>ZheNing Hu
>

--
Thanks,
Matej
