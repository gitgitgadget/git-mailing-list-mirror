From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] index-pack: always zero-initialize object_entry list
Date: Tue, 19 Mar 2013 16:33:42 +0100
Message-ID: <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
References: <20130319102422.GB6341@sigill.intra.peff.net>
	<20130319105852.GA15182@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyYH-0000nG-Js
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab3CSPdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:33:46 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48692 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab3CSPdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:33:45 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:33:41 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.171.78) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 16:33:42 +0100
In-Reply-To: <20130319105852.GA15182@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2013 06:58:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.171.78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218522>

Jeff King <peff@peff.net> writes:

> Commit 38a4556 (index-pack: start learning to emulate
> "verify-pack -v", 2011-06-03) added a "delta_depth" counter
> to each "struct object_entry". Initially, all object entries
> have their depth set to 0; in resolve_delta, we then set the
> depth of each delta to "base + 1". Base entries never have
> their depth touched, and remain at 0.

This patch causes index-pack to fail on the pack that triggered the
whole discussion.  More in a minute in another side thread, but
meanwhile: NAK until we understand what is really going on here.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
