From: Jeff King <peff@peff.net>
Subject: Re: t5505-remote fails on Windows
Date: Thu, 19 Mar 2009 01:03:28 -0400
Message-ID: <20090319050328.GA9746@coredump.intra.peff.net>
References: <49C0DE23.8020809@viscovery.net> <20090319041837.GA32642@coredump.intra.peff.net> <20090319044313.GA341@coredump.intra.peff.net> <76718490903182156y3b2b9d8aw708829a6ed151aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 06:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkARH-0001VJ-Lk
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 06:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbZCSFDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 01:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZCSFDi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 01:03:38 -0400
Received: from peff.net ([208.65.91.99]:60907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbZCSFDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 01:03:38 -0400
Received: (qmail 29704 invoked by uid 107); 19 Mar 2009 05:03:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 01:03:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 01:03:28 -0400
Content-Disposition: inline
In-Reply-To: <76718490903182156y3b2b9d8aw708829a6ed151aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113716>

On Thu, Mar 19, 2009 at 12:56:37AM -0400, Jay Soffian wrote:

> > As a side note, I find this solution a little bit ugly. String lists
> > should sort on their strings, not on some other random magic in the util
> > field. This usage really abuses string_list a bit as a data type because
> > we have no generic "list" type.
> 
> I really don't think so. The string_list API accommodates this case
> quite nicely. So why not?

I think the code would be more natural as a list of structs, each with a
source and dest. But C does not make it pleasant to write generic data
types, so things end up stuffed into string_lists with a magic util
field. So I think leaving it as a string_list is probably the most sane
thing to do.

-Peff
