From: Jeff King <peff@peff.net>
Subject: Re: format-patch: numbered patches from a patch list?
Date: Tue, 21 Jul 2009 22:44:45 -0400
Message-ID: <20090722024445.GA31254@coredump.intra.peff.net>
References: <auto-000020035874@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: tfogal@sci.utah.edu
X-From: git-owner@vger.kernel.org Wed Jul 22 04:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRp2-0008FF-10
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZGVCol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbZGVCok
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:44:40 -0400
Received: from peff.net ([208.65.91.99]:48850 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbZGVCok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:44:40 -0400
Received: (qmail 2608 invoked by uid 107); 22 Jul 2009 02:46:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Jul 2009 22:46:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jul 2009 22:44:45 -0400
Content-Disposition: inline
In-Reply-To: <auto-000020035874@sci.utah.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123735>

On Tue, Jul 21, 2009 at 08:25:52PM -0600, tom fogal wrote:

> I have a need to generate a numbered sequence of patches from a sparse
> sprinkling of patches on a branch.  Is there a way to accomplish this?
> 
> Basically I want to say, `for the patches at the heads of these sha1s,
> give me a numbered sequence.'  Currently I take the list of shas that I
> want, throw them in a file, and loop over each entry:
> 
>   for sha in $(cat patches) ; do git format-patch -o a/ ${sha}^..${sha} ; done
> 
> This is undesirable because each patch is the first patch in a series,
> e.g. "0001-...".  A desirable interface would be specifying multiple
> disconnected ranges via some separator, say ",".

Try

  git format-patch --no-walk $(cat patches)

-Peff
