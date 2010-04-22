From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 11:20:34 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004221119290.26046@i5.linux-foundation.org>
References: <20100421195822.GX10984@baikonur.stro.at> <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com> <20100422121408.GI3211@stro.at> <20100422124042.GA1433@progeny.tock> <m2hbn37e7q.fsf@igel.home> <20100422144433.GB28923@coredump.intra.peff.net>
 <20100422145455.GC28923@coredump.intra.peff.net> <20100422150325.GB4801@progeny.tock> <20100422151708.GA15039@coredump.intra.peff.net> <20100422162504.GA4913@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 20:22:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O513A-0003IE-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 20:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab0DVSWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 14:22:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36385 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109Ab0DVSWp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 14:22:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3MIM9XP005557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Apr 2010 11:22:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3MIM7UN032716;
	Thu, 22 Apr 2010 11:22:07 -0700
In-Reply-To: <20100422162504.GA4913@progeny.tock>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145544>



On Thu, 22 Apr 2010, Jonathan Nieder wrote:
>
> Hi Ted, [ nip ]
> 
> It seems that the committer date is set to coincide with the author
> date for ext4 patches, which breaks some assumptions by git that each
> commit has a later or equal committer date than all parents (modulo
> some skew).

Argh. Yeah, that's just _evil_. Admittedly, git should never care, but in 
practice it does, because doing the whole graph walk can be _very_ 
expensive. So git wants to think that the committer dates at least have 
_some_ real-life significance.

		Linus
