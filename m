From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Thu, 8 Nov 2007 23:52:56 -0500
Message-ID: <20071109045256.GD31760@sigill.intra.peff.net>
References: <4733AEA6.1040802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 05:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqLrn-0000iI-IB
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 05:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761200AbXKIExA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 23:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761116AbXKIExA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 23:53:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1033 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760727AbXKIEw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 23:52:59 -0500
Received: (qmail 20804 invoked by uid 111); 9 Nov 2007 04:52:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 Nov 2007 23:52:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2007 23:52:56 -0500
Content-Disposition: inline
In-Reply-To: <4733AEA6.1040802@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64128>

On Fri, Nov 09, 2007 at 01:49:42AM +0100, Ren=E9 Scharfe wrote:

> +	strbuf_expand(sb, format, placeholders, format_commit_item, (void *=
)commit);

This void cast is pointless, since all pointers types convert implicitl=
y
to void pointers anyway. At best, it does nothing, and at worst, it
hides an actual type error if the function signature or the type of
'commit' change.

(In the patch I just sent out, I had to change this line anyway, and
removed the cast).

-Peff
