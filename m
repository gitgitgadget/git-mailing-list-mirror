From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible --remove-empty bug
Date: Sun, 12 Mar 2006 15:12:12 +0100
Message-ID: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 15:12:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIRJ2-0008Si-8f
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 15:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWCLOMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 09:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWCLOMN
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 09:12:13 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:48627 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750803AbWCLOMN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 09:12:13 -0500
Received: by wproxy.gmail.com with SMTP id 69so1229241wri
        for <git@vger.kernel.org>; Sun, 12 Mar 2006 06:12:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t2fPd8BiRD7bWXcufe9DSI2PNEUglS1jrtRTafX6zDIbTZfp5Jo+FX57XlWi1YRr7VfNNUbBxADp5F8UiHWMmmxRsQ0AsmH8WSTvUYt11hZpdnm0OKofgyWO4SIP1GdhrpYWnPTkAbiogsa7wg8/abM+u7mbbRZ5PR0d1/ocC5g=
Received: by 10.65.73.20 with SMTP id a20mr1577490qbl;
        Sun, 12 Mar 2006 06:12:12 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 12 Mar 2006 06:12:11 -0800 (PST)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17514>

>From today git:

$ git-rev-parse HEAD
be767c91724275c4534965c0d25c452b76057602
$ git-rev-list be767c91724275c4534965c0d25c452b76057602 -- imap-send.c
f2561fda364ad984ef1441a80c90b0ee04f1a7c4
$ git-rev-list --remove-empty be767c91724275c4534965c0d25c452b76057602
-- imap-send.c
$

>From git-rev-list documentation:

--remove-empty::
	Stop when a given path disappears from the tree.

But isn't it to be intended *after* a path disapperas from the tree?
In this case I would expect to see revision
f2561fda364ad984ef1441a80c90b0ee04f1a7c4 also with --remove-empty
option.

BTW rev f2561fda364ad984ef1441a80c90b0ee04f1a7c4 is the 'Add
git-imap-send, derived from isync 1.0.1.' patch.

Thanks
Marco
