From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 23:20:16 +0200
Message-ID: <20150917212016.GF606@cruxbox>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
 <xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:20:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcgbS-0006SX-EA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 23:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbIQVUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 17:20:21 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51178 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbIQVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 17:20:20 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 775CE41C236;
	Thu, 17 Sep 2015 23:20:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id KpCFRMf5s0Vq; Thu, 17 Sep 2015 23:20:17 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 91D7641D49E;
	Thu, 17 Sep 2015 23:20:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278169>

On Thu, Sep 17, 2015 at 12:51:18PM -0700, Junio C Hamano wrote:
> IIRC historically the division between ssl and crypto was messy.
> Especially, I am not sure if the change to NEEDS_SSL_WITH_CRYPTO
> in this patch is correct for platforms that require that macro
> defined.

I think it is correct as anywhere else in Makefile the order is ssl
first then crypto (from Makefile:1047):

        ifdef NEEDS_SSL_WITH_CURL
                CURL_LIBCURL += -lssl
                ifdef NEEDS_CRYPTO_WITH_SSL
                        CURL_LIBCURL += -lcrypto
                endif
        endif


> 
> Other changes in this patch looks sensible, though.

If you agree with the NEED_SSL_WITH_CURL modification, I'll resend a
patch with the typos corrected.
