From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: push git: failing on remote Fedora 10 as well as Cygwin too
Date: Sun, 19 Apr 2009 15:19:39 +0100
Message-ID: <52ECF09C6DA04E3EBD97076191CF1BD8@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 19 16:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXtY-0001zX-6w
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760231AbZDSOTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 10:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758111AbZDSOTn
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:19:43 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49966 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091AbZDSOTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 10:19:43 -0400
Received: by ewy24 with SMTP id 24so819681ewy.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=Ecvi3RNEhzsTeTcXodizDDchrZnLG6Tv9MRm4/+reYk=;
        b=fm2yD2l8qBoK8a6KGiGGEBvRH5aac4Ee5Lu4GccvrM/bRbTRFrJtwKn3KSIcKKo1H1
         qFSQfhB5+INMhPKpZuR6kxgE+vpf5P22UlQqY6DyXSv+seCnscEuHh0KbkIEyZPJMgPU
         djblJ5oE8DnkG6KLSgtxJz/hfOOkRnb5LEprI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=lGLXXzSl90k59h++Zc1MnxkG4qpkmnshRT7H498zFW5fG92LLX7fDFmuwJqi5NdMvY
         SnT3XhyL56uAyE5GmGp7qLW2VT5mbyo/hI0SjLg8LCH3JMopK1Fd98IWqutfD872sQd1
         m56Mc856RObkvc9rmja6IqZh231PtZQRidmgM=
Received: by 10.210.33.3 with SMTP id g3mr4762220ebg.82.1240150781263;
        Sun, 19 Apr 2009 07:19:41 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 10sm2006728eyz.38.2009.04.19.07.19.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 07:19:41 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116899>

The same F10 server is failing when doing a push locally from Linux :-

[root@*** hello-world]# git push git://git.***/hello-world
Counting objects: 4, done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 535 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
error: unpack failed: unpacker exited with error code
To git://git.cybercomms.org/hello-world
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'git://git.***/hello-world'

messages :-

Apr 19 15:10:43 *** xinetd[29002]: START: git pid=30384 
from=::ffff:192.168.0.1
Apr 19 15:10:43 *** git-daemon: [30384] Connection from 192.168.0.1:40205
Apr 19 15:10:43 *** git-daemon: [30384] Extended attributes (25 bytes) exist 
<host=git.***>
Apr 19 15:10:44 *** git-daemon: [30384] Request receive-pack for 
'/hello-world'
Apr 19 15:10:44 *** xinetd[29002]: EXIT: git status=0 pid=30384 
duration=1(sec)

a 'git push /pub/git/hello-world' works fine though.

Aaron

On Sat, Apr 18, 2009 at 7:07 PM, Aaron Gray 
<aaronngray.lists@googlemail.com> wrote:

I am trying to get git to do a remote push, but it is intermittent, hanging 
sometimes, and not working others :-

  Aaron Gray@AMD2500-PC /usr/src/test/gittest/hello-world
  $ git push git://git.***/hello-world
  Counting objects: 4, done.
  Compressing objects: 100% (3/3), done.
  Writing objects: 100% (3/3), 557 bytes, done.
  Total 3 (delta 1), reused 0 (delta 0)
  fatal: read error (Software caused connection abort)

Server: F10
      git is version 1.6.0.6
      git-daemon 1.6.0.6-3.fc10.i386

Client: Cygwin
      git is version 1.6.1.2

/var/log/messages :-
Apr 18 18:18:28 *** xinetd[29002]: START: git pid=3083 
from=::ffff:212.19.110.144
Apr 18 18:18:28 *** git-daemon: [3083] Connection from 212.159.110.144:6008
Apr 18 18:18:28 *** git-daemon: [3083] Extended attributes (25 bytes) exist 
<host=git.***.org>
Apr 18 18:18:29 *** git-daemon: [3083] Request receive-pack for 
'/hello-world'
Apr 18 18:18:29 *** xinetd[29002]: EXIT: git status=0 pid=3083 
duration=1(sec)

Aaron 
