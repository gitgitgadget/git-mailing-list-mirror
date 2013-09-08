From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/5] git-config and large integers
Date: Sun, 8 Sep 2013 04:27:24 -0400
Message-ID: <20130908082724.GA27184@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 10:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaLX-0000nB-C6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab3IHI13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:27:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:43710 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3IHI12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:27:28 -0400
Received: (qmail 10942 invoked by uid 102); 8 Sep 2013 08:27:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 03:27:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 04:27:24 -0400
Content-Disposition: inline
In-Reply-To: <20130820223953.GA3429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234219>

Here's a re-roll (and re-design) of my series to help with "git config"
and large integers. It takes the different approach we discussed of
simply removing (well, increasing) the range limits for "git config
--int".

I also improved the error messages for bogus config (patches 3-4).

  [1/5]: config: factor out integer parsing from range checks
  [2/5]: config: properly range-check integer values
  [3/5]: config: set errno in numeric git_parse_* functions
  [4/5]: config: make numeric parsing errors more clear
  [5/5]: git-config: always treat --int as 64-bit internally

-Peff
