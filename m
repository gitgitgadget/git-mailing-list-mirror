From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Per-remote tracking branch
Date: Thu, 24 Sep 2009 13:10:40 +0200
Message-ID: <vpq63b8egy7.fsf@bauges.imag.fr>
References: <vpq4or48bux.fsf@bauges.imag.fr>
	<20090924062911.GC24486@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 13:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqmEK-0006ri-5d
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 13:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbZIXLLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZIXLLJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 07:11:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41598 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbZIXLLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 07:11:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8OB68cO003468
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Sep 2009 13:06:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MqmDh-0000oq-0i; Thu, 24 Sep 2009 13:10:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MqmDg-0003Wj-Vc; Thu, 24 Sep 2009 13:10:40 +0200
In-Reply-To: <20090924062911.GC24486@coredump.intra.peff.net> (Jeff King's message of "Thu\, 24 Sep 2009 02\:29\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 Sep 2009 13:06:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8OB68cO003468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254395170.3754@Q7d3XnCPWSbou9a0fJe4fA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129035>

Hi, and thanks for your answer,

Jeff King <peff@peff.net> writes:

> On Tue, Sep 15, 2009 at 05:29:58PM +0200, Matthieu Moy wrote:
>
>> Is there a way, with Git, to specify a tracking branch on a per-remote
>> basis?
>
> I don't think so, and I'm not sure there is an easy way to extend the
> current configuration scheme. Adding multiple config options like this:
>
>   [branch "master"]
>     remote = origin
>     merge = refs/heads/master
>     remote = alternate
>     merge = refs/heads/master

I had tried this in case it would have worked ;-).

> And it feels a little backwards. When I say "git pull foo", I would find
> it equally likely to discover the pulled branch under "remote.foo" as it
> would to find it under "branch.master". Of course, in either case, you
> have to combine the context (current branch _and_ selected remote)
> to come up with the actual information.

Actually, for my particular use case (aka "almost always only one
branch per repo"), I could as well have a remote.foo.defaultBranch
regardless of the current local branch. Then, if I say "git pull foo",
it would understand it as "git pull foo <remote.foo.defaultBranch>".

If other people would be interested in such feature, say so, I may
give it a try when I have time. If I'm the only one, I guess I'll let
my fingers type the extra " master" instead ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
