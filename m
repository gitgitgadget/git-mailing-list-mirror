From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 15:25:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701151430170.20138@iabervon.org>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
 <20070115102727.GC12257@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 21:50:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6YOy-0001dB-OU
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 21:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXAOUZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 15:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXAOUZy
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 15:25:54 -0500
Received: from iabervon.org ([66.92.72.58]:2860 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbXAOUZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 15:25:53 -0500
Received: (qmail 22117 invoked by uid 1000); 15 Jan 2007 15:25:52 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2007 15:25:52 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115102727.GC12257@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36882>

On Mon, 15 Jan 2007, Shawn O. Pearce wrote:

> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Andy Parkins <andyparkins@gmail.com> wrote:
> > > Of course my favourite is git, but we were talking about the certificates 
> > > needed by monotone for each developer.
> 
> One problem here is a certificate does not make a security system.
> Obviously anyone can generate a certificate and claim anything they
> want within it, just the same as you can claim anything you want in
> a Git commit or tag.  What's needed is some external method that
> all interested parties trust to verify a given certificate is
> associated with a given entity.
> 
> > What I'm actually doing in one particular environment is checking
> > the committer string against a database of known committer strings
> > associated with the current UNIX uid.
> 
> In this particular case access to the UNIX system is tightly
> controlled.  Much paperwork must be filled out and signed by multiple
> people, all of whom recognize the user on sight and know why they
> need access to that system.  They also have checked the user's
> identity through multiple background checks, fingerprinting, etc.
> 
> In other words the entire authentication problem was already solved,
> trusting the UNIX uid just let Git plug into that seamlessly.
> 
> The problem is obviously harder on the Internet.  I've never
> met anyone on this mailing list in person, but the quality (or
> lack thereof sometimes) is evident in my work, and since its all
> peer-reviewed anyway Junio finds little risk in incorporating the
> good stuff into git.git.  No certificate required.

In theory, we could put certificates as blobs in the repository and 
reference them in the commit header. The names and such in the certificate 
would, of course, not be verified in any particular way, but the 
fingerprint would be an effective identity. We'd be able to tell that a 
commit was prepared by someone with access to the same certificate that 
was used to build the reputation.

If we saw certificates with different fingerprints with the same name, 
we'd know to ask what was going on, because that's suspicious.

Of course, there would be no requirement to sign commits, or to have a 
certificate, or to get anyone in particular to say anything in particular 
about a certificate. But you'd be able to create a pseudonym if you 
wanted and have cryptographicly secure access to it.

	-Daniel
*This .sig left intentionaly blank*
