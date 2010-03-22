From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: commit --amend neglecting return value
Date: Mon, 22 Mar 2010 01:16:55 -0400
Message-ID: <196847A3-42CB-4CE8-8FFC-D7C8C8AFCDF7@gernhardtsoftware.com>
References: <20100322043616.GF21406@baikonur.stro.at>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Mon Mar 22 06:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nta0l-0005B8-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 06:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab0CVFRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 01:17:05 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47763 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0CVFRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 01:17:04 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 720BF1FFC2ED; Mon, 22 Mar 2010 05:16:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 1AE001FFC133;
	Mon, 22 Mar 2010 05:16:47 +0000 (UTC)
In-Reply-To: <20100322043616.GF21406@baikonur.stro.at>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142898>


On Mar 22, 2010, at 12:36 AM, maximilian attems wrote:

> bug is easily reproducible by
> 
>> foo
> git add foo
> git commit --amend
> :q!
> 1 files changed, 1 insertions(+), 8 deletions(-)
> create mode 100644 test
> 
> git --version
> git version 1.7.0.2
> 
> aboves is usage with vim as patch editor.
> The expected behaviour would be to have not foo add to repo.
> afair this feature^Wbug exists since loooong.

Vim returns 0 even if quit with :q!.  Killing vim from another terminal causes this:

--- 8< ---
Vim: Caught deadly signal TERM

Vim: Finished.
error: /Users/brian/bin/vim died of signal 15
error: There was a problem with the editor '/Users/brian/bin/vim'.
Please supply the message using either -m or -F option.
--- 8< ---

If you want to abort committing while editing the message, delete the entire message (in Vim: "0dG:wq^M") and git will reply "Aborting commit due to empty commit message."

~~ Brian