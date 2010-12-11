From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Sat, 11 Dec 2010 01:15:15 +0100
Message-ID: <201012110115.16225.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <4D01A5F3.8030108@eaglescrag.net> <7vzksd9nq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 01:15:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRD7s-0000Lr-8l
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 01:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab0LKAP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 19:15:26 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:59792 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab0LKAPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 19:15:24 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so4387083fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 16:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KpjJIxIvYY3ROJx/TI20Auyw3Q5ge1o/W5RaCBfFDyM=;
        b=ulKeqgmmGRcw1rrPNSZSH0AOMkEV60Y0SdQS4V0PX4XQu5VzJ3oqmlHPvhrg/kgvg0
         MdZDcjqQiitw1VQtCvUEV8PGlpDw3oviXhXEKYveSp2zbeZa+yzcwxdIFZEn6ukoIOXR
         FaLQOt13ccroPYZ/hTPnKmF5smazdhSHQUyOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XFXPPeWogG/1y8ThhaI0p/68j2bIHPenwtNh2vOQZ3Di5kPssO0HF+1tPMO9eieHN9
         HlzBvGR2eIHwwa9ZUFSsvw3yVWLH2JLznBvas0NrmtiRWgxjIF/uUpEvthV5S4VzWSHg
         tXn4M3TnISqk+zf+oa0Ei9uyKMG/sf1+AXeSo=
Received: by 10.223.83.206 with SMTP id g14mr1542936fal.129.1292026523489;
        Fri, 10 Dec 2010 16:15:23 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id n26sm1076352fam.13.2010.12.10.16.15.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 16:15:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzksd9nq2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163452>

Junio C Hamano wrote:
> "J.H." <warthog9@eaglescrag.net> writes:
> 
> > My initial look indicated that perl-http-browserdetect wasn't available
> > for RHEL / CentOS 5 - it is however available in EPEL.
> >
> > However there are a couple of things to note about User Agents at all:
> > 	- They lie... a lot
> > 	- Robots lie even more
> >
> > Blacklisting is still the better option, by a lot.  I'll re-work this
> > some in v9, as I'm fine with the added dependency.
> 
> Thanks, both.  I sense that we finally are going to get a single version
> of gitweb that can be used at larger sites ;-)

I wouldn't be so optimistic.  While we borrow features and ideas from
each other, the difference still remains that J.H. patches are bit hacky
but are tested, while my rewrite is IMHO cleaner but untested (well, 
untested on real life load).

Anyway the main issue that was discovered by PATCHv6 by me, and v8 by J.H.
is that die_error sucks... well, at least if background caching is enabled.

Anyway, J.H. plans v9, I plan shortened rewrite.
-- 
Jakub Narebski
Poland
