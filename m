From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.cgi: Teach tree->raw to not require the hash of the blob
Date: Wed, 12 Jul 2006 10:52:20 -0700 (PDT)
Message-ID: <20060712175220.73131.qmail@web31813.mail.mud.yahoo.com>
References: <7v64i31h6f.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 19:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0isr-0006nr-P5
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWGLRwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGLRwW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 13:52:22 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:32645 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932188AbWGLRwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 13:52:21 -0400
Received: (qmail 73133 invoked by uid 60001); 12 Jul 2006 17:52:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iIstfaSd9TLO77GxlG46OvH5X7CeLQr6OHGYPrY4sak6YBJ0UJBcAM5lAIDbdvZbibSz0EDcx7dighgTXTevBod0gP/DL+yWcrNTDWBAl087uuzMa2C+fC/67V54Jo4WduyjPkJiUAjRNKhTqojRT1LfnT3WFXozrzvLgYm5sw4=  ;
Received: from [68.186.50.195] by web31813.mail.mud.yahoo.com via HTTP; Wed, 12 Jul 2006 10:52:20 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64i31h6f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23793>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Teach tree->raw to not require the hash of the blob, but to
> > figure it out from the file name.  This allows to externally
> > link to files into the repository, such that the hash is not
> > required.  I.e. the file obtained would be as of the HEAD
> > commit.
> >
> > In contrast tree->blob for binary files passes the hash, as
> > does tree->blob->plain for "text/*" files.
> >
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> > ---
> >  gitweb/gitweb.cgi |   20 ++++++++++++++++----
> >  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> This has exactly the same line number problem.
[cut]
> Hand-applied, tried, got confused and dropped.

I'll regenerate and send it to the list.

> I think _allowing_ to accept filename not hash is a sane change,
> and would be useful if you want to allow linking to always the
> HEAD version from external sites,

Indeed, it is useful.

> but I do not think listing the
> raw link in the tree view without the hash is a good idea.  It
> makes things quite confusing that "blob" link in its
> neighbourhood gives the blob from that specific version, but
> "raw" gives the version from HEAD, even when you are browsing
> something other than HEAD.

I just thought it to be an easy place to put the "raw"-no-hash
link.

BTW, Junio, it would be a shame to lose this capability.  How
would you like to proceed with this?  Where would you like to
see this kind of link go?

> BTW, can somebody volunteer to be a gitweb/ "subsystem
> maintainer"?

Make sure you pick someone liberal without personal aspirations
or turning it into a personal crusade.  Service to the community
(not self, or company XYZ) is best.

    Luben
