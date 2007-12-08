From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Sat, 8 Dec 2007 03:02:38 -0500
Message-ID: <20071208080238.GB4812@coredump.intra.peff.net>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site> <4759996B.2000300@gmail.com> <20071207204937.GA20111@coredump.intra.peff.net> <20071207212607.GA11504@coredump.intra.peff.net> <7vejdxy70p.fsf@gitster.siamese.dyndns.org> <7vaboly6dv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ueN-0005Ra-JB
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbXLHICl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXLHICl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:02:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4148 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbXLHICk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:02:40 -0500
Received: (qmail 17359 invoked by uid 111); 8 Dec 2007 08:02:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Dec 2007 03:02:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 03:02:38 -0500
Content-Disposition: inline
In-Reply-To: <7vaboly6dv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67523>

On Fri, Dec 07, 2007 at 11:47:56PM -0800, Junio C Hamano wrote:

> Which would make the rewritten patch like this...

Looks like our patches just crossed paths.  Yours looks OK, but we
should add something to the 'configuration' section, and...

> diff --git a/wt-status.h b/wt-status.h
> index 225fb4d..63d50f2 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -28,6 +28,7 @@ struct wt_status {
>  
>  int git_status_config(const char *var, const char *value);
>  int wt_status_use_color;
> +int wt_status_relative_paths;
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);

Shouldn't both of these ints be marked "extern"? I'm surprised it worked
at all (or perhaps the part of my brain that stores C linkage issues is
rotting?).

-Peff
