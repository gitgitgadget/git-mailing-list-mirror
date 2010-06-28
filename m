From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach
 	"git status" the "--ignore-submodules" option)
Date: Mon, 28 Jun 2010 14:29:30 -0400
Message-ID: <4C28EA0A.3080804@xiplink.com>
References: <4C24C34B.20403@web.de>	<7vlja3j7hu.fsf@alter.siamese.dyndns.org>	<20100625190147.GA17493@burratino> <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com> <4C25E83E.4080905@web.de>
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
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 28 20:29:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJ5R-0006YF-Jy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 20:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab0F1S3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 14:29:33 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:40065 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0F1S3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 14:29:32 -0400
Received: from relay25.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay25.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id B0F741B400F;
	Mon, 28 Jun 2010 14:29:31 -0400 (EDT)
Received: by relay25.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 525CA1B4008;
	Mon, 28 Jun 2010 14:29:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4C25E83E.4080905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149846>

On 10-06-26 07:45 AM, Jens Lehmann wrote:
> 
> Yes, I think having them as a submodule makes lots of sense. But
> submodules are not there yet. Unless I overlooked something, the
> following issues must be resolved before having these two as a
> submodule, otherwise people will complain (and rightfully so!):

I applaud all the current submodule work -- thanks a ton!

I would like to ask submodule developers to please keep in mind scenarios
where only a subset of the super-project's submodules are in use at one time.
 In particular, please avoid forcing any blanket updates to all submodules.
I think the features being discussed would be much more useful if they only
applied to submodules that are already initialized and updated by the user,
and that any unintialized submodules should be left alone.

> 1) Switching branches, merging, rebasing and resetting in the
>    superproject must result in a checkout of the matching submodule
>    work tree (right now you always have to issue a "git submodule
>    update" afterwards to get the submodules in sync).

So, extending my request to this situation, I would say git should only
update submodules that are already initialzied and updated.

> 2) On "git clone" the submodules must be cloned and checked out too
>    (currently you have to do a "git submodule update --init" after
>    cloning the superproject).

Making clone do this automatically would be a show-stopper for us.  The
current '--recursive' option is fine (though we never use it).

It would be interesting if the super-project could configure which submodules
to automatically clone.

(FYI, our build works along the lines of what Jonathan suggested: it
instructs folks on how to obtain missing submodules.)

		M.
