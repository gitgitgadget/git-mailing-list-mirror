Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261CF1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdFJLCd (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:02:33 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34265 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdFJLCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:02:32 -0400
Received: by mail-pg0-f42.google.com with SMTP id v18so33288370pgb.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rv0Qpy/BYcLfmIgUoRiHESfi1S98p11xUMB+jWddL0Y=;
        b=hwHEf+o9hrKWDNNJIGPJIUNGL7v4f1QDbHsLoV2W2vPIJaS2D4x/AsIPx99RipTJip
         bvpR4VzIbvqYN4DWFLYRHEr/MpWnHYnyzcOLQ1Wc3XOxGRUxZIpVv035pMNFuxxSNGy9
         p5plQnWHUFaQa2GQsEIVo9UPXU8bE86f9OfXxNxSku+Nzdd3cW1jls/uJOyEBTbN6WSQ
         17yEEElOL5dwuhbjlhHmeHVrp83Fy7POf+BFZXWYv9g9qI1cwQe8IJ2DKDbnwYXbGjnR
         A0pl5MI1/IHOyw6GskBz5kO2YUT6Uy2PMQCfQI0fkgiuLexAWD+JJvTp8qR4jxKy+Cig
         D+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rv0Qpy/BYcLfmIgUoRiHESfi1S98p11xUMB+jWddL0Y=;
        b=GZrrvR3TT6F6Ewn1LlMs/+dv7/BDVaPjbpyZgGLpT2uPSTHCipEc4TpIvwghsK8DxZ
         doXGuCztk7SDTIPKq3VX9WLhlZPqsV3wnzV7n/FC9ezJg6mbmNusD7hilclyDLMzgTlq
         pUutoYNXW53cbvlmbXwXbF1S4mBLtqYzEmXJhx8shmHLb7PnGCVFhlKn2ZP5APKR/7xX
         z+vxgLn2g004cFHsDQiJONM7Xe4wZEK8Fs29n1JFRgYzZQTX3hbN+u0D3F19YFAMfqWo
         McK1Rw2aBjW2XgsVdNMMTWC2QJIftHhXRkCOLFv52lRIjrWkiJ6tEfK10qMhSLa3qphM
         voZg==
X-Gm-Message-State: AODbwcBtdQ/D1pkUtxsye4yMC+smc7/2PXMjdq0kA+yjDVYvINsTwdJH
        +VmD8AHa2EdlRQ==
X-Received: by 10.84.216.24 with SMTP id m24mr44693552pli.281.1497092551303;
        Sat, 10 Jun 2017 04:02:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id u62sm7968900pgd.53.2017.06.10.04.02.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 04:02:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
        <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
        <1497084241.8531.2.camel@gmail.com>
        <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
Date:   Sat, 10 Jun 2017 20:02:28 +0900
In-Reply-To: <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 06:21:27 -0400")
Message-ID: <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jun 10, 2017 at 02:14:01PM +0530, Kaartic Sivaraam wrote:
> ...
>> # Please enter the commit message for your changes. Lines starting
>> # with '#' will be ignored, and an empty message aborts the commit.
>> # On branch master
>> #
>> # Waiting for initial commit
>> #
>> # Changes to be committed:
>> #       new file:   test-file
>> #
>> 
>> Looks odd. Not sure how to fix this. Maybe on of the alternatives have
>> to be considered. "Your current branch does not have any commits" seems
>> a good one.
>
> We could also add an option to "struct wt_status" to differentiate the
> two cases.
>
> I had forgotten completely that this would affect git-commit. And that
> explains the "Initial commit" text in the first place. This output
> originated as the git-commit template message, and only later was moved
> into the git-status command. And in the context of making a commit,
> saying "This is the initial commit" makes a lot of sense.
>
> And it probably does mean we want separate messages for status and
> commit. One is "if you were to make a commit, it would be the first".
> The other is "you are making the first commit".

Again, you said what I wanted to say in my review comment a lot
better than I managed to say ;-)

When the current message "Initial commit" is read in the context
together with "Changes to be committed", etc., by users of "git
commit" who do not use the "-m message" option, it is clear that
these are talking about the commit the user is about to make.  

The confusion factor that triggered the discussion in the thread
that resulted in this patch exists because the output from "git
status" uses phrases that are designed to guide the user in working
toward creating the next commit on the branch, even though the user
may not be thinking in terms of "what would happen when I say
'commit' now?"

And I do not think the potential confusion is limited to "Initial
commit" from that point of view.  The files listed in "Changes to be
committed" list are not files to be "committed", UNLESS the user is
aware that s/he is asking "what would happen when I say 'commit'
now?".  When the question is "what is the status of my working area?",
that phrase in the section header is suboptimal.

Adding a bit to "struct wt_status" is a good first step to allow all
three (i.e. in addition to "Initial commit" and "Changes to be
committed", "Changes not staged for commit" is the other one that
shares this potential confusion factor) to be phrased in a way that
is more appropriate in an answer to the question "what is the status
of my working area?", I would think.

Thanks.


