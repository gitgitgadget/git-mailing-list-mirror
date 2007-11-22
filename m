From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from
	configuration
Date: Thu, 22 Nov 2007 07:18:36 -0500
Message-ID: <20071122121836.GG12913@sigill.intra.peff.net>
References: <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045606.0232fc2d@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvB1E-0000jU-Qy
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXKVMSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXKVMSj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:18:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2401 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbXKVMSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:18:38 -0500
Received: (qmail 23503 invoked by uid 111); 22 Nov 2007 12:18:37 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 07:18:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 07:18:36 -0500
Content-Disposition: inline
In-Reply-To: <20071122045606.0232fc2d@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65815>

On Thu, Nov 22, 2007 at 04:56:06AM -0600, Dan Zwell wrote:

> +			# Grab the 3 main colors in git color string format, with sane
> +			# (visible) defaults:
> +			$prompt_color = Git::color_to_ansi_code(
> +				scalar $repo->config_default('color.interactive.prompt',
> +					'bold blue'));

And by the same token as the last message, given that config_* take only
two arguments, is there a reason not to extend them so that

  $repo->config_bool('my.key', 0);

handles the default. Then I think you could simplify this to just:

  $repo->config_color('color.interactive.prompt', 'bold blue');

and hide the color_to_ansi_code messiness from the script altogether.

-Peff
