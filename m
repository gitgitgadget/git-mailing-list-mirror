From: Tim Chase <git@tim.thechases.com>
Subject: Re: misleading diff-hunk header
Date: Fri, 24 Aug 2012 19:41:54 -0500
Message-ID: <50381F52.9030007@tim.thechases.com>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com> <7vfw7gdtfg.fsf@alter.siamese.dyndns.org> <20120824142908.GA15162@sigill.intra.peff.net> <20120824164415.GA23262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 02:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T54Qk-0000Ds-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 02:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2HYAkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 20:40:45 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:56215 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753046Ab2HYAkn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 20:40:43 -0400
Received: from ppp-70-251-69-251.dsl.rcsntx.swbell.net ([70.251.69.251] helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tim.thechases.com>)
	id 1T54QZ-000ARQ-Oq; Fri, 24 Aug 2012 19:40:39 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Icedove/3.1.16
In-Reply-To: <20120824164415.GA23262@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204243>

On 08/24/12 11:44, Jeff King wrote:
> With the old code, you'd get:
> 
> 	diff --git a/old b/new
> 	index f384549..1066a25 100644
> 	--- a/old
> 	+++ b/new
> 	@@ -2,3 +2,3 @@ one
> 	 two
> 	-three
> 	+three -- modified
> 	 four
> 
> So the hunk header is showing you something useful; the element just
> above your context. But with my patch, you'd see:
> 
> 	diff --git a/old b/new
> 	index f384549..1066a25 100644
> 	--- a/old
> 	+++ b/new
> 	@@ -2,3 +2,3 @@ two
> 	 two
> 	-three
> 	+three -- modified
> 	 four
> 
> I.e., it shows the element just before the change, which is already in
> the context anyway. So it's actually less useful. Although note that the
> current behavior is not all that useful, either; it is not really giving
> you any information about the change, but rather just showing one extra
> line of context.
> 
> So I would say that which you would prefer might depend on exactly what
> you are diffing. But I would also argue that in any case where the new
> code produces a worse result, the hunk header was not all that useful to
> begin with.

If the documented purpose of "diff -p" (and by proxy
diff.{type}.xfuncname) is to show the name of the *function*
containing the changed lines, and all you have is a list of lines
with no function names, it's pretty arbitrary to call either
behavior "worse". :-)

-tkc
