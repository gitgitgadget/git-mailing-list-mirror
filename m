From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 16:20:24 -0700
Message-ID: <7vej1w73nr.fsf@gitster.siamese.dyndns.org>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
 <20081031165003.GA5355@steel.home>
 <alpine.DEB.1.00.0811010012320.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:22:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3JZ-000772-V3
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYJaXUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbYJaXUs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:20:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYJaXUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:20:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6678B777E3;
	Fri, 31 Oct 2008 19:20:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3EF65777CF; Fri, 31 Oct 2008 19:20:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0811010012320.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 1 Nov 2008 00:13:29 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C75D842-A7A2-11DD-A0A9-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99673>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Oct 2008, Alex Riesen wrote:
>
>> Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
>> > @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>> >  
>> >  int cmd_revert(int argc, const char **argv, const char *prefix)
>> >  {
>> > +#if 0
>> > +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
>> > +#endif
>> 
>> "git revert" is much shorter to type than "git cherry-pick -R". How 
>> about renaming "cherry-pick" into something short, like "pick"?
>
> I thought we agreed that we should _never_ remove support for "git 
> revert"?  I mean, we can deprecate it, but I find it pretty strong, and 
> unnecessary, to break existing users' expectations.

Likewise.

The current state of affairs is that there is no remedy if teachers find
"git checkout -- path" or "git revert HEAD~24" is confusing to new people.
By introducing "git unstage path" or "git cherry-pick -r HEAD~24",
teachers can choose to teach what they feel less confusing, and they do
not have to teach "git checkout -- path" or "git revert HEAD~24".  We
should stop there.
