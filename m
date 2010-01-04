From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 17:29:26 +0100
Message-ID: <4B421766.4040506@kdbg.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpoK-0006Ar-5m
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0ADQ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221Ab0ADQ3f
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:29:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:47186 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752983Ab0ADQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:29:35 -0500
Received: from [77.117.74.72] (77.117.74.72.wireless.dyn.drei.com [77.117.74.72])
	by bsmtp.bon.at (Postfix) with ESMTP id 3968B10030;
	Mon,  4 Jan 2010 17:29:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136128>

Junio C Hamano schrieb:
> * jk/run-command-use-shell (2010-01-01) 8 commits
>  - t4030, t4031: work around bogus MSYS bash path conversion
>  - t0021: use $SHELL_PATH for the filter script
>  - diff: run external diff helper with shell
>  - textconv: use shell to run helper
>  - editor: use run_command's shell feature
>  - run-command: optimize out useless shell calls
>  - run-command: convert simple callsites to use_shell
>  - run-command: add "use shell" option

Two notes about this:

1. My patch "t0021:..." contains an unrelated change to t4030 (it changes 
a /bin/sh to $SHELL_PATH) that is not necessary. I included it in my first 
version of the patch, but later noticed that we already have many similar 
uses of /bin/sh instead of $SHELL_PATH in test scriptlets and decided to 
remove the change, but I only changed the commit message and forgot to 
unstage t4030.

2. If you intend to merge the early part of the topic to master early and 
hold "diff:..." and "textconv:..." in next a bit longer (as proposed by 
Jeff), then you should move "t0021:..." after "run-command: optimize out 
useless shell calls".

Thanks,
-- Hannes
