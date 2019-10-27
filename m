Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569781F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJ0JVx (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 05:21:53 -0400
Received: from master.debian.org ([82.195.75.110]:56044 "EHLO
        master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfJ0JVw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 05:21:52 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Oct 2019 05:21:51 EDT
Received: from localhost ([::1]:53010 helo=vox.robbo.home)
        by master.debian.org with esmtp (Exim 4.89)
        (envelope-from <robert@debian.org>)
        id 1iOedi-0001vd-4I; Sun, 27 Oct 2019 09:15:10 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by vox.robbo.home (Postfix) with ESMTP id 5B00611F3FF;
        Sun, 27 Oct 2019 10:14:26 +0100 (CET)
Subject: Re: [PATCH] gitweb: correctly store previous rev in
 javascript-actions mode
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <53CECC87.7030209@debian.org> <20181216232429.GJ75890@google.com>
From:   Robert Luberda <robert@debian.org>
Openpgp: preference=signencrypt
Autocrypt: addr=robert@debian.org; prefer-encrypt=mutual; keydata=
 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
Organization: Debian
Message-ID: <8073f537-4380-4571-6997-546a9ca919f4@debian.org>
Date:   Sun, 27 Oct 2019 10:14:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20181216232429.GJ75890@google.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: pl-PL
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Luberda <robert@debian.org>
Date: Sun, 16 Mar 2014 22:57:19 +0100

Without this change, the setting

 $feature{'javascript-actions'}{'default'} = [1];

in gitweb.conf breaks gitweb's blame page: clicking on line numbers
displayed in the second column on the page has no effect.

For comparison, with javascript-actions disabled, clicking on line
numbers loads the previous version of the line.

Addresses https://bugs.debian.org/741883.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Robert Luberda <robert@debian.org>
---
> Hi Robert,

> Years ago, you sent this obviously correct patch to the link mentioned
> above, but it got lost in the noise.  Sorry about that.  Hopefully
> late is better than never.

Hi,

Somehow I missed your e-mail and just have found it today by a chance :(

> May we forge your sign-off?  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#sign-off
for more details about what this means.

Done, I've added the Signed-off-line above.

> Jakub et al, any thoughts?  I don't see any unit tests in gitweb/static
> that could avoid this regressing --- am I missing some, or if not any
hints for someone who would want to add a test framework?

Thanks,
Robert

 gitweb/static/js/blame_incremental.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/static/js/blame_incremental.js
b/gitweb/static/js/blame_incremental.js
index db6eb50584..e100d8206b 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -484,7 +484,7 @@ function processBlameLines(lines) {
 			case 'previous':
 				curCommit.nprevious++;
 				// store only first 'previous' header
-				if (!'previous' in curCommit) {
+				if (!('previous' in curCommit)) {
 					var parts = data.split(' ', 2);
 					curCommit.previous    = parts[0];
 					curCommit.file_parent = unquote(parts[1]);
-- 
2.20.0.405.gbc1bbc6f85



