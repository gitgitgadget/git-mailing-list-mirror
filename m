From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 03:15:27 -0400
Message-ID: <4A5ED38F.5070708@garzik.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org> <4A5EA598.5050801@garzik.org> <7v3a8xb0lz.fsf@alter.siamese.dyndns.org> <4A5ECC09.3010405@garzik.org> <7vocrl9kwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLDT-0001D6-BB
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbZGPHRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZGPHRK
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:17:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58633 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbZGPHRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:17:09 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MRLDI-0006nu-E3; Thu, 16 Jul 2009 07:17:09 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vocrl9kwi.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123373>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> I want to publish this tree to the world via a *.kernel.org-like
>> system, so my task is to
>>
>> 	scp -r /spare/repo/cld/.git remote.example.com:/pub/scm/cld.git
>>
>> but if I do this with scp, then future pushes to
>> remote.example.com:/pub/scm/cld.git emit the warning about updating
>> the currently checked-out branch
> 
> I think "scp -r" is a wrong way to "clone", as it will copy .git/config
> that is specific to your local work tree that does not apply to the
> situation at remote.example.com anyway.  You do not want to push into your
> local repository with a work tree you are "scp -r"ing out of, but you do
> want to push into the one at remote.example.com.
> 
> Interestingly enough, we had a two separate thread about making a bare
> repository out of a repository with a work tree today ;-)
> 
> 	remote.example.com$ cd /pub/scm/
>         remote.example.com$ git clone --bare over.there:/spare/repo/cld/.git cld.git

That direction doesn't work due to firewalls, hence the scp out /to/ 
remote.example.com.

So, will this make git happy?  :)

[starting on local machine, where I do development]
1) scp -r /spare/repo/cld remote.example.com:/tmp

2) ssh remote.example.com

3) cd /pub/scm

4) git clone --bare /tmp/cld/.git cld.git

Regards,

	Jeff
