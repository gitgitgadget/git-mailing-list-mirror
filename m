From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 16:40:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231638190.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org> <20080623222404.GM13395@artemis.madism.org>
 <7vmylbg4ks.fsf@gitster.siamese.dyndns.org> <20080623233146.GP13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAvft-0007Th-Ak
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbYFWXlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYFWXlF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:41:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57278 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752714AbYFWXlD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 19:41:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NNecNu016604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 16:40:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NNeb2A022232;
	Mon, 23 Jun 2008 16:40:37 -0700
In-Reply-To: <20080623233146.GP13395@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.843 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85954>



On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> 
>   Are we sure argv[argc] is NULL when those are main() arguments ?

Yes. There's tons of code that ends up not caring about argc at all, so 
any system that doesn't NULL-terminate would break.

In fact, git itself already depends on it, because it turns argv directly 
into the pathspec name pattern array.

		Linus
