From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-config(1): clarify precedence of multiple values
Date: Sun, 7 Jul 2013 15:55:18 -0400
Message-ID: <20130707195518.GB20700@sigill.intra.peff.net>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
 <7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
 <20130707095026.GR9161@serenity.lan>
 <7v38rq5lad.fsf@alter.siamese.dyndns.org>
 <20130707194956.GU9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jul 07 21:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvv3P-00041c-7v
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 21:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab3GGTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 15:55:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:50673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab3GGTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 15:55:22 -0400
Received: (qmail 7628 invoked by uid 102); 7 Jul 2013 19:56:36 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 14:56:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 15:55:18 -0400
Content-Disposition: inline
In-Reply-To: <20130707194956.GU9161@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229802>

On Sun, Jul 07, 2013 at 08:49:56PM +0100, John Keeping wrote:

> In order to clarify which value is used when there are multiple values
> defined for a key, re-order the list of file locations so that it runs
> from least specific to most specific.  Then add a paragraph which simply
> says that the last value will be used.

Makes sense.

>  file is not available or readable, 'git config' will exit with a non-zero
>  error code. However, in neither case will an error message be issued.
>  
> +The files are read in the order given above, with last value found taking
> +precedence over values read earlier.  When multiple values are taken then all
> +values of a key from all files will be used.

What order do the values come in --get-all?

If you read carefully, I think it is implied by the "files are read in
order given above", but it took me a minute to think about it. Maybe add
at the end:

  ...values of a key from all files will be shown, in the order the
  files are processed (least specific to most specific).

Or something (I do not like "least specific" because we have not
introduced that term earlier, but I can't think of another succinct way
to say it).

But even without that, the patch is certainly an improvement.

-Peff
