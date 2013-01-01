From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: Bug in latest gitk - can't click lines connecting commits
Date: Tue, 1 Jan 2013 12:21:57 -0500
Message-ID: <20130101172156.GA22450@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, stefan@haller-berlin.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 18:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq5Xg-0004iu-Pp
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 18:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab3AARWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 12:22:00 -0500
Received: from mail-vb0-f53.google.com ([209.85.212.53]:58486 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab3AARV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 12:21:59 -0500
X-Greylist: delayed 168953 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jan 2013 12:21:59 EST
Received: by mail-vb0-f53.google.com with SMTP id b23so13426392vbz.40
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=YiiEYtfnoHjJPqkrKdhlzS1b32wjgiwbo4AAE2WsaMo=;
        b=00zQOi0pp7z6E0GndL3Y9jm6rBl2iLVPD8a9PyNssqacsM0sTOX64KmbgWmU7PfPll
         lGoySQfy80Thwy4AWeATYEnMnK3GAjIPUw/O1frXJL4/VnOaD0wIzM0suBdwn3xh5boj
         MXoxbQ+nAi6CQel5IsmAy2isr2yJmVpR6p2WvXJC55K6pj2B/pQgV81I4jdYdNB0NgJQ
         bQv9O9EJVhZf6D5MPRy86BDRDUvj/31qbM/rBH74nKyHgroGy21Oyis5/BnJGfl4iv3W
         aak9nJCXK79CQGdPj5zdc5bjDwURGeODV1IqjJgWkV8ZdJGdJ4NpwH4S8gYnS1B9Xbwu
         6gSQ==
X-Received: by 10.52.156.72 with SMTP id wc8mr60002161vdb.77.1357060918876;
        Tue, 01 Jan 2013 09:21:58 -0800 (PST)
Received: from gmail.com (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id f13sm39523448vep.12.2013.01.01.09.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 09:21:58 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212428>

I was testing some patches against the latest gitk, and noticed that when I 
click the mouse on the lines that connect the commits in the history graph,
I get an error popup with:
 Error: can't read "cflist_top": no such variable

Looks like this was introduced in gitk commit b967135d89e8d8461d059
 gitk: Synchronize highlighting in file view when scrolling diff

This commit hasn't been merged yet from upstream into git.

Here's the full error trace:
can't read "cflist_top": no such variable
can't read "cflist_top": no such variable
    while executing
"$cflist tag remove highlight $cflist_top.0 "$cflist_top.0 lineend""
    (procedure "highlightfile" line 4)
    invoked from within
"highlightfile 0"
    (procedure "highlightfile_for_scrollpos" line 8)
    invoked from within
"highlightfile_for_scrollpos $topidx"
    (procedure "scrolltext" line 9)
    invoked from within
"scrolltext 0.0 1.0"
    (vertical scrolling command executed by text)

-Jason
