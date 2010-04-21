From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Wed, 21 Apr 2010 00:15:05 -0700
Message-ID: <20100421071505.GA11339@dcvr.yhbt.net>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com> <7vbpddekwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 09:15:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4U9n-0001FV-KA
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 09:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab0DUHPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 03:15:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40244 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab0DUHPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 03:15:08 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9F01F4ED;
	Wed, 21 Apr 2010 07:15:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vbpddekwk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145411>

Junio C Hamano <gitster@pobox.com> wrote:
> Michael Olson <mwolson@gnu.org> writes:
> 
> > [svn-remote "svn"]
> >        url = https://svn.my.org/svn/root
> > ...
> >        ignore-refs = ^refs/remotes/(tags/)?old/myorg
> 
> Traditionally configuration variable names are spelled camelCase without
> dashes.  You probably would want to be consistent.

Configuration variables should definitely be camelCase in
examples/documentation (and I even dislike camelCase).  No dashes or
underscores here.

> Also "refs" and any pathname-like things are traditionally matched using
> globs and not regexes.  It is Ok to deviate if you have a strong reason to
> (and I suspect it would make it easier to write "exclude" patterns like
> the above example to allow a regex here), but that needs to be prominently
> documented (e.g. "Unlike any other ref-matching configuration variable,
> this alone uses regex, not glob") to avoid end user confusion.

I favor globs for more consistent/natural for path matching.

Another thing to keep in mind is that these would be Perl regular
expressions exposed to a user interface.  If git-svn were ever be
reimplemented in something other than Perl, PCRE (or similar) would be
required to interpret them consistently.

-- 
Eric Wong
