From: Junio C Hamano <gitster@pobox.com>
Subject: Re: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 11:31:36 -0700
Message-ID: <7vwsufap9z.fsf@gitster.siamese.dyndns.org>
References: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
	<Pine.LNX.4.64.0709241400410.28395@racer.site>
	<7v6420au43.fsf@gitster.siamese.dyndns.org>
	<e1dab3980709241009q71f9a40r1f8b551b417f7475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:31:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZsim-0002WU-1z
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 20:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686AbXIXSbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 14:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758381AbXIXSbo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 14:31:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756628AbXIXSbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 14:31:44 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FC65139364;
	Mon, 24 Sep 2007 14:31:59 -0400 (EDT)
In-Reply-To: <e1dab3980709241009q71f9a40r1f8b551b417f7475@mail.gmail.com>
	(David Tweed's message of "Mon, 24 Sep 2007 18:09:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59068>

"David Tweed" <david.tweed@gmail.com> writes:

> ... I'm just asking if there's a way to say
> "the `working dir' associated with this git dir" explicitly (in the same
> way I can use `HEAD' to refer to the topmost commit on the
> current branch) when you're not somewhere within the 'working dir'.

Not for "git diff <one-tree>" which is a way to diff the _part_
of work tree you are _currently in_ with the given tree, nor for
"git diff" which is to do the same with the index.  With these
commands (and others that error out when you run without GIT_DIR
outside the work tree), you are really expected to be _in_ the
subdirectory you are interested in.

GIT_WORK_TREE is somewhat related but is a different issue, by
the way.  It is to let you say where the top level of the work
tree is.  It does not change the fact that the way for you to
express which subdirectory in the work tree you are interested
in to work tree commands is by your $PWD relative to the top of
the work tree.
