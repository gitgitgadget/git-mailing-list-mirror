From: Tim Chase <git@tim.thechases.com>
Subject: Re: misleading diff-hunk header
Date: Sat, 25 Aug 2012 07:56:06 -0500
Message-ID: <5038CB66.1040006@tim.thechases.com>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com> <7vfw7gdtfg.fsf@alter.siamese.dyndns.org> <20120824142908.GA15162@sigill.intra.peff.net> <20120824164415.GA23262@sigill.intra.peff.net> <50381F52.9030007@tim.thechases.com> <7va9xjy4or.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 14:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5Fty-0006cN-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 14:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab2HYMzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 08:55:00 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:34587 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752843Ab2HYMy7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 08:54:59 -0400
Received: from ppp-70-251-69-251.dsl.rcsntx.swbell.net ([70.251.69.251] helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tim.thechases.com>)
	id 1T5FtA-0003Kx-H4; Sat, 25 Aug 2012 07:54:56 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Icedove/3.1.16
In-Reply-To: <7va9xjy4or.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204273>

On 08/24/12 23:29, Junio C Hamano wrote:
> Tim Chase <git@tim.thechases.com> writes:
>> If the documented purpose of "diff -p" (and by proxy
>> diff.{type}.xfuncname) is to show the name of the *function*
>> containing the changed lines,....
> 
> Yeah, the documentation is misleading, but I do not offhand think of
> a better phrasing. Perhaps you could send in a patch to improve it.
> 
> How does GNU manual explain the option?

Tersely. :-)

       -p  --show-c-function
              Show which C function each change is in.

And that's it.  To describe the current behavior, it might be better
written as "Find and show the first function definition prior to the
hunk".  The code in diff(1) actually just uses the regexp something
like "^[a-z]" which happens to find function definitions, but can
also find module-level variable definitions, structs, etc.

-tkc
