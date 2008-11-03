From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 12:15:05 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031211180.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:17:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5re-0006DD-7f
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbYKCUQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbYKCUQA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:16:00 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44149 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754304AbYKCUP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 15:15:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3KF676025138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 12:15:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3KF53s009208;
	Mon, 3 Nov 2008 12:15:05 -0800
In-Reply-To: <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99987>



On Mon, 3 Nov 2008, Linus Torvalds wrote:
>
> I'll post a simple series of four commits in a moment. They're all 
> trivial, and the first three are just setting stuff up (in fact, the very 
> first one is a commit I've already posted, and it's technically totally 
> unrelated, but since it touches the same area as one of the other ones, 
> I'm too lazy to try to separate it out).

Side note: it's certainly possible that we could improve on this. Right 
now, "--simplify-namespace" will totally override any path simplification, 
so you can't get a combination of pathnames _and_ naming commits. I don't 
know exactly what the rules should be, but I could imagine that we could 
do something like:

 - if no pathnames are given, work the way the current patch-series works.

 - if path-names are given, make rev_compare_tree() truen 
   REV_TREE_DIFFERENT if a name decoration _or_ a tree difference exists.

Anyway, that's a fairly trivial extension to the idea, and doesn't really 
matter for the basic code. It can easily be left for later.

		Linus
