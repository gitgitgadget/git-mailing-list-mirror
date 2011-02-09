From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Column output
Date: Tue, 8 Feb 2011 23:42:10 -0600
Message-ID: <20110209054210.GA2019@elie>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <20110208224745.GA14190@sigill.intra.peff.net>
 <AANLkTi=WKnj8M2Uh+ACSay1STgOhWAjQbmspYSja3y0+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 06:42:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn2op-0006GT-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 06:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab1BIFmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 00:42:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54605 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab1BIFmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 00:42:16 -0500
Received: by iwn9 with SMTP id 9so6462554iwn.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 21:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AOOwNRQIdjYtuY+cYd3ZIaSzzEErJhLYANCAuSCkgLU=;
        b=YZ4KPtngF8kPYdG9B6xwr0rXNlvQeneKOo8wMLWfkSr+/crgrGeUA2NVbuh+iK3tqo
         ZOT1yJjBVhbON5/hWPFLaYErDPwaYq0e8aEXKd71WG5NYV+cHePzdh4EurqTicKbicJM
         AEE3g2NNJal/RTirRAB2YOoq2UMc3kB4KkvSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wgMVrcaukd6X8oTNZXR4XsX7rU1X4qV79UL1LFWgbFJMVH9RLFv9EGyiH+fE4vUKO3
         p89f7ffPjmrMwahlw+2YukjZlAmCHX7oXPIvztBBUNmskndnjLgxxGpNI2asrkHoICO+
         ++jYMMyx9z5dpM2YrSBAB3i1PpetigTaV2u6Q=
Received: by 10.231.12.68 with SMTP id w4mr20299682ibw.50.1297230135634;
        Tue, 08 Feb 2011 21:42:15 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id u9sm432841ibe.20.2011.02.08.21.42.14
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 21:42:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=WKnj8M2Uh+ACSay1STgOhWAjQbmspYSja3y0+@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166392>

Some general reflections.

Nguyen Thai Ngoc Duy wrote:
> 2011/2/9 Jeff King <peff@peff.net>:

>> I don't really care for column output myself,

Me neither.  I tricked myself into reading with a vague hope that it
might lead to a porcelain-level "git ls" command.

[...]
>> But why not use the BSD column program?
>
> Solaris did not have one last time I checked. Windows obviously does
> not either, but I don't use msysgit so it does not count.

A good reason to port the "column" program, no?  I admit I find this a
compelling excuse not to bother with getting --column options and
core.column configuration right.

All that said.

Patches 1, 2, and 5 replace git help's existing columnation code
with something more reusable and functional.  After those patches,

	git --paginate help -a

no longer forces 80-column output.  Another application of
term_columns could be to teach "git log" and "git log --graph"
to wrap to terminal width some day.

So if I ran the world, I would put those three patches before
--column et al in a possible reroll. :)

Thanks for some clear and pleasant reading.
Jonathan
