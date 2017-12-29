Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2771F406
	for <e@80x24.org>; Fri, 29 Dec 2017 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdL2GVG (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 01:21:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59393 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750836AbdL2GVF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Dec 2017 01:21:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CA8BB20C89;
        Fri, 29 Dec 2017 01:21:04 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 29 Dec 2017 01:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=Ctewt7hm2cO+DfPu5jbXPdeZaDWs8qmQEY2at11NZk8=; b=VUIcr
        gZnPmBxy6loYGVqGkkyufflSIQmA8vv4nMOoLoQ7v2FIIvQ/WMzvdkxGTzc1oUlo
        9aYRAG6iWmE/RnIEyo97Hlz3g8ga5LzKG5N94Mr2BmEaqz4gm+qDTKkNRoyh6+tG
        BC11iVx7C+mCj1B0ML3a1Vi8zdGa7XxXoFcFOM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Ctewt7hm2cO+DfPu5jbXPdeZaDWs8
        qmQEY2at11NZk8=; b=gm9dbXubP4GGUoTI/XzDEsG5MfWNXhNZH6QkmNJruBTHN
        u8yX09HYUlsxNyofUm8Fdj7rDRKukH+U/mhZ/wwVwe1JmHedBGRm7XvJfptbcNmd
        4B8bb0r7DGZMe4t0H36V9TPmQJovkY/2iFvA4Z4oYojfEkwQrvfvw7x+ftByDAXk
        +opdYU+gMOgEKF8toZMuEqY2SpqkmGLE0EkFePY3PtWCmC18pwKxeW/ludBdVCX3
        dAufeBQdPCRNS0DmdTFpjg71yfWDeqof6UiW9p3f4prhzhWJv5ohALTIifllGftw
        8difLSHfWTPMP0sEK6KS/705okFQ0Q/mqfPTVw7sw==
X-ME-Sender: <xms:0N5FWlhtCNPJ0_0nPeR8L22SOsweHzTeCf7irP0IJHMuE5P8BMbO-w>
Received: from localhost (unknown [136.24.23.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70742240DB;
        Fri, 29 Dec 2017 01:21:04 -0500 (EST)
Date:   Thu, 28 Dec 2017 22:21:03 -0800
From:   Keith Smiley <k@keith.so>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229062103.GA19203@bryant.local>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
 <20171229060016.GA25718@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171229060016.GA25718@alpha.vpn.ikke.info>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about that! Patch below.


Previously git remote rm did not complete your list of removes as remove
does.

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

On 12/29, Kevin Daudt wrote:
>On Fri, Dec 29, 2017 at 02:01:00AM +0000, Keith Smiley wrote:
>> From: Keith Smiley <keithbsmiley@gmail.com>
>>
>> Previously git remote rm did not complete your list of removes as remove
>> does.
>
>Your signed-off-by[1] is missing, could you please add that?
>
>[1]:
>https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L278
>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 3683c772c5586..3e9044087e6ba 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2665,7 +2665,7 @@ _git_config ()
>>  _git_remote ()
>>  {
>>  	local subcommands="
>> -		add rename remove set-head set-branches
>> +		add rename remove rm set-head set-branches
>>  		get-url set-url show prune update
>>  		"
>>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>
>> --
>> https://github.com/git/git/pull/448
