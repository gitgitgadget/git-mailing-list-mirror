From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit standalone client on OpenVMS works (somewhat)
Date: Sun, 3 May 2009 17:15:21 +0200
Message-ID: <200905031715.22085.robin.rosenberg.lists@dewire.com>
References: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ben Armstrong <BArmstrong@dymaxion.ca>
X-From: git-owner@vger.kernel.org Sun May 03 17:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0dPl-0002Pr-VH
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 17:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbZECPPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbZECPPa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 11:15:30 -0400
Received: from mail.dewire.com ([83.140.172.130]:8015 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755988AbZECPPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 11:15:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CC9D680027D;
	Sun,  3 May 2009 17:15:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDtEMJXXhw7t; Sun,  3 May 2009 17:15:24 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 004A6800277;
	Sun,  3 May 2009 17:15:23 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118178>

torsdag 30 april 2009 17:39:36 skrev Ben Armstrong <BArmstrong@dymaxion.ca>:
> I am happy to report that the jgit standalone client works (somewhat) on
> OpenVMS/Alpha, a non-POSIX platform for which no C git port exists.  I
> understand that not all functionality of the C client is supported yet, but
> for limited use, and supplemented by using the C client on a PC, I may be
> able to get away with this.  At least being able to do a 'git clone' is
> encouraging.

	O_o

Not sure what to say here.. cool. I never even thought of VMS as a Java platform.

> The only problem I have found so far is that if a tag has dots in it and the
> last dotted expression looks like a VMS file version number, it is
> interpreted as such instead of part of the filepath used to represent it
> under .git/refs/tags


> 3. On VMS, set up the jgit command environment appropriately:
> 
> $ define jgit_home dsa0:[dymax.jgit]
> $ jgit==java+" -cp /jgit_home/jgit ""org.spearce.jgit.pgm.Main"""
> $ git=="pipe define/user JAVA$FILENAME_CONTROLS 8 ; "+-
>    "define/user DECC$ARGV_PARSE_STYLE ENABLE ; "+-
>    "define/user DECC$EFS_CASE_PRESERVE ENABLE ; "+-
>    "define/user DECC$EFS_CHARSET ENABLE ; jgit"

After googling a little, I think you got JAVA$FILENAME_CONTROLS wrong.
8 is for basic unix filenames. But you also need %x00200000 (or possibly
%x00100000) as well. See
http://h18012.www1.hp.com/java/documentation/1.5.0/ivms/docs/user_guide.html#unix_style

That's my guess....  I wouldn't dare to tell you how to get the exact syntax right, My VMS 
skillz are not what they once were.

Come to think of it, the first VMS machine I used was named "Linus", named
after a widely known character (in a comic strip called Snoopy). </anecdotes>

-- robin
