Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0818F5C
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331521AC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:43:58 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 584DB2074D;
	Fri, 27 Oct 2023 06:43:56 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwKJn-bFk-00; Fri, 27 Oct 2023 12:43:55 +0200
Date: Fri, 27 Oct 2023 12:43:55 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phil@crinan.ddns.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTuUa5bA8dh29cyv@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly>
 <ZTtyHScKkMg4qnMH@tanuki>
 <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>

On Fri, Oct 27, 2023 at 11:22:35AM +0100, Phillip Wood wrote:
>On 27/10/2023 09:17, Patrick Steinhardt wrote:
>>>> +	CI_BRANCH="$CI_COMMIT_REF_NAME"
>>>> +	CI_COMMIT="$CI_COMMIT_SHA"
>>>>
>>> assignments need no quoting to prevent word splitting.
>>> repeats below.
>>>
>>>> +	case "$CI_JOB_IMAGE" in
>>>>
>>> ... as does the selector in case statements.
>> 
>> True, but I'm simply matching the coding style in this script.
>
>I think it is quite common for us to quote variables when it isn't 
>strictly necessary as it makes it clear to anyone reading the script 
>that there is no word splitting going on

>and ensures that we don't start splitting the variable if the contents 
>changes in the future.
>
the point was that it *isn't* content-dependent; it's simply the shell 
rules. of course, many people (apparently you included) don't know these 
subtleties, so just quoting everything isn't the worst idea (though it 
would backfire with some *really* old buggy shells, but this doesn't 
need to concern us).

regards
