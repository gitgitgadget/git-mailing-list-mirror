Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B6381C1
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67875CE
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:12:19 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id C46F624258;
	Fri, 27 Oct 2023 12:12:17 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwPRZ-i1Q-00; Fri, 27 Oct 2023 18:12:17 +0200
Date: Fri, 27 Oct 2023 18:12:17 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTvhYSMOiaNbpTZ2@ugly>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
 <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>

On Fri, Oct 27, 2023 at 09:14:42AM -0400, Marc Branchaud wrote:
>On 2023-10-25 06:29, Oswald Buddenhagen wrote:
>> The behavior in the presence of multiple "fixup -c" is somewhat
>> questionable, as arguably it would be better to complain about it rather
>> than letting the last instance win. But for the time being we document
>> the status quo, with a note that it is not guaranteed. Note that
>> actually changing it would require --autosquash eliding the superseded
>> uses.
>
>I do not think this kind of editorializing belongs in the commit's 
>message, but this likely isn't the first commit message that expresses 
>an opinion.
>
commmit messages should elaborate alternatives considered, which 
includes ones which depend on changes that can be reasonably expected to 
possibly happen at some point.

>But I think you should remove the "but this should not be relied upon" 
>phrase.  This reads as if Git's current behaviour is undefined, which 
>most definitely is not true.
>
>Even changing this to something like "but this might change in the 
>future" is unhelpful.  Everything in Git is subject to change over a 
>long-enough time span, so the same could be said about every aspect of Git.
>
>Until the behaviour actually changes, it's perfectly fine for people to 
>use multiple "fixup -c" commands.  There's no reason to scare them off 
>of it.
>
things can't change overnight; the resistance even the most trivial 
behavior changes meet is enormous. so explicitly documenting long in 
advance that something is subject to change is basically the only way to 
get it changed at all.

specifically for this feature, there is no reason at all to rely on this 
behavior when hand-editing the todo list, and occurrences most likely 
indicate a mistake, which is why i would prefer it to be rejected.

regards
