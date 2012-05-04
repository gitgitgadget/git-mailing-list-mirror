From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: RFC: reflog for deleted branches
Date: Fri, 04 May 2012 08:27:01 +0200
Message-ID: <4FA376B5.50804@dewire.com>
References: <4FA2F7DA.6020108@tu-clausthal.de> <7vaa1pdjz8.fsf@alter.siamese.dyndns.org> <4FA30270.6000806@tu-clausthal.de> <7vwr4sdfw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 08:52:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCNg-0003Di-QL
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 08:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2EDGwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 02:52:38 -0400
Received: from mail.dewire.com ([83.140.172.130]:29863 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab2EDGvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 02:51:36 -0400
X-Greylist: delayed 1471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 02:51:36 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 858208007A5;
	Fri,  4 May 2012 08:27:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PA0Z6txLQuRK; Fri,  4 May 2012 08:27:03 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5F7868003F7;
	Fri,  4 May 2012 08:27:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120425 Thunderbird/13.0
In-Reply-To: <7vwr4sdfw7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196995>

Junio C Hamano skrev 2012-05-04 01.05:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>
>> The "normal" reflog cannot be used if you just create and then delete a
>> branch - the reflog is empty in this case.
>
> I somehow thought we discussed about the lack of "creation" event.
> Perhaps it is sufficient to create a reflog entry for such then?

We have the create event (oldd=0000...), if we just don't delete the log and add
a destroy event (newid=000000).

A bit trickier with the current reflog design is the case where you
delete branch foo and then create the branch foo/bar. One way would be
to append a "." to the leaf in the refs directory tree. Older readers
wouldn't understand that to there's a compatibility issue.

-- robin
