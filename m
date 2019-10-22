Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48631F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbfJVQaX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 12:30:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfJVQaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 12:30:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MGSuKD165257;
        Tue, 22 Oct 2019 16:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aGu1aHzafMqFrU5v6bmC0bZUGDBIxfBU5FS6beFKAV4=;
 b=lI37fSWrTn9vVdOmdpBjEJGThnaTTpKR11O4uvEIwaQ1/NdWEE/Ipn2i7uVL7rhsQWq8
 lVm+fj4SJpy0Eejilmx60PyC39LXfx4Cq+TOYyTPJx2pZZBH2FMn9PbsPjsaS02vjIoG
 5yPkHfuouWceRyr+vK58Az1dkGkZNBQxdseedeOjvORlw91qbdMIS91ZNgoyNT+dF9Ha
 LHZgVvtE8gu0KHXv62vxZOHEIOML2gPIcPIs7SqiXD5xwvAN1ZNggzjeYQJO9BmlyRlD
 UovC5s+xsF+NB3qpOU1q08qoOAGH9F6pC6hOzSfCvp6gR7AN/PSohPROXx3ARZ/LiHs0 iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vqu4qqsx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 16:29:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MGStG0064556;
        Tue, 22 Oct 2019 16:29:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vt2hdbqb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 16:29:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9MGThJN023491;
        Tue, 22 Oct 2019 16:29:43 GMT
Received: from [10.175.28.77] (/10.175.28.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 09:29:43 -0700
Subject: Re: email as a bona fide git transport
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Willy Tarreau <w@1wt.eu>, Santiago Torres Arias <santiago@nyu.edu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018161547.GG21137@mit.edu>
 <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
 <20191018191456.GI21137@mit.edu> <20191020031716.GA17475@1wt.eu>
 <1a259d8d-b3d1-b64e-07c3-ba143b42c442@oracle.com>
 <de6dd8b5-5c28-d0b2-d3fc-e72a6d643105@oracle.com>
 <20191022135344.GC23268@mit.edu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <eed119a2-1561-131e-9d3d-d4d5aadee825@oracle.com>
Date:   Tue, 22 Oct 2019 18:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022135344.GC23268@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/22/19 3:53 PM, Theodore Y. Ts'o wrote:
> On Tue, Oct 22, 2019 at 02:11:22PM +0200, Vegard Nossum wrote:
>>
>> As I wrote in there, we could already today start using
>>
>>    git am --message-id
>>
>> when applying patches and this would provide something that a bot could
>> annotate with git notes pointing to lore/LKML/LWN/whatever. I think that
>> would already be a pretty nice improvement over today's situation.
>>
>> Sadly, since the beginning of 2018, this was only used for a measly
>> ~0.14% of all non-merge commits in the kernel:
>>
>> $ git rev-list --count --no-merges --since='2018-01-01' --grep 'Message-Id:
>> ' linus/master
>> 178
> 
> You might also want to count commits which have a link tag with a
> Message-Id:
> 
> Link: https://lore.kernel.org/r/c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org
> 
> That's because some kernel developers have been using a hook script like this:
> 
> #!/bin/sh
> # For .git/hooks/applypatch-msg
> #
> # You must have the following in .git/config:
> # [am]
> #	messageid = true
> 	
> . git-sh-setup
> perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> test -x "$GIT_DIR/hooks/commit-msg" &&
> 	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
> :
> 
> .... as we had reached rough consensus that this was the best way to
> incorprate the message id (since it could made to be a clickable link
> in tools like gitk, for example).  This rough consensus has only been
> in place since around the time of the Maintainer's Summit in Lisbon,
> so uptake is still probably a bit slow.  I'd expect to see a lot more
> of this in the next merge window, though.

Thanks, I was not aware of this!

Seems like something that should go in Documentation/maintainer/,
right?

The figure is much better, 16.7% on all non-merges since 2018-01-01.
This should help and we can maybe already do some interesting things
with git notes and lore/public-inbox.


Vegard
