From: Wayne Scott <wsc9tt@gmail.com>
Subject: BUG: 'make clean; make' won't rebuilt 'git'
Date: Thu, 17 Nov 2005 08:58:26 -0500
Message-ID: <59a6e5830511170558u2356fb8djf48914702a95ec07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Nov 17 15:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EckHe-0002SH-Ff
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKQN61 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 08:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKQN61
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:58:27 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:41223 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVKQN61 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:58:27 -0500
Received: by xproxy.gmail.com with SMTP id s14so2211021wxc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 05:58:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lWV6KZvELjBEXrmswFyHmMPLucuwD4s8dVmicoySfwvDvs1sl5VYnfCl23H7Zo/wkRwB/Usul3QI+awVukmG5z0o0vKDIqZvPhqRfVjDfMb1LQySk3I8TtBJu/pB9pyCaxN8zRh6iRjCoOXVC8oxsSMEsufCId0Nj1oko00F1Mo=
Received: by 10.70.43.4 with SMTP id q4mr4889731wxq;
        Thu, 17 Nov 2005 05:58:26 -0800 (PST)
Received: by 10.70.7.3 with HTTP; Thu, 17 Nov 2005 05:58:26 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12114>

The 'make clean' target doesn't remove the 'git' application and since
the 'git' make target depends on git.c directly it won't get rebuilt
after a clean.

The net result is that if you do:
   make
   make clean
   make prefix=/usr/local
   make prefix=/usr/local install

it won't install the correct git binary.

-Wayne
