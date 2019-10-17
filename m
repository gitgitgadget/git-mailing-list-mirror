Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6AD1F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 13:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394235AbfJQNIa (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 09:08:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJQNI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 09:08:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HD3dt1060584;
        Thu, 17 Oct 2019 13:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XHC9CqrlVQexOD5a/SoHu9DKmd73hu+7jf1dADbhx20=;
 b=eqmbRzySnFzUrkJxpYOsivyE4IB92g8Dx7go2HG4tunuUofeHtRVS55z6qr8zxQ3pUCl
 nHymATy+i+wEQzmTk7u+wGVxPdD6mqpkOCc56xgGiyDa0HvU4m0VzzOtIy4zbOFgSl0c
 yCLJVNwZfDwo95Ob/vqevimJkvms5DsjfmsAdY7vPc7SpmPLJy831AneFYJvrn7W7+/J
 EQ8j1nUCXkSoteGpLRRd1RZ4ypJLi5X+oSEYXN3giBcnGTJ619euN6I9I1dfj1btU1St
 Ig0AxNpjUjsEBJwe92jXY4Tcvt4xMRU3ANbaLJIU0q732PL0IgUwoiMt5pEV5VQ7864e ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqx7xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 13:08:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HD47Bm163414;
        Thu, 17 Oct 2019 13:08:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vp70pwg68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 13:08:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HD8MM9006337;
        Thu, 17 Oct 2019 13:08:22 GMT
Received: from [10.175.56.189] (/10.175.56.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 13:08:22 +0000
Subject: Re: email as a bona fide git transport
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016205736.GA259536@google.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <fec5f11b-8dd4-8450-863f-487960b9dd1c@oracle.com>
Date:   Thu, 17 Oct 2019 15:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016205736.GA259536@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170121
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/19 10:57 PM, Jonathan Nieder wrote:
> Hi,
> 
> A few small points.
> 
> Vegard Nossum wrote:
> 
>> * git am (or an alternative command) needs to recreate the commit
>>    perfectly when applied, including applying it to the correct parent
> 
> Interesting.  "git format-patch" has a --base option to do some of
> what you're looking for, for the sake of snowpatch
> <https://github.com/ruscur/snowpatch>.  Though it's not exactly the
> same thing you mean.

Yes, --base is great for importing email patches into git, but does not
allow resulting commits to have the same sha1 (because it doesn't have
the complete author/committer information, mainly), so it doesn't do
enough for what I want with this proposal.

> We also discussed sending merge commits by mail recently in the
> virtual git committer summit[1].
> 
> Of course, the devil is in the details.  It's straightforward to use
> "git bundle" to use mail as a Git transport today, but presumably you
> also want the ability to perform reviews along the way and that's not
> so easy with a binary format.  Do you have more details on what you'd
> want the format to look like, particularly for merge commits?

Yes, one of the goals is to continue to use git-send-email and be able
to view and review patches on a mailing list with minimal intrusion to
existing processes.

I did not envision supporting merge commits where the resulting tree is
different from all of its parents, which means any merge commits run
through 'git-format-patch --complete' would just have multiple "parent"
lines and no diff where the diff would normally be.

>> is no need for "changeset IDs" or whatever, since you can just use the
>> git SHA1 which is unique, unambiguous, and stable.
> 
> In [2] the hope was for some identifier that is preserved by "git
> rebase" and "git commit --amend" (so that you can track the evolution
> of a change as the author improves it in response to reviews).  Is
> that the conversation you're alluding to?

Yes.

(Not the specific email/thread you linked, but yes, this is the general
conversation about having stable identifiers I'm referring to.)

> 
> [...]
>> Disadvantages:
>>
>> - requires patching git
> 
> That's not a disadvantage.  It means get to work with the Git project,
> which is a welcoming bunch of people, working on userspace (seeing how
> the other half lives), and improving the lives of everyone using Git.

True! :-)

>> Date: Sat, 5 Oct 2019 16:15:59 +0200
>> Subject: [PATCH 1/3] format-patch: add --complete
>>
>> Include the raw commit data between the changelog and the diffstat.
> 
> Oh!  I had missed this on first reading because it was in an
> attachment.
> 
> I have mixed feelings.  Can you say a bit more about the advantages
> and disadvantages relative to sending a git bundle?  What happens if a
> mail client or a box along the way mangles whitespace in the commit
> message?

Yes, as we both said above: git bundle is not human readable and does
not lend itself to reviews in mail clients or on mailing lists.

Any kind of mangling is a serious concern, and my thoughts are:

  - The _diff_ itself should already be safe from mangling. If this were
not the case, then sending patches by email would be completely unsafe
and would need to be fixed somehow anyway.

  - I think I remember seeing something in either 'git am' or 'git
mailinfo' about format=flowed apparently allowing whitespace to
disappear from the line endings.

  - Isolated problems like that could be preemptively fixed (or at least
warned about) on the submitter side by e.g. warning about potential
issues when committing or running format-patch/send-email)

  - If some mail software is susceptible to mangling patches, then I
think it would great to have a mechanism for detecting that -- which
"git-format-patch --complete" would be! :-)

  - It is true that the commit message itself (and perhaps particularly
people's names) is especially vulnerable to mangling and/or reencoding
(I noticed that 'git am' seems to convert to utf8 before committing). I
honestly don't know if this would be a problem in practice, as I don't
know too much about mail software and encodings. If most people use
format-patch/send-email to send patches, then maybe it's not actually a
problem because everything is either kept as utf-8 to start with or
encoded/decoded consistently across the git userbase?

  - I was thinking of hex-encoding the raw bytes of the author and
committer lines of the extra commit metadata in the final email to keep
everything as ASCII and avoid character set conversions. It is true that
this does not stop mangling of the changelog...

  - I suspect that if mangling was a problem in practice, then we would
have seen it already and the solution to it is not specific to what I'm
proposing here.

I'd love for somebody who is more knowledgeable about email and encoding
to chime in here. It is definitely one of the biggest potential problems
and it would be good to approach it in a way that doesn't require lots
of red tape after it has already been implemented.


Vegard

> 
> Happy hacking,
> Jonathan
> 
> [1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet/
> [2] https://lore.kernel.org/ksummit-discuss/CAD=FV=UPjPpUyFTPjF-Ogzj_6LJLE4PTxMhCoCEDmH1LXSSmpQ@mail.gmail.com/
> 
