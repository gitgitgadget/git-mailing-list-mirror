From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Not going beyond symbolic links
Date: Mon, 4 Aug 2008 19:28:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808041921530.3299@nehalem.linux-foundation.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org> <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCJD-0002z1-KT
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbYHEC25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbYHEC25
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:28:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45557 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754981AbYHEC24 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 22:28:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m752Sk8q021890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 19:28:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m752Sjhn012342;
	Mon, 4 Aug 2008 19:28:45 -0700
In-Reply-To: <alpine.DEB.1.00.0808050356480.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91408>



On Tue, 5 Aug 2008, Johannes Schindelin wrote:
> 
> I vividly remember being quite pissed by Git replacing a symbolic link in 
> my working directory with a directory, and instead of updating the files 
> which were technically outside of the repository, Git populated that newly 
> created directory.

Well, that can cut both ways. For example, I vividly remember a time in 
the distant past when harddisks were tiny, and I didn't have insanely 
high-end hardware, and I was building the X server, but had to split 
things up over two partitions because each individual partition was 
too full.

IOW, sometimes you may _want_ to use symlinks that way, even within one 
project - with a symlink allowing you to move parts of it around 
"transparently".

Of course, these days under Linux we can just use bind mounts, so the use 
of symlinks to stitch together two or more different trees is fairly 
old-fashioned, but is still the only option on some systems or if you 
don't have root.

(These days harddisks are also generally so big that it never happens. But 
on my EeePC laptop, I still end up with two filesystems, 4GB  and 8GB 
each. So it's not inconceivable to be in that kind of situation even 
today).

			Linus
