Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5C15746F
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786861263; cv=none; b=DS5WpCJEWoiXfgsPvc4MJDCPIbz10BG0kO6TaZOeaNECcCVO8QbeX1hEaRe6BX4UhcWIL/asaZl1BeN6kP45YbQCqXxVb4D1/2z69sOD4wDPL7vit/NJOSBDIG/ylruQT1YFUoQ2T8it/wo3c97uky/HNHeqT+iciKceWbqYTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786861263; c=relaxed/simple;
	bh=9L7x0n1fKGlRAUYXfSMgIq+LKy3ooVaStVG73MjbjWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvR+GjlkP9h9k+u9RiBxcS9v/wRZbkb5feqki0kPU6v48oCeQjGQgmQ5/OKsQJ1k5svytjs//x6+LUpQR4qqTy17AFjRvOaigMW23xaKqxQlnPwX1ZyfDi9/p/ETDIO6CTdAJd6znkLOTcpY9uDoa8ctyiEG9vvamJMKiqp4+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fRDZDm1M; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MNtTaNlY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fRDZDm1M";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MNtTaNlY"
DKIM-Signature: a=rsa-sha256; b=fRDZDm1MbZcCv4AGTsp/wSLWYVDCFayvYFzE9Jqkte734QAh+XYIuL/Z1d9pg7uiT1ejafWWJY10qhOC+xlk5fDePOJ9IiyYM38h6O6mzsk3syN9LQpm+8QHkSDUJ6FlJpXVETrqbHygYDifVEv8FCV8z/r5MOZC+TbfXwBX951xpFnwy7KDykGhSwAtC2Qf/h8hdBB6x1uJhpSpzf7uqsBR07FDlB/aXKI9dV6+0AgNrwQjQ75O+MvCcDOO1buMxjoSACdLgZEGTv7XG5Itz0QWTc9PL8+AlojbIBOsZbR6HCQDtbVkBGSB0fRCiimKkcqafZ+GmY9q6wE5be/+Rw==; s=purelymail3; d=malon.dev; v=1; bh=9L7x0n1fKGlRAUYXfSMgIq+LKy3ooVaStVG73MjbjWg=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=MNtTaNlYTGCbQatk8LvjJ6ZxYOB1//Yy9zzx7tG7jbdktkPANlfBMilUBv84YRglKRmjEQOL/bqDsIceJ8iJMi6Orb+PC5jkNEZp6laa6a/kNDlqeMR/9rAng+DhsiD8AQJZPhF3Gb/JA8FNps4GlpTtsVJjjFE8p4wBwXx9b9AHVG0E6WVNBuPx3X9wxN4RDv1Mmpe3SAlJ29HHSSeT4zxp24uZwImHer9H1RDjQqXpdj6Y5BkuLEfK8BzI4ImkvvdxWKHUYkIpyNEVvi6SGUllUxmgF/adgcayYe6mumQ3x/ufKcVgiphA5fiojejAFgjav7/8YLyE59L7Don5wA==; s=purelymail3; d=purelymail.com; v=1; bh=9L7x0n1fKGlRAUYXfSMgIq+LKy3ooVaStVG73MjbjWg=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1880214503;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 16 Aug 2026 06:20:53 +0000 (UTC)
Message-ID: <59841e66-4361-484e-bc1f-131ea9b2d235@malon.dev>
Date: Sun, 16 Aug 2026 14:20:50 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260814072419.1666358-1-cat@malon.dev>
 <20260815064747.2196896-1-cat@malon.dev> <xmqqmrun8jeu.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqmrun8jeu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 23:58, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> The global variable 'fetch_if_missing' controls whether a missing
>> object check should prompt a lazy fetch from a promisor remote.
>> In order to continue the libification effort, move it into
>> 'struct repository' and initialize it to 1 by default to keep the
>> previous behavior.
>>
>> builtin/fetch-pack.c, builtin/fsck.c, and builtin/rev-list.c are
>> entered via commands marked RUN_SETUP in git.c:commands[]. Their
>> 'repo' parameter is only NULL when '-h' is given outside of a
>> repository, in which case either show_usage_if_asked() or
>> parse_options()'s own '-h' handling exits the process before
>> returning. We can therefore drop their UNUSED markers and assign
>> to 'repo' directly.
>>
>> builtin/index-pack.c is entered via RUN_SETUP_GENTLY, so its
>> 'repo' pointer can be NULL any time it is run outside of a
>> repository, not only with '-h'. We keep a NULL check there and fall
>> back to 'the_repository'.
> 
> Hmph, are there legitimate situations where we run "git index-pack"
> outside a repository, or is it a user error?  Just being curious
> and not a suggestion to change the established behaviour (in other
> words, even if it turns out that it should be diagnosed as a user
> error, we shouldn't do so in the context of changing where the
> fetch_if_missing bit lives).
> 
> Other than that, this iteration looks good to me.
> 

Interesting topic. Refer to the git-index-pack documentation:

...Reads a packed archive (.pack) from the specified file, builds a pack 
index file (.idx) for it, and optionally writes a reverse-index (.rev) 
for the specified pack. The packed archive, together with the pack 
index, *can then be placed in the objects/pack/ directory of a Git 
repository*...

Does this clarify that the design intent is to operate a standalone 
.pack file, and whether or not to put it into a repository are two 
different things?

Thanks! yuchen

