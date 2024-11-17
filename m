Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E518C2ED
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731857218; cv=none; b=b+qxjnNK3qnATv3k7lqNMotM0aeYjhHDXhCJNHS2fMk0SnmGL79VaPZFFgTJtGcwt8wQKJzp3BKfCCnzSvdN9sSgxm0sw1Mq/W8Gch9Z1+JcM1oGiV1WtAaiSTiWJ69JBYr3tHxQLlGhI6qbh2sdp4Sv5xtjPfg25lfFGcXmGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731857218; c=relaxed/simple;
	bh=16XX0bSDM9Q5s6/cTeK+kWA5OjWhcETquZ+uHNwdXyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYRV3NlO1kvzWTUtIgbWJ755PA1a7F9FFiyill81n5vn+ApiULAtrergkptuM6QScG9saE4vkglDCSuC88VkFobd28o25ggpU+ig7wCItUP9At2p3xWS/oDsI4au9PEoB/jdH7PbAOuQx7CqoH3nPulr5aNgJISNUxIjr5HiIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XrvkC2cd2zRnlK;
	Sun, 17 Nov 2024 16:26:41 +0100 (CET)
Message-ID: <5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org>
Date: Sun, 17 Nov 2024 16:26:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Gitk maintainership, was Re: The health of gitk
Content-Language: en-US
To: Paul Mackerras <paulus@ozlabs.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Beat Bolli <dev+git@drbeat.li>, Tobias Pietzsch <tobias.pietzsch@gmail.com>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
 <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
 <ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
 <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.11.24 um 08:19 schrieb Paul Mackerras:
> On Wed, Nov 13, 2024 at 08:41:42AM +0100, Johannes Schindelin wrote:
>> Hi Hannes,
>>
>> I would like to offer this thread as Exhibit A in support for the case I
>> started making at [GitMerge '24](https://git-merge.com/) to convince you
>> to consider maintaining gitk in addition to Git GUI.
>>
>> Having one maintainer of Git GUI and gitk would make for a quite natural
>> fit, I would think, as both are written in Tcl/Tk, neither is used by the
>> core Git contributors because they are GUI programs, both lower the bar
>> for new Git users because they are GUI programs, and either would be
>> subject for eviction from git/git unless maintained by an active
>> volunteer.
>>
>> From what I see, Git GUI is in real good hands since you took over, I see
>> reports and patches picked up quickly and the style of your replies is
>> refreshingly constructive and friendly.
>>
>> This morning, I woke up to find a new PR in microsoft/git
>> (https://github.com/microsoft/git/issues/704) that cherry-picks the patch
>> that was offered in this here mail list thread. That patch is almost four
>> years old, i.e. just about ready to enter pre-school and to learn how to
>> read and write. Yet apart from Beat's confirmation that it fixes a real
>> bug, this here patch has been treated with silence.
>>
>> Unfortunately, the original GitGitGadget PR had to be locked down and
>> therefore Tobias would not be able to send another iteration even if he
>> wanted to (which I doubt, given the experience on this mailing list).
>>
>> Therefore I see the need not only to revive this thread, but also to look
>> for an active gitk maintainer.
>>
>> May I ask you, now in public, whether you would be potentially open to
>> maintain gitk in addition to Git GUI? If so, I would then start a proper
>> new thread to nominate you officially.
> 
> If Hannes is willing to take this on, I would support that fully and I
> would also be happy to assist.  I know I was extremely slack about
> gitk patches for a long while, but I think I have a little more free
> time now, having retired.
> 
> There is another issue which will need to be sorted out, which is
> whether to persist with a separate tree that gets merged into the git
> repository, or just edit the copy of gitk in the git repository.
> There have been tree-wide patches applied to the git tree which
> affected gitk, meaning that my gitk repository is now out of sync.
> I recently (as in several weeks ago) sent Junio Hamano an email asking
> this question, and asking for his opinion on the best way to proceed
> with gitk patches, but got no reply.

[For some reason, Dscho's original message didn't make it to my mailbox.]

I have given the idea to take maintainership of Gitk ample
consideration, and I would accept the task. Paul, let me know how to
proceed.

Regarding whether to have a separate tree or not, I would prefer a
separate tree at this time, but only for the reason that it is known
ground for me, and not that it has some (technical) advantage.

-- Hannes

