From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Fri, 06 Jun 2008 16:21:48 -0700
Message-ID: <7vzlpyqhdf.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050536380.21190@racer>
 <200806050358.m553wgK9013230@mi0.bluebottle.com>
 <200806062147.m56LlCOd030269@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lGi-00013d-Lr
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbYFFXV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbYFFXV4
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:21:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYFFXVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:21:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A27C523AC;
	Fri,  6 Jun 2008 19:21:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EB5B023AA; Fri,  6 Jun 2008 19:21:50 -0400 (EDT)
In-Reply-To: <200806062147.m56LlCOd030269@mi0.bluebottle.com>
 (nanako3@bluebottle.com's message of "Sat, 07 Jun 2008 06:46:33 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59D1D180-341F-11DD-AF57-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84140>

しらいしななこ  <nanako3@bluebottle.com> writes:

> But I started wondering (especially after read Junio's example) if you
> might have to stop and force edit the message even for commits you
> "pick", once you have a conflict.  The patch might not conflict, but
> with your logic shouldn't you be given a chance to amend messages, now
> it was discovered that the upstream did change that overlaps what you
> did?

[jc: again, linewrap X-<]

That may be true but at that point I would have to say that people should
always examine the resulting history anyway to see if they need to fix-up
mismerges (and mismerges do happen if the reordered patches have semantic
conflicts that do not appear as textual conflicts), and re-fix the
commits, perhaps using "rebase -i" on now linearlized history.  Forcing
every single patch to be committed by hand after a single conflict is
going a bit too far, I think.

Of course, you _can_ argue that forcing the patch that conflicted to be
committed by hand even when you merely asked to 'pick', not 'edit', is
going too far by the same logic, and I tend to agree with that.  The world
is not just black and white and that case certainly feels gray.
