From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] tests: stop hard-coding the list of GIT_* vars to
 scrub
Date: Tue, 15 Mar 2011 05:08:46 -0500
Message-ID: <20110315100846.GB3923@elie>
References: <20110315064909.GA25738@elie>
 <20110315070445.GC29530@elie>
 <20110315073718.GB11754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRBe-0005Ow-Oo
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab1COKIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:08:51 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34559 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab1COKIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:08:51 -0400
Received: by yia27 with SMTP id 27so162902yia.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gDFkWRhBzvaWT8TH8r8dLx5nWmZ5mnj4vVGFA8LlX3Q=;
        b=nT6ajpEoDnI0OaoJGffbu9Z0r5gHHurqwAoNrlTx/eQVEfIuvHNJkvVzkDZJ7uc6gt
         5iYXs6/p44vohO32C42NIg8kTI1QymtYy7NmX1gwoNcGc0kI5jloKGd1iyld+YBXxtq7
         Q6VW0aOB7aNSStts8nqyg7bIvgONiBPFvejZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KIDhgP+318CEdqiLNDuopegaUs/B7c7+R7N1/t4dAIBrHkheKzf4sZICyO/nbLJSUC
         8v2u14LH7LFi8tip5eAqJ9OBKnUWziDdkyaVNrSXEmPOrUOtKfRvqwmD5Ipi2C/M6+2S
         WjF2k1g9Rr7/ZPUHpnAQoTpmRIe83+7ZardDg=
Received: by 10.150.179.10 with SMTP id b10mr7155196ybf.129.1300183730355;
        Tue, 15 Mar 2011 03:08:50 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id d3sm6119774ybi.17.2011.03.15.03.08.48
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 03:08:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315073718.GB11754@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169057>

Jeff King wrote:

> According to posix, just running "set" provides an unambiguous,
> parseable output. The problem is that it's actual shell, so it's a
> little tricky to parse (it's single-quoted, and you have to follow
> values across embedded newlines). So it's probably not worth the
> headache.
>
> Having a big list of "clear these variables" is probably not the end of
> the world.

Here's one way (using perl), for what it's worth.

Jonathan Nieder (2):
  tests: stop worrying about obsolete environment variables
  tests: scrub environment of GIT_* variables

 t/test-lib.sh |   30 +++++-------------------------
 1 files changed, 5 insertions(+), 25 deletions(-)
