From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Prettify log decorations even more
Date: Fri, 8 May 2009 03:45:07 -0400
Message-ID: <20090508074507.GF12989@coredump.intra.peff.net>
References: <1241649948-11765-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 09:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Km8-0003Wc-Uy
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbZEHHpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757380AbZEHHpI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:45:08 -0400
Received: from peff.net ([208.65.91.99]:36932 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbZEHHpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 03:45:07 -0400
Received: (qmail 16765 invoked by uid 107); 8 May 2009 07:45:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 03:45:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 03:45:07 -0400
Content-Disposition: inline
In-Reply-To: <1241649948-11765-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118576>

On Thu, May 07, 2009 at 01:45:48AM +0300, Felipe Contreras wrote:

> -extern const char *prettify_ref(const struct ref *ref);
> +extern const char *prettify_refname(const char *refname);
> +#define prettify_ref(ref) prettify_refname((ref)->name)

I think it is an improvement for this function to take just the name,
but I don't see much point in keeping the crufty #define compatibility.
I would just fix up the few callers, as it really is just
s/ref/ref->name/.

-Peff
