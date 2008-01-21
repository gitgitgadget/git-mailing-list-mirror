From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 13:33:52 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211323120.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
 <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
 <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4IO-0004nM-4v
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYAUVei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYAUVei
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:34:38 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55307 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbYAUVeh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:34:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLXr24026962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 13:33:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLXqZD020996;
	Mon, 21 Jan 2008 13:33:52 -0800
In-Reply-To: <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71348>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> I'm not sure what you mean. I stated a fact - at least on OS X, the filename
> does not contribute to the listed filesize, so changing the encoding of the
> filename doesn't change the filesize. This isn't a philosophical point, it's a
> factual statement.

And my point was that your *whole* argument boils down to "normalization 
is invisible".

When it isn't. It's not invisible for filenames, it's not invisible for 
file contents.

You're trying to claim that normalization cannot matter. I'm just pointing 
out that it sure as hell can. Exactly because lots of things don't 
actually look at data other than as just a Unicode string. They do look at 
the raw format.

And that's true both of file contents and file names.

> I don't, but I do think this discussion revolves around filenames, therefore
> it should not surprise you when I talk about filenames.

I'm surprised that you make generalized sweeping statements about how it's 
ok to normalize because normalization is "invisible", and then when I 
point out that that isn't true, you try to limit it.

And no, that normalization is not invisible EVEN IN FILENAMES. If it was, 
git wouldn't ever have noticed it, would it?

> > And git tries to be a general data tool, not a Unicode-specific one.
> 
> Yes, I realize that. See my previous message about discussing ideal vs
> practicality.

I don't know which argument you're talking about. Git (and, btw, Linux) 
does the "ideal" thing (don't screw up peoples data), and it turns out to 
be the "practical" thing too (it can handle a wider range of cases than OS 
X can).

So no, this is not "ideal" vs "practical". They aren't in any conflict 
here.

> I could argue against this, but frankly, I'm really tired of arguing this same
> point. I suggest we simply agree to disagree, and move on to actually fixing
> the problem.

.. and people have even suggested how. Hide the idiotic OS X choices by 
making a OS X-specific wrapper around readdir() that turns it into NFC.

That's just about the best we can do. We can't *fix* the thing that OS X 
loses information, but a least we can then show the lost information in 
the same form it _probably_ was in originally.

But no, it won't "fix" git on OS X. 

			Linus
