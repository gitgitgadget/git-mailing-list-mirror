From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Can I enforce required approval on some files
Date: Tue, 20 Jul 2010 21:45:01 +0100
Message-ID: <80pqyhc27m.fsf@tiny.isode.net>
References: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dominik Gront <dgront@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 22:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJim-0001RK-9i
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690Ab0GTUq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 16:46:56 -0400
Received: from rufus.isode.com ([62.3.217.251]:60300 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597Ab0GTUpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 16:45:21 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <TEYK3QADGyxi@rufus.isode.com>; Tue, 20 Jul 2010 21:45:17 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 20 Jul 2010 21:45:01 +0100
X-Hashcash: 1:20:100720:git@vger.kernel.org::zXKKknWHLzI3N1jL:0000000000000000000000000000000000000000000lae
X-Hashcash: 1:20:100720:dgront@gmail.com::Byvpk92nM+A0REqj:01Vu7
In-Reply-To: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
	(Dominik Gront's message of "Tue, 20 Jul 2010 13:22:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151365>

Dominik Gront <dgront@gmail.com> writes:

> I have been a happy SVN user for quite a long time, but now I miss
> some functionality in Subversion. I wonder if it could be done in git.
> If so, I convert to git right away :-)
>
> There are some files in our repository that all their modification
> need to be approved by a project leader.

Either have the repository owned by someone who'll do whatever checking
you want (which seems to be common at least amongst the public projects)
or use hooks in a shared repository.  Specifically the update hook.

The hook can do whatever checking you deem appropriate.  At work we have
it check the commit message for Signed-off-by names (in our context it
really means Reviewed-by; we use sob because that's more convenient to
add).  The hook could look at which files are changed or whatever else
you wanted.  (Notice it gets called to update a ref, and that may
involve more than one commit, so be sure to check all the relevant
commits.)

[...]
