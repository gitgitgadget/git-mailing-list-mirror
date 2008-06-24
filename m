From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/7] parse-opt: fake short strings for callers to believe
 in.
Date: Tue, 24 Jun 2008 10:20:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806241019370.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCED-0006UU-Fr
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYFXRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbYFXRVx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:21:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34116 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753660AbYFXRVx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 13:21:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHKT5I019334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 10:20:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OHKSp4029864;
	Tue, 24 Jun 2008 10:20:29 -0700
In-Reply-To: <1214298732-6247-6-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86094>



On Tue, 24 Jun 2008, Pierre Habouzit wrote:
>
> If we begin to parse -abc and that the parser knew about -a and -b, it
> will fake a -c switch for the caller to deal with.
> 
> Of course in the case of -acb (supposing -c is not taking an argument) the
> caller will have to be especially clever to do the same thing. We could
> think about exposing an API to do so if it's really needed, but oh well...

Well, if the other parser is _also_ parse_options() (ie you just cascade 
them incrementally in a loop), then the other parser should get it right 
automatically. No?

		Linus
