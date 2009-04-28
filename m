From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Tue, 28 Apr 2009 16:53:52 -0400
Message-ID: <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 22:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyuL4-0004PD-UR
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 22:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840AbZD1Uxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756732AbZD1Uxy
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:53:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:1261 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786AbZD1Uxw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 16:53:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so447575ywb.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=PyXGM1xVSp3nAomV0SII7r75ejSdKsrJX5QzWKiMt/8=;
        b=yEUDXPi9HChPFwBPcpiEDrb584LEkiVOawGIPVyYeiukHyor+Vmqb1JP8EhHS2D+13
         gA4Wz+DRimZCojQAEY5yFT7OrXWqj1ds9JFDdBy6GZ9+z9CiSAbvv3ekrmR7N8OyiOXh
         EdQtjuHOvyC7Et3O1gUjlYzNJX5jO0WR7D7wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=TY/mMGRtNTGheOa5oLNqkVVueIJ9ovkN71UgIL1VctjRdnw1N7smJs76gUe9xveD/B
         TxIovAIYxClNjNEmvKD6zNH/8TsmKmUSTJ10vuWytQ56SVJzEXFWDGr4RcoYVOnM/jCe
         8cKl57V7QDfb97YXS47jAgydh+729zQqCJFNk=
Received: by 10.151.74.3 with SMTP id b3mr11748778ybl.1.1240952032232; Tue, 28 
	Apr 2009 13:53:52 -0700 (PDT)
In-Reply-To: <20090427201251.GC15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117810>

On Mon, Apr 27, 2009 at 4:12 PM, Josef Wolf <jw@raven.inka.de> wrote:
> I have two subversion repositories which I would like to synchronize =
via
> git-svn. =A0[...]

What you're attempting is rather complicated.  I guess I'd suggest we
back up a step: why do you want to do this?  In what way does a "pure
svn" tool like svnsync
(http://svnbook.red-bean.com/en/1.5/svn.ref.svnsync.html) not do what
you want?

Are you making changes to *both* svn repositories and then want to
synchronize their histories?  This is basically impossible, since svn
only has a linear history.  If you add commit A to one repo, and
commit B to the other, you will never make the histories identical in
both repos; one will necessarily have A and then B, and the other will
have B and then A.  That's not really desirable, since one of those
two histories is a lie.  If commit B breaks A, but it looks like A was
committed *after* B, then the person who wrote A will be blamed for
the error.

So, what is it you're *really* trying to do?

Have fun,

Avery
