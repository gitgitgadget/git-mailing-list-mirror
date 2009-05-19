From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 13:49:25 -0600
Message-ID: <4A130D45.1050207@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil> <4A130309.2060407@nortel.com> <0WGSJO_TdUxCKWhDCupb3MaPOyPeVNH7Rs_7iKVnQcahmxUpwu8qzw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue May 19 21:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6VJh-0000fn-JB
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 21:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbZESTt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 15:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbZESTt2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 15:49:28 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:33305 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZESTt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 15:49:28 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n4JJnRt22199;
	Tue, 19 May 2009 19:49:27 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 15:49:27 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <0WGSJO_TdUxCKWhDCupb3MaPOyPeVNH7Rs_7iKVnQcahmxUpwu8qzw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 May 2009 19:49:27.0158 (UTC) FILETIME=[EACCD960:01C9D8BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119562>

Brandon Casey wrote:
> Chris Friesen wrote:

>> [cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag ncgl
> 
> What's "ncgl"?  Another branch at the same tip as "arch"?

Oops, missed a replace.  "ncgl" is my main branch.

> Ok, you tagged main, and previously arch was at the same state,
> so 'git describe' printed out 'my_tag' for both of them.  Now,
> the arch branch is ahead of main by one commit, so you get an
> expanded string from 'git describe' (the meaning of which I
> described earlier, above).
> 
>> Now we add another tag to the main branch:
>>
>> [cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag2 main
>> [cfriesen@localhost linux]$ git describe main
>> my_tag
>> [cfriesen@localhost linux]$ git describe arch
>> my_tag-1-g4c8dfa7
>>
>> I assume that since there were no code changes on the main branch,
>> it doesn't think that there is any difference between the two tags.
> 
> Right.  There is no difference.  You created another tag pointing at
> the same revision as the first tag.  Here's something else to try:

<snip>

> Starting to make sense?

Yep.  I still need whatever identifier I use to be associated with the
head of each branch.

Based on the discussion (thanks for the explanations, by the way) I
don't see any option other than looping through each branch and using
tags with the branch name embedded in them to ensure uniqueness across
the repository.

Chris
