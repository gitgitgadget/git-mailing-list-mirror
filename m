From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach
 	"git status" the "--ignore-submodules" option)
Date: Mon, 28 Jun 2010 21:00:00 +0200
Message-ID: <4C28F130.2090904@web.de>
References: <4C24C34B.20403@web.de>	<7vlja3j7hu.fsf@alter.siamese.dyndns.org>	<20100625190147.GA17493@burratino> <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com> <4C25E83E.4080905@web.de> <4C28EA0A.3080804@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 21:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJYx-0000WW-MJ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab0F1TAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 15:00:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35492 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0F1TAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 15:00:04 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1E9CE1697D391;
	Mon, 28 Jun 2010 21:00:01 +0200 (CEST)
Received: from [80.128.76.242] (helo=[192.168.0.214])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OTJYm-0002HP-00; Mon, 28 Jun 2010 21:00:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C28EA0A.3080804@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/DrrlXwbVmxaBGJQJJu2lOknunGzAKxWgGQEVA
	tdzxVcccN/0akX5+Ip9KP/nVmIDmsk+5UUonCjc3x+vrHAdN5F
	SxzPir3ZHvhcg9Sm45vQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149850>

Am 28.06.2010 20:29, schrieb Marc Branchaud:
> On 10-06-26 07:45 AM, Jens Lehmann wrote:
> I applaud all the current submodule work -- thanks a ton!

Thanks for your feedback!


> I would like to ask submodule developers to please keep in mind scenarios
> where only a subset of the super-project's submodules are in use at one time.
>  In particular, please avoid forcing any blanket updates to all submodules.
> I think the features being discussed would be much more useful if they only
> applied to submodules that are already initialized and updated by the user,
> and that any unintialized submodules should be left alone.

Yes. I think we agreed some time ago that until the user can configure the
wanted behavior only populated submodules should be touched, so I don't
mention that explicitly anymore.


>> 1) Switching branches, merging, rebasing and resetting in the
>>    superproject must result in a checkout of the matching submodule
>>    work tree (right now you always have to issue a "git submodule
>>    update" afterwards to get the submodules in sync).
> 
> So, extending my request to this situation, I would say git should only
> update submodules that are already initialzied and updated.

Yes, see above.


>> 2) On "git clone" the submodules must be cloned and checked out too
>>    (currently you have to do a "git submodule update --init" after
>>    cloning the superproject).
> 
> Making clone do this automatically would be a show-stopper for us.  The
> current '--recursive' option is fine (though we never use it).
> 
> It would be interesting if the super-project could configure which submodules
> to automatically clone.

That's what I have in mind too. Maybe we could use the 'update' option of
.gitmodules to clone all those submodules where it is set. Then different
branches with different .gitmodules would behave differently.
