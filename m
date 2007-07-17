From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 12:07:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707171207090.27353@woody.linux-foundation.org>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
 <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 21:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAsOy-00008A-DK
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 21:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086AbXGQTHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760797AbXGQTHj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 15:07:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53968 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757949AbXGQTHh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 15:07:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HJ7VYt018455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2007 12:07:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HJ7PdZ001607;
	Tue, 17 Jul 2007 12:07:25 -0700
In-Reply-To: <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.651 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52789>



On Tue, 17 Jul 2007, Junio C Hamano wrote:
> 
> This is wrong.  If the filesystem has a symlink and we would
> want a directory there, we should unlink().  So at least the
> stat there needs to be lstat().

Good catch. Ack.

		Linus
