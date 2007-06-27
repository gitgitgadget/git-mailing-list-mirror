From: Nicolas Vilz <niv@iaglans.de>
Subject: post-apply hook or something like that
Date: Wed, 27 Jun 2007 20:17:26 +0200
Message-ID: <20070627181726.GH17855@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 20:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3cgq-0005dI-Ad
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 20:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbXF0S4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 14:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757312AbXF0S4a
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 14:56:30 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:1173 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757112AbXF0S43 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 14:56:29 -0400
X-Greylist: delayed 1540 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2007 14:56:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id EF0453F42
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 20:30:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y2X6icW9UN7m for <git@vger.kernel.org>;
	Wed, 27 Jun 2007 20:30:48 +0200 (CEST)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id BEE7D3E53
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 20:30:47 +0200 (CEST)
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51061>

Hello fellow gits,

I try to insert metastore into my workflow and i wonder if i could get
the following scenario working:

(1) cd /etc/ && git-init-db # start gittify etc-directory
(2) git commit -a # fire up first commit
(3) metastore -s # save current state of permissions and ownerships
(4) git commit -a # commit the changes
(5) chown nobody bash/<somefile> # change ownership
(6) git commit -a # with the pre-commit shipped with metastore this is tracked
(7) git reset --hard HEAD^1 # go back one step
(8) git reset --hard <former-sha1-sum> # go forward again
(9) metastore -a # apply the changes from last commit

what i was wondering, is it possible, to get a metastore -a
automatically after checking out something?

Greetings
Nicolas
