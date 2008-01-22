From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 18:50:24 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org>
 <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
 <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati! on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 03:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9EE-0006xK-Oq
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 03:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYAVCug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 21:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbYAVCug
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 21:50:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54250 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761AbYAVCuf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 21:50:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M2oPou012926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 18:50:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M2oOaU000699;
	Mon, 21 Jan 2008 18:50:24 -0800
In-Reply-To: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71404>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> Anyway, please see my countless former emails where I ask to work towards a
> solution instead of just arguing.

We know what the solution is:

 - The OS X filesystem _is_ crap (and you seem to have almost admitted as 
   much by your comment that the HFS+ designers did it back in the dark 
   ages and didn't mean for it to ever be a server filesystem anyway)

 - But we can at least make a wrapper around readdir() return the NFC form 
   on OS X, and effectively hide much of the fallout from the crap.

There is no way around it. Your "solutions" all seem to boil down to 
asking git to do the same idiotic crap that OS X does, taking all the 
same performance hits, and just generally doing crap just to work around 
crap in your favourite OS.

And no, making git be stupid just to suit a stupid filesystem simply isn't 
going to happen.

So how about you see _my_ point instead: OS X may have an inferior 
filesystem, but we don't have to make git inferior just for that. The fact 
that OS X does case independence is *its* problem, not git's.

		Linus
