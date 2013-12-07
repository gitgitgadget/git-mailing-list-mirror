From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 20/21] t/perf: add tests for pack bitmaps
Date: Sat, 07 Dec 2013 17:51:43 +0100
Message-ID: <8761r0ioyo.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124834.GA11612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpL6l-000873-He
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab3LGQv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:51:56 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52348 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab3LGQvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:51:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 7A82E4D6510;
	Sat,  7 Dec 2013 17:51:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PDZ3VEUUC1xg; Sat,  7 Dec 2013 17:51:44 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 329F94D64C4;
	Sat,  7 Dec 2013 17:51:44 +0100 (CET)
In-Reply-To: <20131114124834.GA11612@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:48:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239006>

Jeff King <peff@peff.net> writes:

> +test_perf 'simulated fetch' '
> +	have=$(git rev-list HEAD --until=1.week.ago -1) &&

This will give you HEAD if your GIT_PERF_LARGE_REPO hasn't seen any
activity lately.  I'd prefer something that always takes a fixed commit,
e.g. HEAD~1000, keeping the perf test reproducible over time (not over
changing GIT_PERF_LARGE_REPO, of course).

-- 
Thomas Rast
tr@thomasrast.ch
