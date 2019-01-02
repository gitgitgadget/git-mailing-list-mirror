Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109221F770
	for <e@80x24.org>; Wed,  2 Jan 2019 20:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfABUpl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 Jan 2019 15:45:41 -0500
Received: from esg260-1.itc.swri.org ([129.162.252.140]:33393 "EHLO
        esg260-1.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfABUpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 15:45:41 -0500
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 15:45:40 EST
Received: from smtp.swri.org (MBX260.adm.swri.edu [129.162.29.125])
        by esg260-1.itc.swri.edu (8.16.0.27/8.16.0.27) with ESMTPS id x02KKrLx140852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 2 Jan 2019 14:20:53 -0600
Received: from MBX260.adm.swri.edu (129.162.29.125) by MBX260.adm.swri.edu
 (129.162.29.125) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 14:20:53 -0600
Received: from MBX260.adm.swri.edu ([10.10.10.3]) by MBX260.adm.swri.edu
 ([10.10.10.3]) with mapi id 15.00.1395.000; Wed, 2 Jan 2019 14:20:52 -0600
From:   "Strain, Roger L." <roger.strain@swri.org>
To:     Marc Balmer <marc@msys.ch>, Duy Nguyen <pclouds@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Topic: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Thread-Index: AQHUoPOhBs+DBgT4BUyx7i00nvsJraWZEGEAgAAF3ACAAAIBAIAAASoAgANNh9A=
Date:   Wed, 2 Jan 2019 20:20:52 +0000
Message-ID: <59718f73a0a14b828a6d4fd4c8c222d1@MBX260.adm.swri.edu>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
In-Reply-To: <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [129.162.26.94]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=-40 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Marc Balmer <marc@msys.ch>
> Sent: Monday, December 31, 2018 5:24 AM
> To: Duy Nguyen <pclouds@gmail.com>
> Cc: Git Mailing List <git@vger.kernel.org>; Strain, Roger L.
> <roger.strain@swri.org>; Junio C Hamano <gitster@pobox.com>
> Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
> 315a84f9aa0e2e629b0680068646b0032518ebed
> 
> 
> 
> > Am 31.12.2018 um 12:20 schrieb Duy Nguyen <pclouds@gmail.com>:
> >
> > On Mon, Dec 31, 2018 at 6:13 PM Marc Balmer <marc@msys.ch> wrote:
> >>
> >>
> >>
> >>> Am 31.12.2018 um 11:51 schrieb Duy Nguyen <pclouds@gmail.com>:
> >>>
> >>> On Mon, Dec 31, 2018 at 5:44 PM Marc Balmer <marc@msys.ch> wrote:
> >>>>
> >>>> Hi
> >>>>
> >>>> One of the last three commits in git-subtree.sh introduced a regression
> leading to a segfault.
> >>>>
> >>>> Here is the error message when I try to split out my i18n files:
> >>>>
> >>>> $ git subtree split --prefix=i18n
> >>>> cache for e39a2a0c6431773a5d831eb3cb7f1cd40d0da623 already exists!
> >>>>  (Lots of output omitted)
> >>>> 436/627 (1819) [1455]       <- Stays at 436/ while the numbers in () and []
> increase, then segfaults:
> >>>> /usr/libexec/git-core/git-subtree: line 751: 54693 Done                    eval
> "$grl"
> >>>>   54694 Segmentation fault      (core dumped) | while read rev parents;
> do
> >>>
> >>> Do you still have this core dump? Could you run it and see if it's
> >>> "git" that crashed (and where) or "sh"?
> >>
> >> It is /usr/bin/bash that segfaults.  My guess is, that it runs out of memory
> (as described above, git-subtree enters an infinite loop untils it segafults).
> >
> > Ah that's better (I was worried about "git" crashing). The problematic
> > commit should be 19ad68d95d (subtree: performance improvement for
> > finding unexpected parent commits - 2018-10-12) then, although I can't
> > see why.
> >
> > I don't think we have any release coming up soon, so maybe Roger can
> > still have some time to fix it instead of a just a revert.
> 
> In a (private) Email to me, he indicated that had no time for a fix.  Maybe he
> can speak up here?
> 
> In any case, if I can help testing, I am in.  I just don't know the inner workings
> of git-subtree.sh (I am a mere user of it...)

TL;DR: Current script uses git rev-list to retrieve all commits which are reachable from HEAD but not from <abc123>. Is there a syntax that will instead return all commits reachable from HEAD, but stop traversing when <abc123> is encountered? It's a subtle distinction, but important.

Long version:

While I don't have a lot of time to troubleshoot this as deeply as I'd like, I've at least tried to give it a little bit of thought. If we assume it's an out of memory problem, that's likely due to commit 315a84f9aa0e2e629b0680068646b0032518ebed, which introduced a recursive history search. It might be possible to refactor that logic to avoid the recursive approach, but shell scripting is not my native tongue, and I didn't immediately see the right way to do it. I can explain the problem the commit was trying to address, and if anyone has suggestions about how to better fix the problem, I'd love to hear them.

This part of the subtree script is attempting to identify all mainline commits which need to be evaluated for subtree content. When subtree rejoin commits are included, it short-circuits this process by identifying all commits which can be reached from the current HEAD, but which CANNOT be reached from any of the known subtree rejoin points. While this does simplify the number of commits that need to be evaluated, it causes the script to miss commits that do in fact need to be evaluated when merges bypass those rejoins. Consider the following:

(Apologies for the crude diagram, I'm having to use Outlook at work and have no idea if this will format properly.)

[A]--(B)--(D)--[E]---(G)
 \       /          /
  ---(C)-------(F)--

In this graph, [A] represents an initial commit, which is a subtree rejoin (presumably mapping to subtree commit A'). From this, commits B and C were created, then those two were merged as commit D, and a subtree operation was performed to push these changes to the subtree. The result was rejoined as commit [E] (mapping as subtree commit E'). We then have a commit F with a single parent of C, and a merge of E and F into commit G.

At this point, I want to push the commits through G back to the subtree. The original script used git rev-list to list all commits which can be reached from G, but which cannot be reached from known split points A and E. This results in a commit list of G, F. It then looks at commit F to determine how it fits into the subtree, sees that it has a parent C, and looks for what subtree commit C maps to. Unfortunately C wasn't included in the list of commits to evaluate, so that check failed, and the script treats F as an initial commit. The subtree generated then includes F' as a complete commit, unrelated to any previous commits in the subtree, rather than connecting it to C' as a parent.

The ideal solution to this would be a call to git rev-list (or another tool, if appropriate) that could actually generate a commit list of G, F, C in the above diagram. Rather than being "All commits I can reach from G but not from A or E", what it really needs is "All commits I can reach from G, but stop traversing the history any time I reach A or E". If someone with better knowledge can provide that command, I think we could restore the script to a non-recursive approach and give better information about the true progress of the command, rather than having to rely on the "extra count" I introduced to keep track of how many unexpected commits are being recursively evaluated because the initial rev-list didn't include them.

As an aside, there's still another problem that we've run into which is forcing us to still run a custom version of the subtree script. There's a section in the script commented "ugly.  is there no better way to tell if this is a subtree vs. a mainline commit?  Does it matter?" Unfortunately, that section isn't working properly in our repo at this point, and I've had to include a VERY ugly check that looks for the existence of a known file in our specific mainline repo to make this determination. I'm still trying to sort through a better approach that might work for others, but have come up blank to this point. If anyone else has thoughts, I'd really love to hear those as well.

Anyway, sorry for the novel, but I wanted to brain dump what I've learned in this process. If anyone can suggest a syntax for rev-list that gives the appropriate set of commits, I'd love to get that in place; otherwise we could definitely try to unwind the recursion approach, but my shell script naivety may get me in trouble.

-- 
Roger
