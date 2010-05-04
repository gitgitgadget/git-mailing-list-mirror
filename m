From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] for-each-ref: Field with abbreviated objectname
Date: Tue, 4 May 2010 07:01:34 -0400
Message-ID: <20100504110134.GA7947@coredump.intra.peff.net>
References: <61d114759b023b3937f8417ce44c3361f345c6f1.1272918259.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 04 13:01:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Fsn-0004Cu-Eu
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 13:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab0EDLBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 07:01:39 -0400
Received: from peff.net ([208.65.91.99]:33649 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab0EDLBi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 07:01:38 -0400
Received: (qmail 8465 invoked by uid 107); 4 May 2010 11:01:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 07:01:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 07:01:34 -0400
Content-Disposition: inline
In-Reply-To: <61d114759b023b3937f8417ce44c3361f345c6f1.1272918259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146308>

On Mon, May 03, 2010 at 10:25:19PM +0200, Michael J Gruber wrote:

> Introduce a :short modifier to objectname which outputs the abbreviated
> object name.

I don't see any reason not to do this if you have a use for it.

>     TODO: test, doc

Yep.

> +		else if (!strcmp(name, "objectname:short")) {
> +			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
> +		}

In theory there could be multiple such ":$foo" tags, and we would have
to fix this parser. But given that there aren't other modifiers now, I
think we can just push that problem off until it happens (if ever).

-Peff
