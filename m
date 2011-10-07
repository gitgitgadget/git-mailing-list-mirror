From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Scalable reference handling
Date: Fri, 7 Oct 2011 12:51:43 -0600
Organization: CAF
Message-ID: <201110071251.44052.mfick@codeaurora.org>
References: <4E8CCC55.9070408@alum.mit.edu> <4E8E6E8E.5070909@alum.mit.edu> <4E8F2012.90108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 07 20:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCFWk-0000eF-Lk
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 20:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab1JGSwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 14:52:05 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:38485 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1JGSwD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 14:52:03 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6492"; a="125748608"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 07 Oct 2011 11:51:45 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2332C10004C2;
	Fri,  7 Oct 2011 11:51:45 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4E8F2012.90108@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183096>

On Friday, October 07, 2011 09:51:46 am Michael Haggerty 
wrote:
> I can't write more now, but Martin, if you have time to
> benchmark 9944c7faf903a95d4ed9de284ace32debe21cdc1
> against your repository, I would be very interested to
> learn the results.

The fetch no longer seems to suffer from the large 
regression, it is now faster (~7m) than 1.7.7 (which was 
+15m).


As a quick note, if I comment out the 
invalidate_cached_refs() call in write_ref_sha1() on line  
2065 (on top of 9944c7), it is still much faster, only ~2m.  
Perhaps growing the array on the fly with many refs is still 
be too inefficient?


-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
