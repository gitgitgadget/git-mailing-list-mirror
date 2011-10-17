From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 0/7] Provide API to invalidate refs cache
Date: Mon, 17 Oct 2011 20:47:08 +0200
Message-ID: <20111017184708.GB2540@sandbox-rc>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 17 20:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsDT-0008KB-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab1JQSrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:47:11 -0400
Received: from darksea.de ([83.133.111.250]:58218 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751331Ab1JQSrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:47:10 -0400
Received: (qmail 20219 invoked from network); 17 Oct 2011 20:47:08 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Oct 2011 20:47:08 +0200
Content-Disposition: inline
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183805>

Hi,

On Mon, Oct 17, 2011 at 04:38:04AM +0200, mhagger@alum.mit.edu wrote:
> I won't myself have time to figure out who, outside of refs.c, has to
> *call* invalidate_ref_cache().  The candidates that I know off the top
> of my head are git-clone, git-submodule [1], and git-pack-refs.  It
> would be great if experts in those areas would insert calls to
> invalidate_ref_cache() where needed.

[...]

> [1] http://marc.info/?l=git&m=131827641227965&w=2
>     In this mailing list thread, Heiko Voigt stated that git-submodule
>     does not modify any references, so it should not have to use the
>     API.

This is not entirely true. I was saying that my submodule-merge code is
currently the only one using the refs api for submodules and that does
not need to modify submodule refs. I imagine that there will be some
users when submodule support matures (e.g. recursive push).

Cheers Heiko
