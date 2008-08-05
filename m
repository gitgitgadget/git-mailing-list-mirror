From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Not going beyond symbolic links
Date: Mon, 4 Aug 2008 17:21:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 02:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQAJg-0008Bk-K2
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 02:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbYHEAVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 20:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbYHEAVS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 20:21:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41184 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755137AbYHEAVR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 20:21:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m750L4t0013388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 17:21:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m750L3Qp007455;
	Mon, 4 Aug 2008 17:21:04 -0700
In-Reply-To: <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.414 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91394>



On Mon, 4 Aug 2008, Junio C Hamano wrote:
> 
> I started to revisit this issue and patched "git update-index --add"
> and "git add" so far.  Patches follow.

Patches look good to me, but did you check the performance impact?

The rewritten 'has_symlink_leading_path()' should do ok, but it migth 
still be a huge performance downside to check all the paths for things 
like "git add -u".

I didn't test, though.

		Linus
