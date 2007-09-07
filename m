From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 14:44:37 -0700
Message-ID: <7vhcm62lru.fsf@gitster.siamese.dyndns.org>
References: <1189120800.6203.23.camel@beauty>
	<7v642m436q.fsf@gitster.siamese.dyndns.org>
	<1189200421.12525.8.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Josh England <jjengla@comcast.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITldB-00014L-CN
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbXIGVoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758618AbXIGVoo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:44:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758615AbXIGVoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:44:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 79B1712E759;
	Fri,  7 Sep 2007 17:45:02 -0400 (EDT)
In-Reply-To: <1189200421.12525.8.camel@beauty> (Josh England's message of
	"Fri, 07 Sep 2007 15:27:01 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58080>

Josh England <jjengla@comcast.net> writes:

> ... there doesn't seem to be a
> good way to access the top of the working tree from within the GIT_DIR.
> Since I now know that post-receive has a CWD in .git, I could just use
> `pwd`/../ , but I was hoping for a better (read: consistent between
> hooks) solution.

I do not think it is a bad thing for _your_ script to have the
knowledge that in _your_ repositories everywhere, the top of the
work tree is $GIT_DIR/.. and there is no repository that lacks a
work tree.  Obviously that would not work for people with bare
repositories, but they would not be using _your_ script in their
bare repositories, so that is Ok.

You can also configure core.worktree in $GIT_DIR/config and use
that from the hook script, I presume, although I haven't done it
(and do not see a need to do so) myself yet.
