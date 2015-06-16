From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Tue, 16 Jun 2015 12:54:03 +0200
Message-ID: <20150616105403.GA8519@book.hvoigt.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
 <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 12:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4oVb-0005ge-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 12:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbbFPKyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 06:54:15 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:50089 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbbFPKyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 06:54:13 -0400
Received: from [188.108.151.195] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z4oVN-0004W6-6H; Tue, 16 Jun 2015 12:54:09 +0200
Content-Disposition: inline
In-Reply-To: <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271748>

On Mon, Jun 15, 2015 at 11:06:11PM +0200, Heiko Voigt wrote:
> In a superproject some commands need to interact with submodules. They
> need to query values from the .gitmodules file either from the worktree
> of from certain revisions. At the moment this is quite hard since a
> caller would need to read the .gitmodules file from the history and then
> parse the values. We want to provide an API for this so we have one
> place to get values from .gitmodules from any revision (including the
> worktree).

I just realized that we are talking too much about .gitmodules here, where
it probably should be "submodule configuration values". For revisions we
only read from .gitmodules files but for the worktree we actually
overlay those with local configurations from .git/config and friends. Not sure
how we can name this though. "submodule configuration values" is kind of
long compared to .gitmodules.

Does anyone have a better name? Or is it maybe to confusing, to abstract
it too much and we should just keep it .gitmodules, since everyone knows
that those values can be overridden by local configuration?

Cheers Heiko
