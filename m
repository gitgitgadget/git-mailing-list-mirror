From: Bill Lear <rael@zopyra.com>
Subject: Re: Git as electronic lab notebook
Date: Sat, 19 Dec 2009 22:43:11 -0600
Message-ID: <19245.43871.588697.532035@lisa.zopyra.com>
References: <loom.20091219T130946-844@post.gmane.org>
	<8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
	<4B2D6CA5.3070304@gmail.com>
	<alpine.LFD.2.00.0912192212400.28241@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Johan 't Hart" <johanthart@gmail.com>,
	"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>,
	Thomas Johnson <thomas.j.johnson@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 05:44:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMDeO-0006zg-Ax
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 05:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZLTEnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 23:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZLTEnS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 23:43:18 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:48901
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZLTEnS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 23:43:18 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id nBK4hF730812;
	Sat, 19 Dec 2009 22:43:15 -0600
In-Reply-To: <alpine.LFD.2.00.0912192212400.28241@xanadu.home>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135517>

On Saturday, December 19, 2009 at 22:15:00 (-0500) Nicolas Pitre writes:
>On Sun, 20 Dec 2009, Johan 't Hart wrote:
>
>> Is git able to handle 4Gig files? I've heard git loads every file completely
>> in memory before handling it...
>
>Right.  Sowith current Git you will be able to deal with 4GB files only 
>if you have a 64-bit machine and more than 4GB of RAM.

??

% uname -a
Linux pppp 2.6.31.6-166.fc12.i686 #1 SMP Wed Dec 9 11:14:59 EST 2009 i686 i686 i386 GNU/Linux
% cat /proc/meminfo  | grep MemTotal
MemTotal:        3095296 kB
% mkdir gogle
% cd gogle
% git init
% dd if=/dev/zero of=zerofile.tst bs=1k count=4700000
% git add *
% git commit -a -m new
[master (root-commit) 35a25be] new
 1 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 zerofile.tst
% git --version
git version 1.6.5.7

Seems ok to me...

Though, I find this interesting:

% git log -p
commit 35a25be3fff2f8bbd6ec22c94b9a5c0d66053d21
Author: Bill Lear <rael@zopyra.com>
Date:   Sat Dec 19 22:38:48 2009 -0600

    new

diff --git a/zerofile.tst b/zerofile.tst
new file mode 100644
index 0000000..e5bd39d
Binary files /dev/null and b/zerofile.tst differ


Bill
