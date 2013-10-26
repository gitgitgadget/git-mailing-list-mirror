From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pathspec: stop --*-pathspecs impact on internal
 parse_pathspec() uses
Date: Sat, 26 Oct 2013 02:39:12 -0400
Message-ID: <20131026063912.GA24499@sigill.intra.peff.net>
References: <20131025034947.GA4959@sigill.intra.peff.net>
 <1382753360-32037-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 08:39:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZxWp-0005FV-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 08:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab3JZGjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 02:39:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:55949 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751686Ab3JZGjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 02:39:15 -0400
Received: (qmail 8550 invoked by uid 102); 26 Oct 2013 06:39:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Oct 2013 01:39:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Oct 2013 02:39:12 -0400
Content-Disposition: inline
In-Reply-To: <1382753360-32037-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236736>

On Sat, Oct 26, 2013 at 09:09:20AM +0700, Nguyen Thai Ngoc Duy wrote:

>  Jeff, how about this?
>  
>  It's similar to your last suggestion (i.e.  relaxing the magic mask
>  about literal magic). In addition, it forces literal magic
>  unconditionally in this case, which I think is the right thing to do.
>  And it will fix other --*-pathspecs as well.

Yeah, I think I follow your reasoning. The problem I saw was just about
--literal-pathspec, but the real issue is that "blame" does not want
magic pathspecs at all, and your new flag turns that off.

So it fixes both my problem, as well as "git blame -- :(foo)bar".

-Peff
