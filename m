From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git commit workflow question
Date: Sat, 15 Sep 2007 13:31:37 +0200
Message-ID: <BCFC81AB-0EDD-4C3C-B7D4-DEC60E2565C3@wincent.com>
References: <20070914103348.GA22621@bulgaria> <20070914181417.GU3099@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Swetland <swetland@google.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 13:31:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWVsO-0003Vg-N0
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 13:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXIOLbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 07:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXIOLbs
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 07:31:48 -0400
Received: from wincent.com ([72.3.236.74]:37973 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbXIOLbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 07:31:47 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8FBVfKD029068;
	Sat, 15 Sep 2007 06:31:42 -0500
In-Reply-To: <20070914181417.GU3099@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58237>

El 14/9/2007, a las 20:14, Shawn O. Pearce escribi=F3:

> I'm not sure how the Git community would react to being able to edit
> the list of files being committed from within the commit message
> buffer.  I think most Git users run at least `git diff --cached`
> before they commit to make sure they are happy with the difference.
> I know a lot of users who do that.

Yes, I generally check what's in the index before going ahead with a =20
commit; in fact I have the following alias in my .bash_profile so =20
that I can just type "staged" to see what'll be in the commit, along =20
with an "unstaged" alias for the opposite:

alias staged=3D'git diff --cached'

Having said that, it would be very useful to be able to edit the list =20
within the commit message buffer for those occasions where you =20
realise that stuff you have staged in the index really should be two =20
separate commits. It would enable this very simple workflow:

   1. review changes, realize that some of the changes belong in a =20
separate commit
   2. commit, omitting the unwanted changes
   3. commit again, this time with the remainder of the changes

Without the ability to edit the list within the commit message buffer =20
your workflow becomes a bit more cumbersome:

   1. review changes, realize that some of the changes belong in a =20
separate commit
   2a. explicitly pass files to commit on the commandline (cumbersome =20
if number of files is large); or:
   2b. use git-commit --interactive (again can be relatively =20
cumbersome); or:
   2c. explicitly unstage unwanted files, commit, then restage them =20
and commit

So, yes, the proposed functionality isn't necessary by any means, but =20
it would make some nice usability sugar. I know that in the past my =20
experience with other SCMs that can do this has made me mistakenly =20
believe that Git does too.

Cheers,
Wincent
