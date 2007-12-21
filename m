From: Sean <seanlkml@sympatico.ca>
Subject: Re: Failed binary detection.
Date: Fri, 21 Dec 2007 18:02:18 -0500
Message-ID: <BAYC1-PASMTP0471A96A025F672FF637C8AE5E0@CEZ.ICE>
References: <20071221195019.GA20668@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qtA-0005pn-6j
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750AbXLUXCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbXLUXCV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:02:21 -0500
Received: from bay0-omc2-s35.bay0.hotmail.com ([65.54.246.171]:2716 "EHLO
	bay0-omc2-s35.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755995AbXLUXCU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 18:02:20 -0500
Received: from BAYC1-PASMTP04 ([65.54.191.164]) by bay0-omc2-s35.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Dec 2007 15:02:19 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 21 Dec 2007 15:02:19 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J5qsd-0004cg-Ov; Fri, 21 Dec 2007 18:02:11 -0500
In-Reply-To: <20071221195019.GA20668@old.davidb.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 21 Dec 2007 23:02:19.0489 (UTC) FILETIME=[89B52D10:01C84425]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69106>

On Fri, 21 Dec 2007 11:50:19 -0800
David Brown <git@davidb.org> wrote:

> A coworker has a branch with some large binary files (video test streams).
> Git doesn't seem to be detecting this file is binary, and is causing things
> that try to generate diffs to fail.
> 
> Specifically, he is unable to rebase his branch, getting an error:
> 
> .dotest/patch:3241:LD   := ld
> fatal: corrupt patch at line 84682
> Patch failed at 0001.
> 
> Line 84682 is in the middle of what appear to be the binary contents of the
> large media file, with pluses inserted after newline.
> 
> Any advice on where to look or possibly how to fix this?
> 
> I was able to work around the problem by cherry picking the change instead
> of using rebase.  git-format-patch generates a patch that is corrupt in the
> same way, which fails with 'git-am'.
> 

Dave,

Telling Git that the file is binary is likely all you need to do.  Something
like the following line in a .gitattributes file:

filename -diff

For more info see "man gitattributes".

HTH,
Sean
