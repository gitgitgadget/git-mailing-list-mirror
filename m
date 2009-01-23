From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 22:55:59 +0100
Organization: glandium.org
Message-ID: <20090123215559.GA5561@glandium.org>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQU1s-0002Ip-Vu
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbZAWV4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZAWV4J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:56:09 -0500
Received: from vuizook.err.no ([85.19.221.46]:46602 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688AbZAWV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:56:08 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LQU0O-0006AN-Et; Fri, 23 Jan 2009 22:56:03 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LQU0N-0003Vc-EF; Fri, 23 Jan 2009 22:55:59 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106921>

On Fri, Jan 23, 2009 at 03:42:24AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 23 Jan 2009, Sverre Rabbelier wrote:
> 
> > On Fri, Jan 23, 2009 at 02:24, Junio C Hamano <gitster@pobox.com> wrote:
> > > I think the basic idea is Ok, but is it a reliable check at this point to
> > > see if (refs == NULL) to tell if the target repository is an empty one?
> > 
> > This is the question I asked Dscho, and he said/guessed that it was.
> > 
> > > I am mostly worried about a failure case (connected but couldn't get 
> > > the refs, or perhaps connection failed to start).  If you get a NULL 
> > > in such a case you may end up saying "oh you cloned a void" when you 
> > > should say "nah, such a remote repository does not exist".
> > 
> > Yes, this was my concern as well.
> 
> From what I can see in get_remote_heads(), the native protocols would 
> die(), as would rsync().
> 
> HTTP transport, however, would not die() on connection errors, from my 
> cursory look.
> 
> That might be skewed, though, as I am on top of Mike's patches (in the 
> hopefully not so futile hope that Mike -- after letting me wait for over 
> one year -- finishes his work.

As I said when posting my patch batch, I don't have much time nor
motivation to work on this series. But let's make a deal: if someone
writes a good enough http test suite, I'll polish the http code.

Mike
