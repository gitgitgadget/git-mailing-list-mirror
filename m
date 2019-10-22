Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FD01F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 12:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfJVMMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 08:12:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfJVMMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 08:12:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MC8tCn113199;
        Tue, 22 Oct 2019 12:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=MFJzMYNcFvDsXyams3WVY/szvOVOHehPEPgrKljIzhc=;
 b=bp60qwlbt9nzMsjtdt9HiuUcE5bkuVIY3/S6BWCxKWwdv9U9/lhQcG/A/+aeudq0GXmH
 nt/k/rQKYyVRl3Ss2EdxNXrTuxxhYNllr6aPxugzRRNupLwst3z50/Z8E6YtnTmlvqOm
 IjNEQiiy1ZlKklOjSEACe05aD4iH1vtIhuZuDXVLsVtgHxUTssn7ldu2ja6F8PdYzw8A
 Qw7FcjPj9U7XU6n02Npi3CrqoZvXgGept8ESk7nljs2C44Gs/uIKqAOFuKT9HO448cbF
 oxve13v/F6Ywc+nulsOX6sJXlfqME/fdUFb9LtKgvYHlrdk1xXqPSYGWUVHlsrMlL+Mf IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqtepp5pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 12:11:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MC8J4q100829;
        Tue, 22 Oct 2019 12:11:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vrc01rnte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 12:11:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9MCBVdT031690;
        Tue, 22 Oct 2019 12:11:31 GMT
Received: from [10.175.28.77] (/10.175.28.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 05:11:31 -0700
Subject: Re: email as a bona fide git transport
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Willy Tarreau <w@1wt.eu>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Santiago Torres Arias <santiago@nyu.edu>,
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
Message-ID: <de6dd8b5-5c28-d0b2-d3fc-e72a6d643105@oracle.com>
Date:   Tue, 22 Oct 2019 14:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1a259d8d-b3d1-b64e-07c3-ba143b42c442@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/19 8:28 AM, Vegard Nossum wrote:
> 
> On 10/20/19 5:17 AM, Willy Tarreau wrote:
>> On Fri, Oct 18, 2019 at 03:14:56PM -0400, Theodore Y. Ts'o wrote:
>>> On Fri, Oct 18, 2019 at 06:50:51PM +0200, Vegard Nossum wrote:
>>>> The problem I ran into with putting the metadata at the end was
>>>> detecting where the diff ends. A comment in 'git apply' suggested that
>>>> detecting the difference between "--" as a diff/signature separator and
>>>> as part of the diff is nontrivial in the sense that you need to 
>>>> actually
>>>> do some parsing and keep track of hunk sizes.
>>>
>>> Could we cheat by having "git format-patch" add a "Diff-size" in the
>>> header which gives the number of lines in the diff so git am can just
>>> count lines to find the Trailer section?
>>
>> Be careful with this, it starts like this and ends up with non-editable
>> patches. I'd rather have git-am use best-effort detection of the end.
> 
> Expect filesystem developers to come up with a format that uses extents ;-)
> 
>> Also when dealing with stable backports, I've done a lot of
>> "cat foo.diff >> bar.patch" to fixup some patches in which I just had
>> to move some parts around. Having to count lines and edit a counter
>> somewhere is going to become really painful.
> 
> I almost have some new patches ready for putting the metadata after the
> patch using a very bare-bones diff parser (it's actually not that bad),
> I just need to fix a few corner cases that are causing breakage in the
> git test suite.

I sent v2 of the patches (with metadata _after_ the diff) to the git
list here:

https://public-inbox.org/git/20191022114518.32055-1-vegard.nossum@oracle.com/T/#u

As I wrote in there, we could already today start using

   git am --message-id

when applying patches and this would provide something that a bot could
annotate with git notes pointing to lore/LKML/LWN/whatever. I think that
would already be a pretty nice improvement over today's situation.

Sadly, since the beginning of 2018, this was only used for a measly
~0.14% of all non-merge commits in the kernel:

$ git rev-list --count --no-merges --since='2018-01-01' --grep 
'Message-Id: ' linus/master
178

$ git rev-list --count --no-merges --since='2018-01-01' linus/master
130777

So how can we spread the word about --message-id and get maintainers to
actually use it? I don't suppose it's reasonable to change the 'git am'
default setting?


Vegard
