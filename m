From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
Date: Thu, 24 Sep 2009 02:11:14 -0400
Message-ID: <20090924061114.GB24694@coredump.intra.peff.net>
References: <20090923182756.GA12430@onyx.camk.edu.pl>
 <20090923191428.GA30104@coredump.intra.peff.net>
 <4ABB0ACF.5040508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhXt-0001E9-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 08:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZIXGLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 02:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZIXGLE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 02:11:04 -0400
Received: from peff.net ([208.65.91.99]:44412 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbZIXGLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 02:11:04 -0400
Received: (qmail 3058 invoked by uid 107); 24 Sep 2009 06:14:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 02:14:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 02:11:14 -0400
Content-Disposition: inline
In-Reply-To: <4ABB0ACF.5040508@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129022>

On Thu, Sep 24, 2009 at 07:59:43AM +0200, Johannes Sixt wrote:

> Jeff King schrieb:
> > Bug. The script does a chdir() and then looks at the cvspsfile later. I
> > think "-A" would have the same problem. Here is a totally untested patch
> > to address the issue. Johannes, will this is_absolute_path actually work
> > on Windows? I think The Right Way would be to use
> > File::Spec::file_name_is_absolute, but I haven't checked whether that is
> > part of core perl and if so, which version it appeared in.
> 
> We have File::Spec::file_name_is_absolute in the msysgit installation. I
> suggest you use it. It sounds like a very basic feature, and I'd be
> surprised if it were not part of core perl.

Looks like File::Spec at least goes back to perl 5.004, and we are
already using it. I'll assume file_name_is_absolute has been there a
while, then. Thanks.

-Peff
