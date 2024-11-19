Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD16183CB8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051927; cv=none; b=AJD4003620ym/3KCmvQeggTd3b0SL57XJZqJqawhHlbFQQie1VRC8yQmY1YTq7tJr/s4x5mETk+YpaDrzJdfhCEk6INyJZC+tgkoRpQa9fpCz1P3AqMN+pdTY28jvF74ec1oBQFArfBJ9LGTjeP5PDsgwF4+ME9ZdEsTyJhXcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051927; c=relaxed/simple;
	bh=Gq78kSqSJqtSLRGr7JcKrumiMWM8kHLqdGMCkLl2bvs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9qPMyRXt/y3Sz2M8P+8HJkjDeamskycHMNsC7GmqAuNMLEemI6uzBGtXdSCGr1eFBNTnDyIoQL6xNWMgAWvrowtMGqePVObEabu8SEqmV9R9zJNpCB5Ap2yD3zicSyYSX2aJZvg/REpTiWBJuX3IQzThRMx4A+idkhO076C9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AJLVt6A365650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 21:31:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>
Cc: <git@vger.kernel.org>,
        "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me> <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com> <6arLzsCWhxM8QTlPRbNStMLfz5ZqVJTTUSX1E1NXLiy_n_d0v0wFMiUK5brfkqTV3chUOp9OLYyBpIbe4tYQ6qvrLKDzfg5el0EWnqDIYDM=@proton.me>
In-Reply-To: <6arLzsCWhxM8QTlPRbNStMLfz5ZqVJTTUSX1E1NXLiy_n_d0v0wFMiUK5brfkqTV3chUOp9OLYyBpIbe4tYQ6qvrLKDzfg5el0EWnqDIYDM=@proton.me>
Subject: RE: How do you undo an add
Date: Tue, 19 Nov 2024 16:31:51 -0500
Organization: Nexbridge Inc.
Message-ID: <028e01db3aca$75de0150$619a03f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIujZMfl62xzE/fsxvvZCpEhSyanwNPSAY4AQLRLVIBhiobnrHptQXQ

On November 19, 2024 3:59 PM, A bughunter wrote:
>On Tuesday, November 19th, 2024 at 02:13, Kristoffer Haugsbakk
><kristofferhaugsbakk@fastmail.com> wrote:
>> On Tue, Nov 19, 2024, at 00:20, rsbecker@nexbridge.com wrote:
>> > On November 18, 2024 5:10 PM, A bughunter wrote:
>> > > ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for
>> > > commit. It's already been commit : push failed. Failed pushes =
piled up. I need
>them untracked.
>> > > How do you undo an add ( many adds): simple question. Without
>> > > deleting any files, to repush 1 by 1.
>> >
>> > Once you have pushed an added file, your only option is
>> > filter-branch to prune out the invalid content.
>>
>> git-filter-branch? Why not `git reset --hard` with `push =
--force-with-lease --force-
>if-includes`? Maybe I=E2=80=99m missing something.
>Yes you are missing something "Without deleting any files," a bunch of =
irrelivent
>and wrong answers is SPAM because literacy is necessity for =
participating in any ML.

filter-branch can be used to edit your repository if you accidentally =
added files
post-commit. That is why I included it in my original reply - you are =
free to read
the fine manuals that this team produces for more information on that =
and the
reset commands.

Our answers are provided as a courtesy. We are all volunteers, and I =
would ask
that you consider the possibility of treating the people who have spent =
time
in an attempt to answer your questions with a modicum of the same. Thank =
you.


