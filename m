From: Christof =?ISO-8859-1?Q?Kr=FCger?= <mail@christof-krueger.de>
Subject: Re: git push in a git-init without --bare option?
Date: Mon, 27 Jun 2011 00:30:17 +0200
Message-ID: <1309127417.11860.142.camel@oxylap>
References: <201106261142.28142.psdc1978@gmail.com>
	 <vpqliwoa24m.fsf@bauges.imag.fr>  <201106262221.33294.psdc1978@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Pedro Sa Costa <psdc1978@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 00:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qaxsb-0001Uw-9f
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 00:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1FZWav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 18:30:51 -0400
Received: from vserver.localhost.li ([85.214.46.152]:50812 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab1FZWaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 18:30:24 -0400
X-Greylist: delayed 30172 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jun 2011 18:30:24 EDT
Received: from p5794cbe3.dip.t-dialin.net ([87.148.203.227]:38942 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mail@christof-krueger.de>)
	id 1QaxqN-0007jD-NR; Mon, 27 Jun 2011 00:30:20 +0200
In-Reply-To: <201106262221.33294.psdc1978@gmail.com>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176337>

On So, 2011-06-26 at 22:21 +0100, Pedro Sa Costa wrote:
> So this means that eveytime that I want a repository to be shared by
> several 
> persons, the repository must always be bare?

Short answer: no.

Long answer: Not necessarily, it depends on your workflow.

You could have a central "official" repository on a server that is
accessible by all members of your team. This is how centralized
version-control systems like Subversion work. You can imitate this with
git, but with git it's just convention, not a technical necessity. This
central repository would then be bare, as nobody will work on it
directly. If connectivity between developers is an issue (e.g. because
of firewalls or NAT), this might be the preferred model in some cases.
You can also use a service like github.com for example.

But you could also use it the distributed way. Then you should
understand and respect the asymmetry between push and pull. Every
developer on a team can have a local (non-bare) repository he works on.
As it is his private repository, all you can say is "hey buddy, I've got
a shiny new feature ready. Pull branch 'foobar' from my private
repository". He can then decide to pull and merge it with his code if he
wishes.

The above doesn't work if you'd allowed everyone to push around stuff to
other developers without their consent. You would lose control over your
own private repository and your working-copy would never be up-to-date
with what is the HEAD of your repo.

Of course, you can have a topology that is far more complex than what I
outlined above, combining bare and non-bare repositories at once and
having multiple repositories per developer, but I hope that the basic
idea became clear.

Regards,
  Chris
