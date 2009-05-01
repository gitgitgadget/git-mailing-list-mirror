From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] user-manual: add global config section
Date: Fri, 01 May 2009 15:08:08 -0700
Message-ID: <7v3abowk6v.fsf@gitster.siamese.dyndns.org>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
 <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
 <94a0d4530905010137h772b53f1q8af0d30400a05043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M00u7-0005e5-2H
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 00:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbZEAWIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 18:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZEAWIP
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 18:08:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZEAWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 18:08:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C6FA13B43;
	Fri,  1 May 2009 18:08:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A7BB713B42; Fri, 
 1 May 2009 18:08:10 -0400 (EDT)
In-Reply-To: <94a0d4530905010137h772b53f1q8af0d30400a05043@mail.gmail.com>
 (Felipe Contreras's message of "Fri, 1 May 2009 11:37:37 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 908CEE3C-369C-11DE-B5FD-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118101>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> For that "introductory" purpose, however, I'd suggest showing how they
>> appear in the actual .git/config file first in the editor and then show a
>> way to use the "git config" command as an alternative.
>
> I disagree. Opening ~/.gitconfig will just open an empty file for the
> new users, afterwards they'll just scratch their heads wondering, now
> what?

Why on earth would anybody start introducing ~/.gitconfig before talking
about .git/config?

A good sequence would be:

	To start working on a tarball extract (or your uncontrolled
	project) with git, first do:

	$ git init

	Whoa.  That was fast.  Did it do anything?  Yes, it created a
	subdirectory .git that is going to store your history and other
	control information.  Right now you do not have any history (nor
	the current state for that matter) recorded in it, but it already
	has some control information.  One of the more important one is
	the per-repository configuration file.  Take a look:

	$ git config --edit

	It would show something like:

	[core]
        	...

	... explain a bit on how simple the configuration syntax is ...

        While you have it open, it would be a good idea to add this to
        introduce yourself to git:

	[user]
        	email = clueful@git.us.er
                name = My Self

	If you work in multiple projects under the same identity, you
	do not have to add user.email and user.name to each and every
	repository this way.  Instead, you can do that to your per-user
	configuration file, like:

	$ git config --global --edit

	but if you work in different projects using different mail address
	(e.g. work vs hobby projects), you would want to have this
	information per-repository.
