Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D263E49D
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7110D7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id DE30320092;
	Tue, 24 Oct 2023 17:19:09 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvOnt-xxk-00; Tue, 24 Oct 2023 23:19:09 +0200
Date: Tue, 24 Oct 2023 23:19:09 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTg0zXkvSQ6L+4Oj@ugly>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com>

On Tue, Oct 24, 2023 at 10:01:07AM -0400, Marc Branchaud wrote:
>I will only say that, I personally don't read man pages from 
>start-to-end like a novel.  I jump to the part that explains the thing 
>I need to learn about.  So I think your assumptions about what context 
>a reader might have in mind when they see this text are invalid.
>
we are speaking about the context of a single paragraph, so that doesn't 
seem like a relevant objection.

>> +The commit message for the folded commit is the concatenation of the
>> +message of the first commit with those of commits identified by "squash"
>
>s/message of the first commit/picked commit's message/
>
that does indeed sound better, but i think it's more confusing (and 
potentially even more so when translated directly). i guess one could 
use "pick'd commit's", but that's kind of ugly again.

>> +commands, omitting those of commits identified by "fixup" commands,
>> +unless "fixup -c" is used. In the latter case, the message is obtained
>> +only from the "fixup -c" commit (having more than one of these is
>> +incorrect).
>
>As Phillip said, this is wrong.  I agree with Phillip that the 
>documentation should reflect the actual implementation, not what we hope 
>the implementation might be some day.
>
there is also the middle ground of making it intentionally vague in 
anticipation of a possible change. my current draft says "if multiple 
are present, the last one takes precedence, but this should not be 
relied upon".

>> +The first commit which contributes to the suggested commit message 
>> also
>
>s/suggested/folded/ -- with "fixup -C" there is no "suggested" message.
>
that's a good point, but i want to emphasize the fact that it's the 
pre-edit message, i.e., that trimming down the squashed message doesn't 
change anything.
anyway, this part will be postponed to another contribution anyway (see 
parallel thread).

thanks
