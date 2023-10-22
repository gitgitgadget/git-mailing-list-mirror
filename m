Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D32570
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qR0ZmNc8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECA97
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 05:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697979305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwj70cxFu2cV21+nvG5VcTaZaj7ajsABG/SwxsLgFSk=;
	b=qR0ZmNc8LfcOlzaBhmwa103lg1a0lLyatizuFtFS1vg5F8I2nU8MXNDpB8wI7kAnaJaRNA
	Pi/AZnk8q5wGJQ8idlZVXwN9pfv5DKcbQeGY8HHJMUHB/aPj5bHY9VjqlpKDm0Yv2vL8MW
	6HkzXkpydu3i4tyUCySIKrAk4fn9OnCVxcv8vAXDeybHpZVGkPpiG8EBteOm8F8cERFFOY
	0Adqf+NU4s8M8bV/YWCwU/J12BYC2N2DCZZN9XUaumQPLybydtQlD+Ob0hW5COFDDUs9+i
	mLBnRPDmp9Buv9F6rK4ndn3OIlIbSUwt+oFa3631Tp8W0wojr2Bfjtjm+vGOBw==
Date: Sun, 22 Oct 2023 14:55:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTT5uI5Hm1+n0Agx@ugly>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
Message-ID: <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-22 12:30, Oswald Buddenhagen wrote:
> On Sun, Oct 22, 2023 at 08:38:19AM +0200, Dragan Simic wrote:
>> True, but I still think that having git put its thoughts into tables
>> is actually not helpful.
> 
> i'm not convinced that the proposed feature specifically would have
> helped me, either (i found the index a rather obvious concept once i
> knew that it's there), but i'm making a general argument here. so:
> 
>> To be precise, it actually might be helpful, but only to the first
>> category of users, who will never reach it.  I mean, never say never,
>> but in this case I'm pretty sure it's safe to say it.
> 
> well, and i think that you're wrong about that.
> your categorization is simply wrong, because it assumes an incorrect
> static model.
> 
> while for the last decade i've been as much of a git expert as one can
> reasonably be without being literally obsessed with it or having
> written much of it, i absolutely *did* start out in your first
> category (as in, it was forced upon me, while i couldn't have cared
> less about the specifics - p4 was working well enough (or so i
> thought)). and i hated this stupid git (it was 2009, and it was much
> more of a pita for noobs than it is now). i certainly could have used
> more sensible visualizations at every step - on the command line,
> because that's where i mostly "live".

Oh, that's awesome and I'm really happy to be wrong with my broad 
classification of VCS users.  However, I still need to be convinced 
further, and I'd assign your example as an exception to the rules, 
especially because you migrated to git from another VCS, which you 
liked, and because you use the command line a lot.

Full disclosure, I used Subversion for many years and I loved it.  I 
knew it very well and it did all I needed for me and the team I worked 
with.  Then git came and I really didn't like it, because it was touted 
to be "the best thing ever".  After using git for a while, I can firmly 
say that git is awesome, but that it also is a total overkill for many 
projects that need a VCS, for which choosing Subversion would be a much 
batter choice.  Why, you'll ask?  Because Subversion is many times 
simpler, and because many projects actually don't need a distributed 
VCS.

> the second major error in the thinking is that "expert" and "gui user"
> are mutually exclusive categories. while i do most things on the
> command line, i would never voluntarily use "add -p" - why should i
> inflict that pain upon me, when i can simply use git-gui to do the job
> in a much more visual and freely navigable way? the same goes for "log
> --graph" vs.  gitk, and git's "blame" function vs. qt creator's (or
> git-gui's, but i don't use it for that).

I also ask myself why would I use git-gui or any other GUI utility?  To 
me, clicking on something that represents a file is often simply wrong.  
Though, I understand that many people prefer GUI utilities and I respect 
that, everyone is free to do anything, but I also expect others to 
respect my own preferences.
