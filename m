From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 16:34:36 -0700
Organization: CAF
Message-ID: <201202091634.36563.mfick@codeaurora.org>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com> <201202091453.38564.mfick@codeaurora.org> <CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdVi-0004Lf-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661Ab2BIXei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:34:38 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30398 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450Ab2BIXeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:34:37 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6615"; a="161978737"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 09 Feb 2012 15:34:37 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5A0D810004D1;
	Thu,  9 Feb 2012 15:34:37 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190343>

On Thursday, February 09, 2012 04:24:47 pm Hilco Wijbenga 
wrote:
> On 9 February 2012 13:53, Martin Fick 
<mfick@codeaurora.org> wrote:
> > On Thursday, February 09, 2012 02:23:18 pm Hilco
> > Wijbenga
> > 
> > wrote:
> >> For the record, our (Java) project is quite small.
> >> It's 43MB (source and images) and the entire
> >> directory tree after building is about 1.6GB (this
> >> includes all JARs downloaded by Maven). So we're not
> >> talking TBs of data.
> >> 
> >> Any thoughts on which FSs to include in my tests? Or
> >> simply which FS might be more appropriate?
> > 
> > tmpfs is probably fastest hands down if you can use it
> > (even if you have to back it by swap).
> 
> I don't have quite that much RAM. :-)

But I am sure that you have that much disk space which you 
can allocate to swap, if not you already couldn't build it.  
And tmpfs swapping is still likely faster than a persistent 
FS (it will not need to block on syncs).  If you are 
benchmarking, it is likely worth you effort since that will 
probably mark the upper performance bound,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
