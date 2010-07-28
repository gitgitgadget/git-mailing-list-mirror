From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Sparse checkout improvements
Date: Wed, 28 Jul 2010 09:42:20 -0400
Message-ID: <4C5033BC.5020002@xiplink.com>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>	<4C49C9C6.3080409@gmail.com>	<loom.20100727T125434-697@post.gmane.org>	<m3bp9tks6e.fsf@localhost.localdomain>	<4C4EEC0D.2070105@xiplink.com> <AANLkTimJpmGqOogQ1HtN0zu0=tPK0C0kQuEkg4PeOqUh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Alex <ajb44.geo@yahoo.com>,
	git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 28 15:42:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6tg-0007bI-Bm
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab0G1NmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 09:42:08 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:39518 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab0G1NmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:42:05 -0400
Received: from relay18.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay18.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 5E8D516F1D3E;
	Wed, 28 Jul 2010 09:42:04 -0400 (EDT)
Received: by relay18.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B81A916F1D3C;
	Wed, 28 Jul 2010 09:42:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <AANLkTimJpmGqOogQ1HtN0zu0=tPK0C0kQuEkg4PeOqUh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152086>

On 10-07-27 12:55 PM, skillzero@gmail.com wrote:
> On Tue, Jul 27, 2010 at 7:24 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> 
>> * What's missing is a way to define named collections of paths
>> ("sparse-sets?") in .git/info/sparse-checkout, so that you can conveniently
>> checkout a particular subset of the working directory.  It would also be nice
>> to switch between different sparse-sets.
> 
> I pasted in a script I wrote to work with the sparse checkout feature.
> I'm not a scripting expert so it probably doesn't things incorrectly.
> It lets you create "modules" by adding sections to .gitmodules file at
> the root of the repository (or a file you specify). You can list them,
> switch/checkout between them, or reset back to normal:

That script looks like a great proof-of-concept.  I haven't tried it out yet,
but it seems to work along the lines of what I was thinking about.

I'd like to see most of this functionality folded into the standard git
commands, and maybe a new git-sparse command for managing sparse sets.

> [module "MyApp1"]
> 	<path1>
> 	<path2>
> 
> $ git module list
> MyApp1
> 
> $ git module checkout MyApp1
> 
> $ git module reset
> 
>> * It would also be good to have a way for a repo to define a default
>> sparse-set, so that a clone would only checkout that default.
> 
> Yes, this would be nice. Ideally what I would like is for there to be
> a clone option to specify a "module" (what I've been calling sparse
> sets). A first step could just clone the full repository with -n then
> do 'git module checkout <module>' (what my other scripts do to prepare
> archives).

I'd really prefer to see it as a configuration option for the remote
repository.  Let the remote tell me what the initial sparse set should be.

> Ideally, it would do some work on the server side to only
> send the objects needed for paths specified by the sparse set (but
> still allow me to commit and later push changes back).

I'm less interested in sparse fetching, so I'll stay out of that side of the
conversation.

		M.
