Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05FE1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 03:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHFDAa (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 23:00:30 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44678 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHFDAa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 23:00:30 -0400
Received: by mail-pf1-f169.google.com with SMTP id t16so40627647pfe.11
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7vnKGyAZTa+HZppkkAY+wIMEBumyeyWm+2WHoHMx84=;
        b=njD+6T/qkZD36VotztkOIZ++DU4hEiewjZFqQy8xAysPocEju51y0BNucCo9dqBMcj
         iw9q/TQdvoQAp1Jf1W7Qp8ncgZNAg2z4d4dFey/fxQYQkRsCHLAm/+jY/snkQICmUxU7
         YjHRfzcTntHIRtEvSmMKP1avf3IsSAwkasbpP6qu5uI6Lvv3yEk1qFAZ60xso4Zlj8ti
         WdeSK2ctbFTvOTJPecmrsXr8CIXftRKP9KQ7matUCa+L/uD4i8GAWbbMBypGvzEojGZi
         iIsuA2wk6hCIQWKYuD/Cj3NFFCiQE8/xISXCwfS1ecOMnPD47p7MTe5fKiMj+CZYaHRy
         +jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7vnKGyAZTa+HZppkkAY+wIMEBumyeyWm+2WHoHMx84=;
        b=pgpEBNhM65+YPu1TkEMy8WOGL6OIqdLZKYu+JYgBJcxtw4uNUZkPqmM+9HCV+JNt7z
         h01pJAwsXYFce5riMROZddZvMRcM6Ynd7Sn0S6G8jstOl7Q0IpRcWzDePfjMgU/jExqd
         rc5saMBw6tvIjun6IY2P3RMSYbC/M5M68t014tPRrc0pOr+eDlBbhN09OQ/4hGM9vVfX
         s69sC/SYEDb2fvOXAvDdlweYjhhw3PbtItD1rCf4hMRa40CZzNG8KFHe0CCPz6BjOips
         wrNg5qKtisRI2wGCeYr1tTEdrDp7W0YwfjF2kiKemb6ieROZ1DRThO7ys4LHfWJOkPmd
         j8/g==
X-Gm-Message-State: APjAAAUB7MMQh29wDLO7eZdNvXrojpbhYIkylVH+LfmLuol2wcTDjINC
        uh538ugofXmFMrH5akSZEsU=
X-Google-Smtp-Source: APXvYqzEdCvPMd3w1fqwlvz0n0326Hn/dkvdg0B8JT0agxCcWNobGs0C3iCgj8Iu7OKKcyQFc1ifbQ==
X-Received: by 2002:a63:c013:: with SMTP id h19mr976449pgg.108.1565060429149;
        Mon, 05 Aug 2019 20:00:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w4sm106607882pfn.144.2019.08.05.20.00.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 20:00:28 -0700 (PDT)
Date:   Mon, 5 Aug 2019 20:00:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190806030026.GA8864@google.com>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
 <20190806021618.GC61803@google.com>
 <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Lukas Gross wrote:

>>> I had intended to stage commits but forgot to do so. Git responded
>>> with a normal commit creation message, so I pushed to the remote to
>>> begin a CI build. When the build failed for the same reason, I
>>> realized
[...]
>> 	$ git commit --amend --no-edit
>> 	[detached HEAD 33a3db8805] Git 2.23-rc1
>> 	 Author: Junio C Hamano <gitster@pobox.com>
>> 	 Date: Fri Aug 2 13:12:24 2019 -0700
>> 	 2 files changed, 2 insertions(+), 1 deletion(-)
>> 	$
>>
>> Some non-judgemental descriptive output like
>>
>> 	$ git commit --amend --no-edit
>> 	No changes.
>> 	$
>>
>> would address this case, without bothering people who are doing it
>> intentionally.  So I think there's room for a simple improvement here.
>
> I do that to refresh the committer timestamp.

I do, too.  The proposal is, paraphrasing,

	$ git commit --amend --no-edit
	Ah, I see that you want me to refresh the committer timestamp.
	Done, as requested.
	$

In other words:

[...]
>                                                           I am not
> yet convinced that "--amend --no-edit will become a no-op" is the
> final solution we want.

Not this.

Hoping that clarifies,
Jonathan
