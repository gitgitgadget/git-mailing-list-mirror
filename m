From: Steven Tweed <orthochronous@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 16:33:13 +0000
Message-ID: <d9c1caea0903240933n6dea7ddcl90a5e105c2a45b52@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
	 <49C8E074.4030808@gmail.com>
	 <20090324135906.GA10644@coredump.intra.peff.net>
	 <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Roel Kluin <roel.kluin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9bC-0005PL-Sd
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761948AbZCXQdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761889AbZCXQdT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:33:19 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:58590 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761198AbZCXQdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 12:33:16 -0400
Received: by bwz17 with SMTP id 17so2302313bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OUkwlw0t5xphO6EdoxlYnhQ1fwaHAJ8grgB+e5ybs90=;
        b=HViA6GAEXoIVgxtc6OIbpyI5ppQ8BaeW79S8CG51JGv0VMYchCINTiuVD2nxUPcGxV
         WHhdS059Z0QIv0EPA0pfONSH7IvHtBU+uUt4fmbbvEoVtpAlnT0YvP7YoUdpnFmD+Aoy
         WfkV6kk/LlcH2WLICBScuRqUYznw7zkzQ+gD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WMCdEsUcHHePZ1/l0S9q8W+ur0A6FjMUuhTThC1VKB5Q1nbksmxX2yx+2ufLTG+TmY
         SaPwOqnRBV9guW6gtJ0iwos02ZeDQisD7ls8v1SowrFom9D4Ub4U2EorSgFIfeZsYLEK
         lSHN9DKgT38Fi+6+Fx5FZEqnevJFq1/1cfcvo=
Received: by 10.223.113.9 with SMTP id y9mr7257043fap.19.1237912393125; Tue, 
	24 Mar 2009 09:33:13 -0700 (PDT)
In-Reply-To: <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114471>

On Tue, Mar 24, 2009 at 2:38 PM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 2009/3/24 Jeff King <peff@peff.net>:
> This kind of pipeline has the benefit that it can actually work on the
> *repository*, and not just the working copy (as per the posted
> script).

Speaking of wanting things to work with the actual repository , one
thing that I've been meaning to continue work on if I get the time is
basically a 'show me any commit diff's that involve string s' (ie, the
locations in which a change involving s occurs rather than just
'current file contains s (in exactly the same ways the previous
version did). I'm extremely unlikely to actually produce anything
based on that in the near future. But one thing that struck me that
might be reasonably useful is some way of filtering the "context" that
a string occurs in (is it in generic code context, in a string or in a
comment). These are things that tend to be reasonably parametrisable
by regular expressions (although escaping string delimiters within in
strings makes completely correct behaviour tricky), so if git-grep
itself were to be extended I'd prefer something that can be specified
per search in a more generally usable way than something very C
specific. Of course this is a quite difficult task as the actual diff
may not contain enough lines to distinguish, eg, that it occurs within
a longer comment. (As already disclaimed, I'm unlikely to actually get
around to doing any of this work).

cheers, dave tweed
