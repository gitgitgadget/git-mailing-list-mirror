From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 17:01:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
 <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.!
 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org>
 <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7X6-0000sB-1t
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbYAVBBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756932AbYAVBBf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:01:35 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58352 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754699AbYAVBBe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:01:34 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M11LYo007441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 17:01:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M11LIn029014;
	Mon, 21 Jan 2008 17:01:21 -0800
In-Reply-To: <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71383>



On Mon, 21 Jan 2008, Kevin Ballard wrote:

> > I think it's fine having git treat filenames "as unicode", as long as you
> > don't do any munging on it.
> 
> When I say "treat filenames as unicode" I'm implying the equivalence
> comparisons and everything else that we've been talking about.

Yes, because you're an idiot.

I've told you over and over again that equivalence is stupid.

It's stupid when it's "equivalent except for case", and it's stupid when 
it's "canonically equivalent".

> No, you've argued against unicode equivalency in filenames. Can't you figure
> out, when the entire time I've been talking about equivalency, that I'm
> *still* talking about equivalency?

I agree: normalization and equivalency is idiotic.

But the two actually go hand in hand:

> > All my complaints - every single one of them - comes down to making the
> > idiotic choice of trying to munge those strings (not even strictly
> > "normalize") into something they are not.
> 
> Yes, I understand quite well that you are against munging strings.

You don't seem to.

The thing is, the two are inexorably intertwined. Any filename equivalence 
(except for the trivial "identity" equivalence) INVARIABLY means that 
filenames get munged.

Why?

Think about the file name "Abc", and think about what happens when you 
create it.

Now, think about what happens if that filename is considered equivalent in 
case..

See? The filesystem has to *corrupt* the filename.

Can you not UNDERSTAND this? Equivalence and normalization is STUPID. It's 
just two sides of the exact same coin. They both INVARIABLY cause the 
filename to be munged.

And changing user data is not acceptable.

Do you get it now?

			Linus "probably not" Torvalds
