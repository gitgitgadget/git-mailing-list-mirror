From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/4] commit test: Use write_script
Date: Fri, 13 Jun 2014 02:50:37 -0400
Message-ID: <20140613065037.GA7908@sigill.intra.peff.net>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-3-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLK0-0000Wm-9g
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 08:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbaFMGuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 02:50:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:43196 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751866AbaFMGuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 02:50:40 -0400
Received: (qmail 7359 invoked by uid 102); 13 Jun 2014 06:50:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 01:50:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 02:50:37 -0400
Content-Disposition: inline
In-Reply-To: <1402601942-45553-3-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251519>

On Thu, Jun 12, 2014 at 02:39:00PM -0500, Caleb Thompson wrote:

> Use write_script from t/test-lib-functions.sh instead of cat, shebang,
> and chmod. This protects us from potential shell meta-characters in the
> name of our trash directory, which would be interpreted if we set
> $EDITOR directly.

I'm not sure about this last sentence; isn't that what test_set_editor
is doing, which was already there? I think the real rationale is
readability: since $SHELL_PATH is handled for us, you can turn off
interpolation in the here-doc containing the helper script. That avoids
an extra layer of quoting.

-Peff
