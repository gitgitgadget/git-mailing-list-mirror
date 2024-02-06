Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2281773D
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248723; cv=none; b=p1M5BIB+EF7WkaNJDek+on2Sw8yPXDG7xgYAwGx3N9EzMMjPeNstBk5OJQi5v5sjIsokQwNDzFFOozKNM1tCjmjMItpcXBCP2qccOtO4iIqRY5+oxy0gqphka8YoOEvUwXu3X4+rrgH2zSRjlZcBQLCEq+UhsKtXUoAzc8BYHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248723; c=relaxed/simple;
	bh=nS3PdsKeLdh46hZarLchB7nz8iakKkQeo5+QCik/sTw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JotSpg/HeAjY9bcBFMrRJyxi/kvJ9K6p0dLRXRJh8oSAFWoltCz+DY7YbxaRAUnZbaKJaTFx16xbs2MQe0EgZIFe8sqnpWHi1dUlZGH3O4iw44woWH7W1kP2Llxe+vKV+/Xyvu2j2EIAeuL3QMy+IGL+j2WvAN/o4UCYGN0nlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHlUDEqU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHlUDEqU"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0b750518bso23813601fa.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707248720; x=1707853520; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pE6f+QE1whJ4t+O4hAXBKgJMlhmvN3reSE483kaovCg=;
        b=kHlUDEqUT0UNN7MF1ewww3vMv78r6TOm+x8uOXZZKLDYdmfJYQDDsA9nuD//shQhIT
         5c7SSRyax3QdtX7Sp+d+BzmxUeNlyLkwmVK+xllJNCrSehoijGbkkJZ0ZAesliIFbgEw
         CX3jtPvcOOLqYzPdRGXRJse8LeCrvWFAZ8GuK0exblaUJAFOvMlOW/q+I5ChYMditnYt
         h4RAQHa1gqc2Blv1kdz5pKovICE/roc8MG8tli32CJ4KS5Gzceq3Ny/DXSNy2mh6rXZ+
         ULjtxfTopP9CFzM9zUReG5kan7SDjajFTEo1gh9X2i3p/Sob1NsA2EquPVzrYLSFrpZd
         7PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707248720; x=1707853520;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE6f+QE1whJ4t+O4hAXBKgJMlhmvN3reSE483kaovCg=;
        b=kIPaobZ+2sQIbJffniuZ4ySUyROnZBOhf7RlGmXdO8lgr5ii7liKprsqFa1n9D3f29
         fG/pgbGLnn+RAeKo2zxED0m4pvf+xXul2tMxa6dVbkSZ9NhcZA/gNZUl1Y8Uhv//rSFs
         Np3CSfxxivkiG8o2sg+RYx9XuQNIMZMZMoy6H1shBBm6VNHkkeDwJUS3hYeFkmCUzQnn
         hxk1hhescn39gA4uTiGPYYmjmB7BIPwqv4v/YzOYwAlh3+znjSXg2NbrbhMf0+mGlq30
         BDeTAfvGnthtLLyJp5mxlWjEhHxVRHRISsBxQOQDJlNJkmPcELUeIau7/wsl8X2pCe2j
         6RbQ==
X-Gm-Message-State: AOJu0YzDe5376BG06Uyd0gq1Ic742FTkc9tbIf4epI1qUdNqUE5Rpfyo
	JK6VRYDWgLzVKzTGWMUcEbnX7Bi12a7bamLVQK+FngQj3mRh+URMO0ztbE94/qk=
X-Google-Smtp-Source: AGHT+IGTy1w7N3MpoNciwFHGxhk+W7IcdO7v1oPXVtvHYvnG+3hsgb2VdRX949Ioua+Cw9IKOYLJsg==
X-Received: by 2002:a05:651c:1411:b0:2d0:9fac:bdff with SMTP id u17-20020a05651c141100b002d09facbdffmr2549021lje.38.1707248719388;
        Tue, 06 Feb 2024 11:45:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8ZMC+PiAgdNBgksWgFVRKkWs2ptYtfzO/PKv3xe9eh950Wshe9+NJU1FdFsFFKjVhOvnbq8AZvmjWfLojiue0eBG0
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z13-20020a2ebe0d000000b002cf30f27698sm352176ljq.91.2024.02.06.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 11:45:18 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Britton Kerin <britton.kerin@gmail.com>,  git@vger.kernel.org
Subject: Re: is it a bug that git status show the in-progress 'edit' in an
 interactive rebase as 'done'?
References: <CAC4O8c_oKT+a0hm+tqSOG7d1=AuJJKy5bsh72cJKVsWynvHw+w@mail.gmail.com>
	<ZcIYz82iLxPOVR9Q@ugly>
Date: Tue, 06 Feb 2024 22:45:18 +0300
In-Reply-To: <ZcIYz82iLxPOVR9Q@ugly> (Oswald Buddenhagen's message of "Tue, 6
	Feb 2024 12:32:31 +0100")
Message-ID: <87il31s7g1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Tue, Feb 06, 2024 at 01:02:43AM -0900, Britton Kerin wrote:
>>>Last command done (1 command done):
>>>   edit 71b73de914 message for first commit
>>>...
>>>You are currently editing a commit while rebasing branch
>>>...
>>
>>This seems wrong, because until git rebase --continue has been done
>>the edit operation for the first commit is *ongoing* and it would be
>>much clearer for the output of status to accurately say so.
>>
> it makes a lot of more sense when you decompose 'edit' into 'pick'
> followed by 'break', which it essentially is. so from git's perspective,
> the command really _is_ already done. note that in this state, you can
> do all kinds of crazy things - including adding new commits (possibly by
> cherry-picking them) and even dropping already rewritten commits (using
> a hard reset). so in a way, the message above is even a bit too
> suggestive.

Yep. Maybe, if the rebase action itself were called "amend" rather than
"edit", it'd have been more clear and consistent thus less confusing.
Check:

git status
interactive rebase in progress; onto e79552d197
Last command done (1 command done):
   amend 71b73de914 message for first commit
Next commands to do (6 remaining commands):
   amend 3a478a7a08 message for second commit
   pick fab7159cf4 message for third commit
  (use "git rebase --edit-todo" to view and edit)
You are currently amending a commit while rebasing branch
'my_completion_updates' on 'e79552d197'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

-- 
Sergey
