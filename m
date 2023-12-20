Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B91773A
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoQZDrCR"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb732e7d78so1670b6e.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 22:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703055129; x=1703659929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkO4cYKt8OB5kMzj/7UwZK96Mr3N4G3IrQneWB8DnTw=;
        b=RoQZDrCRttKESjHi/FAQPf3a3FnC2oESqX5MbuNvZaupfqiFTZH6NDMFqM2hx2gqVu
         9iLSaOmlMF6S7pGQXqKzj+c9oJu4Caoh5/OI27Gnizj9WYMGwrYxKYvssAVQBwCYXCOp
         Lh/CIyGrAZGZpEj7i5M2BLpD34sFYJ3MGa7bQQhmyw+v4tXsJ5J0bD7oADfRhxxDWLL4
         N4qZibL4WQENga+fW0Ei+5eX2X9nRcgNN+wc268Vhv7zb5/T5O3kCp/QaSFPQ6NhMP0s
         aqqy+1zZWmeIxFtNQDaJLdbgMkEFzZk68F2piXWactGU/itZ5fAhexN9xQcDErKhNYT7
         YYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703055129; x=1703659929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkO4cYKt8OB5kMzj/7UwZK96Mr3N4G3IrQneWB8DnTw=;
        b=GWzH9x84H3WmJMu6FPfydd+M5cB6fnGCBj0+z5gEYzfHEBwNd8CtQtQjFVqbV9Y+46
         Uq92/ATYTCK3BhwL40aG4ktvNkRk15BZNXN12k73EaZLEfU3iiWOvdjQk0ZVqq/hhiLf
         /votvuH6/0HCPLk2t98iCoi6g4yoEnnQprIXd3m7oTzMJ7AKzHU2k0ZZzl3U27GUcvFp
         w2ov/20IOPZHEikcxpjHT5Xa0lBfqZ5DBwzrbJ+MHqG0wKD+qZSz5R3MDscOvJuxsFBg
         vJ+/zmW7KnJkqA4+xRKJRw3IaEbKLZAb8q0UCQgRqWCDhOpmiuJidWqVOBfGCNxRawwN
         Z0+A==
X-Gm-Message-State: AOJu0YxmutS3ybFbvD+GMt0i25V7rqykAk8KJxi1Y3TcOj+i5+2L2hgc
	pqOg7Zbm+J1bniNgv8CzfYgk1kffS/Uq0w==
X-Google-Smtp-Source: AGHT+IGkXlvN9vMyEUgja02FjZoX6O5HgKgecdLCDOEvMD0BEBkLRmoecTLJRdqcXiysFFUk0eMm0g==
X-Received: by 2002:a05:6808:220c:b0:3b9:d8bb:8ff6 with SMTP id bd12-20020a056808220c00b003b9d8bb8ff6mr19186555oib.31.1703055128627;
        Tue, 19 Dec 2023 22:52:08 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id e21-20020aca1315000000b003ba3b053eadsm2034031oii.52.2023.12.19.22.52.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Dec 2023 22:52:08 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	mial.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: Re: [PATCH 0/1] revert/cherry-pick: add --show-current-patch option
Date: Wed, 20 Dec 2023 07:51:41 +0100
Message-Id: <20231220065141.7599-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <42ff6b11-f991-4a6d-ad68-ca8c5a3cd735@gmail.com>
References: <42ff6b11-f991-4a6d-ad68-ca8c5a3cd735@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip

On 18/12/2023 16:42, Phillip Wood wrote:
> Thanks for bringing this up I agree it can be very helpful to look at
> the original commit when resolving cherry-pick and revert conflicts.
> I'm in two minds about this change though - I wonder if it'd be better
> to improve the documentation for CHERRY_PICK_HEAD and REVERT_HEAD and
> tell users to run "git show CHERRY_PICK_HEAD" instead. I think the
> main reason we have a "--show-current-patch" option for "rebase" is
> that there are two different implementations of that command and the
> patched-based one of them does not support REBASE_HEAD. That reasoning
> does not apply to "cherry-pick" and "revert" and
> "--show-current-patch" suggests a patch-based implementation which is
> also not the case for these commands.

I appreciate the urge of limiting the interface to the minimum needed
and not to duplicate functionality that already exists. On the other
hand, this would
a) grant the user the same experience, not having to wonder about
implementation details such as different backends for rebase, but not
for revert/cherry-pick and
b) (I know it is more indicative of me, but:) when I am looking for a
feature in software and I look into the respective man page I tend to
focus first on the synopsis instead of reading the whole page (or
sometimes I even just rely on the shell autocompletion for
discoverability).

So yes, mentioning REVERT_HEAD and CHERRY_PICK_HEAD in the respective
docs would technically be sufficient, but I don't think it is as
discoverable to an average user (who does not know about the details of
all the existing pseudo refs) as a toplevel action would be. But an
assessment of the pros and cons is not on me to decide.

I have to be honest: I have troubles distinguishing a "patch" and a
"diff", the latter of which `git show <commit>` shows according to the
documentation ("For commits it shows the log message and textual
diff."), though my understanding was that a patch is a diff + context
lines, which is what `git show` actually shows... I think this is
probably why I don't feel so strong about the potential loose usage of
the word here.

Also the documentation of cherry-pick already uses the word "patch" in a
(according to my understanding from a technical perspective) sloppy (but
from a layman's point of view probably nevertheless helpful) way:

> The following sequence attempts to backport a patch, bails out because
> the code the patch applies to has changed too much, and then tries
> again, this time exercising more care about matching up context lines.
> 
> ------------
> $ git cherry-pick topic^             <1>
> $ git diff                           <2>
> $ git cherry-pick --abort            <3>
> $ git cherry-pick -Xpatience topic^  <4>
> ------------
> <1> apply the change that would be shown by `git show topic^`.
>     In this example, the patch does not apply cleanly, so
>     information about the conflict is written to the index and
>     working tree and no new commit results.

Should that also be rephrased?


Out of curiosity: The following from the rebase docs seems to imply that
the apply backend will probably be removed in the future:
> --apply
>           Use applying strategies to rebase (calling git-am
>           internally). This option may become a no-op in the future
>           once the merge backend handles everything the apply one
>           does.

But I would expect the `rebase --show-current-patch` still to be
working. Would that only be a legacy compatibility flag and instead also
for rebases the recommended option would be to run
`git show REBASE_HEAD`?

Best Wishes

Michael
