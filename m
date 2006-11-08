X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote
 branches?
Date: Tue, 07 Nov 2006 21:23:29 -0800
Message-ID: <455169D1.8060408@saville.com>
References: <20061107172450.GA26591@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 05:23:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <20061107172450.GA26591@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31117>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghfua-0001hp-Hm for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754295AbWKHFX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbWKHFX1
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:23:27 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:6589 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1754294AbWKHFX0 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 00:23:26 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 70EED57A6F; Tue,  7 Nov 2006 21:20:09 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

As a newbie I'm confused, recently I attempted to get Andrew Morton's -mm "tree". It turns out the instructions were incorrect and Junio was kind enough to correct the mistake. But I for one am still confused.

  git-fetch is; "Download objects and a head from another repository"

Fair enough and that make sense, but where does it go? Apparently it just gets stored in the object database and a reference to it in "FETCH_HEAD". Now what? Ok the documentation says:

  'The information is left for a later merge operation done by "git merge"'

Now in the case of fetching -mm apparently you don't do a merge, instead the instructions now read:

  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git tag v2.6.16-rc2-mm1
  git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

The git-fetch apparently gets "linux-trees.git" and places a reference to it in a tag named 'v2.6.16-rc2-mm1'. Then the git-checkout, check's out this tag to a new branch, there was no merge! This is confusing and makes no sense to this newbie.

Now lets take a quick look at the git-merge documentation "HOW MERGE WORKS":

"A merge is always between the current HEAD and one or more remote branch heads, and the index file must exactly match the tree of HEAD commit (i.e. the contents of the last commit) when it happens. In other words, git-diff --cached HEAD must report no changes."

Sorry, there is basically no information in those two sentences that makes any sense to me. Take the first part, "between the current HEAD and one or more remote branch heads". So apparently merges occur against the current checkout branch, but I would guess the origin is also involved somehow? Secondly, what is the relationship between "remote branch heads" and FETCH_HEAD? I see no mention of FETCH_HEAD or how it might be used anywhere in the git-merge documentation.  Then we come to "the index file must exactly match the tree HEAD commit", sorry but my question is how could it not match? Obviously I don't understand how the index file is used, but I can say that adding "git-diff --cached HEAD must report no no changes" adds nothing to the explanation, yet I'm sure it does mean something to an expert.

It then goes onto say "it may fetch the objects from remote" I thought that is what "fetch" does.

Anyway, as you can see there is room for confusion for some people.

Regards,

