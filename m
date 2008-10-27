From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: [ANNOUNCE] intergit repository-linking tool (early release)
Date: Mon, 27 Oct 2008 03:22:37 +0100
Message-ID: <490525ED.8080702@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gambit-list <gambit-list@iro.umontreal.ca>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 03:23:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuHlr-0007iw-CK
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 03:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbYJ0CWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYJ0CWm
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 22:22:42 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:52615 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750790AbYJ0CWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 22:22:41 -0400
Received: (qmail 11025 invoked from network); 27 Oct 2008 02:22:39 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 27 Oct 2008 02:22:39 -0000
Received: (qmail 2820 invoked from network); 27 Oct 2008 02:22:38 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 27 Oct 2008 02:22:38 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99197>

Hello

Ten days ago I started a thread about "Separating generated files?" [1], 
and suggested in the end that instead of using git submodule 
functionality, one might be better off using a tool which can, upon 
committing files in the repository containing generated files, add a 
link ("reference") pointing to the commit in the source repository which 
represents the source files they have been generated from, and then when 
someone is checking out some revision of the source files later, use 
this information to find the (best-)matching commit in the repository 
with the generated files. This may also be useful in other situations 
where one likes to keep repositories separate but they have a version 
dependency on each other.

I've now written a first version of a pair of these two programs, which 
accomplishes this. You can get them from:

http://www.christianjaeger.ch/dyn/pubgit/gitweb?p=intergit.git;a=summary
git clone http://christianjaeger.ch/pubgit/intergit.git

This will need some finish before really being production ready; it will 
mainly need some experimentation on how it is to be used exactly, so 
that possibly missing features in the search and indexing algorithms can 
be added (like whether it should understand merges between two commits 
containing references as a commit having both references even if the 
merge commit doesn't specify a reference), and I'm also keen on some 
feedback implementation-wise (building the index is currently slow, and 
some of the problems that I'm listing in the docs (Implementation.txt 
and TODO.txt) may have solutions I've not been aware of). I've tried to 
add some useful documentation (see *.txt files), so I'm hoping this 
helps anyone interested to understand how it works, or just give me some 
feedback on how it may or may not be useful.

I've developed and tested it on Linux. Hints on whether it works under 
other systems and how to make it work with msysgit would be very 
appreciated.

Christian

[1] http://marc.info/?l=git&m=122415845625044&w=2

PS. I've just noticed the thread about "repo - The Multiple Git 
Repository Tool". I'll have to take a look first to see how it is 
related to my program--it may take me a few days as I'll be busy.

--
My OpenPGP fingerprint: F033 D030 F75D E445 05A1  1865 4ECB DF80 1FE6 92DA
