From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 06 Aug 2009 19:22:46 +0200
Message-ID: <4A7B1166.8020507@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 19:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6gL-0000i2-1g
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbZHFRW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbZHFRW7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:22:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:27808 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387AbZHFRWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:22:51 -0400
Received: by qw-out-2122.google.com with SMTP id 8so410419qwh.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=OzyJfzE1Er0e3bu62hrcvvJM27z5CRygsRRhKV9rt74=;
        b=oCTdCPJdhXZgz6SsqCAlJeQaC43eVYpMFzcTaLfYedULiCijxoo6ZGN7/e2xAyZbaY
         +QphmY2/xjdrR5jbKYcd6LooCMz05Uqbv3p2F630WRDNYMZIqsrwMeOSE+ohtUniIRl0
         AF0NXlc1cAv58TSfBTKT0e5uhip+nNfIyJM44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ChxjJjKNei4xyVWcQvTjq3UA+0STGl+tO2su2BoutMrLjy0+KSacIY38V17pTJkUqJ
         3IaxubkARFBSFiUs4o28DzkGDnIjz8qyCox3Hi3Qk/GWaetuTPdKw9V/js13olBCQxyy
         yDuuKUeTYTNodqzuuarVFhkLTJT6XGPBKEfHo=
Received: by 10.224.6.66 with SMTP id 2mr179990qay.143.1249579371863;
        Thu, 06 Aug 2009 10:22:51 -0700 (PDT)
Received: from ?172.19.43.221? ([72.14.241.5])
        by mx.google.com with ESMTPS id 2sm278926qwi.43.2009.08.06.10.22.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:22:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125097>

Linus Torvalds wrote:
> where the thing is loosely based on the Mozilla SHA1 routines but by the 
> end doesn't really resemble them all that much. The Mozilla ones suck 
> donkey d*ck in so many ways - unnecessary copies, idiotic byte-at-a-time 
> build-up of the hash input etc.
> 
> The end result is pretty much equivalent in performance to the OpenSSL 
> SHA1 code for me on x86-64. Getting rid of OpenSSL gets rid of another 

For those curious just how close the C version is to the various
asm and C implementations, the q&d microbenchmark is at 
http://www.src.multimo.pl/YDpqIo7Li27O0L0h/sha1bench.tar.gz

In short: 88% of openssl speed on P3, 42% on P4, 66% on Atom.

artur
