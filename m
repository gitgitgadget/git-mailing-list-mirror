From: Mark Burton <markb@ordern.com>
Subject: gitk: 'show origin of this line' barfs if gitk run in subdir
Date: Wed, 3 Dec 2008 20:51:58 +0000
Organization: Order N Ltd.
Message-ID: <20081203205158.6b4b62c7@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7yjy-0000dX-WF
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYLCUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYLCUw7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:52:59 -0500
Received: from c2beaomr06.btconnect.com ([213.123.26.184]:19440 "EHLO
	c2beaomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbYLCUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:52:58 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2beaomr06.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id AVF12545;
	Wed, 3 Dec 2008 20:51:58 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 5C156190CFB;
	Wed,  3 Dec 2008 20:51:58 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0203.4936F1A7.013C,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102287>


Hi,

I was just trying out the new gitk feature that shows you the origin of a
selected line in the diff pane and found that it doesn't work right if
gitk is not started in the top-level work directory - i.e. if you are
in a subdir it pops up an error message of this form:

Error running git blame: fatal: no such path $path in $sha1

I guess it needs something like subdir-depth number of ../ prepended to
the front of the pathname to make the blame succeed.

I could try and fix this but I am sure that others who understand
the sources of gitk/git-blame/git can do it much quicker than me.

Cheers,

Mark
