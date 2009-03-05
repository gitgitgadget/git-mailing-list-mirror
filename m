From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Thu, 5 Mar 2009 16:11:20 -0500
Message-ID: <20090305211120.GB20157@coredump.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org> <20090305104304.GA17760@coredump.intra.peff.net> <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKsC-00004q-Er
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 22:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZCEVL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 16:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZCEVL1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 16:11:27 -0500
Received: from peff.net ([208.65.91.99]:42154 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbZCEVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 16:11:26 -0500
Received: (qmail 3289 invoked by uid 107); 5 Mar 2009 21:11:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 16:11:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 16:11:20 -0500
Content-Disposition: inline
In-Reply-To: <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112346>

On Thu, Mar 05, 2009 at 04:04:44PM -0500, Jay Soffian wrote:

> > This makes the interface simpler to understand: --date remains a
> > selector, and --date=local is a special case that new people don't need
> > to think about or understand.
> 
> I started to pick this up and I want to clarify what you meant by
> interface. Was it the CLI you had an issue with? Because that I
> understand and it's easy to support the CLI changes you outline above.

I meant the CLI.

> Or did you have a problem with how Junio was going about passing along
> both bits (i.e. 1. date format; 2. local or not) in an enum? Because I
> have to tell you, I started looking at what it would take to switch
> the enum to something like:

I find that a bit confusing, too, but at least it is not something users
see. So I don't feel as strongly about it.

> struct date_mode {
> 	enum {
> 		DATE_NORMAL = 0,
> 		DATE_RELATIVE,
> 		DATE_SHORT,
> 		DATE_ISO8601,
> 		DATE_RFC2822,
> 		DATE_RAW
> 	} format;
> 	unsigned int local;
> };
> 
> It's a significantly more invasive change.

Yep, it is more invasive. But I consider it more maintainable in the
long run.

-Peff
