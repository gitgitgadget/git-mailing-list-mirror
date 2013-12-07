From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 21/21] pack-bitmap: implement optional name_hash cache
Date: Sat, 07 Dec 2013 17:59:28 +0100
Message-ID: <87wqjgha1b.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124855.GB11612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpLES-0002pT-Ry
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758904Ab3LGQ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:59:40 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52370 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab3LGQ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:59:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 420024D64E4;
	Sat,  7 Dec 2013 17:59:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y9NcslRXFXz0; Sat,  7 Dec 2013 17:59:28 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A30E64D64C4;
	Sat,  7 Dec 2013 17:59:28 +0100 (CET)
In-Reply-To: <20131114124855.GB11612@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:48:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239007>

Jeff King <peff@peff.net> writes:

> Test                      origin/master       HEAD^                      HEAD
> -------------------------------------------------------------------------------------------------
> 5310.2: repack to disk    36.81(37.82+1.43)   47.70(48.74+1.41) +29.6%   47.75(48.70+1.51) +29.7%
> 5310.3: simulated clone   30.78(29.70+2.14)   1.08(0.97+0.10) -96.5%     1.07(0.94+0.12) -96.5%
> 5310.4: simulated fetch   3.16(6.10+0.08)     3.54(10.65+0.06) +12.0%    1.70(3.07+0.06) -46.2%
> 5310.6: partial bitmap    36.76(43.19+1.81)   6.71(11.25+0.76) -81.7%    4.08(6.26+0.46) -88.9%
>
> You can see that the time spent on an incremental fetch goes
> down, as our delta heuristics are able to do their work.
> And we save time on the partial bitmap clone for the same
> reason.

The time now goes down across the board compared to master.  Good job!

> Signed-off-by: Vicent Marti <tanoku@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Thomas Rast <tr@thomasrast.ch>

-- 
Thomas Rast
tr@thomasrast.ch
