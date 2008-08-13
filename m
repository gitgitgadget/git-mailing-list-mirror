From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 10:38:42 -0700
Message-ID: <a6b6acf60808131038s1ae7fb69s2b703c25766a82c0@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <m363q5t152.fsf@localhost.localdomain>
	 <20080813150425.GC3782@spearce.org>
	 <200808131810.19914.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, "Geert Bosch" <bosch@adacore.com>,
	"Andi Kleen" <andi@firstfloor.org>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKKc-0008Es-2A
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148AbYHMRip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757133AbYHMRio
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:38:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:47238 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbYHMRin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:38:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so86914rvb.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9Nnm/7gW1/WfduHlv0AjYa0CLJCXnbudVItuB6a9+yQ=;
        b=u/r2kvkbs1yH66KfkF2Fq4uEmkqTZ6TVuAc38aSc8slXYK8yr1t1RLs7VyeSvIqO1a
         JGZ3TTw9zt/aK7oHSUEnYPQbiAyGxHKeMIJUjds/k3kkgPAxYog0ZGRvv2TVfpqNIUwG
         5V8AEmgaaxvBBFYZa6BTQQ3s02QH2qA342AV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=K7Z0kCfKD1w8CUuMsl5N3zwhZ89ERQCI6ddWHQGbMykx+plDKQOrq312pMVf3FfgMB
         /Jd/gaNjTVKVpwtOhJS7xSXvMBukU/eEuwJ1Zyim2LSCYwGXuu2T91U94aZvWRfxAx93
         SO1/DAlljgjHcE5xXTptEV1lIPm0u1j9V2SYk=
Received: by 10.141.116.16 with SMTP id t16mr63012rvm.280.1218649123011;
        Wed, 13 Aug 2008 10:38:43 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Wed, 13 Aug 2008 10:38:42 -0700 (PDT)
In-Reply-To: <200808131810.19914.johan@herland.net>
Content-Disposition: inline
X-Google-Sender-Auth: 86bb0876e444baf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92250>

> As for how to estimate entropy, isn't that just a matter of feeding it
> through zlib and compare the output size to the input size? Especially
> if we're already about to feed it through zlib anyway... In other
> words, feed (an initial part of) the data through zlib, and if the
> compression ratio so far looks good, keep going and write out the
> compressed object, otherwise abort zlib and write out the original
> object with compression level 0.

This if probably off topic now, but as the OP, I'd like to mention
that I tried setting pack.compression = 0 and it did not solve my
memory issues. So it seems to be that the packing itself that is
sucking up all the memory -- not the compression.

Thanks for all the insightful replies!

-Ken
