From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Documentation/notes: describe content of notes
Date: Tue, 4 May 2010 23:23:10 -0400
Message-ID: <20100505032310.GA8779@coredump.intra.peff.net>
References: <20100503233604.GA27451@progeny.tock>
 <20100503234229.GC27483@progeny.tock>
 <201005041155.02192.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 05 05:23:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9VCj-0002O3-LM
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 05:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065Ab0EEDXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 23:23:16 -0400
Received: from peff.net ([208.65.91.99]:39099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757386Ab0EEDXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 23:23:16 -0400
Received: (qmail 18276 invoked by uid 107); 5 May 2010 03:23:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 23:23:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 23:23:10 -0400
Content-Disposition: inline
In-Reply-To: <201005041155.02192.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146366>

On Tue, May 04, 2010 at 11:55:01AM +0200, Johan Herland wrote:

> On Tuesday 04 May 2010, Jonathan Nieder wrote:
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
> >  Documentation/git-notes.txt |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > index 0594776..273264b 100644
> > --- a/Documentation/git-notes.txt
> > +++ b/Documentation/git-notes.txt
> > @@ -27,6 +27,10 @@ By default, notes are saved to and read from
> > `refs/notes/commits`, but this default can be overridden.  See the
> > CONFIGURATION and ENVIRONMENT sections below.
> > 
> > +Notes can contain any sequence of non-null bytes.  Since they are
> > +sanitized with linkgit:git-stripspace[1], empty lines other than a
> > +single line separating paragraphs are not significant.
> 
> In principle, a note is a regular Git (blob) object, and can contain NUL 
> bytes - indeed any kind of (non-)format is accepted.
> 
> However, the stripspace/text-based formatting kicks in when specifying the 
> notes content with -m or -F, or when an editor is used to edit the notes.

The textconv-cache notes contain whatever the textconv filter produces,
so they are a likely way of getting non-standard characters. In
practice, though, you will probably not see NULL, because the point was
to generate a _text_ version.

-Peff
