From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Sun, 21 Jun 2009 07:15:36 +0200
Message-ID: <200906210715.36965.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <m3ab43gsrm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 07:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIFOz-0004Hc-0Y
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 07:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbZFUFP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 01:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZFUFP0
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 01:15:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54251 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbZFUFPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 01:15:25 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 38FA481805F;
	Sun, 21 Jun 2009 07:15:19 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 550208180BA;
	Sun, 21 Jun 2009 07:15:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <m3ab43gsrm.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121964>

On Saturday 20 June 2009, Jakub Narebski wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Subject: [PATCH 2/2] rebase -i: use some kind of config file to save
> > author information
>
> Errr... "kind of" config file?  I'd say use config file format for
> saving author information.

Ok, I changed this in the patch series I just sent.

> > This is better than saving in a shell script, because it will make
> > it much easier to port "rebase -i" to C. This also removes some sed
> > regexps and some "eval"s.
>
> Would it?  Well, I guess that at least we will avoid problems with
> shell quoting and shell variable expansion rules.

Yeah.

> > +load_author_ident () {
> > +	GIT_AUTHOR_NAME=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> > +		git config rebase.author.name) &&
> > +	GIT_AUTHOR_EMAIL=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> > +		git config rebase.author.mail) &&
> > +	GIT_AUTHOR_DATE=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> > +		git config rebase.author.date)
> >  }
>
> Why not use --file=<filename> option of git-config instead?

That's a good idea. I changed that too.

Thanks,
Christian.
