From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Tabs and spaces (Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate
 --date=local)
Date: Wed, 20 Apr 2011 19:07:01 -0500
Message-ID: <20110421000701.GA10987@elie>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net>
 <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 02:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QChQi-00066t-9j
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 02:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab1DUAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 20:07:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45151 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab1DUAHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 20:07:09 -0400
Received: by iwn34 with SMTP id 34so1008748iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SngNUDeUhVb8I2OCkUVuWRRjvVuZhVDHHAsSMpE7xmI=;
        b=bp7cgtRoTXr13Gx6PMv6v/OaYBUfsvZaiW+SoXmQdJkegoNcpc0yyGFd3TWvMohmyc
         QPmUCe/xgOcrQUV7D34xh5rg1pHH61E4AdkrGgMi6fCwmUXfcORr63s0CR4un3eBqnXJ
         M+AoH0egY6zAPQsdBJ5Y6Q5fbWzybWuBOgLIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=seQcXTzq1ZlToA4Dm75Sx4CC9lRXgnnUUjnHxM3rSigEjyBjSU5t0OJPaLk06GZcKi
         3OQJNO2VmJLdeMlZS7OG3ZKvZ+YJQaX2PmC5h6USup2t1H+hiytm6rLYSGs60NReI3Qn
         uqVvHrBhB/Qx+CPTFba6k3OlxUCRDCOQQ+agw=
Received: by 10.231.130.153 with SMTP id t25mr6223991ibs.135.1303344428178;
        Wed, 20 Apr 2011 17:07:08 -0700 (PDT)
Received: from elie ([69.209.64.141])
        by mx.google.com with ESMTPS id i20sm536256iby.14.2011.04.20.17.07.06
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 17:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171883>

Hi Michael,

Michael Witten wrote:

> and I'm also responsible for this massive git flamewar of yore on the same
> subject:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/61095
>   Message-ID: 634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu

Heh. :)

> However - and this is the key point - if you are going to be mixing
> tabs and spaces ANYWAY, then you might as well do it in a way that
> maintains alignment within a tab level regardless of the current
> setting for the tabwidth:

In principle, I generally agree.  But as mentioned in the thread you
reference, most text editors don't make that very easy.

I personally use a tabwidth of 6 when I really want to concentrate on
reading.  When coding in a rush for other people, that leads to using
tabstop of 8 and only aligning text that is much shorter than one tab:

	if (foo && bar && baz &&
	    qux && quux) {
		...
	} else if (quuux(quuuux, quuuuux,
				long_expresion_comes_here(quuuuuux))) {
		...
	}

As you can see, this is following the "put continuation lines near the
right margin" convention advocated in linux-2.6's
Documentation/CodingStyle.

Two advantages:

 - looks sensible with any tabstop
 - no need to cascade changes on following lines when the width of a
   function name changes

One major disadvantage:

 - annoys people who like everything nicely lined up.

For what it's worth.  (Not much, of course --- the best rule is as
always to make sure your code fits well with the code around it.)

Hope that helps,
Jonathan
