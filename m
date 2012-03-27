From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 08:14:21 +0200
Message-ID: <4F715ABD.4080102@viscovery.net>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPgG-0004FL-6D
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab2C0GOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:14:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26945 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386Ab2C0GOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:14:23 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SCPfh-0005pv-MU; Tue, 27 Mar 2012 08:14:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 686621660F;
	Tue, 27 Mar 2012 08:14:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194016>

Am 3/27/2012 1:48, schrieb James Pickens:
> I'm not sure if this should be considered a bug or not, but I've noticed that
> when my $PATH contains an inaccessible directory, Git fails to execute aliases.
> ...
> I lean towards calling it a bug, since my shell doesn't seem to care if there
> are inaccessible directories in my $PATH.  It just ignores them, and I think Git
> ought to do the same.

Git is not a shell. And I'm sure it is not the only program that has this
issue. "Don't do it, then."

Git's implementation depends on the system's execvp behavior. As it
stands, current implementations of execvp path lookup and of popular
shells' path lookup differ in this respect. Bad luck. Don't check the
sanity of your PATH by testing how your shell looks up executables.

-- Hannes
