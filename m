From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Unexpected behaviour with git stash save --keep-index?
Date: Tue, 2 Sep 2008 03:28:04 +0200
Message-ID: <20080902012804.GB6739@neumann>
References: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaKhm-0003uJ-8n
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYIBB2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 21:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYIBB2G
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:28:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:50720 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYIBB2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:28:05 -0400
Received: from [127.0.1.1] (p5B13393C.dip0.t-ipconnect.de [91.19.57.60])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1KaKgd0yLj-0000qF; Tue, 02 Sep 2008 03:28:03 +0200
Content-Disposition: inline
In-Reply-To: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX19WcJtgONUwKYQDlaEcJhF5qxfbO80ijiAtYw4
 YwCCs/8LCm/+6kk8Ovs5vYsj09Jow6EgYTcQFtm2fHnca+pJyd
 i3UbRUsHAhJ2FYa2Y1NdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94636>

Hi,

On Tue, Sep 02, 2008 at 01:14:10AM +0200, Jonas Flod=E9n wrote:
> while I was using StGit for the first time and used git stash to spli=
t
> the changes into different patches I noticed that git stash save --=20
> keep-index
> will stash also the changes that are already in the index. This was =20
> unexpected
> atleast to me but maybe someone can explain why it's correct.
A plain 'git stash [save]' means "save all local modifications and
clear both the index and the working tree".

'git stash save --keep-index' means "save all local modifications and
remove all modifications from the working tree that are not in the
index".  This differs substantially from "save only those
modifications that are not in the index, and then remove them from the
working tree".

> Also maybe someone could someone recommend a way to split an unclean =
=20
> working dir
> into several patches/commits?
The workflow described at the end of stash's man page (under 'Testing
partial commits') works well for me.

(Heh, I have just looked that section up, and noticed that the
formatting is broken and some comments are missing from the man page.
I will send out a patch in a minute.)

Regards,
G=E1bor
