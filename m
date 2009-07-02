From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported as binaries
Date: Thu, 02 Jul 2009 04:59:04 -0700 (PDT)
Message-ID: <m34otvwb24.fsf@localhost.localdomain>
References: <200907011208.35397.fenglich@fastmail.fm>
	<20090702053534.GA13255@sigio.peff.net>
	<200907021014.06540.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKwd-00006s-CU
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbZGBL7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 07:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbZGBL7F
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:59:05 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:43238 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZGBL7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 07:59:03 -0400
Received: by fxm18 with SMTP id 18so1431716fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OJbhwRfF2s484c8n5aoBjjdC8SGK0vkeDZATRtUJ4OQ=;
        b=m1cd7RqUlSl6iCmfGGs0IVsc1IjJHKm/cQJwc4NU6LQ0Sze+ZQXBoWLmHlshjLS37J
         96L06bhlf3AJkF9sAVVJqsYi73amxTjXHZyRfBOnVmsEdyfCrv4BjqNl9hjp0kiTKicK
         qugpSpJvvvuzSzJnHu7MoLlZ8JE4C45bsiWaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cSgjhj22doNs+Tu73f8YWFlOYEaSxEmgtlsUKotIYkvR1cQihd1/sKOSmb7NQt8bfh
         3aSyWIN0XLvLf0nATvOsm9o3OPHTaMdvTgLsOcuIcAmmTTp7oQoIXNlYdnBtj8Wnabsz
         XgFcv5FmdJLeUDwe6bW9QuTeb7q+zUQ2B4Z14=
Received: by 10.103.213.19 with SMTP id p19mr3614697muq.135.1246535945526;
        Thu, 02 Jul 2009 04:59:05 -0700 (PDT)
Received: from localhost.localdomain (abwc128.neoplus.adsl.tpnet.pl [83.8.226.128])
        by mx.google.com with ESMTPS id u26sm9086333mug.22.2009.07.02.04.59.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 04:59:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n62Bx2Sx029939;
	Thu, 2 Jul 2009 13:59:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n62BwxgT029935;
	Thu, 2 Jul 2009 13:58:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200907021014.06540.fenglich@fastmail.fm>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122638>

Frans Englich <fenglich@fastmail.fm> writes:
> On Thursday 02 July 2009 07:35:34 Jeff King wrote:
> > On Wed, Jul 01, 2009 at 12:08:35PM +0200, Frans Englich wrote:

> > > Applying -diff Unset to a file using .gittattributes causes "git diff"
> > > to state that the file is a binary even though it isn't, or have been
> > > instructed to be treated as one. See attached script for reproducing.
> >
> > I think you are a little confused by the syntax. Each line of the
> > gitattributes file has a filename pattern and a set of attributes. Each
> > attribute is either set, unset, set to a value, or unspecified. For your
> > example (file.txt and the "diff" attribute), they look like:
> 
> Perhaps that should be considered another bug; that invalid syntax is 
> accepted, instead of being communicated to the user.

This is not a bug, this is a feature.  

You can add extra attributes which are unknown to Git (like "Unset"),
just like you can add config variables in $GIT_DIR/config file which
are unknown to Git, to be used by some wrapper, tool or porcelain.  An
example for unknown config variables is e.g. stgit.sender or
stgit.editor (for StGIT patch management interface).
 
> [...]
> > So as far as I can see, git is behaving exactly as it is supposed to.
> > Maybe you can be more specific about what effect you were trying to
> > achieve by setting gitattributes in the first place?
> 
> To exclude it in diffs, such as from `git show`. Take the case where
> you have a grammar file for a parser and generate a source file from
> it(or any similar scenario); the diff for the generated source file
> is not of interest and is just noisy when read as part of a
> patch. This applies to all kinds of generated files. However, this
> doesn't mean that the file should be treated as a binary, and what
> practicalities that implies.
> 
> If -diff affects whether a file is treated as a binary, as opposed
> whether it's diff'ed, it would imo make sense to call it -binary.

Actually there exists already "binary" gitattribute, or to be more
exact "binary" built-in attribute macro.  "binary" means "-diff -crlf",
as you can see at the bottom of gitattributes(5) manpage.

The message "Binary files differ" is taken from GNU diff, I think.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
