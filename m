From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to "git add ." when some files are not accessible
	(permission denied)?
Date: Sun, 2 Mar 2008 16:41:54 +0100
Message-ID: <20080302154154.GC2973@steel.home>
References: <47C95E34.1050306@dirk.my1.cc>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:42:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqKi-0002Ec-Pt
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYCBPl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 10:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYCBPl5
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:41:57 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:26698 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYCBPl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:41:57 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (mrclete mo35) (RZmta 16.8)
	with ESMTP id a047eek22FetVz ; Sun, 2 Mar 2008 16:41:55 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 22FC1277BD;
	Sun,  2 Mar 2008 16:41:55 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A048D56D24; Sun,  2 Mar 2008 16:41:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47C95E34.1050306@dirk.my1.cc>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75788>

Dirk S=FCsserott, Sat, Mar 01, 2008 14:46:28 +0100:
> Or, more generally spoken: can I tell "git add" to add only those fil=
es it=20
> can handle and ignore the rest? The "-f" switch doesn't work and some
> exclude lists on a per file basis are not applicable for my purpose a=
s I
> don't know the files in advance.

Well, "-f" means something else (include the ignored files). It is
unfortunate, because (I think) your case fits better its traditional
meaning...

You can try the following patches, which add "--ignore-errors" to
git-add. Maybe it will be enough... It is generally considered
not safe to ignore errors.

