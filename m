Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE133A9CD
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965661; cv=none; b=d640WSHI1b9T6gDqPu3wWPpmS5c4WF+jog6wY64xxxe8XoeXgeDO+XeCMAu35yjBYyHaWdMiSJJKHftjoKNsbBg8ep7nDlWPeftcn9F/twp62A4TSWOrlvAfxQiFX9JdeEGxXs9flm8vTWPyyZddvDxbXmL80P7T5kzLGzNDm3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965661; c=relaxed/simple;
	bh=16jlSpJxBDZzFBmjSKVimmPiQOJMpZjeEZIZVmBorMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMc8Mb7uw6hzA1mk3ED/ZGRjOMjZy1YzAAltfJSBjdHUIb0PWVkrPayFG0VJZWGk8/Jjf2EMjNx0XtMhcI+l1stS++clY/r/tWqQruU4zKUi8syxxISSaq+v8hYs1nOe6VHYD+t0bkVyqv2mQCv51DXrwg3VcLFSxbTizIwwURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2glvtp5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2glvtp5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso285608a91.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 12:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771965659; x=1772570459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNpFGcLmGsFlRPVvRJT+JxMWTJbFjxfZzciQ/jJw9h0=;
        b=S2glvtp500Kn5aHc88hT7GoKoPJyoKq5AL9q9+ZXmu/tU0nVUZBUhkEhBU/t54EjAS
         LA+8YysTTfcCpg3BHoUorWsVCHEzh0ixLe3etQPIUJekORLDSpINyt/++kJlndON2yA1
         zwKGWJ10HJYP4uoYYP93+u3stQkXNIxKb5RII48HVES8BjUx0MeYn6HDs6TSYbE5ssNp
         j3Iyo9XbV+FDhXUf8IILtfYHkm6RHLoVz6tHaztZTPJ+7ehoWvtwwLv6KiwMc0MEvLR5
         BotqdRYpMlhVTVbW8Pv+TH5Mok93Ubirb45bUkz2BsklvUaqPPvFXFrGDdr6FaNIQYTH
         QBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771965659; x=1772570459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNpFGcLmGsFlRPVvRJT+JxMWTJbFjxfZzciQ/jJw9h0=;
        b=uDLAimTv5fgMqr6gnp3NEVNJUWif3RJE3g+H1p/mRL09aQG2t7iFkGObnYF4OcmhNO
         yPtO9Kcsxu65xZQbJ1pzaC3CkOXLbllUE2YZRHCNJ1rnhZ03aeEUy6oAEKHqp9d52kIz
         QVBUzdZ0jcumIIwZnkKK3VSD+2DYfTfrhq+BHyQqmK6mSrngVo4QQ9+gs/V98s+/p0QH
         FA5BEI8/mkBlgUVgfpsXorg7brUcIF05k+Qsyf07RvPxjf2NL2vzui8D03mE3KNpCRty
         eylAL3sFVioXt10fJfUYELY8YFL7GzLelq5ojjDy1AH/MzYN/BnMZRjzGm2eE/qVgq8b
         rCCA==
X-Gm-Message-State: AOJu0YyURQaIfoJVmPwtx6uS9qj7mqgG1m65SOvsCmxeB0FndVW1c39u
	sT8s3LtgD2rFFbHelN0BiNBe8IAhUJeEsc7UfNKUoep/8g5iC5esJ9syDvQo1g==
X-Gm-Gg: ATEYQzwzgJ3UV9/NNJEqE4M4/BKhT8b1h2gkdRdQ9RAJbmhA4t+sj+jvIJd1c8nMVoY
	EKAhJ6LUkrNN17cDCT4CEyoAKURWNJPfZE+EwCmL37N33LV1Zs13CiuRuh4w3ngsz6kBtijlMSv
	3j3FY5KTEkdUTWnbHFlXhjhBAVW1BWFrBzXJwnzlD+0NZa205IW4V7fWNExug0NfKenqzTBR9Q0
	7FAnmZoPPYYPETprKjQuTaJFZ7WZAzTxqYV1kvgQNmyDfJBS8sK5iWriA/tuyZ5hTIqwQUSuA9J
	1ow2sHM01GT7bF7yp/4UoFAVEDZJDJIlrhllC+Bx1WvmAOO+2f+VwtYNcAPXYnybSvntKfbSsKk
	G/z3rJqWciiHCqSmLSANEhDWVJFNGf3Y9WlFCxndquj26RNLlZ/0BYG2NNebIpgsWkViaNCOndQ
	1OMqJzPIRGT0T/lXa/rGH2olNcHd5TPk13hnPr31IyoAnMjMDkXrEFnXkZ2E7HcJcHAXMGWOfrr
	kExpVN5bqDZ1eqMfJX7oLmLqow8bL3WY8bJJ1cW7KjA4ahrwUVzrFvJuCdzOQ9Lpd+BgmF7YQXt
	WwRKq/ZvQw==
X-Received: by 2002:a17:90a:e7c4:b0:353:3b33:8263 with SMTP id 98e67ed59e1d1-358ae7fe516mr13820955a91.9.1771965659239;
        Tue, 24 Feb 2026 12:40:59 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:100f:98c3:814b:c2e4:a180:5c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590bd208b6sm75921a91.5.2026.02.24.12.40.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 12:40:58 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: git@vger.kernel.org
Cc: SoutrikDas <valusoutrik@gmail.com>,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 02:10:47 +0530
Message-ID: <20260224204047.8452-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone!

I wish to undertake the "Improve repo" GSOC idea,so I was going through
the repo.c code and trying to make a small patch.

I saw that by default "git repo info" does not print anything at all,
I went through the first discussions [1] : 
>> Also add a flag --allow-empty, which will force the output data to be
>> empty when no field is requested.
>>
>
> Why do you suppose we need this, I'm not against it, but it would be
> nice to state why this is necessary. The idea is to have a default
> output when a user runs `git repo-info`, so I'm missing why this would
> be useful.

And 

> I was thinking about use cases where repo-info is used inside scripts.
> A simple (but kinda useless...) example: an application that is a GUI
> for this command, where the fields are selected in a checkbox, calling
> repo-info with them and then displaying their contents in a dialog.
> 
> In this example, if no field is selected and there's no validation in
> the GUI side, the default set of data will be retrieved. With
> git repo-info --allow-empty, we don't need to care about it.

Would it not be a bit better if we allow the default behaviour to show all
fields and then any subsequent scripts or application can make sure to 
check if they are appending any fields to the git repo info command, 
if not then dont show anything, because even if they ran the command without 
any fields they would get nothing. 

But now if we change default behaviour to show all fields then it becomes a 
bit more user friendly.

> After this review, I'm starting to think that leaving it empty by default
> would be better. Specially after the review by Phillip Wood [2], who
> has a good argument for it:
> 
> """
>   As this is a plumbing command I think it would be clearer if the caller 
>   was required to specify the output format and the information that they 
>   require with an "--all" option for "show me everything" as Junio 
>   suggested. If we were to set defaults for the format and keys now we 
>   would be stuck with them forever.
> """

I don't really have much experience writing scripts, but ... if one is 
scripting to get a certain value, would they not specify that ? like 
why would they excecute a "git repo info" without any fields?

Also ... mayeb this does not make much sense, but the
'git repo info --all' has only 4 fields now, so showing all 4, should be okay ?
Or maybe not.


[1] : https://public-inbox.org/git/20250610152117.14826-1-lucasseikioshiro@gmail.com/t/#m04cb1fc694f334cc861f6ab146f50b45ae277874
[2] : https://lore.kernel.org/git/af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com/
---
Previously, git repo info would print nothing,
when invoked without arguements. Change the default
behaviour to display all available fields, to make
it a little more user friendly.

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
 builtin/repo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..4d7efcd833 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -193,6 +193,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 
 	if (all_keys)
 		return print_all_fields(repo, format);
+	else if(!argc)
+		return print_fields(argc, argv, repo, format);
 	else
 		return print_fields(argc, argv, repo, format);
 }
-- 
2.52.0

