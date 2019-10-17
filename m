Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6501F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbfJQNdM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 09:33:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52356 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfJQNdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 09:33:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HDNtRw096635;
        Thu, 17 Oct 2019 13:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=lJRbZTgg/EUbW624nJ8C/GRS6p8r210DOZWdtGIn12Q=;
 b=ixhQd+P4HH325gdVOLqTwNwpm/iyMGHswVh4cSD/6YN+fn5iBERv3YP0Qsca/2zOsyf1
 utxLQ8cRhuMaXw0VM67xhUzxOBBymZS4CBpm41jdJyF0Fz0vnwxfOiSIZ6yhoRW7CFoQ
 F0ChLBkkETkiP02mtnu2oTfAv+lZXSDWAV4je2I7C/4plxAnlXVDuSxghGW2r2YeoMDq
 jJCbqeHUv/lcLT/lHfU18tMN1za6iNgJQ/LKej+2F49ymPj6nWKsunedzHzEa9qREVXa
 5wRSGzfEwIly5XcyWFxyAjNLrZvzETNTL0g6pjOy1MpcYqpGi/kHxZQyb/GUCtie/yEw Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vk68uxcgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 13:33:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HDMtei139849;
        Thu, 17 Oct 2019 13:31:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vp3bkrdyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 13:31:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HDV1H1023731;
        Thu, 17 Oct 2019 13:31:01 GMT
Received: from [10.175.56.189] (/10.175.56.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 13:31:01 +0000
Subject: Re: email as a bona fide git transport
To:     Junio C Hamano <gitster@pobox.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <xmqqeezc83i6.fsf@gitster-ct.c.googlers.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <9ec63ec0-c322-610c-e1b8-b673b983dc74@oracle.com>
Date:   Thu, 17 Oct 2019 15:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqeezc83i6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/19 5:17 AM, Junio C Hamano wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
> 
>> Step 1:
>>
>> * git send-email needs to include parent SHA1s and generally all the
>>    information needed to perfectly recreate the commit when applied so
>>    that all the SHA1s remain the same
>>
>> * git am (or an alternative command) needs to recreate the commit
>>    perfectly when applied, including applying it to the correct parent
> 
> You can record and convey the commit object name a series is meant
> to be applied on top already, and it in general is a good way to
> give a wider context in order to explain and justify the series.
> 
> On the other hand, "all the information needed to recreate..." is
> not very useful.  If you want the commit object to be exactly what
> you want to see at the tip of the end result, you are better off
> asking your upstream to pull.  Using e-mail for that makes you and
> project participants give up a lot of benefits the workflow based on
> e-mail gives you, the biggest of which is the ease of giving
> suggestions for improvements.  Once you insist "perfectly recreate
> the commit", you are not willing to take any input from the
> sidelines---worse yet, you are even dictating when the upstream
> runs "git am" to turn them into commits, and do so without reading
> the patches (there is no point reviewing as the person who runs "git
> am" is not even allowed to fix typo or make obvious fixes to the
> code, which will fail to perfectly recreate the commit).
> 
> In short, one should resist temptation to bring up "perfect
> reproduction" when one talks about e-mail workflow.

Please see what I wrote to Pratyush Yadav here:

https://public-inbox.org/git/a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com/

TL;DR: the goal is not necessarily for maintainers to be able to merge
the patchset with the same SHA1 that the submitter had, but for the
patchset to have a definite SHA1 that lives in git, and which can be
used by all the participants -- submitter, reviewers, bots (including
potentially testing/CI infrastructure), and maintainers.

I am definitely not proposing to get rid of the email workflow -- on the
contrary, this it the workflow I want to preserve! :-) The "workflows"
mailing list was created for the purpose of discussing this topic (in
the context of Linux kernel development) and right now there are many
proposals that either completely cut out email or reduce it to something
like pull requests. My proposal keeps almost everything the same, except
for a few lines of extra metadata before the actual diff.

(I will answer the rest of your email separately.)


Vegard
