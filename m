From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used
 subcommands
Date: Thu, 05 Jun 2008 11:13:12 -0700
Message-ID: <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
 <20080605081911.GA5946@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Jyg-0006FZ-7P
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbYFESNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYFESN3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:13:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbYFESN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:13:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BB38A4DCA;
	Thu,  5 Jun 2008 14:13:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D94284DC7; Thu,  5 Jun 2008 14:13:20 -0400 (EDT)
In-Reply-To: <20080605081911.GA5946@mithlond.arda.local> (Teemu Likonen's
 message of "Thu, 5 Jun 2008 11:19:11 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 186F60E4-332B-11DD-9EAF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83949>

Teemu Likonen <tlikonen@iki.fi> writes:

>   $ git
>   usage: [...]
>
>   The most commonly used git commands are:
>   [There's no "help" command in the list.]
>
> I think it belongs there,...

While I do agree that a word 'help' should appear in the above output
somewhere, it is a horrible idea to place it in "list of common commands"
for two reasons.

 (1) nobody keeps typing "git help".  The reason we may want to mention
     'help' in this output is not because it is common;

 (2) 'help' _is_ different from other commands.  It is something one may
     want to know the presense of when one is still lost after seeing the
     above quoted output, especially when one is starting to learn.  It
     makes it more difficult to spot it if you bury it as one of the
     commands in a list.

It is reasonable to mention 'help' somewhere in the output, but if we are
going to do this, we should make it stand out.  Perhaps like this.

-- >8 --
$ git
usage: git [--version] ...

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find the change that introduced a bug by binary search
   branch     List, create, or delete branches
   ...
   show       Show various types of objects
   status     Show the working tree status
   tag        Create, list, delete or verify a tag object signed with GPG

See 'man git' and 'git help' for more information.
-- 8< --
