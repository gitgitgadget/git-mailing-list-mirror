From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Tue, 20 Dec 2011 10:23:16 +0100
Message-ID: <87wr9rk35n.fsf@thomas.inf.ethz.ch>
References: <CB152498.2D6DB%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 10:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcvv7-0005Kj-3m
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 10:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab1LTJX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 04:23:27 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:59210 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab1LTJXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 04:23:19 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:23:14 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 10:23:17 +0100
In-Reply-To: <CB152498.2D6DB%joshua.redstone@fb.com> (Joshua Redstone's
	message of "Tue, 20 Dec 2011 01:40:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187506>

Joshua Redstone <joshua.redstone@fb.com> writes:
> As a bonus, I've also profiled git-add on the 1-million file repo, and it
> looks like, as you might expect, the time is dominated by reading and
> writing the index.  The time for git-add is a couple of seconds.

Note that the time to write the index itself is also rather small, but
the time needed to sha1 the index when loading and then again when
saving it really hurts.

(I noticed this while working on the commit-tree topic.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
