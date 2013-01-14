From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 00:56:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1301150055520.32206@s15462909.onlinehome-server.info>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuttZ-0001VW-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab3ANX42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 18:56:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:58025 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab3ANX41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 18:56:27 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M9cyP-1To3K10Cb9-00CwGv for
 <git@vger.kernel.org>; Tue, 15 Jan 2013 00:56:26 +0100
Received: (qmail invoked by alias); 14 Jan 2013 23:56:25 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp012) with SMTP; 15 Jan 2013 00:56:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/s4C0i3PfsyMZlOmKCH4mUkUCd0QeaMrU2isiY63
	7OtRZeRbSmE9x1
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213546>

Hi Junio,

On Mon, 14 Jan 2013, Junio C Hamano wrote:

> It appears that memcmp() uses the usual "one word at a time"
> comparison and triggers valgrind in a callback of bsearch() used in
> the refname search.  I can easily trigger problems in any script
> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
> without this suppression.

I have no way to replicate that issue, but I take your word for it. With
that in mind, here is my ACK.

Ciao,
Johannes
