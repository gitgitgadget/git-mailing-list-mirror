From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] t7011: Mark fixed test as such
Date: Mon, 30 Nov 2009 13:49:01 +0100
Message-ID: <4B13BF3D.7010503@drmicha.warpmail.net>
References: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net> 	<fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com> 	<4B127DC0.4020108@drmicha.warpmail.net> <fcaeb9bf0911291756g1857fe32r8da8e50f0a137119@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 13:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF5hv-0004Pt-FM
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 13:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbZK3MuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 07:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbZK3MuI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 07:50:08 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48876 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106AbZK3MuH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 07:50:07 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7E461C5AC4;
	Mon, 30 Nov 2009 07:50:13 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 30 Nov 2009 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=b2HqwjBjdWWgZ7B0kSYXF66Eyng=; b=cqTdgIicuW8f4NU62unT5Qc8T55I64IcyR3L3P15UL5yoGDPcPEWEo86Ye1X8ZgdVopHMPBzglRSWpGE4BY86H4VlbhkkV1g9bnuHWOOXCSNBkleP3DDXmzrl3a+W7oo8ixonZar8AxU2r358aaI51BTSl7sSnsqkG67mQAKNAw=
X-Sasl-enc: iFBOZjt/akFUBEmYPMua+WRSUlNEO1+qKmNgXXLY0MMg 1259585412
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9357149CAAE;
	Mon, 30 Nov 2009 07:50:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <fcaeb9bf0911291756g1857fe32r8da8e50f0a137119@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134094>

Nguyen Thai Ngoc Duy venit, vidit, dixit 30.11.2009 02:56:
> On Sun, Nov 29, 2009 at 8:57 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Nguyen Thai Ngoc Duy venit, vidit, dixit 29.11.2009 09:47:
>>> On 11/29/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>>> Test 16/17 had been fixed since its introduction in b4d1690 (Teach Git
>>>>  to respect skip-worktree bit (reading part), 2009-08-20). So, mark it as
>>>>  expect_success rather than expect_failure.
>>>>
>>>>  Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>>
>>> No ACK. See below.
>>>
>>>>  ---
>>>>  I'm actually wondering about 17/17 as well.
>>>>  If commit is called with a file name then shouldn't it simply commit the
>>>>  current state of the file in the worktree, no matter what the index or
>>>>  skip-worktree say? I therefore think 17/17 should be expect_success
>>>>  and have no test_must_fail.
>>>
>>> Both 16/17 and 17/17 ensure that Git won't look at files on worktree
>>> if they are marked as skip-worktree (by definition of skip-worktree,
>>> you can safely ignore worktree, otherwise you would not mark them as
>>> such). 16/17 happens to pass, not because it does not touch worktree,
>>> but because the base index does not have "1", which happens to is the
>>> same situation in 16/17 (test commit when "1" is gone). The result is
>>> OK but it is actually not (17/17 shows this clearer as it commits the
>>> worktree version).
>>
>> On 16/17, I really cannot agree. You explain that you expect the test to
>> succeed (we agree here), but that it succeeds for the wrong reasons. So
>> it should be either "expect_success", or the test itself should be
>> changed so that it really tests what it intends to, otherwise it raises
>> a wrong "FIXED". I suggested and submitted the former.
> 
> That was my bad in setting up the environment for 16/17. I will fix
> that in the next roll of nd/sparse.
> 
>> On 17/17, it's not clear what should happen. "skip-worktree" says ignore
>> the worktree and look in the index instead of accessing worktree files.
>> But "git commit file" says ignore the index and stage and commit the
>> file from the worktree directly. And that is exactly what happens:
>>
>> You say "git commit file".
>> That means "ignore the index".
>> That also means that git ignores the skip-worktree bit which is set in
>> the index.
>> Therefore, file is committed with the content is has in the worktree.
> 
> To me, no command should break out skip-worktree mask. In reality I
> would expect that case 17/17 only happens when a user accidentally
> leaves a file that is marked skip-worktree and tries to commit it. An
> error would be more appropriate to keep consistency with other
> commands ("git diff HEAD -- 1" would show nothing before committing),
> and to warn the user that he/she is stepping on the border. He/she can
> then choose to extend worktree area if still wants to commit that
> file. How does that sound?
> 
>> I'm going by the documentation for git-update-index and git-commit. It
>> could be that they are wrong, too, but they agree with the code, so
>> what's the reference for saying both code and documentation are wrong?
> 
> Both code and documentation are for Git without skip-worktree. If you
> agree with my reasoning above, I will update documentation to reflect
> this too.

Thanks for the clarification. I see the background behind 17/17 now. I
think git-commit.txt needs a careful update then, because the
explanation of a common feature (git commit file) should not get
confusing because of a not so common feature (skip-worktree/sparse co).

Regarding 16/17: Seeing a FIXED is very misleading. I caught it during
my work on a patch series and was confused. FIXED usually occurs only
while working on a fix, before adjusting the test. So, unless the reroll
of nd/sparse is to happen very soon, I still suggest marking it as
expect_success as proposed, and then modifying the test during the reroll.

Cheers,
Michael
