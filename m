Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C251F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 14:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439766AbfJQOBu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 10:01:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47360 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437401AbfJQOBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 10:01:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HDsEP6110486;
        Thu, 17 Oct 2019 14:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0QScDqhM+OdSLb2+n04awHcFUcvd0iyX+44obYNKk2A=;
 b=YV9+VbL5+IqwXcfGm/EeLmT/dNDLB+nOnujHihW2sgJpKbk+bCuaI8FRKPeX5U/a/z+e
 h/EhrIvtAu3rFgvJUS6DWscZOTOjEB7Ceq1pew63xfMFkSphVWzCVfAFD5/4Ft5XaJ5r
 ua3g+D89/lf/fjDbFYoej9cYTVm/keVx1DufTaP/sKEhtaOaippcdzpHO5QxvbIE54nJ
 lTkxVgzfleV+qKzMXIJGfOff2gfjAabu+cjS5imQe1yNp/Ma27hqttUDE2+L6g/2SiXb
 7KRdsG+F96/rlLUdHIGzIiHpVWBZzqQQBCYx4Ir3swJGSo80PnBHV9XqJ9Zyzg7nIzDR /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vk7frpcwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 14:01:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HDxRe9112384;
        Thu, 17 Oct 2019 14:01:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vp70q06sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 14:01:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HE1dfD001909;
        Thu, 17 Oct 2019 14:01:39 GMT
Received: from [10.175.56.189] (/10.175.56.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 14:01:39 +0000
Subject: Re: email as a bona fide git transport
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016150020.cr6jgfpd2c6fyg7t@yadavpratyush.com>
 <a1c33600-14e6-be37-c026-8d8b8e4bad92@oracle.com>
 <20191017131140.GG25548@mit.edu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <507d7293-964a-048b-2de6-98e7e7982cfb@oracle.com>
Date:   Thu, 17 Oct 2019 16:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017131140.GG25548@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170125
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/17/19 3:11 PM, Theodore Y. Ts'o wrote:
> On Thu, Oct 17, 2019 at 02:23:58PM +0200, Vegard Nossum wrote:
>> Of course, this relies strongly on actually having (correct) sha1
>> references to previous versions inside the changelog. In my original
>> idea, this reference would only appear inside the merge commit that
>> binds the patchset together to minimise churn, although maybe it is
>> feasible to also append it to each patch -- in that case, the "patchset"
>> command from my first email is not sufficient to create a new version of
>> a patchset.
> 
> This also relies on the base of the commit actually being a public
> SHA1.  Sometimes developers will cherry-pick in a patch that they need
> so that the kernel will actually *boot* (or otherwise fix problems
> that have been fixed in other subsystems, but not yet landed in -rc2
> or -rc3).
> 
> Of course, we could tell people that they should always create their
> patches off of the last stable version (but then there may have been
> changes pulled in via the last merge window that makes their patch not
> apply), or they could be told to develop against -rc2 or -rc3, and
> then cherry pick the required fix-up patches on top of -rc2 and -rc3,
> but then they have to do a lot more rebuilding.
> 
> So there are no perfect solutions here, and while in the ideal world,
> -rc2 and -rc3 should be perfectly stable enough for developers so that
> they never need to manually patch in stablization patches, we need to
> live in the real world.  I believe that Darrick told me that in the
> previous development cycle, he had to wait until -rc4 before the tree
> was stable enough for him to start building xfs patches on top
> mainline.
> 
> (This is also true for this development cycle if you enable
> CONFIG_KMEMLEAK, although fortunately, the workaround that worked for
> me was to just CONFIG_KMEMLEAK --- although of course, if I do have to
> run a KMEMLEAK test run, I'll need to cherry-pick the fix which landed
> this week on top of the ext4 git tree.)
> 
> What this all might mean is that sometimes it will make sense to allow
> the user to override the base commit so such stablization patches can
> be elided.  Of course, we could force the user to create a separate
> branch and rebase, but can be quite painful and slow --- and they
> won't be able to test the rebased branch anyway, unless we then want
> to tell them to cherry pick the stablization patches on top, and then
> remove them before running "git send-email".

Good points.

I suspect that you should almost always be able to find a good base
revision to build and test your changes on.

In your example, couldn't Darrick simply base his xfs work on the latest
xfs branch that was pulled by Linus? That should be up to date with all
things xfs without having any of the things that made Linus's tree not
work for him.

Otherwise, you could apply the stabilisation patches and then do your
final testing in a branch that merges that with your patchset, like so:

    rc1 o -----> fixup A ------> fixup B ---->o merge (tested)
(base)  \                                   /
          \                                 /
           ---> patch 001 --> patch 002 -->o patchset (submitted)

It does not seem too hard to me, and it should be pretty safe from a
test-what-you-ship point of view assuming the fixups and your patches
really are independent.

I think the more difficult problem to solve might be how to ensure that
the base commit is actually public/reachable when this is the intention.
A bot watching the mailing list could always respond with a "Hey, I
don't have that, could you rebase the series or push it somewhere?". But
it would be even better if git could tell you when you're about to
submit a patch. Maybe something like:

   git send-email --ensure-reachable-from [remote] rev^^..

In the worst case, I guess the base commit will just not be available --
the email will still have a sha1 on it, though, and which might still be
usable as an identifier for the patch/patchset. If not, it's still not
worse than the current workflow (which would still work).


Vegard
