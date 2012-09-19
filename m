From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] Make 'not ok $count - $message' consistent with
 'ok $count - $message'
Date: Wed, 19 Sep 2012 13:50:36 -0400
Message-ID: <20120919175036.GB11699@sigill.intra.peff.net>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-3-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOQB-00044O-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805Ab2ISRuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:50:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49768 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932717Ab2ISRui (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:50:38 -0400
Received: (qmail 2539 invoked by uid 107); 19 Sep 2012 17:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 13:51:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 13:50:36 -0400
Content-Disposition: inline
In-Reply-To: <1348074915-19985-3-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205961>

On Wed, Sep 19, 2012 at 06:15:11PM +0100, Adam Spiers wrote:

>  test_failure_ () {
>  	test_failure=$(($test_failure + 1))
> -	say_color error "not ok - $test_count $1"
> +	say_color error "not ok $test_count - $1"

Interesting. I wondered what TAP had to say about this, and in fact we
were doing it wrong before. However, since the test numbers are optional
in TAP, a harness is supposed to keep its own counter when we fail to
provide a number.

So it happened to work, but this change in fact makes us more
TAP-compliant. Good.

-Peff
