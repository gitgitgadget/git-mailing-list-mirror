From: "Sean" <seanlkml@sympatico.ca>
Subject: Colorized git log
Date: Thu, 21 Apr 2005 17:12:45 -0400 (EDT)
Message-ID: <3536.10.10.10.24.1114117965.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 22 00:08:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjqC-0005Li-98
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDUWMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVDUWMU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:12:20 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:15310 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261400AbVDUWMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:12:07 -0400
Received: from linux1 ([67.71.124.169]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050421221204.YOZT1623.simmts8-srv.bellnexxia.net@linux1>
          for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:12:04 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3LLCjr8030632
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 17:12:45 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 21 Apr 2005 17:12:45 -0400 (EDT)
To: "GIT Mailing Lists" <git@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On the off chance that someone else might like it, here is a pager script
for the git log that adds a splash of color:

#!/bin/sh
git log "$@" | sed -re '
     /.*signed-off-by.*/Is//\x1b[34m&\x1b[0m/
     /^--*$/Is//\x1b[31m&\x1b[0m/
     /^(commit|tree|parent) .*/Is//\x1b[32m&\x1b[0m/
     /^author .*/Is//\x1b[36m&\x1b[0m/
     /^committer .*/Is//\x1b[35m&\x1b[0m/'  | less -R


Sean


