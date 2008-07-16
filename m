From: David Christensen <david@endpoint.com>
Subject: Re: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 14:43:27 -0500
Message-ID: <D5EB71BB-FEA1-4900-AB72-914367B029AB@endpoint.com>
References: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com> <7vtzepr7g5.fsf@gitster.siamese.dyndns.org> <20080716185811.GA3517@xp.machine.xx>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ciaran McCreesh <ciaran.mccreesh@googlemail.com>,
	git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:14:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDOj-0001wT-Vw
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbYGPUNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYGPUNu
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:13:50 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:52678 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774AbYGPUNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:13:50 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2008 16:13:49 EDT
Received: from [192.168.1.140] (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by mail.endcrypt.com (Postfix) with ESMTP id B601C37DDF5;
	Wed, 16 Jul 2008 19:43:27 +0000 (UTC)
In-Reply-To: <20080716185811.GA3517@xp.machine.xx>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88740>

On Jul 16, 2008, at 1:58 PM, Peter Baumann wrote:

> On Wed, Jul 16, 2008 at 11:48:42AM -0700, Junio C Hamano wrote:
>> Ciaran McCreesh <ciaran.mccreesh@googlemail.com> writes:
>>
>>> git rm --if-missing will only remove files if they've already been  
>>> removed from
>>> disk.
>>
>> This probably is a borderline with feaping creaturism.  What's the  
>> use of
>> it in a real workflow that you need this for?
>>
>> "git add -u" may be too broad in that it also adds anything  
>> modified, but
>> so is --if-missing too broad in that it removes anything removed,  
>> and if
>> you are going to limit by giving pathspecs _anyway_, then...
>>
>> Old timers might just do:
>>
>> 	git diff --name-only --diff-filter=D |
>>        git update-index --remove --stdin
>>
>> ;-)
>>
>
> Ah. This comes in handy. I already searched for a command to delete  
> all
> missing files. After reading through the fine manual of 'git rm', I  
> went
> to git update-index but didn't come up with a solution to my problem.
>
> But I have to say, an argument to 'git rm' would be preferable than  
> the
> above plumping.


Wouldn't:

git rm $(git ls-files --deleted)

do the trick, or am I missing something?

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com
