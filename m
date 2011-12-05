From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Mon, 5 Dec 2011 16:51:48 -0500
Message-ID: <20111205215148.GA22663@sigill.intra.peff.net>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Mon Dec 05 22:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXgS3-0002L8-VL
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 22:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549Ab1LEVvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 16:51:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39913
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372Ab1LEVvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 16:51:50 -0500
Received: (qmail 29932 invoked by uid 107); 5 Dec 2011 21:58:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 16:58:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 16:51:48 -0500
Content-Disposition: inline
In-Reply-To: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186292>

On Sun, Dec 04, 2011 at 06:20:26AM +0200, Kirill A. Shutemov wrote:

> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> 
> Normally git tag stripes tag message lines starting with '#', trailing
> spaces from every line and empty lines from the beginning and end.

s/stripes/strips

> --cleanup allows to select different cleanup modes for tag message.
> It provides the same interface as --cleanup option in git-commit.

Thanks, I think this is better, though it would be better still if they
could share the code. As a minor nit, I think the patch would be a
little easier to read and review if you split the actual changes from
the refactoring to use the "struct create_tag_options".

More importantly, though, this seems to break t6300 badly. I haven't
looked into why yet, though.

-Peff
