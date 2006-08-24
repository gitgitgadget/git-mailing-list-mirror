From: Timo Hirvonen <tihirvon@gmail.com>
Subject: git-daemon hangs after invalid request
Date: Thu, 24 Aug 2006 15:37:05 +0300
Message-ID: <20060824153705.600f2b1a.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 14:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGESN-0002Uq-1T
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 14:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWHXMhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWHXMhG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 08:37:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:50648 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751205AbWHXMhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 08:37:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so562788nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 05:36:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Y88/FMCrzswYIVd0lyAsvOmilhta4jVBalIFDJRTkUOkDtv4H4eX03s4ZqTFGI15E3hL8SiTd2UElL2HSGb6PGi5u68+1TiV+mQtJRB52stvlv6YOzXGv3vyE6ACBI6VvQrw535p6b3oF9h2181dx/toCGshqzrjUld3y4dAME8=
Received: by 10.49.8.15 with SMTP id l15mr3492388nfi;
        Thu, 24 Aug 2006 05:36:57 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.21])
        by mx.gmail.com with ESMTP id v20sm4362433nfc.2006.08.24.05.36.52;
        Thu, 24 Aug 2006 05:36:54 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25956>

Hi,

I noticed git-daemon hangs sometimes...

    git clone git://example.com/git/repo.git

works just fine but this

    git clone git://example.com/git/invalid.git

hangs and I have to hit ^C.  It's OK but error message would be nice.
git-daemon outputs these lines to syslog:

    Request for '/git/invalid.git'
    '/git/invalid.git': unable to chdir or not a git archive

Now if I try to clone the existing repo again

    git clone git://example.com/git/repo.git

it hangs.  I have to restart git-daemon to get it working again.  I
started git-daemon (1.4.2) with --syslog --verbose flags.

-- 
http://onion.dynserv.net/~timo/
