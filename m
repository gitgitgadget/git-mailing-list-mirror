From: Lars Noschinski <lars.noschinski@rwth-aachen.de>
Subject: Re: cvsexportcommit and cvsimport's -k option
Date: Fri, 2 May 2008 22:11:02 +0200
Message-ID: <20080502201102.GA24914@lars.home.noschinski.de>
References: <f6c6e2a5cc39.481773ba@rwth-aachen.de> <200804292146.42262.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js1iQ-0007q9-UF
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 22:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810AbYEBUR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761130AbYEBUR7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 16:17:59 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:58106 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYEBUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 16:17:58 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 May 2008 16:17:58 EDT
Received: from [134.130.243.125] (helo=vertikal.home.noschinski.de)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars.noschinski@rwth-aachen.de>)
	id 1Js1az-0001x9-Vi; Fri, 02 May 2008 22:11:06 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars.noschinski@rwth-aachen.de>)
	id 1Js1aw-0006UN-Gx; Fri, 02 May 2008 22:11:02 +0200
Content-Disposition: inline
In-Reply-To: <200804292146.42262.robin.rosenberg.lists@dewire.com>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81032>

Hello!

* Robin Rosenberg <robin.rosenberg.lists@dewire.com> [08-04-29 22:56]:
>tisdagen den 29 april 2008 19.15.06 skrev Lars Alexander Noschinski:
>> ... hack away ...
>> git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
>> git-rebase cvs # If work was done in the meantime
>> git-cvsexportcommit -cpuv $COMMIT # Multiple times, if necessary
>> git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
>> git-checkout -b master cvs # commit ids are changed now
>>
>> As far as I am concerned, this works fairly well, accept when for any
>> reason a line containing a CVS keyword (e.g. $Id$) is contained in a
>> changeset. In this case, patching fails, and I have to investigate why it
>> fails, eventually just copying the old version from the cvs repository.
>>
>> Would it be possible to add an option to cvsexportcommit to detect such
>> killed keywords and ignore them?
>
>Sure, but is it necessary? If the cvs checkout you use is checked out
>with -kk there shouldn't be any problem.

Errm, now as you mention it ... Even it is clearly mentioned in
git-cvsimport(1), it did not realize, that -k just invokes cvs with -kk.
I think this is a perfectly fine solution.

>If not, start by thinking up a few testcase for inclusion in
>t9200-git-cvsexportcommit.sh that illustrates the problem. Then we can
>change cvsexporcommit until the new tests pass.

As cvs can do this for us, I think it is not necessary to introduce
another source of potential errors.


Thanks for your quick answer and sorry for me being dumb,
     Lars
