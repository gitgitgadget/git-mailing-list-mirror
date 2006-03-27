From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reintroduce svn pools to solve the memory leak.
Date: Mon, 27 Mar 2006 10:16:58 -0800
Message-ID: <7vhd5joiqt.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160603270326i3a8ddcfau61ca84cdac036ff9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 27 20:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNwH4-00013c-Oa
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 20:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWC0SRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Mar 2006 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWC0SRD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 13:17:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10747 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbWC0SRB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 13:17:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060327181659.GQWB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 13:16:59 -0500
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8aa486160603270326i3a8ddcfau61ca84cdac036ff9@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Mon, 27 Mar 2006 13:26:01
 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18086>

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 3/24/06, Santi B=E9jar <sbejar@gmail.com> wrote:
>> Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
>>
>> diff-tree 4802426... (from 525c0d7...)
>> Author: Karl  Hasselstr=F6m <kha@treskal.com>
>> Date:   Sun Feb 26 06:11:27 2006 +0100
>>
>>     svnimport: Convert executable flag
>>
>>     Convert the svn:executable property to file mode 755 when conver=
ting
>>     an SVN repository to GIT.
>>
>>     Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>>     Signed-off-by: Junio C Hamano <junkio@cox.net>
>>
>> :100755 100755 ee2940f... 6603b96... M  git-svnimport.perl
>
> And this patch fixes my problems.

Jan-Benedict, thanks for pinpointing the regression, and Santi,
thanks for the patch.

I should have looked a bit more closely when applying the patch
-- it is clear that the patch is doing more than what its log
says.  My fault.

Karl, were there other reasons you needed to disable the pool
here (maybe to work around a problem with incompatible version
of SVN module)?  I see some other uses of SVN::Pool still there
in the code, so I am assuming this was a simple typo, but just
in case...
