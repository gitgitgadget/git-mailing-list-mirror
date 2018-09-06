Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B481F404
	for <e@80x24.org>; Thu,  6 Sep 2018 22:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeIGDcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 23:32:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeIGDcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 23:32:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5996884pff.9
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPhBh7ZUrrDDnFMK5DCmNp8gHApbpM2eiaXXoWqUQG8=;
        b=amFPZCx4nhYq431vIorETdj7SibFtsPfdmH0iN3hSvJ9Otd71rDprB4GccZMhp9KaI
         Rp0mDb7Zg8q/OQ8dKChGw+/dgzlAT5DC5+Tv8lOPqI/wSNHoMGByw1SyWfJMr+nFESY1
         NVv4Wab2FEyhhuslSsdUJyB6IkCa1u56PwZo7uHJEyqCWHC86vc883H2IrkRC9Zu2SHW
         awuOuGKoPWCCg+JJc2Cvgo0nYsbBegmx+DLCt/nsH5OkEPd9TQArkzm8RqE+5jEdAP9m
         d2KaWgq4zaF601p1k+WtrP7DGnNsIskiZsk0KyiG7wzctApD5TCA/s156hHxrk6IYmnP
         wMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPhBh7ZUrrDDnFMK5DCmNp8gHApbpM2eiaXXoWqUQG8=;
        b=DGZUwKoTe1M/S+e/XoCTNA817hdBf1wFkumvSb4L0q7sCJ5/gaDOuv7l+U8EMOljeo
         jTqYWpa88IbrybOt5ZHk2nZGX40kuz2d1EsIf4/ENNbzHb98nwntTIzMYCfvttauXATd
         douzZK/ktLqMJs8QLXGYh7uUVozblNHqpLTF/IDIpm9HbZMt/a1B66qE7N0ukgHahWP1
         EMQPBm4W+OhVS49lNZHofcS+2Cun0xhITE7JOLH5rxj4Ypv9+NGyY5UhneKvwFCQNnDQ
         4yH+HJNAG7xDQ6TaEzmbpX6o4iE+lAzbPlcPkVRqyF44cSMPHbaVmjcd3i08wsPpkbDw
         axRw==
X-Gm-Message-State: APzg51DL6JIuXqqOElN95fLQBwQcrIuiFmLjWGv25Bdvn6gtxKvLTIfV
        k6kOqLqou7RZqtTIUyU4tKD2IuY6
X-Google-Smtp-Source: ANB0VdbpPKk4uCoKx5oB0z8yKRr1gbdUGdMTG9EwnQCOIyXCr9EP83eabh4Qj65mT+shynWOGtz7gA==
X-Received: by 2002:a63:8543:: with SMTP id u64-v6mr5383233pgd.248.1536274466061;
        Thu, 06 Sep 2018 15:54:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f67-v6sm18631618pfe.75.2018.09.06.15.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:54:25 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:54:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] submodule.sh update --remote: default to oid instead of
 master
Message-ID: <20180906225423.GB81412@aiede.svl.corp.google.com>
References: <20180905224825.13564-1-sbeller@google.com>
 <20180905231006.GC120842@aiede.svl.corp.google.com>
 <CAGZ79kY_O+y0=1qMr2tw2cw3ULhhjTPQ-G5swa+KNXKLKSOSYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY_O+y0=1qMr2tw2cw3ULhhjTPQ-G5swa+KNXKLKSOSYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Wed, Sep 5, 2018 at 4:10 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Broader comment: do you think people will be surprised by this new
>> behavior?  Is there anything special we'd need to do to call it out
>> (e.g., print a warning or put something in release notes)?
>
> I guess. Not sure how to approach this best. Maybe we can
> extend the output of 'submodule update' to print that branch names
> instead of hashes for the configured case and keep printing hashes
> only for this case. Although that would not help someone who relies
> on the default solely.

Thinking more out loud: often the simplest migration path involves
multiple steps:

 1. Warn in the case that is going to change, with no behavior change
    yet.

 2. Treat the case that will change as an error.  This should
    help flush out cases where people were relying on the old behavior.

 3. Introduce the new behavior.  Warn that old versions of Git don't
    support it yet.

 4. Eliminate the warning.  You're all clear now.

Sometimes some of these steps can be combined.

Another possible approach is to measure.  For example, is there some
way to find out how many people are relying in this "git submodule
update --remote" defaulting behavior?  One example of this approach is
to make the change (all in one step) in "next" and deploy to some
relevant subpopulation and see if anyone screams.  By making the
change in "next" instead of something with more stability guarantees,
you get the ability to roll back quickly.

There are other tools at our disposal --- e.g. command-line flags,
config, other kinds of research.

Here my first instinct would be to say this should be a command-line
flag.  To start out, we can keep the historical behavior as a default,
but introduce a command-line option for the new behavior.  This way,
people can pass the negation of that command-line option if they want
the older behavior, throughout the transition.

For example (please ignore names):

 Step 0: introduce

	git submodule update --remote --default-to-master; # current behavior
	git submodule update --remote --no-default-to-master; # new behavior

 and treat plain "git submodule update --remote" as --default-to-master.

 Step 1: when neither --default-to-master nor --no-default-to-master
 has been passed, warn when encountering a submodule with no branch
 and treat it as "master".

 Step 2: when neither --default-to-master nor --no-default-to-master
 has been passed, error out when encountering a submodule with no
 branch.

 Step 3: when neither --default-to-master nor --no-default-to-master
 has been passed, warn when encountering a submodule with no branch
 and treat it as pinned.

 Step 4: eliminate the warning.

What do you think?

Thanks,
Jonathan
