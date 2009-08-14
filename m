From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 2/3] fast-import: add option command
Date: Fri, 14 Aug 2009 10:39:29 -0700
Message-ID: <20090814173929.GU1033@spearce.org>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com> <1250190156-4752-2-git-send-email-srabbelier@gmail.com> <1250190156-4752-3-git-send-email-srabbelier@gmail.com> <20090814153707.GT1033@spearce.org> <fabb9a1e0908140937h32a2eac7ka88f76aa417fd631@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc0kb-0006Uu-93
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 19:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbZHNRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 13:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756501AbZHNRj2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 13:39:28 -0400
Received: from george.spearce.org ([209.20.77.23]:44321 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbZHNRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 13:39:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 55438381FD; Fri, 14 Aug 2009 17:39:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908140937h32a2eac7ka88f76aa417fd631@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125938>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Aug 14, 2009 at 08:37, Shawn O. Pearce<spearce@spearce.org> wrote:
> > Sverre Rabbelier <srabbelier@gmail.com> wrote:
> >> +`option`
> >> +~~~~~~~~
> >> +Processes the specified option so that git fast-import behaves in a
> >> +way that suits the frontend's needs.
> >> +Note that options specified by the frontend are overridden by any
> >> +options the user may specify to git fast-import itself.
> >
> > Wha? ?This disagrees with the code.
> 
> It does? It's saying that the user my override what the frontend
> specifies, which is what the current version does.

Sorry, lack of caffeine.  Rereading the docs makes sense.
 
> >> + ? ? if (!seen_non_option_command)
> >> + ? ? ? ? ? ? parse_argv();
> >
> > This is too late.
> 
> No it's not. Earlier in the patch, at the other
> 'seen_non_option_command', we call parse_argv() as well (which happens
> when a non-option command is issued). This statement is here to deal
> with options that affect an empty stream, such as 'git format-patch
> --import-marks=marks.old --export-marks=marks.new < /dev/null &&
> test_cmp marks.old marks.new'.

Oy, I missed that call.  I looked for it but gave up too soon I guess.
 
> > So yea, I really do think its a good idea for command line options
> > to override stream options, despite what Dscho may think. ?:-)
> 
> Which is what the current version does, yes?

Yes.  :-)

-- 
Shawn.
