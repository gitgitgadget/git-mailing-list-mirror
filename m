Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377091F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfARJbT (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:31:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53159 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfARJbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:31:18 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so5833275itg.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6elRjpNoM4dWuWDLN0sM/FGSpGsHCoiy4KS6aPweFiQ=;
        b=BnQETwgnwiT540f9PPXEPMtNT2mgwfGZzi4yOwuM0GjdOZV9Okb9KmRtsNhkuUZPot
         +mfBN5twGHpgwHPVft8tHTapkEltX1SF17aodjTR/1Jxlbax/22YhLHqDNBqS+JkHzPk
         KJC6xu6ZJ4bm3a87q27xK7CyUBTaaZo1ULa+Y45lKHmwQYENBwj9Oum1IZufMjtVa1Xa
         cdFKibENJbeK5EOPmGqSQJrC01V4lli0306RW1xRC73B7V/TlVIihOxNEAZ9hl0mwVmW
         Ofc1QSLHdzpOV0gOOkxNt/utW96wKG+galUgafnVz35ObabijmcNeecdkSc3+i1I6DOI
         1TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6elRjpNoM4dWuWDLN0sM/FGSpGsHCoiy4KS6aPweFiQ=;
        b=pX1YvC8BCPope0bGOQwJtF9jxk0IR+BrOo95DYauZz4uY3G7prrDctz3GRVoLZzN6d
         g96P2OfdrFOfWW0sf64Rbt36UeGhIIeMS/yV1WTlrcCcfIVnAJWsY2opgU6h2jH2PX6a
         R4NmIXunzBTuJ/cVtzFeG1W1AQWAwDYjW3ONngSzTIA9yD0FrkMwY5H0lQmH7oNCImbd
         TfXGkDx4nd5b5T3U7urZXML7s976hS9MTDymGjyrecXkyHJ31q+ftPj1fi98mrfS2k5K
         Hcq8xHJ/VrtkH+TPfvVQ5eEWCcCkTnHAxWFE9bFFbscIoSzzw0YQLtAq4HqCBXoPpB3T
         rixQ==
X-Gm-Message-State: AJcUukdEUD0p0XrHjZgJMZBjfCtyfpPMO38/Lq/9v93vwXhLqznk3sXB
        bsO7mAiVDRQCn0e01ttpzrkuPO/0PARRCxuHc8IZCA==
X-Google-Smtp-Source: ALg8bN5PaEbA5PsU7rvuPCbFT/pBl5VRm7rba2+X/dyBamltOknUXtwp9QC/JL8zmoJv0dl2LIkhb2xYtDzLxqdrS+M=
X-Received: by 2002:a24:4606:: with SMTP id j6mr9048166itb.10.1547803877553;
 Fri, 18 Jan 2019 01:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-75-pclouds@gmail.com>
 <CAGZ79kaAf7NytateigG_f6-UbeJKa2bno9+4zC7R4uqfFB77FA@mail.gmail.com>
In-Reply-To: <CAGZ79kaAf7NytateigG_f6-UbeJKa2bno9+4zC7R4uqfFB77FA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 18 Jan 2019 16:30:51 +0700
Message-ID: <CACsJy8A7SpCnXHfYg=Tx4kyUwONbAMufWkhuV4pfyu+BdFbWmQ@mail.gmail.com>
Subject: Re: [PATCH 74/76] range-diff: use parse_options() instead of diff_opt_parse()
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nOn Fri, Jan 18, 2019 at 2:46 AM Stefan Beller <sbeller@google.com> wrote:
> > and we get a
> > looong 'git range-diff -h'
>
> This is an interesting tidbit to put into the commit message.
>
> range-diff is interesting in that in it is unclear where the options
> should take effect. My mental model of range-diff is
>
>     diff --inner-options-1 <range1> >tmp1
>     diff --inner-options-2 <range2> >tmp2
>     diff --outer-options tmp 1 tmp2

This outer/inner refer to the first and second +/- column in
range-diff output, right?

> and for most operations we would want to have the inner
> options to be the same. However there are cases of changing
> one of the inner options, example at
> https://public-inbox.org/git/20180810001010.58870-1-sbeller@google.com/
>
> But even when we assume this to be a corner case for
> weird research of our own options, it is unclear to me
> if the options should apply to the inner diffs or to the
> outer diff or both.
>
> As far as I read the patch, the options are applied to both
> inner and outer, which may be ok?

As far as I can tell, I'm not changing the behavior of this command.
Whatever options accepted before are accepted now. I'm simply exposing
the problem. So no I don't know if it's really ok.

This is not restricted to range-diff either. "git diff" uses
revision.c parser which accepts a whole lot of options that only make
sense with "git log" and friends. Even the "log-tree" command family
has separate set of options for each command, see the "ifdef" in
rev-list-options.txt.

That, I think, would be the next step. To somehow filter options by
command, remove unused ones. Frankly I only have a vague idea how to
do it now ('struct option[]' manipulation).


>
> I would think that sometimes you want to control only the
> inner options, e.g. file copy/rename/move detection
> thresholds. And sometimes you want to control the outer
> options only (white space error highlighting?)



--
Duy
