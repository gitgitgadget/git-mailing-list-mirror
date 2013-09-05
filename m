From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 00/38] pack version 4 basic functionalities
Date: Thu, 05 Sep 2013 02:19:23 -0400
Message-ID: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSxK-0000D7-TW
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab3IEGUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab3IEGUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:15 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3S2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id B775A2DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:13 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233930>

After the initial posting here:

  http://news.gmane.org/group/gmane.comp.version-control.git/thread=233061

This is a repost plus the basic read side working, at least to validate
the write side and the pack format itself.  And many many bug fixes.

This can also be fetched here:

  git://git.linaro.org/people/nico/git

I consider the actual pack format definition final as implemented
by this code.

TODO:

- index-pack support

- native tree walk support

- native commit graph walk support

- better heuristics when creating tree delta encoding

- integration with pack-objects

- transfer protocol backward compatibility

- thin pack completion

- figure out unexplained runtime performance issues

However, as I mentioned already, I've put more time on this project lately
than I actually had available.  I really wanted to bring this project far
enough to be able to kick it out the door for others to take over, and
there we are.

I'm always available for design discussions and code review.  But don't
expect much additional code from me at this point.

@junio: I'm hoping you can take this branch as is, and apply any ffurther
patches on top.

The diffstat goes like this:

 Makefile        |    3 +
 cache.h         |   11 +
 hex.c           |   11 +
 pack-check.c    |    4 +-
 pack-revindex.c |    7 +-
 pack-write.c    |    6 +-
 packv4-create.c | 1105 +++++++++++++++++++++++++++++++++++++++++++++++++
 packv4-parse.c  |  408 ++++++++++++++++++
 packv4-parse.h  |    9 +
 sha1_file.c     |  110 ++++-
 10 files changed, 1648 insertions(+), 26 deletions(-)

Enjoy !
