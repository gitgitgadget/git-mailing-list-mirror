From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 12:47:32 -0400
Message-ID: <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com> <46DAE025.900@trolltech.com> <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 18:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsbi-0007ql-P2
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbXIBQr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXIBQr1
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:47:27 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48745 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964950AbXIBQr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:47:26 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2C1371FFC00D;
	Sun,  2 Sep 2007 16:47:25 +0000 (UTC)
In-Reply-To: <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57365>


On Sep 2, 2007, at 12:33 PM, Reece Dunn wrote:

> You pull a repository that contains executable scripts that are
> required to work in order to build the system. You then make some
> modifications to the local repository and run the 'git add .' command.
> Since this patch is reporting executable bits differently, the mode
> change is stored as well as the local modifications. Now the changes
> are pushed upstream (along with the file mode changes).
>
> Someone running a Linux machine, pulls your changes. When those files
> are checked out, the executable state of those scripts has now
> changed, preventing the Linux user from running those scripts. _That_
> is what I meant. Or am I misunderstanding how git works in this case?

This is what "git config core.fileMode false" is for.  See git- 
config's man page for information (or Documentation/config.txt).

We already have a way to tell git that the "executable bit" is  
worthless, and any Windows port should use it.

~~ B
