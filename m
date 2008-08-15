From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to
 bash-completion
Date: Fri, 15 Aug 2008 11:50:51 -0700
Message-ID: <7vvdy29kok.fsf@gitster.siamese.dyndns.org>
References: <1218816948-7864-1-git-send-email-marcus@griep.us>
 <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org> <48A5CC07.2040500@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU4PD-0004Sn-CT
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901AbYHOSvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbYHOSvD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:51:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYHOSvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:51:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3FB95A3FC;
	Fri, 15 Aug 2008 14:50:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7FE955A3FB; Fri, 15 Aug 2008 14:50:55 -0400 (EDT)
In-Reply-To: <48A5CC07.2040500@griep.us> (Marcus Griep's message of "Fri, 15
 Aug 2008 14:33:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A14B590-6AFB-11DD-979F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92508>

Marcus Griep <marcus@griep.us> writes:

> Junio C Hamano wrote:
>> Marcus Griep <marcus@griep.us> writes:
>> 
>>> Git allows access to the gitattributes man page via `git help attributes`,
>>> but this is not discoverable via the bash-completion mechanism.  This
>>> patch adds all current non-command man pages to the completion candidate
>>> list.
>> 
>> I really do not think this belongs to completion.  "git help topics"
>> perhaps.
>
> I'm not sure I grok what you mean here...  These items are already accessible
> from `git help`, they just aren't discoverable...

That is exactly what I mean.  I do not think bloating shell completion to
enumerate what help topics there are when the user hits "git help <TAB>"
is a good idea to begin with.  It is a maintenance nightmere for one
thing, and it does not help non-bash users.

	$ git help
	$ git help --all

are existing ways for you to get list of "command topics" that you can ask
the help system about, but I do not see a way to ask "git-help, please
tell me what topics that are not git-commands can I ask you about?", hence
my suggestion to add "git help topics".

And if you based "git help <TAB>" completion on the output from such help
subcommand, you would not have to maintain the list of topics yourself in
the completion script, and I would not mind such a patch too much.
