From: Theodore Tso <tytso@mit.edu>
Subject: Re: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 07:32:07 -0400
Message-ID: <20071014113206.GB17368@thunk.org>
References: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org> <ee77f5c20710140403j7a88ffa4q579a8c4118d8fd71@mail.gmail.com> <20071014110714.GA17368@thunk.org> <ee77f5c20710140412s1eb68991ke552995dbbd226b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih1i7-0002lh-B8
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 13:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbXJNLcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 07:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbXJNLcd
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 07:32:33 -0400
Received: from thunk.org ([69.25.196.29]:47189 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007AbXJNLcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 07:32:32 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ih1ri-0002VR-OO; Sun, 14 Oct 2007 07:42:39 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ih1hh-00059y-Pu; Sun, 14 Oct 2007 07:32:18 -0400
Content-Disposition: inline
In-Reply-To: <ee77f5c20710140412s1eb68991ke552995dbbd226b@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60831>

On Sun, Oct 14, 2007 at 09:12:43PM +1000, David Symonds wrote:
> On 14/10/2007, Theodore Tso <tytso@mit.edu> wrote:
> > On Sun, Oct 14, 2007 at 09:03:48PM +1000, David Symonds wrote:
> > > git push <remote> :<branch_name>
> > >
> > > If the left side of the colon in a push refspec is empty, it deletes
> > > the remote ref given by the right hand side.
> >
> > Cool, thanks!  It's not in the git-push man page.  I'll play with it
> > some and then submit a patch update the man page.
> 
> Yes, it is, including in the examples section. 

Wow, I completely missed that!  It would be nice if:

       <refspec>
          The canonical format of a <refspec> parameter is +?<src>:<dst>; that
          is, an optional plus +, followed by the source ref, followed by a
          colon :, followed by the destination ref.

.... mentioned that the source ref could be optional (just like it
explicitly says the '+' is optional)...

          The <src> side can be an arbitrary "SHA1 expression" that can be
          used as an argument to git-cat-file -t. E.g. master~4 (push four
          parents before the current master head).

.... and I think the throwaway sentence at the end of the refspec
would be better at the end of the second paragraph above.  I'll send a
patch.

Thanks for pointing that out!

       	      	     	 		  - Ted
