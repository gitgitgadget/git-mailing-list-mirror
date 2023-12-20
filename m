Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192A482F4
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd8eQ4u7"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e3cde8ab8so1054871e87.0
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703094176; x=1703698976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BbVabM7MwUDQGXSaFBN5JJWlhvnxLezsq4bhxVtpiWk=;
        b=hd8eQ4u7295ZgvmR8W6sqED/JzoLLYaKvmULtn1D5nfJ9pXhCirygqN6NPPzH2EtTm
         831MvL/1FjWzHjQkLvIHmsAIrUT/myAWJ+FWnODg/2tTXlLOm/8y0WnE21kO4M91dpo7
         vY44fg5t5g1n76eG+9nIKLllbp2Rw7jvN4fYr18w+DfYuOd2gyK0O5w+X5ZV4Aga4uWf
         WVuyLZ8iDNFBPxWaTBi7N+FMX/drmQMul4/awjlv2PsciKZsSzyf9N+/aLxVRN+jUxk4
         6q47TOTQ3l5grVlQKEvxYnq+y3Zqg9cK6gg55ss8qXqeciHy2HHByV+M6e+VTeXvGMxq
         j7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094176; x=1703698976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbVabM7MwUDQGXSaFBN5JJWlhvnxLezsq4bhxVtpiWk=;
        b=XBhcOgYiHmbY/qPHTUdnskjeFVqJfuxZLdQX+yf+5g1wFUGn8MCHfw1BSXHdFdUZ+J
         fUc8qct5rwkXRmKICoNdIakGgFIyhB1ARIP0on74S3eFhDVzeysY42EWAA/OpahYbGU0
         mBHRYsh02qCYwX6EAQa0kzaXwI0zs3Dc1Lda0xHCqVpGsHM1Smi4Cc+D3XJlmmkrRUsp
         fr0ZT0gvKxyHE6NAiNOv57K8HEWIwZypwmswQqz+jR9MbamvpJ/XtqiIC9HRJhQlj/2h
         G29Lc+X2sSnNlUeIPt3VKZgV+l5zhIh/QZ5WpjpkncLA7dNgXLoHadSwGbqWVL/1xMOc
         JjgA==
X-Gm-Message-State: AOJu0YzsBNx0xAZFEnZdgOilpsvYZVL2ECzXn6wQaLTt5yizTGFZ10Lk
	HlQtH2YJnn6TCPU3qGAvUPcdez2IK0t8LunvHyodX3Kh+uo=
X-Google-Smtp-Source: AGHT+IGxQu4/Ps57vlRWPrFNxsA7s9Xm7cUAO8dB7SPDjybd4nu/CYoC4N99IQeZS/VeeR5CDh2jtGyu5JrHG1MfdQY=
X-Received: by 2002:a05:6512:3d18:b0:50e:4ffb:3bfc with SMTP id
 d24-20020a0565123d1800b0050e4ffb3bfcmr1225385lfv.14.1703094176196; Wed, 20
 Dec 2023 09:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
 <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com> <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
 <CACZqfqAiSpGP5ABN7MZ50Za=-vAEKnqE0ravzEMbLJCByfRd8w@mail.gmail.com> <CABPp-BFjotLN4sCe+6uHAU7qhr1COM0B4EdW0f0-X-xf5qXinA@mail.gmail.com>
In-Reply-To: <CABPp-BFjotLN4sCe+6uHAU7qhr1COM0B4EdW0f0-X-xf5qXinA@mail.gmail.com>
From: Josh Soref <jsoref@gmail.com>
Date: Wed, 20 Dec 2023 12:42:44 -0500
Message-ID: <CACZqfqCar=tay5diocU7jVWBwPUFqewNYfPLHkYvvR1fSBSdPA@mail.gmail.com>
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Elijah Newren wrote:
> Yeah, well it appears that those of us who have been here in Rome for
> a while aren't a fan of it anymore either; see also Junio's response
> in this thread about that.

Right.

> [Josh Soref <jsoref@gmail.com> wrote:]
> > Given that Noticed-by is more common than Co-authored-by, I have a
> > hard time arguing that it shouldn't be included.
>
> Not if you look at the last three years; there Co-authored-by is more
> than 17 times more common than Noticed-by.

> Given the large drop-off in usage of the Noticed-by trailer, I'd
> suggest just leaving it out.



> Perhaps replace
>
>    You can also create your own tag or use one that's in common usage
>    such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
>
> with
>
>    While you can also create your own trailer if the situation warrants it, we
>    encourage you to instead use one of the common trailers in this project
>    highlighted above.
>
> ?

Let's have some fun (inception):

commit eac2211332f754c5f4127a58aafb9882bfe939e8
Author: Josh Soref <jsoref@gmail.com>
Date:   Wed Dec 20 12:34:54 2023 -0500

    SubmittingPatches: discourage new trailers

    There seems to be consensus amongst the core Git community on a working
    set of common trailers, and there are non-trivial costs to people
    inventing new trailers (research to discover what they mean/how they
    differ from existing trailers) such that inventing new ones is generally
    unwarranted and not something to be recommended to new contributors.

    Suggested-by: Elijah Newren <newren@gmail.com>
    Signed-off-by: Josh Soref <jsoref@gmail.com>

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 32e9023877..58dfe40504 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -358,4 +358,5 @@ If you like, you can put extra tags at the end:

-You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+While you can also create your own trailer if the situation warrants it, we
+encourage you to instead use one of the common trailers in this project
+highlighted above.
