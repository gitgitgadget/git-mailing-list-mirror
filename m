From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Tue, 24 Jun 2008 21:32:49 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:34:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMhp-0000ms-7O
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYFYEdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbYFYEdI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:33:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56294 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752081AbYFYEdH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 00:33:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5P4Wn1I029824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 21:32:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5P4WnGI022722;
	Tue, 24 Jun 2008 21:32:49 -0700
In-Reply-To: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.351 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86222>



On Wed, 25 Jun 2008, Nicolas Pitre wrote:
> 
> Git older than version 1.5.2 (or any other git version with this option
> set to 1) may revert to version 1 of the pack index by manually deleting
> all .idx files and recreating them using 'git index-pack'.  Communication
> over the git native protocol is unaffected since the pack index is never
> transferred.

Rather than talk about when it does _not_ matter, wouldn't it be better to 
talk about when it _can_ matter?

Namely when using dumb protocols, either http or rsync, with the other end 
being some ancient git thing (and it is worth mentioning version of what 
counts as 'ancient' too, I can't remember, probably means that pretty much 
nobody else can either).

		Linus
