Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492CF1F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGPVW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:21:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36917 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEGPVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:21:21 -0400
Received: by mail-it1-f193.google.com with SMTP id l7so1759ite.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N0PZAI/T/wRjf+cDU5bIqYwd/Kjhy6pmiHRwk147We0=;
        b=IzEsWaC0+f8AW48J2wTROV1IU1PtqttuIwn5KY7X8Ub2Z/40eMctqINsClszkBX5qp
         N0IIHr/Wy03VpbsdMTvOn2DCl+adpvzg9BP5MyaCDlsC4wm35FjmTuC/Xs9F5v9ffcYr
         uGiC1PwYKKXRTnDlGUuVxiufy6bjoXteCgm7CPX9pEY2U6/Eei8ockIRzeCdTOhQdJS+
         EYLZk0cFC9ncsfa5AjIZcTxDwpdnhysrYnCMIOwp8AgDdDHCn5f1vVwFhqfHMBvw4Pqi
         RYX+PH0tjL9ThdCFkgJLl+Y0YZPLlWHFxJH2Qzfj60TO/k3MEkFcHgomTvBY9WKTs6dz
         iF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N0PZAI/T/wRjf+cDU5bIqYwd/Kjhy6pmiHRwk147We0=;
        b=kGN7LBCGdfFIy3pDL6VDR8JHJxYS+wpieACci8JZdSsWO7oR+o8A6NeuNOdcOsUyiI
         w+CLTfoTF7fo+7pUQ90pRsiTv3qUjwLU8AkubqCZlvEeE9fdWfInq+TtCuNSV+08nm79
         rMuVTppI4Urxn6BzyxS/MRa8Mi//cxlln2zPCGtxEIqpRxM0YzPH6TptOuNR5TaDc6hC
         fgykDgGz3B4WMAroCjBdFa+TMxn1Zb2aDWEdvp9M0F/wr9vycxsQXRowePlKqbcnu9V1
         27qbIUFu68DmbjnLcrcnzXik+mggya5WcGUWvuzqVCN0x0+ZzMIxEvjqH+1guhX2CgkD
         wg6Q==
X-Gm-Message-State: APjAAAUopXmjHtWhKWUl+PBcDWzdEp5+7a5S7XJSaq3BWNB5MiAKT2AH
        nn4VVJ2KkEAEJPN6HScxCLRI4uuk
X-Google-Smtp-Source: APXvYqxW8ltj6J8mIEhQHHLbrfGv4SBItaGJqLXckDT0Yn2Z1TgLb1PatyaP9Wvxi64y5PyBRWKC9g==
X-Received: by 2002:a24:d241:: with SMTP id z62mr1234157itf.141.1557242480971;
        Tue, 07 May 2019 08:21:20 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id h21sm6725559ith.8.2019.05.07.08.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 08:21:20 -0700 (PDT)
Date:   Tue, 7 May 2019 11:21:18 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
Message-ID: <20190507152118.GA12057@archbookpro.localdomain>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
 <20190507141942.GA359@archbookpro.localdomain>
 <xmqq36lql2yg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36lql2yg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 12:05:43AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:

[snip]

> >
> > Would you suggest moving to a format.<branchname>.* approach or would it
> > make sense to rename the configs to something like
> > branch.<name>.{emailCoverSubject,emailTo,emailCc}?
> 
> So if I have to pick between the two, I would probably vote for the
> former from the philosophical ground, but operationally, I suspect
> that the latter would be much simpler to use.  You could even have
> "git branch -d <name>" to get rid of them at the same time.
> 
> But as I may have hinted in the message you are responding to, I am
> not quite convinced we want these configuration variables in the
> first place.  Why should both description and coverSubject need to
> exist?  Perhaps we should add a heuristic like "If the branch
> description looks like a single line, optionally followed by 'a
> blank line and more paragraphs', use the first line as the subject
> of the cover letter (and the remainder as the body of the cover
> letter) or something?
> 

I considered doing something like that but I opted not to because it
wouldn't be a backwards compatible change and I didn't want to surprise
any future users with a change like this.

For branch.<branchname>.{to,cc}, I wanted these config options because
the current method for format-patch to handle Cc-lists is just manually
keeping track of the people who have responded and entering them into
the --cc option of format-patch.
