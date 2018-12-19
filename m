Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2D11F405
	for <e@80x24.org>; Wed, 19 Dec 2018 22:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLSWOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 17:14:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39227 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 17:14:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so10101133pld.6
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 14:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=slSFla0LjaICiidYjDgq5Tp2yuwtnEvzKVU7JPpKBLU=;
        b=uk4yHrfldfJYSNdbC4IpTCQjWowXjB3lFczjGMdRlDQXU10OSRbk8Ai1HIWbofXN+d
         nzAPuARzbHMdbh+3e0116fzFWq5dBNZaEg7pZTiJ0HVosxng4jbrYzLiFAOGeJgStmr7
         gu1tgfIxWYYuRfdSrEm/7YqoTz1BhjDm3mQYhwyiS5A3c3uPIYuC511MjcSexMIv/KSo
         JCqVbO3HYG/VyyV7OTESzlDCMbquAlczIRkUXnmEd5NQFDx58Y+AO5eXitjSp4sYFIPX
         jPXc9E5VD/B4qZDL96Iz5rhVKw2Z2UUuVXFHfshZ1ZVxGs/CvTr9215w+YTIOWUURO/D
         gCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=slSFla0LjaICiidYjDgq5Tp2yuwtnEvzKVU7JPpKBLU=;
        b=ffLKxOOvvOaEUK1WSbxYtdPPVmdzswjKeLCbi1zN3akt0VGNDNKLPPMeQDbrdxSH7F
         aGawJqAN1vxhAJN5b88ADmMm89MCDX/jpAiMUXQ9dNMBkHK8dayJVHOUoMszgRnSsxOB
         ZUcUSYQzZh5RCm9uXTp2a3JDFFpy4gmbXV7DLWS+Ue/pjANV0z29a6p0pTpFKqbXk1Ho
         Zj+F39hrs/eJbqw8HBiQRBBc68UHzspB8mTmQH9O6Rn1QVzYxikS16ZLsGxSPHhOnPHy
         OtlzbbAEfMw7BN40eVaY/qYoCvc+urPdF2hg0+Yn4AGItFk1a21QYYIgbDH79P9WBYO7
         rrqQ==
X-Gm-Message-State: AA+aEWZpAEyE2z0jpdw8qx7Z+KX7EywWXF7hGbmP1ZuAyzPccFo2WhH+
        XFyj81LggpfXEE5i5o0oXZfLC7fN
X-Google-Smtp-Source: AFSGD/V62l3e+1imZkCkVN/Er5CBQWIuQSLyRioceZ4nJ5DTUhs/ihyFBEXEB8T4NwrsImcXn4qDLA==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr21852133pls.293.1545257644080;
        Wed, 19 Dec 2018 14:14:04 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k24sm25716718pfj.13.2018.12.19.14.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 14:14:03 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:14:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219221401.GC228469@google.com>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
 <CACsJy8DdgjjQLEn=O7ePBo7ndLuv22RGQA3nM1Lyizz=59Pj9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DdgjjQLEn=O7ePBo7ndLuv22RGQA3nM1Lyizz=59Pj9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> On Wed, Dec 19, 2018 at 6:04 PM Ævar Arnfjörð Bjarmason

>> E.g. when composing
>> https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
>> remembered PERLLIB_EXTRA went back & forth between
>> working/breaking/working with your/my/your patch, so:
>>
>>     git log --grep=0386dd37b1
>>
>> Just found the chain up to my breaking change, but not your 7a7bfc7adc,
>> which refers to that commit as v1.9-rc0~88^2.
[...]
> To follow email model, this sounds like a good trailer for related
> commits, like In-Reply-To for email. We could even have special
> trailer "Fixes" to indicate what commit is the problem that this
> commit fixes.

In Linux kernel land, Documentation/process/submitting-patches.rst
contains the following:

-- >8 --
If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.  For example::

	Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")

The following ``git config`` settings can be used to add a pretty format for
outputting the above style in the ``git log`` or ``git show`` commands::

	[core]
		abbrev = 12
	[pretty]
		fixes = Fixes: %h (\"%s\")
-- 8< --

I like it because (1) the semantics are clear, (2) it's very concrete
(e.g. "first 12 characters", (3) it goes in a trailer, where other
bits intended for machine consumption already go.

Should we adopt it?  In other words, how about something like the
following?

If it seems like a good idea, I can add a commit message.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index ec8b205145..36ce1ac5d8 100644
--- i/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -367,6 +367,20 @@ If you like, you can put extra tags at the end:
 You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
+If your patch fixes a bug in a specific commit, e.g. you found an issue using
+``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
+the SHA-1 ID, and the one line summary.  For example::
+
+	Fixes: 539047c19e ("revert: introduce --abort to cancel a failed cherry-pick")
+
+The following ``git config`` settings can be used to add a pretty format for
+outputting the above style in the ``git log`` or ``git show`` commands::
+
+	[core]
+		abbrev = 12
+	[pretty]
+		fixes = Fixes: %h (\"%s\")
+
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
