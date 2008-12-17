From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo
 with git protocol?
Date: Wed, 17 Dec 2008 13:25:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812171322330.28560@intel-tinevez-2-302>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>  <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org> <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvUs-0001qm-Tl
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYLQM0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYLQM0I
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:26:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:43745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753065AbYLQM0C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:26:02 -0500
Received: (qmail invoked by alias); 17 Dec 2008 12:26:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Dec 2008 13:26:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18w+CZjl1swJMXdcUzD5zrM5JXuULDotnbdVq9h7F
	rUk4aOLQz+26wK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103345>

Hi,

On Wed, 17 Dec 2008, Emily Ren wrote:

> I want some group can pull these branches or tags from my repo, while
> other's can't, Need I maintain two repositories ?

Either that (that would be the easy method, and also the proper one, since 
people would not even know what you hide), but you could patch 
upload-pack so that it runs a hook with the rev-list arguments in 
do_rev_list() in upload-pack.c, and die() if the hook returns non-zero.

Ciao,
Dscho
