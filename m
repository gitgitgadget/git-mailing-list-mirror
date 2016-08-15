Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C595C1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 06:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbcHOG2V (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:28:21 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35551 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcHOG2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:28:20 -0400
Received: by mail-it0-f49.google.com with SMTP id u186so31542567ita.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:28:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/sFme9wx3z0IWoQ7R7RVpkrsM1MXhHJI7pkVvL7kQZY=;
        b=haNjG5pgCJpxxL15r22nlW6vk6wpGHS+Dwb4CytoYGq50u1Aiom5PMDcmzydUKYVjv
         KnzhnTkhdMUEpcLyK/XpRLdSpdAD/LlArPYqMbvuTp6D7mlTE2LvZ44+KavaTrry3TcS
         8acVby7TUBmJcNl/+MR7cRVidPAgId4C3ahq060dHho5aTK+QRh5DPuNVcEpeTUBScvx
         xlQQdGFLEktZm8zatGe7dVx9kucMBJoFTqNs+FTaD2W7S/TqLbpmNVqoifufLtT90cGC
         jRvRGqDi2e+txtBRZgI+/a5TfSgGHRnGRMCBWnol27w0xPHVWGpJLW/hFP0wus+Rj+Qo
         +C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/sFme9wx3z0IWoQ7R7RVpkrsM1MXhHJI7pkVvL7kQZY=;
        b=Ogu/UYSiM28YPs+4wuRitCfIhUnnAxuVyZWEVWi9xV1ke/xjUhYS2EowxNfIeyng2c
         yQgDuC0HOFjyVnBF6Ae2DFf22xojWBtcWbvUJirt25OsnVqbQkpI6IeTcj5zmtJPuPBT
         C/cUSIPdjN2fA5MGNsB5BSfsIyVWU1SaXWRnyIn08CNPUyRQ2OBxn5+JnGuRWA7922zs
         Fp+OqGeb5GVSpN54PMn2jvtKGEyuseEavWKwbfAqk2YVnwJWCijVgyhUFI2qsIzFExnB
         jOoXXz7l9LK9FKuZwz8aR/EszoiJTWAZE/li1HL8pLmCYuau066ePat2GJk0PE/u7An+
         URgg==
X-Gm-Message-State: AEkoouucPj3TtbnlmsJ0WXX/dD5SC1KXUf8dwNTDOZNgFZ1WAezlw1ij8BBh3kRnxQHQ4EsmyywTvYtM4PT5/EHx
X-Received: by 10.36.228.138 with SMTP id o132mr11754062ith.49.1471242499262;
 Sun, 14 Aug 2016 23:28:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 14 Aug 2016 23:28:18 -0700 (PDT)
In-Reply-To: <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com> <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 14 Aug 2016 23:28:18 -0700
Message-ID: <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 12:15 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Aug 13, 2016 at 1:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Aug 9, 2016 at 12:27 AM, Stefan Beller <sbeller@google.com> wrote:
>>> is what you want. Maybe we want to see a patch that adds the reverse
>>> functionality as well, i.e. git-am will store the the cover letter as the
>>> branch description and git-merge will propose the branch description for
>>> the merge commit.
>>
>> I almost suggested the same, but there is a problem with this
>> approach: if you're are on a detached head, where does git-am save it?

What would the user expect? We can have a range of expectations:
1) reject and error out git-am
2) warn about not saving branch.description and continue with am
3) have a (maybe special) branch.HEAD.description thing, same for FETCH_HEAD etc
4) have a config option to choose between 1 and 2, if unset default to 1

I think 3 is a bad choice.
4 seems reasonable to me, though I wonder if some people use git-am in
a scripted workflow with a detached head and then create the branch afterwards?
So

5) create a branch for them? (such as $(date)-${subject})

My gut reaction doesn't like 5 either.

>> --
>> Duy
>
> Also, what about the case where a branch already has a description
> such as is the case for something other than an integration branch.
> How does git-am know the difference and ensure it doesn't overwrite
> anything? Not everyone uses separate branches for each patch and such.

I would imagine this is similar to the pull requests on the linux
mailing list, i.e.
how it is with merges. Back in the time we did not open the editor for you to
talk about the merge you just did, and then we started doing that.

So what to do when the description already exists?

We could amend the description separated by a

     # comment, below was added:

line or such and then open the editor asked for user input.

Thanks,
Stefan

>
> Thanks,
> Jake
