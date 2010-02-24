From: Jeff King <peff@peff.net>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 01:36:06 -0500
Message-ID: <20100224063606.GB12796@coredump.intra.peff.net>
References: <loom.20100224T043557-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley3@juno.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 07:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkAr2-0004oe-1C
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 07:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab0BXGgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 01:36:09 -0500
Received: from peff.net ([208.65.91.99]:50767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab0BXGgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 01:36:08 -0500
Received: (qmail 29947 invoked by uid 107); 24 Feb 2010 06:36:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 01:36:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2010 01:36:06 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100224T043557-954@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140904>

On Wed, Feb 24, 2010 at 03:46:37AM +0000, Dale Rowley wrote:

> Steps to reproduce:
> 
> git clone /path/to/some/repo
> cd repo
> git config --unset branch.master.remote
> git push
> (seg fault)
> 
> I'm using version 1.7.0.

I can't reproduce here, using the following script:

-- >8 --
#!/bin/sh

rm -rf parent child

mkdir parent && (
  cd parent &&
  git init
) &&
git clone parent child &&
cd child &&
git config --unset branch.master.remote &&
git push
-- 8< --

Does that trigger the problem for you? If not, can you show what is
different between your earlier reproduction recipe and this one?

-Peff
