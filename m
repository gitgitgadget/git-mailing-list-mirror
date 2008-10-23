From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Tip: avoiding net overhead using git over sshfs
Date: Thu, 23 Oct 2008 11:00:25 +0200
Message-ID: <vpqprlru1na.fsf@bauges.imag.fr>
References: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Felipe Carvalho Oliveira" <felipekde@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 11:07:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KswA3-0000bx-Jf
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 11:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYJWJGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 05:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYJWJGB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 05:06:01 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:63957 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYJWJGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 05:06:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9N93dja029146;
	Thu, 23 Oct 2008 11:03:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ksw3N-0004hk-N5; Thu, 23 Oct 2008 11:00:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ksw3N-0006LA-Kq; Thu, 23 Oct 2008 11:00:25 +0200
In-Reply-To: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com> (Felipe Carvalho Oliveira's message of "Wed\, 22 Oct 2008 22\:26\:18 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 23 Oct 2008 11:03:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98948>

"Felipe Carvalho Oliveira" <felipekde@gmail.com> writes:

> Use git over sshfs is not so good, but is an option for people that
> don't have shell acess to the server/hosting like me.
>
> # mounting
> sshfs -o workaround=rename <user>@<host>:/home/<user>/  <mount_point>
> cd <the_directory_of_your_project>
>
> # we will move the .git directory to the local filesystem
> mv .git ~/.my_project_git
> # and create a symlink to the local .git
> ln -s ~/.my_project_git .git

I think you'd better work locally, and push to the sshfs directory
from time to time. Then, you'd both have working tree and .git locally
and fast, while keeping the safety of replicating to your ssh server.

-- 
Matthieu
