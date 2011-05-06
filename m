From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 6 May 2011 17:26:29 -0500
Message-ID: <20110506222629.GA27945@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie>
 <20110506214801.GA17848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 00:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITTu-0007it-HG
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab1EFW0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:26:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62468 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab1EFW0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:26:36 -0400
Received: by yxs7 with SMTP id 7so1351526yxs.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YAvr2np+C6sw3tZT++CSxOj7laLDEJgGt3U22fYoDgE=;
        b=MJuFnkkkMswKCXLZ1gRoBbzlJCzQjR0f4UELNeRo9e0rlV3KbQlLwFUVpYNnAIHWaI
         aNs46Yu8yhKmEtVHne843EfYomytxLXo1Tt3auPJiBzUls3Dh+su885EddDQdRx0mPFg
         by7b1RdZUlNNqUiBRKyWLi9JU9ff7uQPb9UWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FL35jIaUJmRKCyGpQX+TSOG96eMBXQZy3srko1IvCRhitWppCjgn59FoT9EAjOvp7W
         5S2ve62OlenQPFmPsQa/eqsO2SwHHiAwnGdblN5yOHM1ciuLahKiveUzvRk4Pm/bkR4q
         RpUExoVE6OxMlAIZb1iNpN3iWlxT7k3Pzl0fU=
Received: by 10.150.66.11 with SMTP id o11mr3691953yba.159.1304720796287;
        Fri, 06 May 2011 15:26:36 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id b4sm9913ybo.23.2011.05.06.15.26.34
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 15:26:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110506214801.GA17848@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173021>

Jeff King wrote:

> So there are definitely particular people who prefer different styles
> (and I recalled that Junio and I differed on this style point, which is
> confirmed here). Interestingly, you are the only person to fall right in
> the middle.  I guess that means you are good at emulating surrounding
> code. :)

Probably my older code leaves out the space more often, and newer code
includes it.  There is an odd kind of logic that can be used to
justify including or not including the space, namely:

In C, a function definition starts with an expression that looks
something like a function call, as in "double sin(double x);".  So
when you want to know everything there is to know about the sine
function, you can do a "git grep -F -e 'sin('", and it will return to
you its definition and a list of callers.

The shell function definition syntax looks oddly like an old-style C
prototype "f()".  But do not be misled: to duplicate the above
property familiar from C, one needs to include a space before the
parentheses, so "git grep -F -e 'f '" will return its definition and a
list of callers.

Of course the same argument works backwards: if you want the
definition without the callers, then only the spaceless syntax will
allow you to grep for 'f()'.

Unlike brace placement, this seems to be a question of style with no
right answer. :)
