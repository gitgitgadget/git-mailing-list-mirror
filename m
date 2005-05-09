From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 19:08:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org>
References: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 01:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVHFe-0003pw-Rh
	for gcvg-git@gmane.org; Tue, 10 May 2005 01:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVEIXIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 19:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEIXIp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 19:08:45 -0400
Received: from iabervon.org ([66.92.72.58]:11783 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261354AbVEIXIn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 19:08:43 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVHML-0003hm-00; Mon, 9 May 2005 19:08:21 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Junio C Hamano wrote:

> H. Peter Anvin mentioned that using SHA1_whatever as an
> environment variable name is not nice and we should instead use
> names starting with "GIT_" prefix to avoid conflicts.
> 
> Here is a patch, requesting for comments.
> 
>  - Renames the following environment variables:
> 
>     New name                Old Name
> 
>     GIT_AUTHOR_DATE         AUTHOR_DATE
>     GIT_AUTHOR_EMAIL        AUTHOR_EMAIL
>     GIT_AUTHOR_NAME         AUTHOR_NAME
>     GIT_COMMIT_AUTHOR_EMAIL COMMIT_AUTHOR_EMAIL
>     GIT_COMMIT_AUTHOR_NAME  COMMIT_AUTHOR_NAME
>     GIT_ALTERNATE_OBJECTS   SHA1_FILE_DIRECTORIES
>     GIT_OBJECTS             SHA1_FILE_DIRECTORY

While we're at it, it would be useful to have one for what is normally
".git", rather than just ".git/objects". That way the same variable would
be useful for finding other things in the .git directory, and I haven't
heard of any use of SHA1_FILE_DIRECTORY that didn't end in /objects
anyway, and would enable the brokenness in init-db (it creates ".git", and
then tries to create "<obj-dir>/00-ff").

	-Daniel
*This .sig left intentionally blank*

