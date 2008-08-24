From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sat, 23 Aug 2008 21:23:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808232120420.3363@nehalem.linux-foundation.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 06:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX7DD-0006in-R9
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 06:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYHXEX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 00:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYHXEX6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 00:23:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59701 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbYHXEX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2008 00:23:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7O4Nhch018946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 21:23:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7O4Ngxd015498;
	Sat, 23 Aug 2008 21:23:42 -0700
In-Reply-To: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.929 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93515>



On Sat, 23 Aug 2008, Junio C Hamano wrote:
> 
> There is one alternative, and one augmentation:
> 
>  (A) We do not do anything.
> 
>  (B) In addition to the main transition plan, outside git, prepare an
>      optional "git-old-style" package that installs many "git-foo"
>      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
>      People who like the dashed form can keep typing "git-foo", even
>      though that will cost them two exec()s.

I actually suspect that (A) is fine.

I suggested removing the "git-xyzzy" hardlinks entirely, but that was just 
because I didn't think anybody wanted them.

But given that with the 1.6.0 model you can always just do

	PATH="PATH:$(git --exec-path)"

in your .bashrc or similar to get the git-xyzzy form, and given that 
clearly some people like using them, there's really no downside to keeping 
them.

I _would_ suggest against putting them in /usr/bin, even as a 
"compatibility plan". Just expose them to people who want them, who can 
really quite easily do the above PATH setting.

		Linus
