Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A082055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdJ2D24 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:28:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:55275 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdJ2D24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:28:56 -0400
Received: by mail-qt0-f193.google.com with SMTP id z19so12692730qtg.11
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1sVjYE01eD0kQwuYGjrz+mC/8BrkDU1Iy43lEAiuRws=;
        b=QhCP4EEysmyI7irLOPeFysDOBKFw6BYa+ZZpVwctKH2kQNYPQQ4ibqOIpCISdszms8
         wqu3qFfGaaZAnqU0gODqbPO+5dy+RR6+S4pMsDiw275J2NLroKZKr89PRBqMXVhIr1Ns
         LTe07CzqzoojC8aEfERO1aZADeAnRey7h3q1ZvouuwMuJXVFm+vdc2QbfBN8Y7RjmH1b
         gL0Q7LDAdMmYOHLEqLgnvuEeb/Btnd9DouqaAB+2f8Ngnq4mp1tdssNHT3DrW+lxH1fo
         CgvXg1enqoVNFFDSp7jIeW4WeqYOgXeqUCr4l3alrsoMUdzcIbwF4jQZ+ESZ5Z7lhhmC
         dIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1sVjYE01eD0kQwuYGjrz+mC/8BrkDU1Iy43lEAiuRws=;
        b=anOb/IJkZOnlGrgcGM/c8ie4ps4FsGTp7atQUV2iwZrtqqpQr2U3yFk14Z8VQzBMVc
         TxsrWlp6G/s4yk4q4svlEiR2XTS7u2H0NafxuwCiK2db14v99z6NHpKo3jLC6aUs3PGY
         pgulxr1bBtmNeSmQZNLSa79YueEJLxDn2GcBD5v9+RvEt9eEMbZzViDqEcuA6tjfa73v
         tbd0znq8BdAHNujdDn5h13aINOZzfM/EHHiAavpsox8ilvHUX3JZqh4tL6dZorVZkO1W
         ncsQf1PxV2lOnd/B5vxUgPOyKyTGF5Ez4FEBA3C3rjVQVcq8SB2GU7nIcoOQvoiMrUen
         pYpQ==
X-Gm-Message-State: AMCzsaUb1ds6SeeDY6Ul6gbIIKgvS2P3v1FyAjEdyMt3Lj1ijOzEu7DJ
        ESmg0ROgk2q1rXfYwlnEs+6y6Ec+z1b9xgYlxbjJJA==
X-Google-Smtp-Source: ABhQp+QrHieGQZmfcHfJ1vMICulo0IesnmfuhSOEGF/+bw6egtTozv94lZgttg1hATNWCnnyQEGsYCoWjU3uxjavLVQ=
X-Received: by 10.200.47.77 with SMTP id k13mr8049403qta.298.1509247735109;
 Sat, 28 Oct 2017 20:28:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Sat, 28 Oct 2017 20:28:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
 <20171028004506.10253-3-sbeller@google.com> <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Oct 2017 20:28:54 -0700
Message-ID: <CAGZ79kYpPga-aWmJYXCXT1WyvfeEKnwXEXxq2E0YNYanhUw-Xw@mail.gmail.com>
Subject: Re: [PATCH 3/3] builtin/describe: describe blobs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 10:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 27 Oct 2017, Stefan Beller wrote:
>
>> Sometimes users are given a hash of an object and they want to identify
>> it further (ex.: Use verify-pack to find the largest blobs, but what are
>> these? or [1])
>>
>> The best identification of a blob hash is done via a its path at a
>> given commit, which this implements.
>>
>> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
>
> I also came up with a script to do that:
> https://github.com/msysgit/msysgit/blob/master/bin/what-made-this-repo-so-large.sh
>
> Your method is much more elegant, of course (it describes the commit in the
> same run as it finds the object, and it does not output tons of stuff only
> to be filtered).

That was the task I was given. Discussion here turned out that users
mostly only ever care about commit object names, trees and blobs are
only useful when specifically given.


>
>> @@ -282,6 +283,50 @@ static void show_suffix(int depth, const struct object_id *oid)
>>       printf("-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
>>  }
>>
>> +struct blob_descriptor {
>> +     struct object_id current_commit;
>> +     struct object_id looking_for;
>> +};
>
> Personally, I would call this process_commit_data, but I do not mind too
> much about the name.

I'll take any naming suggestion, as this code was assembled in a hurry using
copy/paste and trial&error as the high-tech methods used.

>> +static void process_object(struct object *obj, const char *name, void *data)
>> +{
>> +     struct blob_descriptor *bd = data;
>> +
>> +     if (!oidcmp(&bd->looking_for, &obj->oid))
>> +             printf(_("blob %s present at path %s in commit %s\n"),
>> +                     oid_to_hex(&bd->looking_for), name,
>> +                     oid_to_hex(&bd->current_commit));
>> +}
>
> s/name/path/
>
>> @@ -295,9 +340,14 @@ static void describe(const char *arg, int last_one)
>>
>>       if (get_oid(arg, &oid))
>>               die(_("Not a valid object name %s"), arg);
>> -     cmit = lookup_commit_reference(&oid);
>> -     if (!cmit)
>> -             die(_("%s is not a valid '%s' object"), arg, commit_type);
>> +     cmit = lookup_commit_reference_gently(&oid, 1);
>> +     if (!cmit) {
>> +             if (lookup_blob(&oid))
>> +                     describe_blob(oid);
>> +             else
>> +                     die(_("%s is not a commit nor blob"), arg);
>
> s/not/neither/
>
> Nicely done, sir!
>
> I wonder whether it would make sense to extend this to tree objects while
> we are at it, but maybe that's an easy up-for-grabs.

I can look into incorporating that, too. What is the use case though?
(Is there any error message, common enough that users want to
identify trees?)

Thanks for the review,
Stefan
