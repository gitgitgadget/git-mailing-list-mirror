From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] README and ChangeLog files
Date: Thu, 21 Aug 2008 08:35:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808210830080.3487@nehalem.linux-foundation.org>
References: <48AC5972.80908@zytor.com> <20080820182636.GJ8318@parisc-linux.org> <48AC6839.7050605@zytor.com> <1219264114.7576.1121.camel@calx> <20080820210733.GA418@smurf.noris.de> <20080820223033.GD18947@flint.arm.linux.org.uk>
 <alpine.LFD.1.10.0808201552070.3487@nehalem.linux-foundation.org> <57C9024A16AD2D4C97DC78E552063EA309E70713@orsmsx505.amr.corp.intel.com> <20080820232332.GE18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201629590.3487@nehalem.linux-foundation.org>
 <m163pv59lo.fsf@frodo.ebiederm.org> <48AD03BD.9000909@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	"Luck, Tony" <tony.luck@intel.com>,
	"users@kernel.org" <users@kernel.org>,
	Matt Mackall <mpm@selenic.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 17:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWCE7-0004ES-OO
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYHUPgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbYHUPga
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:36:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38110 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977AbYHUPga (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2008 11:36:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7LFZrS8016191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 08:35:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7LFZqYW011800;
	Thu, 21 Aug 2008 08:35:53 -0700
In-Reply-To: <48AD03BD.9000909@zytor.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93167>



On Wed, 20 Aug 2008, H. Peter Anvin wrote:
> 
> Personally, I think this grand renaming was a huge step backwards; an attempt
> to be bug-compatible with other SCMs.  The only people I personally ever saw
> complaining about the situation in the first place were people who were
> fanbois of some other SCM.

Heh. It's true that the push came from people who were used to the "scm 
xyz" model, but it's also true that git basically made the situation in 
/usb/bin even worse. 

You _can_ actually have the "best of both worlds" (if you really do want 
to continue the "git-xyzzy" usage) by doing

	PATH=$PATH:$(git --exec-path)

although there has been noise about removing the built-in commands 
entirely even from there. I'm cc'ing the git mailing list just to bring 
the point up - I'm the one who actually championed removing the 
"unnecessary" hardlinks, and it seems that nto doing so was the right 
choice.

One of the reasons that the dashed format is being removed is a real 
technical one, though: git aliases. They never supported the dashed 
format, since they never were real executables (that's the whole point of 
an alias, after all).

So even with the above path thing, you'll still have to use the spacey 
version for any aliases you use.

			Linus
