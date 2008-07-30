From: Steve Haslam <shaslam@lastminute.com>
Subject: Re: [PATCH] Glean libexec path from argv[0] for git-upload-pack and
    git-receive-pack.
Date: Wed, 30 Jul 2008 19:53:32 +0100
Message-ID: <4890B8AC.4010106@lastminute.com>
References: <1217417238-26731-1-git-send-email-shaslam@lastminute.com>     <alpine.LSU.1.00.0807301650060.3486@wbgn129.biozentrum.uni-wuerzburg.de>     <48909396.3080500@lastminute.com> <alpine.LSU.1.00.0807302020300.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:55:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGpA-0000r2-AS
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYG3Sxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbYG3Sxg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:53:36 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:22235 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbYG3Sxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:53:35 -0400
X-ExtLoop1: From 10.136.85.54
X-IronPort-AV: E=Sophos;i="4.31,280,1215385200"; 
   d="scan'208";a="1125128763"
Received: from unknown (HELO sglonbh01.Global.ad.sabre.com) ([10.136.85.54])
  by sglonmg02-out.sabre.com with ESMTP; 30 Jul 2008 19:53:33 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonbh01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 19:53:32 +0100
Received: from [10.104.41.28] ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 19:53:32 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.LSU.1.00.0807302020300.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 30 Jul 2008 18:53:32.0156 (UTC) FILETIME=[90076BC0:01C8F275]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90832>

Johannes Schindelin wrote:
> Hi,
>
> On Wed, 30 Jul 2008, Steve Haslam wrote:
>   
>> I think that once git-upload-pack.c et al get the argv[0] path over to 
>> setup_path() then there's nothing more to do; setup_path() already uses 
>> argv0_path in its list of paths to try. I'm confused to the reference to 
>> PATH, though: we're avoiding the PATH environment variable completely.
>>     
>
> There is an issue in setting up the argv0_path when Git is called as "git" 
> and resolved via the PATH: argv[0] then is literally "git".
>
> And we need argv0_path for other things than just calling programs: 
> relative etc/gitconfig and libexecdir.
>   
Ah, I see what you meant. And all setup_path() actually does is add to 
the end of PATH. I should have understood before.

OK, I will split the patch up and tidy it.

SRH
