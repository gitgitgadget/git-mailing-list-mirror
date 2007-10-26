From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Fri, 26 Oct 2007 08:18:27 +0200
Message-ID: <D38E4717-CF67-4897-983E-2B45CA217C11@zib.de>
References: <20071024212854.GB6069@xp.machine.xx>	<05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>	<Pine.LNX.4.64.0710242258201.25221@racer.site>	<008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>	<Pine.LNX.4.64.0710250021430.25221@racer.site>	<47204297.5050109@op5.se>	<Pine.LNX.4.64.0710251112390.25221@racer.site>	<472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org>	<4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org>	<4720CCE0.2090007@op5.se> <7vejfj11tk.fsf@gitster.siamese.dyndns.org> <4720FA00.1050805@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 08:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlIYM-0001Pp-3x
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 08:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbXJZGUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 02:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbXJZGUE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 02:20:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:41866 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbXJZGUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 02:20:01 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9Q6H5J4029047;
	Fri, 26 Oct 2007 08:19:43 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db109f4.pool.einsundeins.de [77.177.9.244])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9Q6Gxqm001809
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 26 Oct 2007 08:17:04 +0200 (MEST)
In-Reply-To: <4720FA00.1050805@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62393>


On Oct 25, 2007, at 10:18 PM, Andreas Ericsson wrote:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>
>> With that in mind, how about making "git checkout foo", after
>> foo is set up thusly, to show:
>> 	git log --pretty=oneline --left-right origin/pu...foo
>> if (and only if) they have diverged?  Then you can deal with the
>> staleness of local tracking fork 'foo' in any way you want.
>> You could even go one step further and make this "checkout foo",
>> in addition to or instead of showing the above left-right log,
>>  - automatically run "git merge origin/pu" if it is a
>>    fast-forward, and say it did _not_ run that merge if it is
>>    not a fast-forward;
>>  - automatically run "git merge origin/pu" always, even if it is
>>    not a fast-forward;
>>  - automatically run "git rebase origin/pu" always;
>> Would that make your life easier?
>
> That it would, except the confusion would then be that it's  
> automatically
> rebased for the branches one currently hasn't got checked out while  
> pulling,
> and the branch that *is* checked out gets merged (crazy, yes), so  
> those
> who prefer the rebase would get what they want by doing something  
> completely
> bonkers, such as:
>
> git checkout -b just-gonna-pull HEAD^
> git pull
> git checkout whatever-other-branch-they-were-on
>
> (yes, "aggresively ignorant", I think Ted said in an earlier mail)
>
> It'd probably be better to go with Dscho's suggestion, although I'm  
> not quite
> sure what that was any more. It involved automagical rebasing on  
> fetch or pull
> though.

git pull's automagic and the automatic behaviour of git checkout
proposed by Junio should always do the same. git pull should
be changed to act a if your three commands were fused into it
(but obviously implemented differently).

I think teaching "git checkout" a dwim mode is quite
interesting.  The required work to bring a local branch
up-to-date with a remote branch is deferred until really needed.
An then "git checkout" does the right thing. A lot of automagic
but definitely intriguing.

	Steffen
