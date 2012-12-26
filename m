From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: generating format-patch options from an e-mail
Date: Wed, 26 Dec 2012 22:07:37 +0100
Message-ID: <20121226210737.GB20704@xs4all.nl>
References: <20121226200623.GA29446@simaj.xs4all.nl>
 <7vbodgo8kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 22:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnyCz-0001RO-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 22:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983Ab2LZVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 16:07:54 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4808 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2LZVHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 16:07:53 -0500
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBQL7gjl080961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Dec 2012 22:07:46 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qBQL7d0I022966;
	Wed, 26 Dec 2012 22:07:39 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qBQL7baK022960;
	Wed, 26 Dec 2012 22:07:37 +0100
Content-Disposition: inline
In-Reply-To: <7vbodgo8kv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212154>

* Junio C Hamano <gitster@pobox.com> [2012-12-26 12:35:28 -0800]:
> >
> > Anyway, I could imagine this as optional flag of git format-patch, so you could say:
> > $ git format-patch -s --in-reply-to-email <mboxfile> a7fe7de8
> >
> > But I'll save that as an exercise for the reader (or the future)
> 
> I think a much more general approach would be to turn your script
> into "get-msg-id" script and use it like so:
> 
>   $ git format-patch --in-reply-to $(get-msg-id <mboxfile>) a7fe7de8
> 
> Then you can reuse that script in a context outside format-patch,
> whereever you need the message-id in a single message in the
> mailbox.
> 

That would work for the message-ID, but not for the various To: and Cc: addresses.

The hacky script that I sent afterwards produces a string with the various options to git format-patch (--to --cc --in-reply-to) based on the headers To:/Cc:/From:/Message-ID:

Cheers

Simon
