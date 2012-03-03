From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [git wiki PATCH 2/3] "Designing a faster index format" project
Date: Sat, 3 Mar 2012 10:30:17 +0700
Message-ID: <CACsJy8DWKaZZfp4kyj3bkBVF3yzzFa24uMDfoxVc=ATWs1uRew@mail.gmail.com>
References: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
 <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch>
 <7vobseeu9i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 04:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3fge-0001HV-6S
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 04:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab2CCDat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 22:30:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:39896 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2CCDas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 22:30:48 -0500
Received: by wejx9 with SMTP id x9so1402805wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 19:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AJmOI8/stcER/fW1sztx/TWlvnszvT5p/I8fJzSa/II=;
        b=B3RI/vtI4wTQHUF4g/N26bQzHPMOOCPfbSxJ3t5mNsMOwSwFpLbblq7OSoZFXfWNMm
         KTjc6ecMTD951LzwwOEBr8OVdxGXfGg1k4oifFU7oVfNNxqtO7ltUAzJmsuwjueywrAa
         ag2AmXQURR71y2ds02o7i8wBoFCIaYlmTBUKcmwUsU6XDIOiWnZsuIueayHP/8YO+aeB
         9kpPHU66K/wkK0iztaqY/4orCWS30k7yIb2PwOhmcE7kCaenJPdHVcoNoOSeqPeBSZxk
         yQ29MpQSsvpNGKJC2yKR7+AmoBfhdpbdCwFNprwFa4rp5yM1+XxPDjlP5tUU1B2bGHsf
         IVeg==
Received: by 10.180.99.65 with SMTP id eo1mr1200783wib.13.1330745447235; Fri,
 02 Mar 2012 19:30:47 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 19:30:17 -0800 (PST)
In-Reply-To: <7vobseeu9i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192094>

On Sat, Mar 3, 2012 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Having harder and more ambitious ones in the mix is OK, but I suspect this
> one is probably a bit too ambitious to be realistic for a student project
> that lasts only 3 months.
>
> This proposal is about a change that touches core parts of the system that
> has the chance of inflicting permanent damage to end users' histories.
> I'd have a hard time reviewing and convincing myself that the change is
> good, if such a change were done by somebody new to the system, even if
> the work were mentored very closely by one of our top 15 committers.

I was comparing the excitement of seeing this implemented vs packv4,
then realised the complexity of work may be more or less the same.
But, if the new format is not mmap'd for direct access, we can
reconstruct "struct cache_entry*" exactly as it is now from new
format. That makes it less sensitive to the core parts and we still
hopefully benefit from new format (mostly I/O I guess). Phase 2 could
come later to make core parts aware of new format.
-- 
Duy
