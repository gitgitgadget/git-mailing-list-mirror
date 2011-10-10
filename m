From: Martin Fick <mfick@codeaurora.org>
Subject: Garbage collection creates many unpacked objects.
Date: Mon, 10 Oct 2011 17:30:42 -0600
Organization: CAF
Message-ID: <201110101730.43302.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 01:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPJ5-00055N-Mm
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 01:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1JJXar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 19:30:47 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:41646 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1JJXar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 19:30:47 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6495"; a="126266042"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 10 Oct 2011 16:30:46 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5C5C010004B1
	for <git@vger.kernel.org>; Mon, 10 Oct 2011 16:30:45 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183268>

If I clone linus' kernel, delete all the tags, and then run 
git gc, it ends up expanding into about 5K of unpacked 
objects.  The .git size goes from 473M to 511M.  This seems 
a bit strange no?  Shouldn't gcing yield a smaller repo an 
fewer unpacked refs?

If I do this on our internal kernel repo (which has 2Ktags), 
it gets much more pathological, it expands to about 1M 
objects and grows to about 7G!!!

This seems to happen with all versions which I tested, 
1.6.0, 1.7.6 and 1.7.7

Any thoughts?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
