Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EC41F42D
	for <e@80x24.org>; Sat, 19 May 2018 06:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbeESG5X (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 02:57:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45532 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESG5W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 02:57:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id w202-v6so17012594lff.12
        for <git@vger.kernel.org>; Fri, 18 May 2018 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5REQO19uuo6g4H2ZGw8JEv7cY/UubVtUrNl+MlCC32M=;
        b=GoNmLo6jAlQA2my9cf49D6+wCJcn/NT4zrx0Yaz/cQA5b4HIkscCCTLNQx7t5lDXrY
         iQSAfuyDeCzZZuZJ+gpNSgpvwcIQQ15fLl4LbZ2xwgllhDhxXTN6xmofrQ3yjLJHWvkG
         LmK1osMdp8XlQGc6JAk5+LyQbsZDCQ/E7nIEEIvZxZMmy/3A4CXsJexGL2cA4FN+On+o
         zTKOxIbabwVm0JBxdP/xsffnzJLRUl2X5l6pbnn8qedrHJ9UChUuPSX1+zfzctAFUt3p
         ClAbk6piQbgyujR8ItrDZkxVHtnh3o0r4Tw9OULoKdXzL1Jia6DEKb5pl4LJ/8LWulQr
         6pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5REQO19uuo6g4H2ZGw8JEv7cY/UubVtUrNl+MlCC32M=;
        b=PWcdZmqn9U5jYdV3WPjLQg8ArsBbNKOgwOtybHdlIeu6S9gOQ94wd70ka7/bJEL/r7
         7ALnf6GNAC2J2B9HKlG6rKbwyN/ydX60Jr+i/4gjXkzCaUsLhQSfSKXd2PWPSNb6Oo9s
         xmAShpVL1YlOSRYSbRctw25BfU7eik0UWesKUDBiV1TCuqd27KRb9YgZLZWvc/oKhg6t
         neU4pWLV7rXGGu0Dvds4jCjcYIwczgnI1nGmPH5kFfVSQIt4FzobtVST7Vtoaw3LvsKe
         2EitDNzmZSmPXcYD7nDTW05WZxAlyio99e5sKOy8objBa+KiSe1PhnW+qvk9lq5omas9
         I7eQ==
X-Gm-Message-State: ALKqPweskzMrzy/2bfWGXlq4QJikZWjCCvCF4UgMOUUipDkwbCgJ2UsV
        3oiwXxmBBe636JHDERSXG0A=
X-Google-Smtp-Source: AB8JxZqeGNs+bE6cPaUBunOETvjyMDjuLto69nfe33xVcKHjS4SP6ypn4d9digodpWeOi8a7rltRZQ==
X-Received: by 2002:a2e:4152:: with SMTP id o79-v6mr7853534lja.3.1526713041343;
        Fri, 18 May 2018 23:57:21 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l67-v6sm2271121lfk.33.2018.05.18.23.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 23:57:20 -0700 (PDT)
Date:   Sat, 19 May 2018 08:57:18 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 00/11]
Message-ID: <20180519065718.GD14755@duynguyen.home>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 03:21:07PM -0700, Stefan Beller wrote:
> > If you have time, yes translate them all. I don't see how any of these
> > strings are meant for script. If not, just _() the new string you
> > added is fine.
> 
> > With a majority of call sites dying like this though, I wonder if we
> > should just add repo_read_index_or_die() with die() inside. Then the
> > next person won't likely accidentally forget _()
> 
> So this comment tricked me into coming up with a patch series. :)

Yay! (And sorry, Junio)

> 
> Each patch is themed, I tried to make each commit special w.r.t. reviewers
> attention.
> 
> We'd start out with a resend of the origin patch, which is boring.
> 
> Then we'll move all similar cases into one function (no-op for
> introducing the repo_read_index_or_die function as all callers will have the
> same error message and the same localisation).
> 
> Any following patch will be more controversial then the previous patches,
> I would expect, as we introduce more and more change.
> 
> The last patch is just an attempt to finish the series gracefully,
> and may contain errors (sometimes we do not want to die() in case of
> corrupt index).
> 
> Is this series roughly what you had in mind?

This is better than what I had in mind, in fact.

--
Duy
