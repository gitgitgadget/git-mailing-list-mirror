From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 19:42:40 +0400
Message-ID: <20131127194240.2abaff5575961b3d73e1970f@domain007.com>
References: <86d2llc1rs.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Forman <petef4+usenet@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 16:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlhGL-0002C9-I2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 16:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3K0Pmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 10:42:45 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:57588 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3K0Pmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 10:42:45 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rARFgdcx031378;
	Wed, 27 Nov 2013 19:42:40 +0400
In-Reply-To: <86d2llc1rs.fsf@gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238444>

On Wed, 27 Nov 2013 15:17:27 +0000
Pete Forman <petef4+usenet@gmail.com> wrote:

> I am looking for a way of detecting up front whether a git pull or git
> merge would fail. The sort of script I want to perform is to update a
> server.
> 
>     git fetch
>     git okay
>     stop server
>     backup data
>     git merge
>     start server
> 
> Here git okay is a place holder for the command I am asking for.
> 
> If a file has been changed outside of a commit then git pull fails
> with the following error.
> 
> error: Your local changes to '...' would be overwritten by merge.
> Aborting. Please, commit your changes or stash them before you can
> merge.

What's wrong with "git okay" being

if git merge whatever 2>/dev/null; then
  ... OK path
else
  ... "merge failed" path
fi

?
