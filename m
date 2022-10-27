Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBDFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiJ0So1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiJ0So0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:44:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A109C7D0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:44:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f140so2521664pfa.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtTvPdL3wTdzfonIbshTZVCARGNc+V44LUajke4cSbw=;
        b=oYg6709NlOpg8TjOMTfgcFl4lQFjNyZ9nalZPinUocdyoTdvoSCaJtsF7XYPzx6XXM
         ueA5MuLn3bClDkDQPRid/TY7SuH5tH4bJZuzDWElpOuiMVO2Y8OTDiGKD5Zc3nfs2anS
         flI9v7NoIDKyFmHUM5l8+QHxm7bJDOYGuMLscLiakOEhhgPdxnxl/TzxvQRodzPGG++9
         lazdFOQ8Nxd8It1M1rQxXnWTBVtcNdYKzKKYc1ulF+pkMnl7Jh7LFjGdtlmkUkJtNAM+
         VdkuzDcCJIRR45dYExhLbzdo7Xjpr85qOXXcEU76u+Gi4A1hxI/7fWc3nGxpBc0jFcaj
         kqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LtTvPdL3wTdzfonIbshTZVCARGNc+V44LUajke4cSbw=;
        b=3DzRCm0FHBpOa6+FGM3NEtj6vfRNjpXWRIIDKS79P3IptnGnCJtrAz2TSHrvTQBZTr
         d+/v9Yls9RPVqxTKP3YX7FNYkagUwq4XchMAtdDaH27h8Ef7jyuzF3RyHZN0HPrtyq1a
         CFqRW9GyGtGIvCTMOwmdNwGfb0o/BJYSFzCEreY5yXW6UOASWl6tqJOZm9Q47dTTwtwf
         kTs9GXFTZFVk7vUwcQvNrSjZasrh4ie/xVdQenYw5wEOCufTAR8WXq39lFhyL8p92UNN
         uqjWhOVgC1iwkmebE4tolWhTX4EGU9jhZKQ44/Lf21qSlPUSde0UFbXk5cQkTfjg9OFq
         ci9w==
X-Gm-Message-State: ACrzQf18ZZ2DGAvtdV1HkNipnsWZHr/jWuf3QV3IMrQKHPdYocweZulM
        ZrXWgS/JXnmirda7TVT3XlQ=
X-Google-Smtp-Source: AMsMyM4ZtUVWaGtsB3F5JO2mju5FRYMN+L/9n8U4aYNJMpPYnSs4/+YczZ4rlHyIOtdu5EuE/4LSTQ==
X-Received: by 2002:a63:90c4:0:b0:46f:5a21:3b5d with SMTP id a187-20020a6390c4000000b0046f5a213b5dmr2471796pge.210.1666896264531;
        Thu, 27 Oct 2022 11:44:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z30-20020aa79e5e000000b005626a1c77c8sm1483732pfq.80.2022.10.27.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:44:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Subject: Re: Git add documentation error
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
        <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email>
        <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
        <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email>
        <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
        <xmqqo7txmazv.fsf@gitster.g>
        <CAB9Jk9BC1PVxuuNggZuDh1OMe3kdTvCzwkoo7Bkm35nRqAaL4g@mail.gmail.com>
Date:   Thu, 27 Oct 2022 11:44:23 -0700
In-Reply-To: <CAB9Jk9BC1PVxuuNggZuDh1OMe3kdTvCzwkoo7Bkm35nRqAaL4g@mail.gmail.com>
        (Angelo Borsotti's message of "Thu, 27 Oct 2022 19:46:52 +0200")
Message-ID: <xmqq1qqtm7i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hi
>
> I have displayed the contents of the commits with the command you indicate,
> but they still look much the same:
>
> D:\gittest>git ls-tree -r --name-only 91ef45d
> C1.java
> C2.java
> C3.java
> C4.java
> C5.java
>
>
> D:\gittest>git ls-tree -r --name-only 8ec0c2f
> C1.java
> C2.java
> C3.java
> C4.java
> C5.java
>
> I thought that in the second one I would see only the changed file.

Git tracks contents.  What it means is that you should stop thinking
in terms of "changed files".  Each commit (and its tree) represents
a complete snapshot.  Back when you created 8ec0c2f, did you or did
you not have C1.java?  You said you did not modify it, so I assume
you did have it.  As a commit is a complete snapshot of the
contents, when you list the contents of 8ec0c2f, it should be
included.

To put it another way, if you "git checkout --detach 8ec0c2f" in
order to go back to the state you were back when you created that
commit, do you or do you not want to see C1.java and C2.java?  In
order to be able to reproduce the then-current state, of course
you do want to see, and because each commit is a complete snapshot,
you can see C1 and C2.

"git add C1.java" is a way to make sure that, if you make a commit,
the resulting "snapshot" includes the current contents stored in the
C1.java file as you have on the filesystem at the time of issuing
"git add" command.  If you made or did not make changes to C1.java
before running "git add C1.java" is immaterial.  We may optimize out
and make it a no-op if we know you did not make any changes, but it
does not change the fact that the resulting commit will store, and
more importantly, you will be able to recover, the then-current
contents of C1.java out of that commit.
