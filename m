Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B0B1FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 23:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbdDOX2S (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 19:28:18 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:18594 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbdDOX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 19:28:17 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id zX71c3dW0HGLwzX71cfIMV; Sun, 16 Apr 2017 00:28:16 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=IWRwjMYmj02BBUnDWEcA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Sun, 16 Apr 2017 00:28:16 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHtcr+XCmRWNnA0qvqLagA5CoHfzkvrSEE+zbMfTinnSJCQWc5XfHrQ5T+iiXIpQTD4gEknWGZ2uQLOTLw4PX+hAz+kdXJnGnEQwl2u8iwp3c0+ihNEk
 QBzof4Xsq3nS7aJvzN/Mhh3OqymmCCojx6htKUqBir7EhsfmNa7XiN+WtAjoD4bG2lQe6aPKbOgGNhgmLCMlSE2ipICdwj36WVg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christoph Michelbach" <michelbach94@gmail.com>
> While technically in the documentation, the fact that changes
> introduced by a checkout <tree-ish> are staged automatically, was
> not obvious when reading its documentation. It is now specifically
> pointed out.
>
> Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> ---
> Documentation/git-checkout.txt | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt 
> b/Documentation/git-checkout.txt
> index 8e2c066..cfd7b18 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the 
> current branch.
> from the index file or from a named <tree-ish> (most often a
> commit). In this case, the `-b` and `--track` options are
> meaningless and giving either of them results in an error. The
> - <tree-ish> argument can be used to specify a specific tree-ish
> - (i.e. commit, tag or tree) to update the index for the given

Do these lines above actually need reflowing? Their content hasn't changed 
making it more difficult to spot the significant changes below here.

> - paths before updating the working tree.
> + <tree-ish> argument can be used to specify the tree-ish (i.e.
> + commit, tag, or tree) to update the index to for the given paths
> + before updating the working tree accordingly.

> +                               Note that this means
> + that the changes this command introduces are staged automatically.

Does this actually capture the intent of the user confusion it's meant to 
cover? I may have missed the original discussions.

For a clean commit checkout my mental model is not one of anything new being 
actively staged i.e. different from what was in the commit. I can see that 
if a particular tree is checkout then it's implicit staging could well be a 
surprise.

I am in favour of improving the documentation to avoid user surprise

> +
> 'git checkout' with <paths> or `--patch` is used to restore modified or
> deleted paths to their original contents from the index or replace paths
> -- 
> 2.7.4
>
--
Philip 

