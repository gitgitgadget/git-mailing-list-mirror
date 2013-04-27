From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: "git grep" parallelism question
Date: Sat, 27 Apr 2013 15:46:08 +0200
Message-ID: <87mwskf5nj.fsf@hexa.v.cablecom.net>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
	<CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
	<7vip39w14d.fsf@alter.siamese.dyndns.org>
	<CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW5SC-00074d-Gl
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3D0NqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 09:46:12 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9978 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab3D0NqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:46:11 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 15:46:05 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 27 Apr
 2013 15:46:08 +0200
In-Reply-To: <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 26 Apr 2013 13:31:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222649>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, I think your patch is good if for no other reason that it
> allows this kind of testing, but at least for my machine, clearly the
> current default of eight threads is actually "good enough". Maybe
> somebody with a very different machine might want to run the above
> script and see if how sensitive other machines are to this parameter..

I think the last time Duy, Peff, me and others looked into grep
threading (which was a while ago) we basically reached the conclusion
that it's very unstable across machines.

Back then I tested things on a 2x6-core Xeon OS X machine and there the
performance (for the hot-cache, worktree case, which should parallelize
nicely) flatlines at 5 threads for no apparent reason.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
