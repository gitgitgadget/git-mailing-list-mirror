From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 18:03:02 -0400
Message-ID: <49CAAA16.1080401@fastmail.fm>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmbJl-0000go-Jp
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZCYWJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 18:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbZCYWJw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:09:52 -0400
Received: from smtp123.rog.mail.re2.yahoo.com ([206.190.53.28]:39728 "HELO
	smtp123.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754322AbZCYWJv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 18:09:51 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2009 18:09:51 EDT
Received: (qmail 6128 invoked from network); 25 Mar 2009 22:03:09 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp123.rog.mail.re2.yahoo.com with SMTP; 25 Mar 2009 22:03:09 -0000
X-YMail-OSG: I1wo7noVM1m85i.XeAeS7X4dK5Ow_hun1yekB12ldLfuhdNrUOieflxJ5B0HEJ5RnA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 7AC9921C051A;
	Wed, 25 Mar 2009 18:03:08 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4pd2Nt1mnrv4; Wed, 25 Mar 2009 18:03:02 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id C58BB21C0519;
	Wed, 25 Mar 2009 18:03:02 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114685>

Junio C Hamano wrote:
>> "After a feature release is made from "master", however, "next" will
>> be rebuilt from the tip of "master" using the surviving topics"
>>
>> Does this mean:
>>
>> git branch -d next
>> git checkout -b next master
>> git merge ai/topic1_to_cook_in_next
>> git merge ai/topic2_to_cook_in_next
> 
> That is more-or-less correct, even though I'd actually do either
> 
> 	git branch -f next master
> 
> or
> 
> 	git checkout next
>         git reset --hard master
> 
> instead of deleting and recreating.

Is that a stylistic preference or does your approach have some
advantage over the delete/create? Doesn't git branch -f internally
delete and re-create?

This whole approach seems really workable and powerful -- the only
concern I had with this workflow was the difficult to understand
visualization of the history. So to repeat my earlier question: Are
there some canned gitk invocations, or other tips/tricks/approaches,
that can be used to make the visualization of the integration and
topic branches more intuitive?

Within the next couple of days I will probably submit a patch to
maintain-git.txt that includes the information you have relayed to me
here, as I think it may be useful to others.

Cheers,
Raman
