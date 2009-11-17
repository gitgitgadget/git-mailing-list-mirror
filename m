From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Tue, 17 Nov 2009 08:49:30 +0100
Message-ID: <20091117074930.GB11636@glandium.org>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 <20091117073426.GB4007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIpN-0008Mo-LI
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbZKQHuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbZKQHuE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:50:04 -0500
Received: from vuizook.err.no ([85.19.221.46]:53415 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbZKQHuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:50:04 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NAIp1-0006y4-Ob; Tue, 17 Nov 2009 08:49:58 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1NAIoc-000339-74; Tue, 17 Nov 2009 08:49:30 +0100
Content-Disposition: inline
In-Reply-To: <20091117073426.GB4007@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133075>

On Tue, Nov 17, 2009 at 02:34:26AM -0500, Jeff King wrote:
> Maybe:
> 
>   A leading path component of "~user" is expanded to the home directory
>   of "user"; "~" is expanded to the home directory of the user running
>   git.
> 
> would be more clear?

Add "real" before "user running git" and you have my vote. Or maybe
using the effective user would be better, and the patch should use
geteuid() instead of getuid(), I don't know. ident.c uses getuid(), but
I'm wondering if that's what it should use (although it doesn't seem to
have been a problem to anyone)

Mike
