From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Thu, 18 Dec 2008 22:35:48 -0800
Message-ID: <7vljucd64b.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812182129.01021.bss@iguanasuicide.net>
 <76718490812181955u5f56180en47b3a8268c3538bb@mail.gmail.com>
 <200812182354.16269.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jay Soffian" <jaysoffian@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 07:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDYzI-0002Ys-5D
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 07:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYLSGgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 01:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYLSGgA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 01:36:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbYLSGf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 01:35:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96F3388B95;
	Fri, 19 Dec 2008 01:35:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33FE188B92; Fri,
 19 Dec 2008 01:35:50 -0500 (EST)
In-Reply-To: <200812182354.16269.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Thu, 18 Dec 2008 23:54:12 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B2E40DE-CD97-11DD-8A02-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103549>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> In addition, I think a one-time-per-user warning would be nice, but I'm not 
> sure the best way to implement that.  My initial thoughts would be reading a 
> boolean config option, if unset/true issuing the warning and then if unset 
> set it to false.  However, that seems a bit... unclean and I fear there might 
> be a policy against writing ~/.gitconfig configuration options from a 
> subcommand other than 'git config'.  Any suggestions on the implementation?

As an end user, I find one-time-per-user warning more frustrating than it
is worth.  I may see the warning issued for the first time of my using
certain feature, and because I am so novice to the program suite that I do
not fully understand what the warning is trying to say when I see it.
Thanks to the "one-time-per-user"-ness, that is the only chance for me to
see the message --- which often means that I won't see the warning before
the gravity of it has any chance to really sink in my mind.

"You can set i-know-what-i-am-doing in your ~/.xyzzyconfig file to squelch
this message" is slightly better, as (1) I can control when I stop seeing
it, and (2) because setting that in my config is done by me, as opposed to
the tool doing behind my back, it is much more likely for me to recall how
to get the warning back when I choose to see it again.

The above discussion is "in general".  In this particular case, I am not
convinced if the warning itself is worth it, though.
