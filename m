From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I set the committer with cherry-pick? (or is there a
 better way to get changes from someone?)
Date: Sat, 05 Apr 2008 17:05:11 -0700
Message-ID: <7vhcefvoeg.fsf@gitster.siamese.dyndns.org>
References: <810a540e0804051642r79dc10a7h2a231561062b13ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Maddox" <pergesu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 02:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiIOw-00005u-4e
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 02:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbYDFAFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbYDFAFc
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 20:05:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYDFAFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 20:05:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 459EB88BF;
	Sat,  5 Apr 2008 20:05:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 93E8888BE; Sat,  5 Apr 2008 20:05:26 -0400 (EDT)
In-Reply-To: <810a540e0804051642r79dc10a7h2a231561062b13ea@mail.gmail.com>
 (Pat Maddox's message of "Sat, 5 Apr 2008 16:42:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78870>

"Pat Maddox" <pergesu@gmail.com> writes:

> At this point the commits are in the repo, but they only have author
> information.  I'd like to specify that I'm the one who committed this
> change now.  How can I do that?

You've already done that.  They are not what you _wrote_ so your name
won't be on "Author:" lines, but you made into commits in the final
history, and your name would appear on "Committer:" lines.

Try "log --pretty=fuller".

> And finally, is this a good way to incorporate changes from other
> devs?  Is there a better way?

A _better way_, especially because you are already pulling from them,
would be just "pull", without having to cherry-pick to clean-up the
history.

The reason you are being forced to cherry-pick is probably _their_
histories you pulled are suboptimal and full of garbage commit, containing
irrelevant changes you do not want to include in the mainline you
maintain.  Have _THEM_ clean their act and prepare clean history that
consists only of relevant commits.  Shift as much burden as possible to
the contributors; otherwise the central integrator will become the
bottleneck in the process.
