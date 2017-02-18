Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE59D201A8
	for <e@80x24.org>; Sat, 18 Feb 2017 11:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdBRLPR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 06:15:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdBRLPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 06:15:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so6455101wmu.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/qN1qwGcjYOcB2aVntuQfy/AOzWXBVU5hEZ1FvYVRkk=;
        b=YNRZB1n4QmUQtj5ERhF9MaaNsWszSgbo6JEsctMwPsritdeoJWPm+YEpWfVM+RYK0J
         vIucp+vAPeyAwNqWFehJcsd0yBMQWt8esnsn9b1C3jZUqoP0WnjGykONUgXO+Bw8LKaP
         hb8RhfJqHUXcJ/iEAYzsG4Yc26vvV3c0izU2PsdG3O5/Q2H/J8FkH57M0I2od9r5O/5G
         xy72XBtERE1Bz4pqSnKMNM4LP+p54936PsP+LftZCUCiEMlNcEyHlwezR48PpHObGEmA
         SFkyiIPTcY1cX84YCzYqmU9t49H8tv9JQyNWP4C6PcQ7RMcdsLqIys6yuRBdepnUAJhF
         rKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/qN1qwGcjYOcB2aVntuQfy/AOzWXBVU5hEZ1FvYVRkk=;
        b=Zp3GACaqwZ2wMMtXqi/1trvHBp6pbyBP232YYiFfZqS/+4SYBWhKbZ7Ya/1qVBQY2P
         0kL1HTAWeyBeukwAWCtqYhDyPsTvdhVOWs55S7DX0aCmHzU5PCHbf2a+9eBRSZtwDRh7
         Xl8Mosg8vjgNfex9hm2vVD8Tzeo7cmw4SpyobuGUeYMO3E86JdvXoTJ4tWvKKOLog30e
         4EKPJT1P3FCbx69HKeVv8ou0wX7p4m0lhmaP+jWiwswJVVbx5T3a6QCmGDrGTbVT+1ku
         BWzVHHNG9aQOuBLMAU3qOtUtw1ssUIZJvLPjvh6EFTn390tn8C/n1xzB4suAs+7VQ5ps
         nLHQ==
X-Gm-Message-State: AMke39leJ7emDX0s8t5ap7oxDop00BnSQxi0ZkxGTSNddvy5eNP3sAlVSbLonpXeQEPOaIWDZS7Jxwim7OgFNA==
X-Received: by 10.28.186.197 with SMTP id k188mr8630787wmf.25.1487416513913;
 Sat, 18 Feb 2017 03:15:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Sat, 18 Feb 2017 03:15:13 -0800 (PST)
X-Originating-IP: [77.178.91.90]
In-Reply-To: <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
From:   Alex Hoffman <spec@gal.ro>
Date:   Sat, 18 Feb 2017 12:15:13 +0100
X-Google-Sender-Auth: bwY9YjSIl_AB_4117H_Iaa4ALWs
Message-ID: <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> First of all this is confusing, as this commit cannot be reached
>> starting from "v.good".

> Hm, IMHO it shows that your example is pretty artificial (although you
> might have come across it in a real-world scenario): you introduced a
> new feature in f4154e9 (and it worked) and you broke that feature by
> making the merge 671cec2. However, the feature (that broke in 671cec2)
> did not even exist in 04c6f4b; so a test on the feature would not fail
> (leading to "bisect bad" as in the example), it would not exist (leading
> to "bisect skip").

No one commented the fact, that I find this very confusing. Don't you
find this confusing? I will underline, that 'git bisect good v.good'
will fail if the commit 'v.good' is not a parent of the bad commit,
meaning there MUST be at least a path between 'v.good' and 'v.bad',
thus I would expect it looks on this path ONLY. Beside that, this is
what I understand by 'binary search' (to search on this commit path).
You might find this example artificial, but I doubt git is/was
intentionally designed to work with  'natural' examples only (no
matter how you define 'natural' and 'artificial').



>> In other words: bisect assumes that your repo is usually in a good state
>> and you have a commit that changes it to a bad state. In your case you
>> have a repo that is in a bad state and you have a commit that switches
>> it to a good state and later you merge a bad-state branch and you have a
>> bad state again. It is not made for that use-case, I think.

> Correct. The assumption of bisection is that there is only one transition between GOOD and BAD. By violating that assumption, anything can happen.

I did not find that in the manpage or did I miss it? Why would someone
assume that the commit graph looks in a certain way? I assume, that
'git bisect' was not thought through and that it considers the first
directed path between v.good and v.bad, instead of all paths (in my
example graph there are two such paths). I will also underline that
git bisect was designed to work with multiple good commits and one bad
commit (also multiple paths), but probably NOT with multiple paths
between the same pair of good and bad commits.

VG


2017-02-18 10:12 GMT+01:00 Johannes Sixt <j6t@kdbg.org>:
> Am 18.02.2017 um 00:21 schrieb Stephan Beyer:
>>
>> On 02/17/2017 11:29 PM, Alex Hoffman wrote:
>> *   7a9e952 (bisect bad) <BAD>
>> |\
>> | *   671cec2 <BAD> <--- expected
>> | |\
>> | * | 04c6f4b <BAD> <--- found
>> * | |   3915157 <GOOD>
>> |\ \ \
>> | | |/
>> | |/|
>> | * | f4154e9 (bisect good) <GOOD>
>> | * | 85855bf <BAD>
>> | |/
>> * | f1a36f5 <BAD>
>> |/
>> * 1b7fb88 <BAD>
>>
>> The <BAD> and <GOOD> markers are set by your definition of what good and
>> what bad commits are.
>>
>> [...]
>> In other words: bisect assumes that your repo is usually in a good state
>> and you have a commit that changes it to a bad state. In your case you
>> have a repo that is in a bad state and you have a commit that switches
>> it to a good state and later you merge a bad-state branch and you have a
>> bad state again. It is not made for that use-case, I think.
>
>
> Correct. The assumption of bisection is that there is only one transition
> between GOOD and BAD. By violating that assumption, anything can happen.
>
> -- Hannes
>
