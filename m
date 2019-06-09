Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292E81F462
	for <e@80x24.org>; Sun,  9 Jun 2019 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfFIUAr (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 16:00:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52669 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfFIUAr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 16:00:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so6545684wms.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/uRckh6llm8Tg1l6CcdncwL2vJYX2m77FqvKhl7qUg=;
        b=LDiOqXUai8sqVryjiYldLQHt1KdTkyb0fCcOPQvEdbmD1ibRTM+gAe5JVlodrvS4J2
         POV1RE1FJfEZJocYw1TdrlquQjjMHtirYxDiIUnBkrEK5bjiZaL50gkIc7iKp9dXdhFR
         3uu8BiB234Xlzbw58sjpbePz3Qv0+UaKm+g0/fTNM2ThQqTLk1vD1eTuaucuo9JynEdr
         6BGbB/L+3gm1PdsLUh8BQvIl+UHqCnxphRIY0nFYuqVuH3fijd9qdJaaLABwwBaeW8Zf
         /mMqf0Gage971C7/FpoGnwSjl97NGPeWHM7iVlVTzXdzKm/RrrTAxoT7HsP42gSm5kew
         zApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/uRckh6llm8Tg1l6CcdncwL2vJYX2m77FqvKhl7qUg=;
        b=YI2n9SYjqFGFBOGCCYaODLsSkDJLtQ5Fs0JSUAnlxC2i5GkBfuL+l23TxYQrQ2s+6H
         n7lNnvaBz7+3fRHsOra5iaIStRUNmGl7ZNaHv3Pye4pJ82hvZGoSePaINZtN0VM4ayBZ
         9uLhvQtdI8y10ZXSN+RMRCAjzB82pLINyS53z2fwxi3NhMpEB+Cmbe26V4vggGEj5xbC
         JQtYVYNWkHQIyIQnx+WRMWobVS5tlOKxCLZOtJwbwgmm42j44u3WC4UoY8CX/jZL6Vq7
         F2XAk6OjAkCAov/v4I3PcBWkUd3BIMQa3+PYsezmTkiovHXnizszTLZWzSqxPEQZGmkU
         +snA==
X-Gm-Message-State: APjAAAV67FfRaHDRWLs1k4hDOXuWFmE9j+8PDYZ3MBqmJa9eKjdIFqJw
        4otpt/krIDp4Mr0noJXQcS4=
X-Google-Smtp-Source: APXvYqy+vgNmiSL0UoVrOYV+SjC/aksPQVLA0qR0wibnKcIKLuWClqVdTmMZVwo5hlOW6UmeeFTmug==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr11299354wme.95.1560110445323;
        Sun, 09 Jun 2019 13:00:45 -0700 (PDT)
Received: from localhost (adsl-22.176.58.193.tellas.gr. [176.58.193.22])
        by smtp.gmail.com with ESMTPSA id u1sm2398173wml.14.2019.06.09.13.00.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 13:00:44 -0700 (PDT)
Date:   Sun, 9 Jun 2019 21:00:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH 0/3] Teach cherry-pick/revert to skip commits
Message-ID: <20190609200038.GD28007@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190609090235.GC28007@hank.intra.tgummerer.com>
 <CAL7ArXpMBXwOGXWmYx8Rv9bj2trJ-FS_VGgPmJbAh+evbaxNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL7ArXpMBXwOGXWmYx8Rv9bj2trJ-FS_VGgPmJbAh+evbaxNEw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09, Rohit Ashiwal wrote:
> > > PR: https://github.com/r1walz/git/pull/1
> > > Reviewed-by: Elijah Newren <newren@gmail.com>
> > > Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
> >
> > Note that the 'Reviewed-by' footer is something that is "given" by the
> > reviewers, and should only be added after they have explicitly given
> > it for the patch/series in question.  Instead this should probably
> > mention that Elijah and me reviewed this off-list in the PR you linked
> > to above.
> 
> Oh! But I read here, SubmittingPatches[1] docs, that it's nice to give
> credits to those who helped you. Should we fix it in some way? I don't
> know. Anyway, that is beyond the scope of this patch.

Right, thanks for thinking about credit here.  The appropriate way to
do that would be to add a Helped-by trailer to the individual
commits, though especially for the first and last commit in the series
we probably don't deserve that much credit ;)  In past GSoC/Outreachy
projects I've also seen the Mentored-by trailer.

Other than Helped-by, which I've commonly used seen for this they do
seem to be (more or less) documented in SubmittingPatches [2].

> Thanks for the review
> Rohit
> 
> [1]: https://github.com/git/git/blob/v2.22.0/Documentation/SubmittingPatches#L289-L291

[2]: https://github.com/git/git/blob/b697d92f56511e804b8ba20ccbe7bdc85dc66810/Documentation/SubmittingPatches#L353-L365
