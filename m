From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 1/5] Refactor pretty_print_commit arguments into a struct
Date: Sun, 18 Oct 2009 20:51:16 +0200
Message-ID: <200910182051.20461.trast@student.ethz.ch>
References: <cover.1255701207.git.trast@student.ethz.ch> <9d3d0f0a6126afc86689138adf58ac7a12c43858.1255701207.git.trast@student.ethz.ch> <7vljja7xy8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 20:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzarO-0006TY-LU
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 20:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbZJRSvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbZJRSvz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 14:51:55 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:59436 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152AbZJRSvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 14:51:54 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 18 Oct
 2009 20:51:57 +0200
Received: from thomas.localnet (129.132.208.147) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 18 Oct
 2009 20:51:56 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vljja7xy8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130607>

Junio C Hamano wrote:
> The existing calls to format_commit_message() often take DATE_NORMAL to
> its "enum date_mode dmode" argument, and you replaced it with a pointer to
> a struct.  DATE_NORMAL happens to be "0" and the compiler does not catch
> calls you forgot to convert in this patch.

Hmph, that's embarrassing.  Apparently I was way too focused on
pretty_print_commit...

I can devise a test that would have detected this.  Should I include
it in the reroll, or is that something we do not guard against?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
