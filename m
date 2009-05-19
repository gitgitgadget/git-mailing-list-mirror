From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 10:59:50 -0600
Message-ID: <4A12E586.60705@nortel.com>
References: <4A12DDB9.60608@nortel.com> <F3E3C849-76E1-4D5F-8305-276C4C205250@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:00:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Sff-0003TR-4o
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbZESQ7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbZESQ7z
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:59:55 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:41805 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZESQ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:59:55 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n4JGxrt01890;
	Tue, 19 May 2009 16:59:54 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 12:59:52 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <F3E3C849-76E1-4D5F-8305-276C4C205250@dbservice.com>
X-OriginalArrivalTime: 19 May 2009 16:59:52.0317 (UTC) FILETIME=[3A1F52D0:01C9D8A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119550>

Tomas Carnecky wrote:

> Tags are not specific to any branch in particular. Usually you tag  
> commits, and git doesn't care on which branch these commits are. That  
> information is not recorded in the tag.
> 
> What you can do is create an alias that iterates over all branches and  
> tags each one.
> 
> git for-each-ref refs/heads/main refs/heads/arch/ | while read sha  
> type ref; do
>      git tag TAGNAME $sha -m "Tagged $ref"
> done
> 
> $sha is the sha where the ref points to, $type will be 'commit' and  
> $ref is the full ref (refs/heads/arch/xxx for example)

I tried something like this manually but on the second branch it complained
that the tag already existed.

Chris
