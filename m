From: Jeff King <peff@peff.net>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 13:44:29 -0500
Message-ID: <20090211184429.GA27896@coredump.intra.peff.net>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com> <20090211180559.GC19749@coredump.intra.peff.net> <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK6A-00079q-Rh
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbZBKSoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbZBKSoc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:44:32 -0500
Received: from peff.net ([208.65.91.99]:40485 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbZBKSob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:44:31 -0500
Received: (qmail 32741 invoked by uid 107); 11 Feb 2009 18:44:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 13:44:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 13:44:29 -0500
Content-Disposition: inline
In-Reply-To: <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109498>

On Wed, Feb 11, 2009 at 08:42:25PM +0200, Ciprian Dorin, Craciun wrote:

>     For now I see that the problem comes from the function
> setup_git_directory_gentry which I call inside the setup_path function
> in exec_cmd.c

I think you probably end up calling setup_git_directory_gently twice,
which is known to have weird interactions.

-Peff
