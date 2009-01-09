From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 9 Jan 2009 10:13:10 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901091011350.6528@localhost.localdomain>
References: <20090108195511.GA8734@chistera.yi.org> <7v7i552clz.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901091001260.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Clemens Buchacher <drizzd@aon.at>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 19:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLLtE-0005oL-HQ
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 19:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZAISOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbZAISOD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 13:14:03 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43802 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949AbZAISOB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2009 13:14:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n09IDBAX010366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Jan 2009 10:13:12 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n09IDA5k006797;
	Fri, 9 Jan 2009 10:13:10 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901091001260.6528@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.955 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105026>



On Fri, 9 Jan 2009, Linus Torvalds wrote:
>
> Don't combine unique lines, but lines that have the same hash as a 
> thousand other lines? Go right ahead.

Oh, and even then, don't ever combine fragments unless it's a single line, 
and unless you can really stop with just one or two combines. Because we 
don't want to combine 100 one-liner changes (on every other line) into one 
300-line change.

		Linus
