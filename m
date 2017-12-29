Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EFD1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 16:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdL2Qtw (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 11:49:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46107 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbdL2Qtw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 11:49:52 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4723C212DB;
        Fri, 29 Dec 2017 11:49:51 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 29 Dec 2017 11:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=UELXWcspuBLwBgqZH2pNG7Miq5Lnpi7Ll8fCQg4f/XE=; b=DlGj9
        d+JX2kHQJ+zI/xBnzVIQmX3sfpUvhG30N7UegQYXHz0SKy8OUeGpXeZd0aJXA2oJ
        7GBBtcQYsW7GVSSijsLJIidfQK9TGRdO78BJAzS8cr1P2U2bwYB3YX37YHFKCrwp
        yAcA1p4MPlkHVjtyp8/23NDyYvrpO2Z9vXx5ek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=UELXWcspuBLwBgqZH2pNG7Miq5Lnp
        i7Ll8fCQg4f/XE=; b=rc8bNLICTGcM4XsaCUJLU1bWPQaMfYDvdkVsFEfXc6nEw
        2B/y5MhqlsvvrzKc19fWKN/PPJqz6n2iQRbpQRJDPYPl1lU3IaAewuyj53Y3pGJK
        7SUyJTSeJhP0+UDfSiGKVhxO2QtQzDnCr/9jO4Y7o1XymqvBGT8kjnaL8Qxthcgm
        7wFkui7U9S/V07D8pIdq8zP+j7kJRcT+5WKsXfGKnMAQX1PhIbmJfW/YL58t6kzD
        mSUz+mWxPI7ceIqlSMoXjfebc2pVwcjKHzx+SHojcoXx73wWXD/wLPdRbVAgaxp7
        mYpTmReR4RJY5NZT+2YVVOcAPQf3Pd6LaeeoG/V4A==
X-ME-Sender: <xms:L3JGWtLdIBElyt69-qtJz-6HvFnleF_Yv0YoeecyreWJRFmrjTMrQw>
Received: from localhost (unknown [4.14.106.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id D172924804;
        Fri, 29 Dec 2017 11:49:50 -0500 (EST)
Date:   Fri, 29 Dec 2017 08:49:49 -0800
From:   Keith Smiley <k@keith.so>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] completion: restore 'remote rm'
Message-ID: <20171229164949.GA48812@bryant.local>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
 <20171229032927.GN3693@zaya.teonanacatl.net>
 <20171229041927.GA83931@bryant.local>
 <20171229135240.GQ3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171229135240.GQ3693@zaya.teonanacatl.net>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated:

e17dba8fe1 ("remote: prefer subcommand name 'remove' to
'rm'", 2012-09-06) removed the 'rm' subcommand from
completion.  The 'remote rm' subcommand is still supported
and not planned to be removed.  Offer completions for it.

Signed-off-by: Keith Smiley <k@keith.so>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5586..3e9044087e6ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2665,7 +2665,7 @@ _git_config ()
 _git_remote ()
 {
 	local subcommands="
-		add rename remove set-head set-branches
+		add rename remove rm set-head set-branches
 		get-url set-url show prune update
 		"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"

--
Keith Smiley

On 12/29, Todd Zullinger wrote:
>Keith Smiley wrote:
>> It looks like that was just about preferring remove in documentation
>> and the like, I think it would still make sense to have both for
>> completion since rm is still supported.
>
>I read it as a first step in a long process to eventually
>remove 'remote rm', but if that's never intended, then sure,
>restoring completion for it seems reasonable.
>
>It would be good to hear from those who know or recall the
>intention.
>
>I think we should only complete the preferred subcommand.
>That encourages use of 'remote remove' even if 'remote rm'
>will stay forever to avoid breaking existing scripts.
>
>If it does make sense to restore completion, adding a link
>back to e17dba8fe1 and explaining why the completion is
>being restored would be good.  Reading the commit message
>now makes it sound like 'remote rm' was never present and is
>being added to correct an oversight.
>
>Maybe something like:
>
>    completion: restore 'remote rm'
>
>    e17dba8fe1 ("remote: prefer subcommand name 'remove' to
>    'rm'", 2012-09-06) removed the 'rm' subcommand from
>    completion.  The 'remote rm' subcommand is still supported
>    and not planned to be removed.  Offer completions for it.
>
>I also noticed that in your original commit that you say
>"list of removes as remove does." That should be "remotes"
>instead of "removes" there. -- I've made that typo myself
>quite often. :)
>
>-- 
>Todd
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>There are no stupid questions, but there are a LOT of inquisitive
>idiots.
>    -- Demotivators (www.despair.com)
>
