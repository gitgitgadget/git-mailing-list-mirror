Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CD43C06A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748284; cv=none; b=bLF9imw8jIs5cmR1wir5fbJdE/scKIC4fkoWAK+YxyA9DQjP+VyW6otrem3FUBgtGO0l6c88LkSCuAsWaeJus9N41eOAKYLM3C/k3bLZWNO+mJNuNsxmPWimLNKH/VOo/1UfYlox/NtDmk3TPWyQ2FfcsY+dcHBmFUn9UT2qUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748284; c=relaxed/simple;
	bh=3JEvbM72mqVkPbTtvGSYLKPYQ5FGQU1MMSV5rXj/QNE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kaSOtIdsPG4MKQlQ9eVQhcMo45fXsvB30NWv3pSGG31iF/yUxfX8OzjME6Y6RvNhVC0I0uMY2l/OUfcDbeTRqYBbEk2TXUgORCj6UoZq34Qh6S5Fd4gJrz+dkdOpmrTkIC3bFz9MPItwkeXkqKEfK9RzoNpPr7fo1kMbOdykl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpSKd+Ju; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpSKd+Ju"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso18227995e9.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782748281; x=1783353081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3tbug0pX0ubBWNLsgSHUdWhilqqOH/unS8ymjBbanM=;
        b=qpSKd+JurjweRfOF6Rx/8JLLbK6kUZhoEYIhcDf2lVUjX2SY46iCGOnYWhrUXt6QPv
         WbMrySlousQxRJgXpokv0usLQ5Fpc8VFfEE4yEd2/7nYakfvrNeSqerAcNlIRVwH9Xop
         vld8heKl4WB+0DxujWEfArerggl4EX/KcDkiNNkubg5/m16uD5ujjNkooOcJIhYkA2XB
         bxIF/uIRlRaG4CM7RkOP3yWDoPztmo8nAT+vvozkIPbDwy7h0Ppy0bsb3naDfQGSV2XY
         /JAWkhEfE7id14qgwl6Llh95rUAiNw0NPwmUNHYy5d8GxWVLUMOyRYZLY2MbAdpPxUXR
         KwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748281; x=1783353081;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3tbug0pX0ubBWNLsgSHUdWhilqqOH/unS8ymjBbanM=;
        b=oWAnrvu1nQcRgBW0E8gJGFKxScg9SlHjIBTDJ5n55tnIRGAoYr2xzU3mx8kJx4/j4P
         MtVDGAlP5vrOegFqQeLEUr/R3izcl6dgfcy978MUO8RA9/BKdfjXQU76opt3+4ou1Bku
         xd+XU+79WLj478D4rOx2Gzdzvu6U0khU/JZjPrEi0X0Br3haPMuwTeI6/Utw+5RxQunl
         RPD+vufUQNHyICXwdltTIO7OKeFjSBsGkAH6/3b+wgyW5JJQPlGGa/ky41TYnfGsI0c+
         Rh635m4hAroqFp1Q+/CyZ5PpipB+PhpDflv8tgz+izwkYCMG5snH+50v06dvdxrtab4F
         8cuw==
X-Forwarded-Encrypted: i=1; AFNElJ8onP8YvlIWE2vq8OwhAm60We5ZPA9Q0FZtiohybYub1duBYY5s1UZsXflxkEI9KfZG/WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPrzPIOINSxOaRP3um5f5PXKsofW/Nre83cvezsw2Eb2pqbJ2
	acXmM5gshUgMKfOm8v1tlX1rS4VKQvnXwk6iaRRn6Iogt0gYziJNq00c
X-Gm-Gg: AfdE7cnY8Kx7PS2EoN/dZ3tJCCt8YClJXlshuweZtKvIkaljJhu+fVoyRGMSqcO35NA
	2UjX/Pt5vY7NrYSPFCoFhv8PWyv4X8oTGfWjEPP3yepblu5HI7/3Nl5YRE9QtGfrwjmuxDI66So
	pViRWqnLxwf9jWXzXu8sfEMVadll9WWWVg5/VAGMuk/hun37KDa40j/1Lh9h5R8wc8OtxJtWfPo
	br4Blf5RwJ6QdWUXMyeLcD9wtCV9C/9N6a+wNcyVJW03SXdAyVe/L3y8hWC1l2Z0G9yQ0iysqXH
	4/QGlO1Tz/9t4k66oXzR9A4irlbKMn/4fKyp+wh321Oft4SLa6QUOp2nShUmGJ8f+BJAQB6SisR
	tz4k5LbxAAg7nnAOtR99ANQMzpPP1Zk26fhvKzOJpkoAh5CLSLcq3rh4B5vtA8q7C2by2In0YCc
	Ae3BamCdjMdVlNWCm+j7WY2v5amrxCCnozj/S/fDOW9DZbMUzQ9Rl7nR+H9T/2NDKI0wQaDF8BA
	v7Nqg==
X-Received: by 2002:a05:600c:4452:b0:492:3e66:6c84 with SMTP id 5b1f17b1804b1-493b82b5ae2mr3851945e9.30.1782748280735;
        Mon, 29 Jun 2026 08:51:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm289013295e9.2.2026.06.29.08.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:51:19 -0700 (PDT)
Message-ID: <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
Date: Mon, 29 Jun 2026 16:51:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
Content-Language: en-US
In-Reply-To: <akIQLM6xZTHBudWT@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald and Patrick

On 29/06/2026 07:26, Patrick Steinhardt wrote:
> On Fri, Jun 26, 2026 at 09:52:57AM +0100, Phillip Wood wrote:
>> Hi Harald
>>
>> On 24/06/2026 22:54, Harald Nordgren via GitGitGadget wrote:
>>> Adds git history squash <revision-range> to fold a range of commits.
>>
>> It would be helpful to give a bit more detail here about the command so that
>> the reader has an overview of what is actually being implemented.
>>
>>   - what does it do with fixup!, squash! and amend! commits? Can it use
>>     the message from amend! commits to reword the commit?
>>   - can the user reword the commit message?
> 
> Good things to document/discuss.

Thanks, I was disappointed that these questions were not addressed in 
the cover letter for v6 which contains no more detail than this one.

We should make rewording the commit as easy as possible to encourage 
users to create useful commit histories. I think that means having some 
support for fixup! style commits. We could just do what rebase does and 
comment out the fixup! style commit subjects and the commit messages 
replaced by amend! commits but I think we have the opportunity to do 
something nicer (I find the commented-out messages annoying). We could 
have a comment saying "this is the combination of the following commits" 
followed by a list of the subject lines and then in the template message 
we'd simply omit the useless fixup! subjects when the commit body is 
empty and also omit the original commit messages that have been replaced 
by an amend! commit.

So instead of

     # This is the combination of 4 commits
     # This is the first commit message
     Base subject

     Base body

     # This is the second commit message
     # Another subject

     # Another body

     # This is the third commit message
     # fixup! Base subject

     # This is the fourth commit message
     # amend! Another subject
     A better subject

     A better body

We'd have

     # This is the combination of 4 commits
     # 123 Base subject
     # 456 Another subject
     # 789 fixup! Base subject
     # abc amend! Another subject

     Base Subject

     Base Body

     Another subject

     Another Body

Possibly with a comment before each message saying where it came from.

It would be good to error out if the user tries squash a fixup! style 
commit and range does not contain its target commit.

In the long run we should provide a way to squash an arbitrary list of 
commits rather than just a range.

> 
>>   - what happens if a merge commit inside the range has a parent outside
>>     the range?
> 
> Yeah, I agree that we should punt on merge commits for now. They are a
> can of worms, and I'm not sure that we should just squash them. I would
> at least like the user to ask a flag that tells us that it's fine
> squashing those.

There does seem to be some support for merges in this patch series which 
I think behaves pretty sensibly. If we have

           C - D
          /     \
   - A - B - E - F - G

Then squashing A..G should be fine because the parents of F are in the 
range and it looks like we support that. Squashing should B..G without 
--ancestry-path should be safe as well because B ends up as the parent 
of the squashed commit but we don't have a way to disable 
--ancestry-path (and maybe we don't want to add one). Squashing F^@..G 
might be useful to fixup a merge (though perhaps amending F rather than 
creating G is a simpler way to fix a broken merge). Squashing E..G does 
not make sense because the range does not include one of the merge parents.

>>   - what happens to branches that point to commits inside the range?
> 
> Yeah, this should be documented indeed.
> 
>> I had a quick play and found that it accepts ranges that containing a single
>> commit (e.g. @^!) where there is nothing to squash. It also accepts ranges
>> that are not ancestors of HEAD (e.g. checkout master and run "git history
>> squash --dry-run origin/seen^2^!") without printing an error message. Only
>> accepting a single argument is quite limiting as one cannot say
>>
>> 	git history squash ^:/base :/tip

We should sanitize what the user passes though - we do not want to 
accept arbitrary rev-list options. Off the top of my head "--left-only" 
and "--right-only" would allow the use of "A...B" and allowing "--not" 
seems reasonable.

> Note that it is intentional that you can rewrite branches that are not
> currently checked out, and the other subcommands work the same. So I'd
> argue this should also be the case for "squash".

Ah, thanks for clarifying that - it does not seem to check that there is 
a branch to be rewritten though if I do

     ./git checkout origin/master
     ./git history squash --dry-run origin/seen^2^^..origin/seen^2

there is no error message and it exits 0. If I create a branch pointing 
at origin/seen^2 then it does print a sensible ref-update.

Thanks

Phillip
