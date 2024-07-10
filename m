Received: from email.lodispoto.com (email.lodispoto.com [192.46.218.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5B1527A7
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.46.218.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653907; cv=none; b=atZ7CjxYunHvQ2m7j7NYX1SwP+JFbEZFE0yVCRMdLyrDNqcsFlSFsNwtIyOdTQ2Q+tqYm8DXZmulN+6Xh4GXAUTnO9pSjGaDrGDfaZ4rqkmvmUNTf4vLjTnylI/PvuJgobPifHqfP3SlWcp/fPpXdjOOpIm7W+HqVIleiTh/BUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653907; c=relaxed/simple;
	bh=agR5cY2C1lXvwGEamm4sznp13RWDiyAfdJM0syQZrsc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Tf1mpi27DFQ5zvn3aQOSBt1qpe+zqj5QykEhcm/oBWcwG2yUXkT+c/y2v9BOvR44UXASdMIlHYd/mPef0dkyhzvaJLNocFsZfqhdlUXeiJt2KXogcY2K9PyX/RjgrZiAvxgXnzOboVqh2BCL3fuQJaZrka4lq9Crnfhc+6ThNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lodispoto.com; spf=pass smtp.mailfrom=lodispoto.com; dkim=pass (2048-bit key) header.d=lodispoto.com header.i=@lodispoto.com header.b=hbQWflvF; arc=none smtp.client-ip=192.46.218.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lodispoto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lodispoto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lodispoto.com header.i=@lodispoto.com header.b="hbQWflvF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 499D6418EF
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 18:16:52 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lodispoto.com;
	s=dkim; t=1720653412; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:autocrypt;
	bh=/nOYnkczQKDrFX+w5ZcavJ4ABn/od3O/eRl83CPhS54=;
	b=hbQWflvFWN/qE4p2JpoJtsoJY3vO2NnqE/cFuSDixt/QO/VRj++1Ab6yprrsQ79FFPFSSG
	MM01hfqmU956Di++mQGJW6VQ4jCNblXlNv5jFxHS5/Sc0hdqbpLpg1Z9C5hpP50pU0QlyH
	hknumKdTfV0RImfbXlqlaNQ1jetHTxPr7h2trSfS7q+KbYRsVqp2vjz6Rbav9OL2+jOqTA
	c8LqGmIgPxUFBTTfquqqSunfcT19lMxU0nML6V1v3H8b6hdGKToFMeD7sMUiYwlkzrW7pV
	Zu6fBnjBNzIPaGV28m7Ttk6qyat87Gjd3DWCDVcEwePdD4NAISLjSjmsoMTBNQ==
Message-ID: <dd703bdc-f485-4162-92a5-fd2828b69604@lodispoto.com>
Date: Wed, 10 Jul 2024 18:16:50 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Mike Lodispoto <mike@lodispoto.com>
Subject: Shared bare repository dubious ownership error after 2.40.1-r0
Autocrypt: addr=mike@lodispoto.com; keydata=
 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
 JH53RA1MTroCbT76gd1+LosO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

I use bare shared repositories on Alpine Edge, which have been working 
perfectly until I updated git recently (from 2.38.5-r0 to 2.45.2-r1).

My setup is a git user which owns all repositories (/home/git/*.git). 
Each repository has a group, so the ownership is git:projectname. The 
group has the same permissions as the user (-rw-rw----)

To give access to the repository, I have a user set up for the 
developer, and then I add them to the group. Each repository was 
initialized with 'git init --bare --shared'. In the config file, 
'sharedrepository = 1' is set under [core].

My issue is that somewhere between 2.40.1-r0 and 2.43.4-r0 on the 
server, I start getting the following error on the server with a user in 
the group, and remotely (tried with client version 2.39.2 and 2.45.2) 
through a user in the group:

| $ git pull
| fatal: detected dubious ownership in repository at '/home/git/project.git'
| To add an exception for this directory, call:
|
|         git config --global --add safe.directory /home/git/project.git
| fatal: Could not read from remote repository.
|
| Please make sure you have the correct access rights
| and the repository exists.

When using git 2.40.1-r0 or below, it all works and I get this:

| $ git pull
| Already up to date.

Is there a breaking change I missed that I need to change my 
configuration for?

Thank you,

Michael Lodispoto

