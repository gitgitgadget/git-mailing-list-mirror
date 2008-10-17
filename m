From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 01:37:49 -0700
Message-ID: <7vwsg7mxb6.fsf@gitster.siamese.dyndns.org>
References: <7vy70of6t2.fsf@arte.twinsun.com>
 <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 10:39:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqkrq-00074p-5u
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYJQIiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 04:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYJQIiS
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 04:38:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYJQIiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 04:38:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A201870489;
	Fri, 17 Oct 2008 04:38:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75E4D70486; Fri, 17 Oct 2008 04:38:04 -0400 (EDT)
In-Reply-To: <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
 (Richard Hartmann's message of "Fri, 17 Oct 2008 09:21:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F060362C-9C26-11DD-8C76-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98459>

"Richard Hartmann" <richih.mailinglist@gmail.com> writes:

>>  (2) pre-commit hook is a last ditch effort to help ignorant
>>     users who have already done "git add" without thinking and
>>     lost the "unmerged" state.  It has to look at and guess at
>>     the contents for that.
>
> Ignoring the ad hominem attack, I would argue that the two

Eh, Sorry about that --- I did not mean "ignorant" in that sense.  Perhaps
replacing the word with "unfortunate" would sound nicer?

> To err is human, which is why rm -i exists. Else, you could
> just use alias rm='rm -rf'.
>
> Also, within certain boundaries, a tool should adapt to the
> user, not vice versa.

Don't you realize that is what the hook is doing already?  After making
such an error, the definitive information is lost, because the user told
the tool that the resolution is done and the file is ready to be
committed) by mistake.  Even then the hook is trying its best to help the
user.

Replace your "rm=rm -rf" sentence with "why undelete exists" and read it
again.  No, filesystem undelete does not always work (disk block could
have been recycled for other files), but it could help you when you did
remove a file you wanted to keep by mistake when it can.

As to pre-add hook, I am not enthused, but if somebody sends in a clean
patch, I wouldn't be opposed to it at least in principle.
