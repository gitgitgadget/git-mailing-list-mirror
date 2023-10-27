Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E544199A7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FAC2
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:53:40 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 1433820092;
	Fri, 27 Oct 2023 11:53:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwP9S-hfE-00; Fri, 27 Oct 2023 17:53:34 +0200
Date: Fri, 27 Oct 2023 17:53:34 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZTvc/tPGxREyq17J@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <ZTuYjzOfG0y27Sho@ugly>
 <d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>

On Fri, Oct 27, 2023 at 02:17:02PM +0100, Phillip Wood wrote:
>On 27/10/2023 12:01, Oswald Buddenhagen wrote:
>> On Fri, Oct 27, 2023 at 11:25:41AM +0200, Patrick Steinhardt wrote:
>>> +    export GIT_PROVE_OPTS="--timer --jobs $(nproc)"
>>> +    export GIT_TEST_OPTS="--verbose-log -x"
>>>
>> fwiw (as this is again only copied), export with assignment is a 
>> bash-ism
>
>Not according to 
>https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#export
>
hmm, it's there since at least SUSv1, aka XPG4v2, in 1994. i didn't 
bother digging deeper.

>It is true that in our test suite we separate a variable assignment 
>when exporting. Presumably that is because someone reported that their 
>shell did not support the "export name=WORD" syntax in the past.
>
most likely it's just a historical default, not the result of a specific 
bug report. the assumption that it's bash-specific is wide-spread.

>As we're already using this syntax with the same docker images in 
>Github Actions I think we can assume it is safe here.
>
i guess so. docker seems a tad unlikely to run some ancient bourne 
shells ...

regards
