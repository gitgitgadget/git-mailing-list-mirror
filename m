From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 12:05:22 +0100
Message-ID: <201203301305.23567.jnareb@gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com> <20120330052631.GB11648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: jaseem abid <jaseemabid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDZe9-0003ww-R7
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 13:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933698Ab2C3LF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 07:05:29 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55836 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933667Ab2C3LF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 07:05:27 -0400
Received: by wibhq7 with SMTP id hq7so484651wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=pBNpU7oVFXHX5AbaOcj/5BNRmFS2rNkofP1RGgK9Xhk=;
        b=YRIbidYWjYphgXWE2BTVB00NyG7REB082Q1El9GTHBQXDdGlXdhb+UFMz/ScIpEPjt
         1TEheAQihsTaNu4OTj8CSyP72P4rBQiAYo8Q7/liYxgf7ntXWqf1qn67N2r+/bBVtA11
         RD3OOUX1tHWtr5is2njiQytok+uXQf7S2XejalK8JWXjNNwx/Z3ILNxYpTnkcMiqECbi
         GbW+HudYKw2jI+l2gr/lsFKEKhw/5acQlMmiUCnU1vrQo9fWee0sx/CP87ygpcgXnRAq
         S5+kHgDz89ObEpQKYC4FdpNYznhteTFONfxFP/U1aDoZWq93G4N+LVEidpXrvRhBiKbE
         H1yA==
Received: by 10.180.107.104 with SMTP id hb8mr5362152wib.8.1333105526096;
        Fri, 30 Mar 2012 04:05:26 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id b3sm5480514wib.4.2012.03.30.04.05.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 04:05:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120330052631.GB11648@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194346>

On Fri, 30 Mar 2012, Jeff King wrote:
> On Fri, Mar 30, 2012 at 08:19:29AM +0530, jaseem abid wrote:
> 
> > 	1. Where can I find general instructions on "Contributing to git? "
> > more specifically, gitweb?
> 
> Documentation/SubmittingPatches in the git.git repository.

For GSoC we prefer if you had a public git repository with your stuff
(GitHub, repo.or.cz or wherever), and that patches were Cc-ed to mentor.

> > 	2. Where can I find coding standards for git? I am looking for the
> > git version of this document.
> 
> Documentation/CodingGuidelines

There are no special rules for JavaScript (and neither for that matter
for Perl), but:

  "As for more concrete guidelines, just imitate the existing code
   (this is a good guideline, no matter which project you are
   contributing to). It is always preferable to match the _local_
   convention. New code added to git suite is expected to match
   the overall style of existing code. Modifications to existing
   code is expected to match the style the surrounding code already
   uses (even if it doesn't match the overall style of existing code)."

For JavaScript this includes using subset of JSDoc in comments.

> > 	3. Is JavaScript code unit tested? I cant find much docs regarding
> > this anywhere.

No, there are no JavaScript tests at all, neither unit tests
nor procedural (integration) tests.

> Jakub can answer this much better than I can, but I suspect the answer
> is "no". We hardly have any javascript at all, and I doubt the gitweb
> tests cover the javascript bits.
> 
> If there is going to be a javascript-heavy SoC project, I think part
> of that should probably be adding some automated testing
> infrastructure. 

The problem with automated testing of JavaScript is integrating it with
our testsuite, which is run from command line and outputs TAP (Test 
Anything Protocol), so it can e.g. be run by 'prove'.

But even if the JavaScript tests would have to be run in browser (like
most of all of them seems to), having any automated test for gitweb's 
JavaScript code would be a very good idea.

P.S. I wonder how JavaScript-scriptable Veracity DVCS solved that...
-- 
Jakub Narebski
Poland
