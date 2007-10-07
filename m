From: "Gerald (Jerry) Carter" <jerry@samba.org>
Subject: Re: Missing tags from git-clone, but not git-clone -l ?
Date: Sun, 07 Oct 2007 13:58:55 -0500
Message-ID: <47092C6F.7070108@samba.org>
References: <4709242F.7070004@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 20:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IebLL-0004iQ-2w
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 20:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbXJGS7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 14:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755731AbXJGS7A
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 14:59:00 -0400
Received: from mail.samba.org ([66.70.73.150]:54656 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbXJGS67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 14:58:59 -0400
Received: from kayak.plainjoe.org (68-184-60-223.dhcp.mtgm.al.charter.com [68.184.60.223])
	by lists.samba.org (Postfix) with ESMTP id E5A9D162C44
	for <git@vger.kernel.org>; Sun,  7 Oct 2007 18:58:58 +0000 (GMT)
Received: from silk.local (phzzbt.plainjoe.org [192.168.1.1])
	by kayak.plainjoe.org (Postfix) with ESMTP id 066AB1170BF
	for <git@vger.kernel.org>; Sun,  7 Oct 2007 13:58:58 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <4709242F.7070004@samba.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60210>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Gerald (Jerry) Carter wrote:

> I'm really a but stumped on this one.  I've got a set of tags
> (created by git-svnimport):
> 
>   $ git tag -l release-4*
>   release-4-0-0tp1
>   release-4-0-0tp2
>   release-4-0-0tp3
>   release-4-0-0tp4
> 
> but when I "git-clone samba-svnimport tags-test"", one tag
> is missing.
> 
>   $ git tag -l release-4*
>   release-4-0-0tp2
>   release-4-0-0tp3
>   release-4-0-0tp4
> 
> Running git-clone -l works as expected (i.e. the tp1 tag appears
> in the clone).

Sorry.  I did get confused.  And I now understand what happened.
git-clone works correctly.  What I did was "git-remote add svn
/.../path" followed by a "git-fetch svn".  Looks like that
one tag was not directly reachable in the history.  Running
"git-fetch -t svn" gave me the missing tags.

Sorry for the noise.




cheers, jerry
=====================================================================
Samba                                    ------- http://www.samba.org
Centeris                         -----------  http://www.centeris.com
"What man is a man who does not make the world better?"      --Balian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHCSxvIR7qMdg1EfYRAldVAJ4ns/X3JDrBnTft6JDEL5e8Tv80agCgvb59
/odKKLNtH2E1zB83pHg3Qdc=
=KkBD
-----END PGP SIGNATURE-----
