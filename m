From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] config: Introduce diff.algorithm variable
Date: Tue, 15 Jan 2013 08:58:23 -0800
Message-ID: <20130115165822.GB29301@sigill.intra.peff.net>
References: <cover.1358193364.git.mprivozn@redhat.com>
 <f76708fc2a1dc33f3f9c67688ef5709302b56cbb.1358193364.git.mprivozn@redhat.com>
 <7v38y3a31k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9qZ-0000sk-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab3AOQ60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:58:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34177 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3AOQ60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:58:26 -0500
Received: (qmail 31147 invoked by uid 107); 15 Jan 2013 16:59:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 11:59:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 08:58:23 -0800
Content-Disposition: inline
In-Reply-To: <7v38y3a31k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213650>

On Mon, Jan 14, 2013 at 01:05:27PM -0800, Junio C Hamano wrote:

> Michal Privoznik <mprivozn@redhat.com> writes:
> 
> > +static long parse_algorithm_value(const char *value)
> > +{
> > +	if (!value || !strcasecmp(value, "myers"))
> > +		return 0;
> 
> [diff]
> 	algorithm
> 
> should probably error out.

Definitely.

> Also it is rather unusual to parse the keyword values case insensitively.

Is it? "git grep strcasecmp" shows that we already do so in many cases
(e.g., any bool option, core.autocrlf, receive.deny*, etc). Is there a
reason to reject "Myers" here?

-Peff
