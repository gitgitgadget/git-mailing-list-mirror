Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8481A20248
	for <e@80x24.org>; Sun, 21 Apr 2019 13:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDUNDz (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 09:03:55 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:25491 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfDUNDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 09:03:55 -0400
Received: from [192.168.1.12] ([92.21.144.249])
        by smtp.talktalk.net with SMTP
        id IC8NhWY9UnuQZIC8Nhsu8M; Sun, 21 Apr 2019 14:03:52 +0100
X-Originating-IP: [92.21.144.249]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=Dgn57AdRJ25t4HaDIyq3iQ==:117
 a=Dgn57AdRJ25t4HaDIyq3iQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=ZLGELXoPAAAA:8 a=NEAV23lmAAAA:8 a=pM9yUfARAAAA:8
 a=caPJz1QpAAAA:20 a=0mj1ufm8AAAA:20 a=3dcCvHVhAAAA:20
 a=y0lLaKTDth0giv1MyqYA:9 a=QEXdDO2ut3YA:10 a=CFiPc5v16LZhaT-MVE1c:22
 a=YH-7kEGJnRg4CV3apUU-:22
Subject: Re: I messed up my own git tree and I don't know how to fix it.
To:     rob@drrob1.com, Adrian H <adrianh.bsc@gmail.com>
Cc:     git@vger.kernel.org
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
 <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
 <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <4b388e60-703d-8ac3-ef74-211924374249@iee.org>
Date:   Sun, 21 Apr 2019 14:03:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfE1oNepTS+ah5sx3rDUOrvscDj+wyypaX9J5SsLMhYudaU9DR/oFH6SOzLGD6/g2GHyRnakrf+EoPLQx2qozrxcL2Xx0qwjTjuezj9DSrDmr8vBWw5LR
 eYgRZIS4DN7F7+nk054soxEBdkEaarTyvCshQZTF4GRl9xiCr1R7mwsSuVVD9chPMk7t2fs4SSoo3Ofxqe/dUMvTSQGNVNMxw8zka8SizksOJD3G+Mt4qvD+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rob,

On 21/04/2019 13:34, rob wrote:
> didn't work.  I did not get any error messages, just didn't work.  
> After I did
>
>   git reset --hard
>
>   git status
>
> I see the same 3 files that say changes not staged for commit: 
> modified and it lists the same 3 files.
Could this be that the file timestamps are being changed in the 
background and git is detecting those timestamp changes, even when there 
is no change to the files.
- Just as thought.

(In-line posting is preferred, so as to see the replies in context)
Philip

>
> --rob
>
>
> On 4/21/19 1:03 AM, Adrian H wrote:
>> If I understand the commands you are using correctly, you are
>> referencing the remote repo.  You need to reference the local repo.
>> So try using the following commands:
>>
>> git checkout -- alecthomas/gometalinter
>> git checkout -- kisielk/errcheck
>> git checkout -- rogpeppe/godef
>>
>> Or if those are the only files that have been modified, then you can
>> use the following single command:
>>
>> git reset --hard
>>
>> and that will reset all files that have not been staged.
>>
>> HTH
>>
>>
>> A
>>
>>
>> On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>>> I have my own code at a github repository, using Go.  Part of using Go
>>> libraries not part of the official Go people is by using a system they
>>> call go get.  This essentially uses git to, well, go get source code.
>>> Mine are at github.com and golang.org.  My computer runs LinuxMint 
>>> 19.1.
>>>
>>> I used goland IDE from jetbrains to run go fmt on my entire project.
>>> Now I am getting this message that I cannot get rid of:
>>>
>>> changes not staged for commit:
>>>
>>>     modified: github.com/alecthomas/gometalinter (modified content)
>>>
>>>     modified: github.com/kisielk/errcheck (modified content)
>>>
>>>     modified: github.com/rogpeppe/godef (modified content)
>>>
>>>
>>> I do not want any changes to central repos to be tracked or committed,
>>> but I cannot undo this.  I tried, for example,
>>>
>>> git checkout -- github.com/alecthomas/gometalinter
>>>
>>> I don't get an error message but it does not do anything.  The file is
>>> not changes, and git status show me the same information, ie, these
>>> files have changes not staged for commit.
>>>
>>> I do not know how to restore these files to the state they were in in
>>> the repo, and to have my own git tree not to flag this as an unstaged
>>> alteration.  Running rm -rfv on the repos on my computer, then running
>>> go get to restore them does not change git status. It still sahs 
>>> changes
>>> not stated for commit: modified.
>>>
>>> This happens for the above 3 tree items.
>>>
>>> How do I restore these to the github remote repository condition and 
>>> not
>>> have my own git tree mark these as changed?
>>>
>>> --rob solomon
>>>
>>

