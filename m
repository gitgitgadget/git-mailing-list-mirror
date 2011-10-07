From: Martin Fick <mfick@codeaurora.org>
Subject: Re: 66 patches and counting
Date: Thu, 6 Oct 2011 19:59:33 -0600
Organization: CAF
Message-ID: <201110061959.34018.mfick@codeaurora.org>
References: <4E8CCC55.9070408@alum.mit.edu> <201110061616.39381.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 07 03:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBziw-0005aF-10
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 03:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759386Ab1JGB7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 21:59:36 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:54315 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1JGB7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 21:59:35 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6491"; a="125524838"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 06 Oct 2011 18:59:35 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 53FAE10004C2;
	Thu,  6 Oct 2011 18:59:35 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201110061616.39381.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183054>

On Thursday, October 06, 2011 04:16:39 pm Martin Fick wrote:
> On Wednesday, October 05, 2011 03:29:57 pm Michael
> Haggerty
> > [1] hierarchical-refs at
> > git://github.com/mhagger/git.git
> 
> I downloaded your patch series and tested it on my repos.
> 
>  * full fetch changes                  (> 1 hour) (bad!)

I bisected this problem, it was introduced in this commit:


  commit e12ce45b4f1bd8ed6652a742b7e6cf6f101b3604
  Author: Michael Haggerty <mhagger@alum.mit.edu>
  Date:   Wed Oct 5 11:30:06 2011 +0200

    Store references hierarchically
    
    This slightly changes the order of iteration over 
references; now
    references are strictly sorted componentwise rather than 
as
    "/"-containing strings as before.  For example, 
"subspace/one" now
    sorts before "subspace-x", whereas before the order was 
reversed.
    
    Tweak a test case to accept the new ordering.



Up until that point, the fetch looks pretty good,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
