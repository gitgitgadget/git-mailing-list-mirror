From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 13:23:50 -0700
Message-ID: <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
References: <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYo5X-0001cE-Ac
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbYH1U0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYH1U0U
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:26:20 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:52081 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640AbYH1U0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:26:19 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7SKNvTs000516;
	Thu, 28 Aug 2008 16:23:57 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7SKNphP008412
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 28 Aug 2008 16:23:55 -0400
In-Reply-To: <20080828195211.GA3545@mithlond.arda.local>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94132>


On Aug 28, 2008, at 12:52 PM, Teemu Likonen wrote:

> Perry Wagle wrote (2008-08-28 12:24 -0700):
>
>> Is is really only that I
>>
>>    sed s/git-/git<SPACE>/g
>>
>> on the scripts?  I'm doubting it, given the quality of reasoning and
>> lack of respect for upward compatibility on this thread.
>
> I have come to understand that "git " has quite long time been more
> robust and portable way of writing scripts. They work in both
> configurations so I'd definitely suggest doing "s/git-/git /g" for  
> every
> script. Of course in an interactive shell everyone can use whatever  
> they
> prefer and works at the moment.

Sure.  Its an extra fork in git command intensive scripts (and git is  
racey still maybe), but *shrug*.

When I started with git in Fall 2007, the sample scripts and gitweb  
both used git<DASH> and git<SPACE> willy-nilly.  I liked git<DASH>  
better since it was what I used at the command line for the <TAB>  
completion for the commands and for the man pages, and I like being  
meticulously consistent so I can greatly reduce mistakes.

Even as of March 2008 (our last sync with git before the git scripting  
was completed and we got on to other things), the sample scripts and  
gitweb still used the git<DASH> form.  If this has been brewing for  
two years, there shouldn't have been a git<DASH> form in the scripts  
in the standard source *anywhere* for those two years.

There was.  Therefore, you don't get to claim that this was decided  
two years ago, finally done now, and what's Perry's problem anyway?

But, my problem is not git<DASH> vs git<SPACE>, but the slap-dash way  
upward compatibility was broken and the "water over the dam" slippery  
slope rationalizations that refuse to consider reverting.  "You" will  
do it again in the future since you are declaring success here.  And  
"you" have likely done it in the past 6 months.

-- Perry
