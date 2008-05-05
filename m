From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 5 May 2008 10:53:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com> <20080504215208.GG29038@spearce.org> <86skwxd97d.fsf@blue.stonehenge.com> <8663tsbqg0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon May 05 19:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt4uG-0004S1-FK
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 19:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbYEERyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756330AbYEERyH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 13:54:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50468 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756275AbYEERyG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 13:54:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45Hrvvw008202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 10:53:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m45HrunF028787;
	Mon, 5 May 2008 10:53:56 -0700
In-Reply-To: <8663tsbqg0.fsf@blue.stonehenge.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81303>



On Mon, 5 May 2008, Randal L. Schwartz wrote:
> 
> Also, ZFS is case-sensitive, which leads me to believe that out of
> the box, it's more like UFS.
> 
> Still don't know why ZFS breaks but UFS works.

UFS is a traditional Unix filesystem, and will not mangle your filenames.

ZFS apparently acts like a case-sensitive HFS+: it still tries to 
normalize to UTF-8 (and does it badly, at that - picking an Apple-specific 
almost-NFD form of normalization rather than the more sensible NFC form).

So ZFS may not corrupt cases, but it still corrupts UTF-8 filenames.

			Linus
