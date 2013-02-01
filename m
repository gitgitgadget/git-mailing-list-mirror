From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Fri, 1 Feb 2013 05:00:02 -0500
Message-ID: <20130201100002.GF30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1DQ7-0000xk-1g
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 11:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776Ab3BAKAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:00:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55356 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964772Ab3BAKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:00:06 -0500
Received: (qmail 27800 invoked by uid 107); 1 Feb 2013 10:01:29 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 05:01:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 05:00:02 -0500
Content-Disposition: inline
In-Reply-To: <20130130135607.GA23154@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215228>

On Wed, Jan 30, 2013 at 08:56:07PM +0700, Nguyen Thai Ngoc Duy wrote:

> Another point, but not really important at this stage, I think we have
> memory leak somewhere (lookup_commit??). It used up to 800 MB RES on
> linux-2.6.git while generating the cache.

We generate (and then leak!) the linked list in commit_metapack_write.
That may be the culprit.

-Peff
