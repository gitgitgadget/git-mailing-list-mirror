From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 19:11:54 +0100
Message-ID: <20130627181154.GC2232@serenity.lan>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
 <7vzjubtty7.fsf@alter.siamese.dyndns.org>
 <CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
 <7v8v1vtqfa.fsf@alter.siamese.dyndns.org>
 <CAEBDL5VL+C7yKMBq1g4vSrSSsvrKE+FCeoS66mkWQqJJvf0sWA@mail.gmail.com>
 <7vmwqbsa3u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 20:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsGg5-0007Sa-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab3F0SMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 14:12:12 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50234 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3F0SML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 14:12:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 45F26CDA5B9;
	Thu, 27 Jun 2013 19:12:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcFNHAqQiuPv; Thu, 27 Jun 2013 19:12:07 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 16AA5CDA560;
	Thu, 27 Jun 2013 19:11:56 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vmwqbsa3u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229140>

On Thu, Jun 27, 2013 at 11:05:09AM -0700, Junio C Hamano wrote:
> John Szakmeister <john@szakmeister.net> writes:
> 
> > On Thu, Jun 27, 2013 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > [snip]
> >>> diff --git a/git-am.sh b/git-am.sh
> >>> index 9f44509..ad67194 100755
> >>> --- a/git-am.sh
> >>> +++ b/git-am.sh
> >>> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
> >>>  u,utf8          recode into utf8 (default)
> >>>  k,keep          pass -k flag to git-mailinfo
> >>>  keep-non-patch  pass -b flag to git-mailinfo
> >>> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
> >>> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
> >>> independent of am.keepcr
> >>> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
> >>> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
> >>> independent of am.keepcr
> >>>  c,scissors      strip everything before a scissors line
> >>>  whitespace=     pass it through git-apply
> >>>  ignore-space-change pass it through git-apply
> >>
> >>> As you were saying yourself, we tell users to prefer the "git foo"
> >>> form, so we should also do so in the "git am" option help, IMHO.
> >>
> >> What does the above change to the options-help have anything to do
> >> with that theme?  It does not seem to say anything about "git foo"
> >> vs "git-foo"?
> >
> > I initially missed it too, but `git-mailsplit` changed to `git
> > mailsplit` in the help.
> 
> Ahh, OK.

That is rendered differently though, I don't think just having the plain
text git command is as useful.  It should either use the hyphenated form
or enclose the text in quotes.
