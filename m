From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
  lengths)
Date: Thu, 12 Mar 2009 10:24:12 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903121014010.18527@yvahk2.pbagnpgbe.fr>
References: <49B5AF67.6050508@gmail.com>  <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>  <49B5F0BA.3070806@gmail.com>  <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>  <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>  <alpine.DEB.1.10.0903120956460.18527@yvahk2.pbagnpgbe.fr>
 <e2b179460903120212x67081f69wb66364918714add7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhB1-0000Zu-6B
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbZCLJYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZCLJYi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:24:38 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:58582 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZCLJYh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:24:37 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2C9OPPd005913;
	Thu, 12 Mar 2009 10:24:25 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <e2b179460903120212x67081f69wb66364918714add7@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113027>

On Thu, 12 Mar 2009, Mike Ralphson wrote:

>> May I suggest perhaps require a libcurl version that is no older than three 
>> years or something like that?
>
> It might be a plan 8-) Though I was thinking technically in terms of 
> features we think git needs. Though doubtless there are several security 
> fixes it would be beneficial to keep up to date with.

Right, but if you set a common lowest denominator first you know what features 
to expect to be there _at least_, then there might of course be a set of 
additional ones brought by newer versions. It would reduce the amount of 
conditionals in the code and what-if-this-is-used scenarios (in the code and 
in support/docs). It also reduces the risks of git getting odd problems due to 
very old libcurl bugs.

>> (spoiler: libcurl 7.9.3 is more than seven years old!)
>
> And still the release IBM package for AIX [1]. 8-(

However, someone who's building/getting git might also be able to build/get a 
newer libcurl.

> The summary of automatic builds (http://curl.haxx.se/auto/) is very nicely 
> presented. Is that custom code?

The code is custom (perl) but present in the curl CVS repo for the web site 
and could probably fairly easy be adapted for other purposes/projects.

In the curl project we provide scripts for distributed automatic tests and 
then we have a central server that receives the reports by mail and the 
automatic summary script displays the status of those tests on that page.

-- 

  / daniel.haxx.se
