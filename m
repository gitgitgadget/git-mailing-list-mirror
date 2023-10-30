Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889718AF4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v0MPoO3L"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9563D10D
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 07:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698674658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHOHNzSCQghpMceiaheq52UKCtgPjYMI9KRhR8VBIJM=;
	b=v0MPoO3LvDcCQDHlg6OpYniLy5x0lk8VqyGWR3KEzyDCOoIUzD8LuxK/NAH3CVfv5M05yM
	WHNGKm5+Nkin8v431Gu8ye/98e+XEJmqcmKZNeaNxaGkn9+rP97ElxFvPv0bsWw5yNVZRi
	iZ/rDYyGKa6DKmuXSHmx13EED0kdgKANRoGPaZ2pNkO+PC97NtZtvgJ6xgrXU9MANaZ4f/
	BSLUQJvjJnobCJzJYzaFk2JfRudIDnDDQWPdEpqFKb9mDZ0+OmgoC8l8pBJN0atvoBZ2fS
	fMsmYycA5qscMex9bsNt97fbvcLhUi6/Js7F/gzZI+kw/bdLaNSxPwtelK04kA==
Date: Mon, 30 Oct 2023 15:04:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Patrick Steinhardt
 <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
In-Reply-To: <68c4684b-0ab0-427a-90e5-fca602c9d993@gmail.com>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly> <ZTtyHScKkMg4qnMH@tanuki>
 <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
 <ZTuUa5bA8dh29cyv@ugly>
 <b6ef74b7-2c77-4621-9969-d911c34561d5@crinan.ddns.net>
 <ZTv3to98QT8Ma+ag@ugly> <68c4684b-0ab0-427a-90e5-fca602c9d993@gmail.com>
Message-ID: <33788e805b367f9f0c21aed51d7c4da7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-30 10:49, Phillip Wood wrote:
> On 27/10/2023 18:47, Oswald Buddenhagen wrote:
>> On Fri, Oct 27, 2023 at 03:32:48PM +0100, Phillip Wood wrote:
>>> On 27/10/2023 11:43, Oswald Buddenhagen wrote:
>>>> On Fri, Oct 27, 2023 at 11:22:35AM +0100, Phillip Wood wrote:
>>>>>>>> +    CI_BRANCH="$CI_COMMIT_REF_NAME"
>>>>>>>> +    CI_COMMIT="$CI_COMMIT_SHA"
>>>>>>>> 
>>>>>>> assignments need no quoting to prevent word splitting.
>>>>>>> repeats below.
>>>>>>> 
>>>>> I think it is quite common for us to quote variables when it isn't 
>>>>> strictly necessary as it makes it clear to anyone reading the 
>>>>> script that there is no word splitting going on
>>>> 
>>>>> and ensures that we don't start splitting the variable if the 
>>>>> contents changes in the future.
>>>>> 
>>>> the point was that it *isn't* content-dependent; it's simply the 
>>>> shell rules.
>>> 
>>> Oh, I'd misunderstood what you were saying which was that assignment 
>>> and case statements are not subject to field splitting.
>>> 
>>>> of course, many people (apparently you included) don't know these 
>>>> subtleties
>>> 
>>> I find this comment to be condescending, needlessly antagonistic and 
>>> completely at odds with the norms of constructive discussion on this 
>>> list.
>>> 
>> the observation was necessary for the point i subsequently made (which 
>> was basically agreeing with the first part of your response).
> 
> It was not necessary to phrase it as you did though. Before replying
> on Friday I showed your comment to someone else and their reaction was
> "That's rude". You could have made your point by saying something like
> 
>     It is hard to remember all the shell's word splitting rules so
>     quoting everywhere is not a bad idea.
> 
> This is not the first time I've found your comments unnecessarily
> adversarial and at odds with the norms of constructive discussion and
> respectful disagreement on this list. I don't think I'm the only one
> either - in [1] Junio points out an ad-hominem remark and in [2] Marc
> comments on the unreceptive tone of you review responses.
> 
> I would urge you to try and strike a more conciliatory tone in your
> messages - it is perfectly possible to correct or disagree with
> someone without alienating them in the process.

Yeah, I've also noticed a not so great tone is some of Oswald's 
messages.  It's perfectly fine to disagree on something, but it isn't 
that great to put the other party down while doing that, even to the 
point of insulting them.

We're all humans, and we should treat each other with respect.  
Furthermore, disagreeing in a friendly and polite way can many times 
lead to finding a better solution together.

> Best Wishes
> 
> Phillip
> 
> [1] https://lore.kernel.org/git/xmqqleeihok5.fsf@gitster.g/
> [2] 
> https://lore.kernel.org/git/e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com/
