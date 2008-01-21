From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:44:49 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org>
 <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
 <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH6Kz-0005ks-Bx
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbYAUXpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYAUXpH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:45:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45719 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845AbYAUXpF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 18:45:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LNipdF002373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 15:44:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LNinHT026257;
	Mon, 21 Jan 2008 15:44:49 -0800
In-Reply-To: <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71374>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> I find it amusing that you keep arguing against having git treat filenames as
> unicode when

NO I DO NOT!

Dammit, stop this idiocy.

I think it's fine having git treat filenames "as unicode", as long as you 
don't do any munging on it.

Why? Because if it's utf-8, then treating them "as unicode" means exactly 
the same as treating them "as a user-specified string".

So stop lying about this whole thing. I have never *ever* argued against 
unicode per se.

All my complaints - every single one of them - comes down to making the 
idiotic choice of trying to munge those strings (not even strictly 
"normalize") into something they are not.

And what you don't seem to understand is that once you accept _unmodified_ 
raw UTF-8 as a good unicode transport mechanism, suddenly other encodings 
are possible. I'm not out to force my world-view on users. If they are 
using legacy encodings (whether in filenames *or* in commit texts or in 
their file contents), that's *their* choice.

I actually personally happen to use UTF-8-encoded unicode.

I'm just not stupid enough to think that (a) corrupting it is a good idea, 
*or* (b) that I should force every Asian installation of git to also force 
people to use unicode (or even having all the conversion libraries and 
overheads!)

So stop this idiotic "unicode == normalization" crap. 

I'm a huge fan of UTF-8. But that does not mean that I think normalization 
is a good idea.

		Linus
