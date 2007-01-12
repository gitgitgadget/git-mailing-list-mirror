From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change to the repository's root directory if needed.
Date: Fri, 12 Jan 2007 15:17:38 -0800
Message-ID: <7vvejbq1gt.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<20070112191044.GA5113@midwinter.com>
	<7vtzywq703.fsf@assigned-by-dhcp.cox.net>
	<45A807A9.3090402@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 00:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VeY-00050j-7u
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXALXRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXALXRj
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:17:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43722 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161130AbXALXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:17:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112231738.IFVF29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 18:17:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id APGm1W00g1kojtg0000000; Fri, 12 Jan 2007 18:16:47 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45A807A9.3090402@midwinter.com> (Steven Grimm's message of "Fri,
	12 Jan 2007 14:11:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36727>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> Porcelains that define SUBDIRECTORY_OK but do not do cdup are
>> very valid, and they should not be cd'ed up automatically.
>>
>
> My patch doesn't do the cd if SUBDIRECTORY_OK is defined, for exactly
> that reason.

Ah, I misread the patch.  Sorry.

But the point is that the scripts that do not currently say
SUBDIRECTORY_OK have not even been audited to see if it makes
sense to always cd to the top.  Isn't your patch making as if
they are saying SUBDIRECTORY_OK=Yes and cd to the top upfront is
the right thing to do?
