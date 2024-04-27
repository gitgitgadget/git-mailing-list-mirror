Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457D1EA6F
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714234329; cv=none; b=dWT1jgrtNQUWcGuI5/ywrkbsR1gpAsAcBLU1iPoQ0CbC77dmOLBrYehGXyI4Fs0MPmPLl+Bdod1ftzjliMt7feOh0f2XzWuGiXKMeAD5okyDibM+GTT4hyqbg1AgyzOrD/+fGnnR07OZSGizWLm89Ebwy0AwIutJqU47BlLKrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714234329; c=relaxed/simple;
	bh=qBsd5NN0/ynMPCTStrvmoKjBFJNhxTKFKTA8ksOyBeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=iYh1x3lh6PIkVQYdytLZvQm6SJK2HGYxp42cE1nvscnhejGKE4LCzmTZtPk3Gv6OlVhj/bZ1vsSatAMVwL7nccbrpz6mF1x63GqNUOXQg0Mv/ddc+AxWJILmHZR/mgYAGCPN+2c7Z6fZjkguaBbnAPwBb34JyXvl+IpG4IMdC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1s0kbb-0000000060q-41Nn
	for git@vger.kernel.org;
	Sat, 27 Apr 2024 18:08:52 +0200
Received: from [10.20.10.230] (port=14976 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1s0kba-009Lis-2g;
	Sat, 27 Apr 2024 18:08:50 +0200
Message-ID: <30c5852e-c8db-433c-871b-1ae5c87034dc@drbeat.li>
Date: Sat, 27 Apr 2024 18:08:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of Git with local folders
To: Felipe Bustamante <fisadmaster@gmail.com>, git@vger.kernel.org
References: <000901da972c$61efc670$25cf5350$@gmail.com>
 <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
 <000201da97f2$579fa110$06dee330$@gmail.com>
Content-Language: de-CH
Cc: 'Karthik Nayak' <karthik.188@gmail.com>
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <000201da97f2$579fa110$06dee330$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Hi Felipe

[please don't top-post]

On 26.04.2024 17:56, Felipe Bustamante wrote:
> Hi Karthik,
> 
> Thanks for the reply.
> 
> What you indicate allows me to create a relationship between a new
> branch and a new empty local directory, but what I need is to relate
> a branch with an existing local directory since the latter contains
> the changes made to the source code and I need to generate change
> control.
> 
> I am going to clarify the working conditions to explain why we have
> worked in this way.
> 
> The computer for development is in a completely isolated work
> environment, without connection to any data network, all data ports
> are disabled (network, USB, Bluetooth, etc.) so there is no
> possibility of copying the code. source towards a more open
> environment.
> 
> This computer only has Visual Studio 2022 installed, no other type of
> software has been installed, which is why it is impossible to create
> branches from the master since VS 2022 does not allow branches
> connected to local directories.
> 
> The only way that could be used to isolate daily changes was to
> create a directory each day, by means of a copy from Windows File
> Explorer, containing the changes made during the last and previous
> days.
> 
> The structure of the project would be as follows:
> 
> 1. CS_2024-04-10 directory, this is the original directory containing
> the original source code. This directory was converted to a GIT
> repository using VS 2022 which allows us to have the master branch.
> Because of the above, this directory contains the hidden .git
> directory. 2. The next day, a copy of the original directory was
> made, and this copy was named CS_2024-04-11. Because of this, this
> directory contains the hidden .git directory of the original. We
> worked on this copy by opening the project in VS 2022 and making
> various changes and then saving the results.
> 
> 3. The previous process has been carried out for two weeks, so there
> are 10 source code directories which include the changes made during
> each workday plus the changes from the respective previous day, for
> example, the directory CS_2024-04- 16 contains all the changes made
> from day 10 to day 15 plus the changes made during day 16.
> 
> Now, what we need is to know if it is possible to convert all these
> sequential directories into a GIT structure with change control such
> as the first directory with the master branch and then branches that
> can be associated with each subsequent directory.
> 
> I have installed, to support the idea, the GIT program. For this
> reason, now the development computer only contains two software for
> development, Visual Studio 2022, and GIT.
> 
> How would it be possible to create branches from the master branch,
> using the original directory CS_2024-04-10 and associate these
> branches with the sequential directories created?
> 
> Thank you very much for the help.
> 
> Felipe Bustamante Sverige
> 
> -----Original Message----- From: Karthik Nayak
> <karthik.188@gmail.com> Sent: den 26 april 2024 12:16 To: Felipe
> Bustamante <fisadmaster@gmail.com>; git@vger.kernel.org Subject: Re:
> Use of Git with local folders
> 
> Hello Felipe,
> 
> "Felipe Bustamante" <fisadmaster@gmail.com> writes:
>> Hi,
>> 
>> I would like to know if it is possible to combine the contents of
>> several directories with copies of the same source code but with
>> different changes?
>> 
>> The stage is: 1. There is a directory with the original source
>> code, without changes. 2. There are several directories, ordered by
>> the date of creation, which are a copy of the original source code,
>> copies made every day after generating changes, that is, the
>> original source code resides in the DIR1 directory, a copy is made
>> with name dir2, and changes are made to the source code of the
>> project. The next day, a copy of the directory of name DIR2 is made
>> and renamed DIR3, we work with this directory making changes to the
>> source code. The same process is carried out for two weeks.
>> 
>> The important question would be, is it possible to combine these
>> directories in a repository with a Master branch (the first
>> original directory (DIR1) and transform the other directory into
>> branches of the master?
>> 
>> It would be useful, if copies were made that were made on an
>> original directory (dir1) that was already becoming a git
>> repository, with the use of Visual Studio 2022?
>> 
>> As an observation, the work is done on an isolated computer,
>> without internet connection or to backup devices, the computer is
>> fully isolated and it is necessary to generate the version control,
>> in the case that it is possible.
>> 
>> Any orientation in this regard would be very useful.

What would work in my opinion is this, if I understand you correctly:

1. In the Git repo of day 1, remove all files except for the .git 
folder. This is to make sure that any files that are no longer present 
on the next day are really no longer in the repo.

2. Copy the content of day 2 except the .git folder over into day 1. git 
status, git diff etc should show the differences between days 1 and 2.

3. Create a new branch for this day, and commit all changes.

4. Continue from step 1 for each remaining day.

This will result in one repository that has one commit per day. Going 
forward, you'd probably want to commit more often so that your commits 
comprise a meaningful unit of work instead of arbitrary day boundaries.

It does not matter that your system is air-gapped. Git works perfectly 
locally without ever fetching or pushing.

By the way, I don't think it's necessary to create a new branch each 
day; you can inspect the history just as well by only committing.


HTH

-- 
Cheers, Beat

