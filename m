From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: Re: Unable to get "pretty" URL aliases working
Date: Tue, 12 Jan 2010 09:23:08 +1000
Organization: The University of Queensland
Message-ID: <4B4BB2DC.4090203@uq.edu.au>
References: <4B4ABDB5.9000203@uq.edu.au> <7v7hrpvzqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 00:23:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUTbS-0007Nf-H8
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 00:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab0AKXXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131Ab0AKXXO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 18:23:14 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:45077 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0AKXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 18:23:14 -0500
Received: from smtp4.uq.edu.au (smtp4.uq.edu.au [130.102.128.19])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0BNN8to024304;
	Tue, 12 Jan 2010 09:23:08 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp4.uq.edu.au (8.13.8/8.13.8) with ESMTP id o0BNN88Y031039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 12 Jan 2010 09:23:08 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
In-Reply-To: <7v7hrpvzqa.fsf@alter.siamese.dyndns.org>
X-UQ-FilterTime: 1263252189
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136680>

Hi all,

Thanks for the replies!

> In any case, "attempting to learn Git" doesn't mix well with use of
> "insteadOf" to me.  If you know /path/to/repos/project.git is what you
> want to access, any "attempting to learn Git" person would do more
> straight-forward "git clone ssh://myserver/path/to/repos/project.git", or
> "git clone myserver:/path/to/repos/project.git" which is even better (it
> is shorter to type and is a more natural form to spell ssh transport).

Jumping in the deep end is a valid method of learning :-)  Does that 
mean anyone using my repositories really needs to know exactly where on 
the server I choose to keep them?  Something like "git clone 
myserver:/mnt/raid/nightly-backedup/public/repositories/git/project.git" 
isn't particularly friendly.  (It's something that bugs me with NFS as 
well.)  What happens if I want to move the repositories to another area 
on the server?  Do all users have to update their local copies with a 
new origin address?

Is there any hacky way that this could be made to work?  I guess I could 
symlink my repository directory to /git, then myserver:/git/project.git 
might work.

What actually happens when you use the ssh:// style connection? 
git-daemon has a --base-path option which solves this issue for git:// 
URLs, so do ssh:// URLs not use the git protocol at all?  What is 
git+ssh://?  Does that SSH to the machine and then connect to git-daemon 
via localhost?  Because that would presumably make use of --base-path.

Thanks again,
Adam.
