From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 17:15:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
 <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
 <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>,
	"Shawn O.Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:15:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgA1-0003V5-Ug
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbXGTAPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbXGTAPy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:15:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46320 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756100AbXGTAPy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 20:15:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K0FY0J025880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 17:15:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6K0FStw030192;
	Thu, 19 Jul 2007 17:15:28 -0700
In-Reply-To: <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.193 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53040>



On Thu, 19 Jul 2007, Junio C Hamano wrote:
>
> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
> > My apologies for the wasted bandwidth arguing for things that had
> > already been decided.
> 
> Sorry, who decided what?

I think people who didn't know how the world works decided that 
directories that were added manually as directories would stay as 
directories even after the last file was removed.

That's physically impossible with the git data-structures (since there is 
no way of saving "this directory was added empty" in the tree structures, 
nor any point to it), so I think it's just insane rambling.

I dunno. I think empty directories are worth supporting, mainly to be able 
to capture other SCM's notion of what _they_ track, but quite frankly, the 
level of discussion about them hasn't been exactly inspiring. It seems to 
be more about "this is what we'd like to see, without really having a 
reason for it, nor necessarily understanding what we're talking about" 
than "this is realistic and useful and here are patches".

I *do* think that it's a very valid argument that if you import something 
from SVN that has an empty directory, the git import should show that.  

That's about the only valid argument I've ever seen for them, though, and 
I think that's totally irrelevant to such issues as to whether "git rm 
file/in/directory" should remove the directory(*) from being tracked by 
git when the file goes away or not.

			Linus
 
(*) And, for anybody confused about the issue, the answer to the latter 
question is an emphatic: "Yes it should, live with it, and if you want the 
directory back, you had better add it back as an empty directory"
