From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] show git tag output in pager
Date: Mon, 03 Oct 2011 14:57:09 +0200
Message-ID: <vpqwrcmw7ve.fsf@bauges.imag.fr>
References: <20110927134235.GA27478@zelva.suse.cz>
	<vpqehz2cbk4.fsf@bauges.imag.fr>
	<20110929093749.GB27152@zelva.suse.cz>
	<20110930104241.GB24507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 14:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAi60-00008z-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 14:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab1JCM6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 08:58:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50103 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560Ab1JCM6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 08:58:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p93Csp1U018385
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2011 14:54:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RAi4z-0003z9-BN; Mon, 03 Oct 2011 14:57:09 +0200
In-Reply-To: <20110930104241.GB24507@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 Sep 2011 06:42:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 03 Oct 2011 14:54:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p93Csp1U018385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318251294.05072@IZRGz6v+iqQtYyFYgsToVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182659>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 29, 2011 at 11:37:49AM +0200, Michal Vyskocil wrote:
>
>> On Tue, Sep 27, 2011 at 04:19:39PM +0200, Matthieu Moy wrote:
>> > The commit message should explain why this is needed, and in particular
>> > why you prefer this to setting pager.tag in your ~/.gitconfig.
>> 
>> Opps! I read a documentation, but I did not realize this works for all
>> commands and not only for them calling setup_pager(). Then sorry, no
>> change is needed.
>
> I don't think you want to set pager.tag. It will invoke the pager for
> all tag subcommands, including tag creation and deletion.

That's the kind of argument/discussion I was expecting in the commit
message.

> I think instead, you want some way for commands to say "OK, I'm in a
> subcommand that might or might not want a pager now".

Right.

I like the try_subcommand_pager idea. Ideally, there would also be a
nice mechanism to set defaults for subcommands, so that "git tag
<whatever>" does the right thing without configuration.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
