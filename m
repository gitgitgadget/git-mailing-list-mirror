From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Wed, 1 Dec 2010 16:07:42 -0500
Message-ID: <20101201210742.GA13740@sigill.intra.peff.net>
References: <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <20101201175517.GA7774@sigill.intra.peff.net>
 <20101201183615.GA27024@burratino>
 <20101201184659.GA9147@sigill.intra.peff.net>
 <20101201185711.GD27024@burratino>
 <7vipzduufr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtu2-0002Iu-Hp
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab0LAVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 16:07:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55348 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab0LAVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 16:07:45 -0500
Received: (qmail 8176 invoked by uid 111); 1 Dec 2010 21:07:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 21:07:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 16:07:42 -0500
Content-Disposition: inline
In-Reply-To: <7vipzduufr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162614>

On Wed, Dec 01, 2010 at 12:09:12PM -0800, Junio C Hamano wrote:

> We actually need to stress the fact that _only_ newer git will understand
> "add.ignoreErrors", so people with older git (especially the ones who need
> to use both older and newer versions of git) may need to keep using the
> older form in their configuration, no?
> 
> Perhaps phrasing it like this, and then issue v1.7.{0,1,2,3}.X maintenance
> release to reduce the chance of inconveniencing the users?

Yeah, I think it is better to be explicit.

>  add.ignore-errors::
> +add.ignoreErrors::
>  	Tells 'git add' to continue adding files when some files cannot be
>  	added due to indexing errors. Equivalent to the '--ignore-errors'
> -	option of linkgit:git-add[1].
> +	option of linkgit:git-add[1].  Older versions of git accept only
> +	`add.ignore-errors`, whose name goes against the convention, so
> +	newer versions of git honor `add.ignoreErrors` as well.

Nit: Somehow "goes against the convention" doesn't sound quite right to
me. Astute users can probably figure out which convention, but perhaps
we should be more explicit like:

  Older versions of git accept only `add.ignore-errors`, which does not
  follow the usual naming convention for configuration variable. Newer
  versions of git honor `add.ignoreErrors` as well.

-Peff
