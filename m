From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default "tar" umask..
Date: Sat, 30 Dec 2006 11:27:32 -0800
Message-ID: <7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 30 20:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jrl-0000TG-4p
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 20:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWL3T1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 14:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWL3T1e
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 14:27:34 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48748 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030308AbWL3T1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 14:27:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061230192732.OQKD97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 14:27:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 57Sm1W00e1kojtg0000000; Sat, 30 Dec 2006 14:26:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 30 Dec 2006 10:45:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35628>

Linus Torvalds <torvalds@osdl.org> writes:

> We just had a posting on the kernel security list where a person was 
> upset that the 2.6.19.1 and .2 tar-files were apparently group and 
> world-writable.

I had an impression that this is only an issue when you untar as
root, and running 'tar xf' as root _is_ a more serious security
issue than whatever permission the tar archive itself records.

Having said that, I do not see much reason for anybody to want
to extract any material that is worth to be placed under version
control in a way that is world-writable, so I do not mind having
002 as the default, but I feel that group-writability should be
kept under control of the umask of end users who know what they
are doing.

Historically we used to have 022 as the default, and IIRC we
loosened it exactly because some people hated that we created
files and directories closed to group members.
