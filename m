From: Steve Haslam <shaslam@lastminute.com>
Subject: Re: [PATCH] Remove references to git-fetch-pack from "git clone"
    documentation.
Date: Mon, 28 Jul 2008 13:32:50 +0100
Message-ID: <488DBC72.8040204@lastminute.com>
References: <1217011068-1675-1-git-send-email-shaslam@lastminute.com> <alpine.DEB.1.00.0807260523520.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNRvO-00083V-Gb
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbYG1MdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYG1MdB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:33:01 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:21539 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbYG1MdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:33:01 -0400
X-ExtLoop1: From 10.136.85.54
X-IronPort-AV: E=Sophos;i="4.31,265,1215385200"; 
   d="scan'208";a="1124800056"
Received: from unknown (HELO sglonbh01.Global.ad.sabre.com) ([10.136.85.54])
  by sglonmg02-out.sabre.com with ESMTP; 28 Jul 2008 13:33:00 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonbh01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Jul 2008 13:32:59 +0100
Received: from [10.104.41.28] ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Jul 2008 13:32:58 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.DEB.1.00.0807260523520.26810@eeepc-johanness>
X-OriginalArrivalTime: 28 Jul 2008 12:32:58.0374 (UTC) FILETIME=[11354A60:01C8F0AE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90451>

Johannes Schindelin wrote:
> Hi,
>
> On Fri, 25 Jul 2008, Steve Haslam wrote
>> "git clone" no longer calls "git-fetch-pack",
>>     
>
> So it calls it internally, avoiding fork() and exec().  But the code is 
> still git-fetch-pack's.  The difference should be lost on the regular Git 
> user.
>   
Well, I would say that the git-clone command uses code that is also used 
by the git-fetch-pack command; but as you indicate, this is a minor 
implementation detail.

I think that the documentation was perhaps too explicit and as a result 
stale: git-clone certainly does not work any more by creating a 
"--exec=..." argument to pass to the git-fetch-pack command even 
internally, it calls code in transport.c. As you say, the difference is 
immaterial to most users, and a simplified version of the documentation 
should be adequate (and possibly clearer).

SRH
