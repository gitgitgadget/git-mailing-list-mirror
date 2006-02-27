From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Read author names and emails from a file
Date: Sun, 26 Feb 2006 21:51:12 -0800
Message-ID: <7vbqwt1h9r.fsf@assigned-by-dhcp.cox.net>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
	<20060226051131.24860.15804.stgit@backpacker.hemma.treskal.com>
	<440195D4.7080905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 06:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDbI1-0000LU-NS
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 06:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWB0FvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 00:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWB0FvS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 00:51:18 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9391 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751038AbWB0FvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 00:51:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227055122.TQSY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Feb 2006 00:51:22 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440195D4.7080905@op5.se> (Andreas Ericsson's message of "Sun, 26
	Feb 2006 12:49:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16827>

Andreas Ericsson <ae@op5.se> writes:

> Karl Hasselstr=F6m wrote:
>> Read a file with lines on the form
>>   username User's Full Name <email@addres.org>
>> and use "User's Full Name <email@addres.org>" as the GIT author and
>> committer for Subversion commits made by "username". If encountering=
 a
>> commit made by a user not in the list, abort.
>
> This is a good thing, but wouldn't it be better to use the same forma=
t
> as that of cvsimport's -A flag?

If both CVS and SVN have their own native format to express
things like this, and if the format they use are different, then
that is a valid reason for git-{cvs,svn}import to use different
file format.

But if that is not the case, I tend to agree that it might be
easier for users if we had just one format.  I do not think,
however, any single project is likely to have to deal with both
CVS and SVN upstream, importing into the same git repository, so
reusing the mapping file would not be an issue, but having to
learn how to write the mapping just once is a good thing.

I do not offhand recall if SVN has its own native format; if it
has, it may be better to use that, instead of matching what
git-cvsimport does, since I do not think of a reason why the
version with an equal sign is preferrable over the version with
a space.  If the version with '=3D' were the CVS native format
then that might be a reason to prefer it, but if I recall
correctly that is not the case. so...
