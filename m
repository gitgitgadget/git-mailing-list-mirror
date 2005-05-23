From: Jeff Garzik <jgarzik@pobox.com>
Subject: git-switch-tree script
Date: Mon, 23 May 2005 03:24:22 -0400
Message-ID: <42918526.1060406@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040907090901080000080103"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 09:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7Hk-0002PJ-Lj
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEWHYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVEWHYf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:24:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10693 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261853AbVEWHY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 03:24:29 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Da7IY-0000Xf-H6; Mon, 23 May 2005 07:24:27 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: david@gibson.dropbear.id.au
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907090901080000080103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is what I use to switch between branches, in my kernel trees.

	Jeff



--------------040907090901080000080103
Content-Type: text/plain;
 name="git-switch-tree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-switch-tree"

#!/bin/sh

if [ "x$1" != "x" ]
then
	if [ "$1" == "master" ]
	then
		( cd .git && rm -f HEAD && ln -s refs/heads/master HEAD )
	else
		if [ ! -f .git/refs/heads/$1 ]
		then
			echo Branch $1 not found.
			exit 1
		fi

		( cd .git && rm -f HEAD && ln -s refs/heads/$1 HEAD )
	fi
fi

git-read-tree -m HEAD && git-checkout-cache -q -f -u -a


--------------040907090901080000080103--
