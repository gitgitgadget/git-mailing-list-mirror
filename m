From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: How to prevent changes to repository by root
Date: Fri, 18 Jun 2010 13:45:33 -0700
Message-ID: <4C1BDAED.3030809@pcharlan.com>
References: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>	<AANLkTikPNH1ueb5m8JpiB2hU4afd3hv-4qYqSO3QPujl@mail.gmail.com> <AANLkTimjIraq-qDaifACixJ4cCOYuvkf1v-hVpeaVt3u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Aneurin Price <aneurin.price@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 22:46:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPiS6-0001df-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 22:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab0FRUqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 16:46:09 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:50587 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0FRUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 16:46:07 -0400
Received: from swarthymail-a2.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id BB76F17ADB8
	for <git@vger.kernel.org>; Fri, 18 Jun 2010 13:46:06 -0700 (PDT)
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a2.g.dreamhost.com (Postfix) with ESMTP id 653D1EE5F2;
	Fri, 18 Jun 2010 13:45:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTimjIraq-qDaifACixJ4cCOYuvkf1v-hVpeaVt3u@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149361>

On 06/16/2010 07:28 PM, Nazri Ramliy wrote:
> On Thu, Jun 17, 2010 at 12:09 AM, Aneurin Price <aneurin.price@gmail.com> wrote:
>> How are they becoming root? If they are using sudo you could forbid
>> running git as root. If they are using su or logging in directly maybe
>> you can get away with some trivial thing like putting 'alias
>> git=/bin/false' in /root/.bashrc - or some wrapper which does
>> something helpful rather than silently fail :-).
> 
> Thanks for dropping the hint on wrapper.
> 
> I've implemented one that give the user a friendly reminder
> that they are running git as root and ask whether to continue.

When I needed this I wrote a hook that refused a commit by root unless the commit message said something to the effect of:

Root commit performed by <person or script name>.

It's not that I minded so much that root was doing commits, it's the anonymity that was the problem.  So automated scripts that ran as root could perform commits too, they just had to include this note in the commit message so we knew which script was doing it.  It was all the honor-system, but it did what we wanted and prevented committing as root by accident.

--Pete
