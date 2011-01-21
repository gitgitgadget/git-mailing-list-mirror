From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Documentation fixes in git-config
Date: Fri, 21 Jan 2011 11:25:37 -0500
Message-ID: <20110121162537.GD21840@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141401.GE8034@fm.suse.cz>
 <20110121002716.GC9442@sigill.intra.peff.net>
 <20110121102048.GF19715@fm.suse.cz>
 <20110121102537.GH19715@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 17:25:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgJo1-0000fL-IN
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 17:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab1AUQZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 11:25:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab1AUQZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 11:25:40 -0500
Received: (qmail 19783 invoked by uid 111); 21 Jan 2011 16:25:39 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 16:25:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jan 2011 11:25:37 -0500
Content-Disposition: inline
In-Reply-To: <20110121102537.GH19715@fm.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165380>

On Fri, Jan 21, 2011 at 11:25:37AM +0100, Libor Pechacek wrote:

> Variable names must start with an alphabetic character, regexp config key
> matching has its limits.

I think this is fine, although:

>  --get-regexp::
> -	Like --get-all, but interprets the name as a regular expression.
> -	Also outputs the key names.
> +	Like --get-all, but interprets the name as a regular expression and
> +	writes out the key names.  Regular expression matching is currently
> +	case-sensitive and done against a canonicalized version of the key
> +	in which section and variable names are lowercased, but subsection
> +	names are not.  Regular expressions are partially lower-cased
> +	before matching (everything before the first dot and after the last
> +	dot), which makes things like "Core.*' work.

I am half-tempted to mark the lowercasing of the regex as deprecated (or
at least discouraged). It's such a hack, and I don't think we will ever
improve to make it work in the general case, as regexes are simply too
complex for us to handle all possible inputs.

Either way, though, this is definitely an improvement over what is
there, so:

Acked-by: Jeff King <peff@peff.net>

-Peff
