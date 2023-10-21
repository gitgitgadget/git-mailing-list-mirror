Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC2111E
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB1D63
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 00:26:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 834AB23E25;
	Sat, 21 Oct 2023 03:26:23 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qu6NK-7Bm-00; Sat, 21 Oct 2023 09:26:22 +0200
Date: Sat, 21 Oct 2023 09:26:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTN9HgqH01iN2CGr@ugly>
References: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
 <841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <841c3b59-9e7c-4492-9d66-8af42c3222ea@xiplink.com>

On Fri, Oct 20, 2023 at 05:40:01PM -0400, Marc Branchaud wrote:
>I think the original text's "those identified by" is a bit vague: Does 
>"those" mean "messages" or "commits"?  The sentence reads like "those" 
>stands for "messages", but then of course you don't identify *messages* 
>with "squash" commands.
>
fair enough, though the repetition makes it linguistically inferior.

>Maybe emphasize the word "only" in the sentence (i.e. spell it as 
>'only'). 
>
that seems excessive to me. i'm not assuming that my readers are dumb.

> To really drive the point home it could say something like
>	obtained 'only' from the "fixup -c" commit, dropping the
>	messages of all the other involved commits
>
as above.

also, i'm actually uneasy about including the exact behavior in the 
first place, as it codifies something questionable - a better response 
from git would be complaining about it. i will drop it.

>> (having more than one "fixup -c" commit
>> +makes no sense, and only the message from the last one is used).
>
>"Makes no sense" seems a bit opinionated (although I agree with the 
>sentiment).
>
i'm not terribly worried about readers who have an aversion towards 
being told facts ...
anyway, i will use "is incorrect" instead, as it seems more to the 
point.

>Also, you can legitimately have more than one "fixup -c" in the overall 
>instruction set, as long as there's at least one "pick" command in 
>between, e.g.
>
yes, but the context is a single fixup sequence. the above comments 
about readers and repetition apply here, too.

>[1] Makes me wonder if rebase should also support "squash -c"...
>
the distinction is that "squash" combines the messages, while "fixup" 
discards them, and the -c merely changes what is discarded. softening 
that up seems counter-productive to me.

thanks
