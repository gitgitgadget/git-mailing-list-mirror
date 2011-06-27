From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 6/6] rebase --rewrite-refs: tests
Date: Mon, 27 Jun 2011 12:07:10 -0400
Message-ID: <4E08AAAE.5020604@cisco.com>
References: <cover.1309133817.git.greg@quora.com> <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 27 18:16:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbEUO-0001c6-57
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 18:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1F0QQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 12:16:37 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:34823 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab1F0QQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 12:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1213; q=dns/txt;
  s=iport; t=1309191395; x=1310400995;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=SQQayaQ52OEp8lPIfoaSz5NxVs/aX81dTICIKpoenu0=;
  b=m1jUqoNX9Hi+MuFn7tEfqyLQ/GED7dnPVGsm8dk79b+vRWfu8w8ZKUlY
   VZH0pFn4jyWTvx9eiwqRkC0QS3glk2dxu3qY0//keL1XTmifzlNUL6m3J
   V2aUEnKLPVwi7YzRwYuGAvLg0XTOF3Pulu9YzozAWC5rQYPK7qBbY0Gkn
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EADCpCE6tJV2d/2dsb2JhbABSEKced6sOnXKGMASSA4RuinZT
X-IronPort-AV: E=Sophos;i="4.65,432,1304294400"; 
   d="scan'208";a="288387155"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by sj-iport-4.cisco.com with ESMTP; 27 Jun 2011 16:07:05 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-6.cisco.com (8.14.3/8.14.3) with ESMTP id p5RG757k003895;
	Mon, 27 Jun 2011 16:07:05 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110627120710881
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176351>



On 01/24/2010 09:28 PM, Greg Price wrote:
> Signed-off-by: Greg Price <price@mit.edu>
> ---
>  t/t3420-rebase-ref.sh |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)
>  create mode 100644 t/t3420-rebase-ref.sh
>
> diff --git a/t/t3420-rebase-ref.sh b/t/t3420-rebase-ref.sh
> new file mode 100644
> index 0000000..601a434
> --- /dev/null
> +++ b/t/t3420-rebase-ref.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +
> +test_description='git rebase --rewrite-refs'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-rebase.sh"
> +set_fake_editor
> +
> +#      part1  part2 topic
> +#	 |	|     |
> +#	 v	v     v
> +#  A-----C------D-----E
> +#   \
> +#    B <--master
> +
> +test_expect_success setup '
> +	test_commit A &&
> +	git branch topic &&
> +	test_commit B &&
> +	git checkout topic &&
> +	test_commit C &&
> +	git branch part1 &&
> +	test_commit D
> +	git branch part2 &&
> +	test_commit E
> +'

I think there is a missing "&&" at the end of "test_commit D".  But it's
possible I just don't understand the test machinery enough to know this
is normal.  Can you explain to me the difference in that case?

Phil
