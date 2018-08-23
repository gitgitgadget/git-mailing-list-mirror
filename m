Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621AA1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeHWFjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 01:39:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36862 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeHWFjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 01:39:18 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so1681762plb.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuldwXOLC6gmA9fSEiEARD0VtVw83jR57nPOWXW6GV4=;
        b=OmvBv6T2pEI666e1Dd59oK8eq/moEZ1dZc9MDyRTA0kSHYjvNna/oZpk1ktHKfZkvt
         4VYxzwkcWYSPljkkQOGyYJw2QwcSU88MKpa48UAspzfnIPCG56GqJXzsIEUIijMdnlEa
         AjtaDn5rFw0VilQhKNLsA8npqorTO8gfBifHE5nRjR+RpTmnui5gXUie6Rslb7zsDgDb
         dNY67OHllXV6O+zBtdZwGkIgtpYHZ/ZKdTw/5fJTF888GsNVeRA14w4HtIyhngueE6S7
         dtT/93fQkraBjjEEFdsHhZ+KUiKPMoJvWkVL35oeR39RLY034KWLcIWCojxZzbtYJ3/f
         oELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuldwXOLC6gmA9fSEiEARD0VtVw83jR57nPOWXW6GV4=;
        b=jLJE42z64VMmTFwKD3E/bu1UGAw4vlN0CKrpnNkPl71deV5TSTaIRekop13JF7zfV9
         XuviFQRw1VoNxr7AzVTjppcg6H+f6R2yurcR1nzZesfEM4o+cD3AGKnzPT9BeBgXJvT3
         b6VtTfjzAKzWYSXyp0HUheE/nynrBeGpHmnjh76k6dUIFHceXjg6uI2qltM9pGLzpDID
         1xGX848OJnHos4c2++NK9qwBNxPpFyvHKdGFZVnMm5d4uxHmLND+sKkbPBJQ6VU7zD/G
         Znk014e32aPfeqLdpNS/PU7gHWB9T+fYXxcGwVgrkXsx2GeCzj/1XghXiTQiq1d6TvWt
         ycFQ==
X-Gm-Message-State: AOUpUlHvK6sezySnQ51BovKiXxE0rNWDlzhf/x87ktwO40lDAUatYCQP
        u6efDCNw0NcR0hKq07l4psc=
X-Google-Smtp-Source: AA+uWPyV0con5ZwH5Ofr5F/XnEqKvEJQLugea4Fx1wTIZeyiDmwAtLhB4aI/HL5PRoK5//tRP3Buqg==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr56478314plb.129.1534990318773;
        Wed, 22 Aug 2018 19:11:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y124-v6sm4895558pfg.63.2018.08.22.19.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 19:11:58 -0700 (PDT)
Date:   Wed, 22 Aug 2018 19:11:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already
 staged
Message-ID: <20180823021156.GD92374@aiede.svl.corp.google.com>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180820193007.GB31020@aiede.svl.corp.google.com>
 <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> On Mon, Aug 20, 2018 at 9:30 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I frequently use "git commit -a" this way intentionally, so I would be
>> unlikely to turn this config on.  That leads me to suspect it's not a
>> good candidate for configuration:
>>
>> - it's not configuration for the sake of a transition period, since some
>>   people would keep it on forever
>>
>> - it's not configuration based on different project needs, either
>>
>> So configuration doesn't feel like a good fit.
>
> I think it falls under personal preference (yes some people like me
> will keep it on forever in fear of losing staged changes).

Sorry for the lack of clarity.  I meant "some people would keep it off
forever".

>> That said, I lean toward your initial thought, that this is papering
>> over a missing undo feature.  Can you say more about how you'd imagine
>> undo working?
[...]
> [1] https://public-inbox.org/git/1375597720-13236-1-git-send-email-pclouds@gmail.com/
> [2] https://public-inbox.org/git/1375966270-10968-1-git-send-email-pclouds@gmail.com/

Thanks for the links!  That's very helpful.

I'm starting to lean toward having this on unconditionally, with a
message that points the user who really doesn't want to clobber their
index toward "git add -u", as a good idea.  I think that for humans,
that would be okay and that configuration doesn't really help much
for this.

The remaining question becomes scripts.  A script might do

	... modify old-file and create new-file ...
	git add new-file
	git commit -m "some great message"

which would trip this error.  For that matter, humans might do that,
too.  Could the check detect this case (where the only changes in the
index are additions of new files) and treat it as non-destructive?

Thanks,
Jonathan
