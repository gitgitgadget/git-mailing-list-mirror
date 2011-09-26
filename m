From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 09:48:25 -0600
Organization: CAF
Message-ID: <201109260948.25312.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109260915.29285.mfick@codeaurora.org> <CAGdFq_iuY0-PBDOmtz1pRvh6J9EDRiRJHsWkTN_cHjGU20PYTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8DQA-00039b-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab1IZPsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 11:48:38 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:57625 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab1IZPsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 11:48:37 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121607973"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 08:48:26 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A527210004BE;
	Mon, 26 Sep 2011 08:48:26 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAGdFq_iuY0-PBDOmtz1pRvh6J9EDRiRJHsWkTN_cHjGU20PYTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182125>

On Monday, September 26, 2011 09:21:30 am Sverre Rabbelier 
wrote:
> Heya,
> 
> On Mon, Sep 26, 2011 at 17:15, Martin Fick 
<mfick@codeaurora.org> wrote:
> > If this change does not actually speed things up,
> > should it be reverted?  Or was there a bug in the
> > change that makes it not do what it was supposed to
> > do?
> 
> It probably looks at the refs in refs/changes while it
> shouldn't, hence worsening your performance compared to
> not looking at those refs. I assume that it does improve
> your situation if you have all those refs under say
> refs/heads.

Hmm, I was thinking that too, and I just did a test. 

Instead of storing the changes under refs/changes, I fetched 
them under refs/heads/changes and then ran git 1.7.6 and it 
took about 3 mins.  Then, I ran the 1.7.7.rc0.73 with 
c774aab98ce6c5ef7aaacbef38da0a501eb671d4 reverted and it 
only took 13s!  So, if this indeed tests what you were 
suggesting, I think it shows that even in the intended case 
this change slowed things down?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
