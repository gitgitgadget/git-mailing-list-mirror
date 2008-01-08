From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added initialize and update support for submodule in git clone
Date: Mon, 07 Jan 2008 22:19:26 -0800
Message-ID: <7vr6gsx2j5.fsf@gitster.siamese.dyndns.org>
References: <7bfdc29a0801071922h3656a576wbd87e84bfa663d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC7om-00029B-HU
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 07:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYAHGTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 01:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYAHGTk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 01:19:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYAHGTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 01:19:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A579BBE8F;
	Tue,  8 Jan 2008 01:19:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C5C23BE8E;
	Tue,  8 Jan 2008 01:19:34 -0500 (EST)
In-Reply-To: <7bfdc29a0801071922h3656a576wbd87e84bfa663d5a@mail.gmail.com>
	(Imran M. Yousuf's message of "Tue, 8 Jan 2008 09:22:18 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69841>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> This patch adds support for initializing and updating submodules when
> a repo is cloned. The advantage it adds is, the user actually does not
> have to know whether it has a module or not and if it does to what
> depth and path. For this I added a option -w or --with-submodule for
> initializing and updating during clone stage.

For everything else, I strongly agree [*1*] that the notion that
all subprojects are populated is a bug.  I am not convinced the
all-or-nothing approach you implemented in "git clone" is useful
outside small toy projects where all of your users are almost
always interested in everything (which inevitably invites a very
valid question: why use submodule at all then?), but in the very
narrow special case of "clone", all-or-nothing is the best you
can do without giving additional hints somewhere in-tree
(perhaps enhanced .gitmodules entries), and it certainly is
better than "you do not have any choice --- you only get the
toplevel".

> Following is the diff with git-clone 1.5.3.7; I also attached the diff
> and modified file in the attachment.

The same comment as diff plus attachment applies to this patch
as the other message.  Also please do not base new development
on 4-digit maintenance releases, which are meant to contain only
bugfixes and no new features.  A patch like this, primarily for
discussion and not for immediate inclusion, is Ok, but it is
better to get into the habit of producing applicable patches
earlier rather than later.

I'll step aside and let others discuss code and design of the
patch.

[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/44106/focus=44308
