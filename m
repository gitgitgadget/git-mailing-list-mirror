From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add hash parameter in feed URL when a hash is specified in the current request
Date: Fri, 21 Mar 2008 20:53:54 +0100
Message-ID: <200803212053.55998.jnareb@gmail.com>
References: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com> <m3skyjvrgr.fsf@localhost.localdomain> <ae63f8b50803211214i59184fd7jde7d640d6a8580b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcnK9-0003ei-UJ
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 20:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbYCUTyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYCUTyE
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 15:54:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:20424 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYCUTyC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 15:54:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1459874fgb.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Pi68RYAXlKFHMv2/H4iQreE7IO1Y8i3QWf1FkHlzjSQ=;
        b=hGSPHliaPyAG+tFN3dEajyXXAhiTcwxIZlHbHhOlAFbJds6RJ3PRxpxjhN8LwBpoGhoTlvZ4BEXmV9Qs+ShotmHXBhO06S5h5Prlbp+Mzd8l8/85LTQScyZFXUgSCybVHZHMb5riwdp29MZ3rbpwm2etwHoI9BLS5Z673aLI0eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MbaSVswTVfFug9lddh7vlB2LDVuX05wc5itBS1gE8pYbBcPZiPLNdSFB7aagNexS9M2vLPC1WAwU2w1lhzRc7DCpHd1EDOprZBLszXjM1ensq1jEUkaFM4DKQViZnrWPpQ4qOujElEvZWj8tXlmChig3+nAFjN9BnmEoOWPurjo=
Received: by 10.82.115.8 with SMTP id n8mr6140825buc.10.1206129240650;
        Fri, 21 Mar 2008 12:54:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.99])
        by mx.google.com with ESMTPS id u14sm6257624gvf.1.2008.03.21.12.53.58
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Mar 2008 12:53:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ae63f8b50803211214i59184fd7jde7d640d6a8580b8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77762>

On Fri, 21 March 2008, Jean-Baptiste Quenot wrote:
>
> I just read your initial post, and IMHO we should keep it simple.  I
> tested the various links, and it appears to be good-enough to pass the
> hash parameter for all URLs that do not specify the hash parameter
> explicitly.  You can still pass it on a per-link basis if you think
> it's too simplistic.

Well, I think it would be a bit more cautious to just pass the hash
parameter to code generating feed links, in all of two places.
I'm sure about implict 'project' parameter, but not so sure about 
implicit 'hash' parameter, but if you have checked it... I'd rather 
avoid implicit parameters.

BTW. one of things I wanted to address (and what made patch long in 
coming) was that redundancy, unnecessary code duplication in feed links 
in HTML header, and in page footer.
 
> Maybe it's not the perfect solution, but at least it will improve the
> current situation where some people are apparently deceived by not
> having a per-branch RSS feed.  Not everyone forges URLs like we do :D
> 
> Oh, and about the title, just appending the hash is sufficient.
> What's important is the contents of the feed.  Users will probably end
> up editing the feed title in their reader after all.

For example 'tag' view has $hash defined, but I don't think feed 
starting at given tag is something one would want to have; tags don't 
change, feeds are about fresh, changing, live information.

When viewing history of a file, we would want to have feed of file 
history (perhaps for given branch)... and that was what I also wanted 
to address in my patch.

-- 
Jakub Narebski
Poland
