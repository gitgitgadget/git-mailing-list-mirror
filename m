From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Wed, 21 Sep 2011 20:31:01 -0500
Message-ID: <20110922013101.GB26880@unpythonic.net>
References: <20110917022903.GA2445@unpythonic.net>
 <4E7467B7.1090201@gmail.com>
 <m3hb49sn26.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 03:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Y86-0002mM-SH
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 03:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab1IVBbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 21:31:06 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:54647 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750826Ab1IVBbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 21:31:04 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 10086114953; Wed, 21 Sep 2011 20:31:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <m3hb49sn26.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181872>

On Sun, Sep 18, 2011 at 11:50:30AM -0700, Jakub Narebski wrote:
> Perhaps more descriptive name, i.e.
> 
>   linkify.<name>.regexp
>   linkify.<name>.subst
> 
> would be better?
> 
> I guess that regexp is an extended regular expression, isn't it?

If "regexp" is clearer than "re" then I have no quarrel with changing
it.  The typical user won't be typing these over and over, so the value
of brevity is limited.

As written, it's whatever is accepted by tcl's regular expression
matcher, which is described in re_syntax(n), installed as
re_syntax(3tcl) on debian-derived systems.  A one-sentence summary of a
TCL "ARE" is "basically EREs with some significant extensions".

It is probably possible to write expressions that are going to work the
same in tcl, perl, and posix regular expressions, but to some extent the
user who writes a complex expression and then tries to use it with both
gitk and a future gitweb will simply be permitted to keep both pieces
when it breaks.

Is it unnecessarily complicated to design
    linkify.<name>.(regexp|subst)
*AND*
    gitk.linkify.<name>.(regexp|subst)
in from the start?  This way the hypothetical power user can write a
different version of the expression for gitk and future gitweb if it is
required by RE dialect differences.

Jeff
