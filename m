From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 14:09:29 -0400
Message-ID: <87lk3c4ali.fsf@jeremyms.com>
References: <47F15094.5050808@et.gatech.edu>
	<8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	<32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	<49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	<32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	<7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	<6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
	<7v63uqz265.fsf@gitster.siamese.dyndns.org>
	<1207859579.13123.306.camel@work.sfbay.sun.com>
	<7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
	<46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
	<7vmyo0owep.fsf@gitster.siamese.dyndns.org>
	<1207970038.10408.8.camel@ginkgo>
	<7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	<1208202740.25663.69.camel@work.sfbay.sun.com>
	<7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	<1208317795.26863.91.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:42:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmYZ7-0001JL-M3
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 20:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763713AbYDQSJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763494AbYDQSJr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 14:09:47 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:34729 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763221AbYDQSJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 14:09:45 -0400
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JmYY6-0005LW-Pf; Thu, 17 Apr 2008 14:09:30 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <1208317795.26863.91.camel@goose.sun.com> (Roman V. Shaposhnik's
	message of "Tue, 15 Apr 2008 20:49:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79808>

"Roman V. Shaposhnik" <rvs@sun.com> writes:

[snip]

> I'm sorry, but I don't buy this argument. If you have a malicious user
> gaining access to the repository all bets are off. To single out 
> in-tree .gitconfig as the only place which could be hacked seems to
> be a bit shortsighted and unfair. Any "executable" portion of your
> project that rarely gets eyeballed (such as Makefile infrastrucutre)
> could be used. In fact, under your scenario in-tree .gitconfig is
> likely to be the least of your worries. 

> And here's one more thing: in-tree .gitconfig and in-tree 
> update-my-git-settings.sh are absolutely identical as far
> as their security ramifications are concerned. If you really paranoid
> you have to eyeball either of them.

There is a huge difference: if you allow in-tree .gitconfig by default,
then git clone <some-repository> becomes an unsafe operation.  I can't
even inspect some arbitrary repository to _see_ if I like the code and
think it is safe very easily, since I'd normally do that by cloning the
repository.

Obviously actually executing untrusted code is unsafe regardless of
whether you type "git clone" or "make" to do it, but not everyone
intends to type "make" after checking out an unknown repository, and the
user is explicitly invoking make with the knowledge that it is running
whatever code is in the repository.  Similarly, if the user explicitly
calls some shell script in order to set things up, he is conscious that
he is performing a potentially unsafe operation.

As a silly analogy, it is currently perfectly safe to clone a repository
that has a text document containing instructions about committing
suicide, because there is the assumption that the instructions are not
automatically executed simply because they are on the user's hard drive.

[snip]

> Why? I'm really confused here. Unless I'm given a clear example of at
> least one setting that somehow becomes dangerous when stored inside
> in-tree .gitconfig, I really do consider such an enforcement to be
> as meaningful as enforcing that Git MUST manage source code and nothing
> else. You seemed to mention the trust issue. Well, why don't you trust
> the user to place whatever he wants in in-tree .gitconfig? And yes,
> we are talking about trustworthy users here and repositories that
> haven't been compromised.

Obviously any configuration option that specifies a shell command to run
is unsafe to specify in an in-tree .gitconfig.  As Junio noted,
smudge/clean commands are especially unsafe because they will be
executed even if the user only uses the clone command.

You actually seem to be the one assuming that a Git repository must
store source code (in particular source code that is then blindly
executed by anyone that clones the repository), as that is the only case
in which an in-tree .gitconfig can introduce no additional security
risk, since your security is then already completely dependent on
trusting the contents of the repository.

-- 
Jeremy Maitin-Shepard
