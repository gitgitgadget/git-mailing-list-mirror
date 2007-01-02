From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to commit removed file?
Date: Tue, 02 Jan 2007 13:40:41 -0800
Message-ID: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
References: <20061231102444.GD26552@mellanox.co.il>
	<20070102201041.GB10451@mellanox.co.il>
	<Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jan 02 22:41:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rNb-0006TH-2x
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbXABVkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXABVko
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:40:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40301 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXABVkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:40:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102214043.FNHX9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 16:40:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6Mfv1W00J1kojtg0000000; Tue, 02 Jan 2007 16:39:56 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 2 Jan 2007 22:12:33 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35822>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 2 Jan 2007, Michael S. Tsirkin wrote:
>
>> > I'd like to remove a file and commit the removal while
>> > leaving out other changes in repository/index.
>> > 
>> > $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
>> > rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
>> > 
>> > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
>> > error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
>> > any file(s) known to git.
>> > Did you forget to 'git add'?
>> > 
>> > A similiar thing works with "git add".
>> 
>> Any ideas? Can this be done with git?
>
> Did you actually try the "--" thing I suggested in 
> http://article.gmane.org/gmane.comp.version-control.git/35699/?
>
> Besides, I just tested with current "next": 
>
> $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
> Created commit 89a5bb5ac16fb8be9b6e061284e191cafb3e4da2
>  1 files changed, 0 insertions(+), 22 deletions(-)
>  delete mode 100644 a234

The difference is Michael did "git rm" to explicitly tell git to
forget about that path, while you used the vanilla "/bin/rm".

Personally I never saw the point of having "git rm".  Maybe we
should remove it to prevent this confusion from happening.
