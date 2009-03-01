From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Changing the defaults for send-email / suppress-cc ?
Date: Sat, 28 Feb 2009 16:21:54 -0800
Message-ID: <7vsklycct9.fsf@gitster.siamese.dyndns.org>
References: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 01:23:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdZT0-0004SU-JK
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 01:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZCAAWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 19:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbZCAAWF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 19:22:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZCAAWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 19:22:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EB40B296E;
	Sat, 28 Feb 2009 19:21:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3E089296C; Sat,
 28 Feb 2009 19:21:56 -0500 (EST)
In-Reply-To: <7d1d9c250902281129t1ea0d9d0k796d97bdd0af046d@mail.gmail.com>
 (Paul Gortmaker's message of "Sat, 28 Feb 2009 14:29:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA71B0AC-05F6-11DE-88F9-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111804>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> In light of this, I've simply advised new users to run something like:
>
> git config --global sendemail.suppresscc all
>
> ...just so that they won't accidentally do what I've described in the above.

> Apologies if this has been discussed before; I took a quick scan of my
> archive and didn't see any discussions on it.

I think I've seen discussions in the distant past but not very recently.
IIRC some people had exactly the same reaction as you did, and were loud,
while others were happy with the default, but weren't as loud.

But loudness depends on how annoyed they are, and unhappy people are
louder than others, so we cannot judge much from the loudness alone.

> With the recent thread
> about warning people of non-back compatible changes that will appear
> post 1.6.2 -- I thought perhaps this was a good time to
> mention/consider it.

Unless you are a single project person, or have groups of hosts that share
the home directory that is dedicated for working only on a single project,
using $HOME/.gitconfig for this is a bad advice to give in general; as I
think this really depends on what you are working on.

I do have "sendemail.suppressfrom" and "sendemail.signedoffcc = false" in
my repository configuration, but not in global configuration.

My point is that the default does not suit *me* at least.  But it may or
may not match what you want as a default.  I suspect many people are in
the same boat as I am.

> I'm not sure what the right thing to do here is -- I suspect if you made
> suppress-cc=all the default, then there would be more experienced users
> that would complain about having to explicitly add a suppress-cc=self to
> get the old behaviour?  Would that be acceptable?

No matter what different default you choose, there will be people who
complain about it as long as it is not exactly the default they want.

The only thing I could think of offhand that you could do safely to remedy
the situation is to make the command fail until you explicitly set your
default via the configuration, but even then, it is not entirely safe.

You will hear from angry people who use their own wrapper script to "git
send-email" that gives all necessary options from the command line and now
they are forced to add configuration to their repository, even though the
config is never used because their script overrides it from the command
line.

So, I dunno.
