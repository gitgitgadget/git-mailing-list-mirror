From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 3 Nov 2007 12:34:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoOmD-00044X-5k
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbXKCTfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbXKCTfI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:35:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58349 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756042AbXKCTfH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 15:35:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3JYdRA014758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Nov 2007 12:34:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3JYcTm031034;
	Sat, 3 Nov 2007 12:34:38 -0700
In-Reply-To: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
X-Spam-Status: No, hits=-4.731 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63302>



On Sat, 3 Nov 2007, Nicolas Pitre wrote:
> 
> Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.

I mostly like this, but can we please just use "MB/kB" instead of 
"MiB/KiB"?

I hope it was some kind of joke on crazy EU bureaucrats that just wasn't 
caught in time.

I also get the glitch, ie

	remote: Total 118 (delta 86), reused 112 (delta 86)iB/s

where that "iB/s" remains as garbage from the previous line: we use 
hardcoded vt100 sequences for colorization, and nobody has complained yet, 
so maybe we should just do the same for "reset and clear to end of line"?

Or maybe just add a few spaces. Using kB/MB instead of KiB/MiB will make 
it a few less characters to overwrite too.

		Linus
