From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 8 Jan 2009 07:35:55 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901080734400.3283@localhost.localdomain>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
 <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain> <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain> <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
 <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain> <7vbpui8j6f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 16:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKwxP-0002Il-SC
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbZAHPgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbZAHPgk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:36:40 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50678 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600AbZAHPgk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 10:36:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08FZtC3008793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 07:35:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08FZtxU026456;
	Thu, 8 Jan 2009 07:35:55 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vbpui8j6f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.448 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104927>



On Wed, 7 Jan 2009, Junio C Hamano wrote:
> 
> Thanks, but "needs a buffer output buffer" made me scratch my head
> somewhat.

That was just me editing it.

It was originally "needs an output buffer" and then I was supposed to edit 
it to "needs a buffer" (because it can be either output or input, and in 
the case of git it's usually actually the input that was partial).

And then I messed up, and it became that.

		Linus
