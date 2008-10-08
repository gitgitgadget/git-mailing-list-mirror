From: Knut Eldhuset <knut@3d-radar.com>
Subject: Re: Different svn-id URLs in history
Date: Wed, 08 Oct 2008 08:34:23 +0200
Message-ID: <48EC546F.7060106@3d-radar.com>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSe0-0004GL-RV
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbYJHGe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbYJHGe0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:34:26 -0400
Received: from epost.nunatak.no ([193.200.93.202]:41284 "EHLO epost.nunatak.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbYJHGeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:34:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by epost.nunatak.no (Postfix) with ESMTP id 2C93A121C9B5
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 08:34:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.42
X-Spam-Level: 
X-Spam-Status: No, score=-2.42 tagged_above=-10 required=6.6 tests=[AWL=0.079,
	BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from epost.nunatak.no ([127.0.0.1])
	by localhost (epost.nunatak.no [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQ0HbvsasP-d for <git@vger.kernel.org>;
	Wed,  8 Oct 2008 08:34:23 +0200 (CEST)
Received: from [192.168.169.42] (unknown [194.19.26.200])
	by epost.nunatak.no (Postfix) with ESMTP id B7F5C121C932
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 08:34:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48EB79D8.6090908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97764>

Michael J Gruber wrote:
> Knut Eldhuset venit, vidit, dixit 07.10.2008 12:58:
>> Hi,
>>
>> After cloning my svn repository, I notice that the svn-id URL is 
>> different when going back in history:
>>
>> git-svn-id: https://server/trunk@300
>>
>> vs
>>
>> git-svn-id: https://server/trunk/some_folder/project/src@250
>>
> 
> I take this is as an invitation for guesswork (given the amount of
> details)...

Sorry about that... I'm confused.
> 
> You probably have commits which don't follow your usual svn repo layout
> (trunk/some_folder/project/src) but commit to trunk/ directly. The output of
> 
> svn log -v -r300 https://server/trunk@300
> svn log -v -r250 https://server/trunk/some_folder/project/src@250
> 
> should give some clues.
> 

Svn log shows that the same path has been modified in both cases. I see 
something strange in git, though. Our svn repository has about 6500 
commits, but git shows over 10.000. Further investigation shows that a 
lot of svn commits have two entries in git. Some branches off of trunk 
do not start at r1, but off of a duplicate rNNNN. Could this be due to 
our unhealthy practice of creating branches off of subtrees in svn? By 
this I mean create a branch off of 
https://server/trunk/some_folder/project/src instead of 
https://server/trunk. If so, what can be done to fix this?

As a sidenote, during git svn clone, I noticed that each time a new 
branch or tag was discovered, the "scanning" started back at r1. Is this 
normal? I would think the history before the branch was already 
imported. Of course, this could maybe be due to the bad branching 
practice described above.

Regards,
Knut
