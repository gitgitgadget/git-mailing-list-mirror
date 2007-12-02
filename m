From: A Large Angry SCM <gitzilla@gmail.com>
Subject: make test failure with latest master
Date: Sun, 02 Dec 2007 07:29:50 -0500
Message-ID: <4752A53E.4030000@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 13:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iynxd-0003bS-BI
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 13:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXLBM3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 07:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbXLBM3y
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 07:29:54 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:25602 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXLBM3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 07:29:53 -0500
Received: by an-out-0708.google.com with SMTP id d31so579365and
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 04:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=2pJS/FUlwRmB0AgiDCzIqoEipMqrWCHMlWFxLtZKWoQ=;
        b=drWFeWB12bUOnypsyE+gu6q2C4/rxvuuv2nME+eMjn0F2voEueQrh3U008W+loMf/RIsYBO3ffpBJHah8RXSe5SW2ZAcZqVVg7b+57OW8a/30JRhwaKEnCjWQLb017hT4Vp6UsFJouJISl/BMOaPDakSlDh/O/aY+LoQpYT9D2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=wIP+P92DchPY0eSax8UQYiknuN9bWbeFJbT2C50eFVdjBTbhfMzcWreLhdtEzSqphVFdIBZ11MBphgYpbGwaJ4t8ZFFRhAAvUfj2fdP03ru6xCVAHXqyI2EZ02H7bN/c0SKS5EhwswvF7x8nowYt7+BCiefCoIdbY3zLVXstlws=
Received: by 10.100.136.15 with SMTP id j15mr17682802and.1196598592452;
        Sun, 02 Dec 2007 04:29:52 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id m75sm11435061wrm.2007.12.02.04.29.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Dec 2007 04:29:52 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66775>

[Resent due to incorrect list address.]

With the latest master, 2221a6757161af1905925c405aded9ff470f70d5, "make 
test" now fails; last successful "make test" was mid-week sometime with 
master d25430. This is on a laptop running Suse 9.3.


*** t9600-cvsimport.sh ***
*   ok 1: setup cvsroot
*   ok 2: setup a cvs module
* FAIL 3: import a trivial module


                 git cvsimport -a -z 0 -C module-git module &&
                 git diff module-cvs/o_fortuna module-git/o_fortuna


*   ok 4: pack refs
*   ok 5: update cvs module
* FAIL 6: update git module


                 cd module-git &&
                 git cvsimport -a -z 0 module &&
                 git merge origin &&
                 cd .. &&
                 git diff module-cvs/o_fortuna module-git/o_fortuna


*   ok 7: update cvs module
* FAIL 8: cvsimport.module config works


                 cd module-git &&
                         git config cvsimport.module module &&
                         git cvsimport -a -z0 &&
                         git merge origin &&
                 cd .. &&
                 git diff module-cvs/tick module-git/tick


* failed 3 among 8 test(s)
