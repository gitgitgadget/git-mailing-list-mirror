From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file: fix delta_stack memory leak in unpack_entry
Date: Sat, 22 Feb 2014 03:12:31 -0500
Message-ID: <20140222081231.GC1576@sigill.intra.peff.net>
References: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
 <20140221054148.GA24882@sigill.intra.peff.net>
 <xmqqmwhk49sy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7hP-0004D5-AL
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaBVIMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 03:12:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:54931 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbaBVIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:12:33 -0500
Received: (qmail 15671 invoked by uid 102); 22 Feb 2014 08:12:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:12:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:12:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmwhk49sy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242505>

On Fri, Feb 21, 2014 at 10:09:33AM -0800, Junio C Hamano wrote:

> >> This delta_stack array can grow to any length depending on the actual
> >> delta chain, but we forget to free it. Normally it does not matter
> >> because we use small_delta_stack[] from stack and small_delta_stack
> >> can hold 64-delta chains, more than standard --depth=50 in pack-objects.
> [...]
> 
> This comes from abe601bb, right?  The change looks correct to me, too.

Yes, it does.

-Peff
