From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach how to discard changes in the working
 directory
Date: Sun, 07 Sep 2008 15:48:50 -0700
Message-ID: <7vtzcrk1wt.fsf@gitster.siamese.dyndns.org>
References: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Sep 08 00:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcT5D-0007ma-Kp
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYIGWtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbYIGWtA
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:49:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIGWs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:48:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9F3B5FD52;
	Sun,  7 Sep 2008 18:48:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0720E5FD51; Sun,  7 Sep 2008 18:48:52 -0400 (EDT)
In-Reply-To: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
 (Anders Melchiorsen's message of "Mon, 8 Sep 2008 00:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26ADA082-7D2F-11DD-86E9-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95186>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Using "git checkout" to undo local changes is a hint that is often
> given in #git. This patch (part 2) adds the hint into the status
> output. A bit of restructuring appears in the initial patch.
>
> This is merely an RFC, I am not sure whether I like it myself :-).

While I think the patch means well, I personally think that the output is
already too chatty with these "friendly hints" about add/rm/reset.  After
this series, will we be adding 'use "git checkout HEAD -- <path>" to go
back to the state of the latest commit', and then "if you want to stage
only part of the change, use "git add -i <path>"?  "To temporarily remove
the change use "git stash"?

I would agree that "hint is often given in #git" is an indication that
people do not know "git checkout" to check out the path from the index to
get rid of the change.  I further suspect that "I modified my file and git
status says 'Changed but not updated'; what should I do" may not be asked
often anymore, which might owe the hint we have in status output.  Even
then, I do not necessarily agree that the status output (yes, I am also
questioning the existing hints as well) is the best place to teach these
people.

The approach would lead to insanely long output that reproduces the user
manual, and we should draw the line somewhere.  As I said, I suspect that
what we say is already too chatty.
