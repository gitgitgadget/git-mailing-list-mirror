From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 8 Jan 2009 08:14:58 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901080813291.3283@localhost.localdomain>
References: <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
 <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain> <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org> <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
 <20090108153410.GB16840@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 17:17:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKxZh-0000xg-HU
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZAHQQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753661AbZAHQQN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:16:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39781 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753587AbZAHQQN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 11:16:13 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08GExdH011362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 08:15:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08GEww7026172;
	Thu, 8 Jan 2009 08:14:59 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090108153410.GB16840@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.448 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104932>



On Thu, 8 Jan 2009, Shawn O. Pearce wrote:
> 
> I still think we should try to reduce pack memory usage when we get
> oom from zlib and retry the current operation once.  We do it almost
> everywhere else and it works relatively well.

Oh, I agree.

It's just that I wanted to verify that people who see this problem 
actually see the message, and that we confirm that it is due to this and 
nothing else.

			Linus
