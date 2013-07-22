From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Mon, 22 Jul 2013 12:39:40 +0200
Message-ID: <87r4er2ct4.fsf@linux-k42r.v.cablecom.net>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<51DC6B37.9030108@alum.mit.edu>
	<7vli5fv5ud.fsf@alter.siamese.dyndns.org>
	<CAPig+cTh2t_Rc13U_F-prmm=sjs2OEHX5AX2DbC5DH+Tx_E5jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DWy-0000x3-8j
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab3GVKjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 06:39:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34734 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3GVKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 06:39:43 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Jul
 2013 12:39:40 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.60.35) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Jul 2013 12:39:41 +0200
In-Reply-To: <CAPig+cTh2t_Rc13U_F-prmm=sjs2OEHX5AX2DbC5DH+Tx_E5jg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 22 Jul 2013 04:12:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.60.35]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230972>

Eric Sunshine <sunshine@sunshineco.com> writes:

> The proposal currently is only for "-L /RE/,whatever" to behave in a
> relative fashion, beginning the search at the end of the last range
> specified via -L (or line 1 if there is no previous -L).
>
> Would it also make sense to support "-L +N,whatever" as relative to
> the end of the last range specified via -L (or 1 if none).

Sounds reasonable.

I'm still not sure I am super-happy with /RE/ always being relative,
though I see Junio's problem space as something worth solving.  How does
it interact with -L:RE?  Do you now have to know in what order the
functions appear in the source to correctly specify -L:foo -L:bar or
similarly, -L/foo/,/^}/ -L/bar/,/^}/?  What if we supported +/RE/ as the
relative version?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
