From: David Caldwell <david@porkrind.org>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Tue, 21 Jun 2011 22:49:22 -0700
Message-ID: <FD779A88A6134648D999E7C7@black.porkrind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>,
	Paul Ebermann <Paul.Ebermann@esperanto.de>
X-From: git-owner@vger.kernel.org Wed Jun 22 07:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZGJs-0004P9-EW
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 07:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1FVFtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 01:49:39 -0400
Received: from kill.porkrind.org ([68.68.97.104]:45054 "EHLO
	david.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1FVFtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 01:49:39 -0400
Received: from porkrind.org (cpe-98-151-185-99.socal.res.rr.com [98.151.185.99])
	by david.xen.prgmr.com (Postfix) with ESMTPS id 5E1942BDA3;
	Tue, 21 Jun 2011 22:49:35 -0700 (PDT)
Authentication-Results: david.xen.prgmr.com; dkim=fail
	(verification failed; insecure key) header.i=@porkrind.org
	header.b=TM4k/Qjj; dkim-adsp=none (insecure policy)
Received-SPF: pass (porkrind.org: authenticated connection) receiver=porkrind.org; client-ip=127.0.0.1; helo=[10.0.0.50]; envelope-from=david@porkrind.org; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from [10.0.0.50] (localhost [127.0.0.1])
	(authenticated bits=0)
	by porkrind.org (8.14.4/8.14.4/Debian-2) with ESMTP id p5M5nOS2029824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Jun 2011 22:49:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=porkrind.org;
	s=apoptygma; t=1308721772;
	bh=1TSMhZod9wrNp8H24Xe9KEl2wxvRFgYAMkNG7ZC/V5U=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=TM4k/QjjcBv4zYiZmHWy+R5jjRfYA61CYL3FYht/GRdjrS13/7kxuK152GpSv4lUq
	 kyxYrO+5zjMPNaN/LYteS58Zf3aAoyf/RSGfDkjVsv16lc6+wpSu/KHRJxoYo8Ko9B
	 H+iNeC36391GqaQn10fJ+xAsweQi9r88Y0B/4qn4/TF87uXjEg8Mw1WVA+cI9/sfGE
	 Zg1yyujyS5FjkR9bPedVHAtmYgHikRoI0laSX/XyuoOyHtjaMncu8ByUW9D
X-Mailer: Mulberry/4.0.9b1 (Mac OS X)
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
	T_DKIM_INVALID,UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on kill.porkrind.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176219>

On 6/21/11 5:23 PM -0400 Marc Branchaud wrote:

> On 11-06-21 12:11 PM, Paul Ebermann wrote:
>>
>> I think `--also-untracked` sounds better. It is even longer, though.
>>
>> There could also be `--only-untracked`, which would stack only the
>> untracked files (and let changes of tracked files there).
>
> Perhaps -uall to match git-status's -u[<mode>] option (and also the long
> version thereof)?

Currently I'm playing with --include-untracked (-u) and --all (-a) while I 
fix a bug I found in the patch. I agree that --untracked sounds like it's 
only stashing the untracked files which isn't the case. I wasn't going to 
have an option to stash *just* the untracked files because I can't come up 
with a use case that makes sense. I still like "--clean", too.

-uall (like git status) isn't really the same thing which I think is 
confusing since it has the same name.

-David
