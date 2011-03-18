From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and
 --merges-only
Date: Fri, 18 Mar 2011 05:54:17 -0400
Message-ID: <20110318095417.GA18526@sigill.intra.peff.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net>
 <20110317195905.GG20508@sigill.intra.peff.net>
 <4D831043.1060709@drmicha.warpmail.net>
 <20110318090724.GB16703@sigill.intra.peff.net>
 <4D8328F9.9050100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0WO2-0007hk-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 10:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab1CRJyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 05:54:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56855
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365Ab1CRJyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 05:54:20 -0400
Received: (qmail 884 invoked by uid 107); 18 Mar 2011 09:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 05:54:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 05:54:17 -0400
Content-Disposition: inline
In-Reply-To: <4D8328F9.9050100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169308>

On Fri, Mar 18, 2011 at 10:42:17AM +0100, Michael J Gruber wrote:

> > I saw it, I was just expecting you to start the "D" with some text. :)
> 
> According to my expectation, I get many more responses doing it this way :)

Heh, you are just trolling? :)

> Maybe you can help me understand this one:
> 
> int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
> {
>         int *target = opt->value;
>         *target = unset ? 2 : 1;
>         return 0;
> }
> 
> This is no tri-state, is it? (It's used only for the undocumented
> --autoupdate option to rerere.) I guess it's more like unset/yes/no,
> which, admittedly, counts to 3, but still.

Yeah, it is not what you want. It takes no argument at all, but is a
boolean that uses "1" and "2" for "yes" and "no" (with presumably
"0" as the "unset" version, though this callback doesn't care).

If you want a parse-options example of what you're trying to do, try
OPT__COLOR.

-Peff
