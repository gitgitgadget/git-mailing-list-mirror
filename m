Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C4D1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdFEXhH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:37:07 -0400
Received: from groups.winserver.com ([76.245.57.69]:61823 "EHLO
        ftp.catinthebox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdFEXhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:37:06 -0400
DKIM-Signature: v=1; d=winserver.com; s=tms1; a=rsa-sha1;
        c=simple/relaxed; t=1496705818; h=Received:Received:Message-ID:
        Date:From:Organization:To:Subject:List-ID; bh=5j5U1J26CqyZg9if7o
        XVXyEc4l0=; b=eNmS462pnFN+PzGw5g8T/CY2QkazlrChHImcbuSPZqYJzwm9Vd
        Pc8AqrHJhj1ugszxvEQ+QaONuBIzCrdZyBqnB2Q6qXrPL8/EE3Rscyd7OEsvW2lH
        wTnr8EKsyOLmQYnhP4G8gWU4wdZW0YEvOeeLz/jSs91Wq82+1a82bAB1o=
Received: by winserver.com (Wildcat! SMTP Router v7.0.454.5)
          for git@vger.kernel.org; Mon, 05 Jun 2017 19:36:58 -0400
Received: from [192.168.1.68] ([99.121.5.8])
          by winserver.com (Wildcat! SMTP v7.0.454.5) with ESMTP
          id 1064711806.1.4492; Mon, 05 Jun 2017 19:36:57 -0400
Message-ID: <5935EB1A.5010100@winserver.com>
Date:   Mon, 05 Jun 2017 19:36:58 -0400
From:   Hector Santos <winserver.support@winserver.com>
Organization: Santronics Software, Inc
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.8.1
MIME-Version: 1.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git "Keeping Original Dates"
References: <5935C999.5060801@winserver.com> <1C2B896999CB4549BCAC61EB369E932E@blackfat> <CACBZZX7VpmEjbzwGd+S15xVLRrkYRxqcf0LUKF1B7pAsd7Lr4w@mail.gmail.com>
In-Reply-To: <CACBZZX7VpmEjbzwGd+S15xVLRrkYRxqcf0LUKF1B7pAsd7Lr4w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------000706070600010400020407"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706070600010400020407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/5/2017 6:06 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jun 5, 2017 at 11:25 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>>> -----Original Message-----
>>> From: Hector Santos
>>> Sent: Monday, June 5, 2017 5:14 PM
>>>
>>> I'm implementing GIT.  If there an option or compile/version that "keep"
>> file timestamps?
>>
>> That is not in the tree data structure, see below.
>>
>> root@blackfat /projects/tipsoftheday
>> $ git cat-file -p head
>> tree 4ca3c2a853c8e817d7de8563c331899cace8ee85
>> parent 2a33f293df6df0d3978612e41fb1ecd52e2450a5
>> author Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400
>> committer Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400
>>
>> add JDK to CM
>>
>> root@blackfat /projects/tipsoftheday
>> $ git cat-file -p 4ca3c2a853c8e817d7de8563c331899cace8ee85
>> 040000 tree 76094b81b3877b5b27cd4fe518fa0708af3cefed    admin
>> 040000 tree c66a88871c285e1485f92be0f8fa47185d94d0b3    client
>> 040000 tree 460495af209a580e65b5d0b38132d774ddb283b7    database
>> 040000 tree 264b191b036180039f3fd8c5d56c2b6800cb2ca2    doc
>> 040000 tree dd128195971f7bafa56371aa6027d7c6bc80f351    middleware
>> 040000 tree 7861fd39923950d501d4e39aeac4762f7daaca6b    reports
>> 040000 tree 2ad3dedf0313ae775321c88c53741a4b4a7e87b0    tools
>>
>> I wish it was an allowable extension, the date could be between the mode and
>> object type.
> Yes it's not part of the tree structure, but in this case you can
> simply set/update the mtime to the date of the last commit that
> modified the file.
>
> It can be a bit expensive to bootstrap that, and git doesn't help you
> along at all, you need to do it via hooks or some script you run, but
> that's a neat way to shove it into the datamodel if you need this for
> some reason.
>
>

Do you see any technical issues with using programmable hooks or 
something like this would have to be patched in? I am giving it a 
serious thought to exploring a fix to the Git Daemon over the wire 
completion issues on Windows. It appears to be a Half Close socket issue.

-- 
Hector, Engineering & Technical Support
Santronics Software, Inc.
http://www.santronics.com (sales)
http://www.winserver.com (support)
http://www.winserver.com/AupInfo (Online AUP Help)
Office: 305-248-3204


--------------000706070600010400020407
Content-Type: text/x-vcard; charset=utf-8;
 name="winserver_support.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="winserver_support.vcf"

YmVnaW46dmNhcmQNCmZuOkhlY3RvciBTYW50b3MNCm46U2FudG9zO0hlY3Rvcg0KZW1haWw7
aW50ZXJuZXQ6d2luc2VydmVyLnN1cHBvcnRAd2luc2VydmVyLmNvbQ0KdGVsO3dvcms6MzA1
LTI0OC0zMjA0DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------000706070600010400020407--

