From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 20:22:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:24:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxDSo-0001vM-BM
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbYKDEWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbYKDEWj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:22:39 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37016 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbYKDEWi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 23:22:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA44MYZP023151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 20:22:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA44MYPc032390;
	Mon, 3 Nov 2008 20:22:34 -0800
In-Reply-To: <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.44 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100030>



On Mon, 3 Nov 2008, Andrew Arnott wrote:
>
> I'm refactoring a library including renaming both files and
> directories.  A few lines of each file are also changed, but they are
> substantially unchanged in content.  I've done a git add to put all my
> changes into the index, but a git status shows that git only detected
> a few of the renames... most of them are delete-add operations.  Is
> there anything I can do to help git recognize the rename so that
> history is preserved across this commit?

How many renames do you have? Modern versions of git will do any number of 
exact renames, but the (rather expensive) inexact rename detection has a 
default limit of something fairly small.

You could try adding

	[diff]
		renamelimit=0

to your ~/.gitconfig file. It can be quite expensive though.

			Linus
