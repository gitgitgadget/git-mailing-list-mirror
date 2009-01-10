From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 14:36:46 +0100
Message-ID: <200901101436.48149.jnareb@gmail.com>
References: <87wsd48wam.fsf@iki.fi> <gk8usj$slh$1@ger.gmane.org> <alpine.DEB.1.00.0901101237050.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLe2i-0001c9-Pf
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZAJNhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbZAJNhD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:37:03 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:54597 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZAJNg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:36:59 -0500
Received: by ewy10 with SMTP id 10so10697963ewy.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8Xrce1RZegUvV0IGNV9GIYjtV1q7j4PJ2Frr4dWHgeQ=;
        b=xuSw4oPcCTeoPhk4RmqsWtS80y/OvE4x6RTwngZHVEcyGdV6YcFcmW5q5RcZifPQ+9
         fNUEAu7AWQxgvopfHQgKg5O9oRtOr4EluJMEzl9UYRA062vN1tPNZvE4/UMuo0Ok9P9p
         T9Kcj89mThUAD/MtVmcZHjYyir50sZRNYup5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UEQkx0kTuKWj+vcCZTUxEVtnn71+hmflTTIpPgRcDDrbgo1NHpD12ez/0bKw1Mkctf
         swG5n2FXNagf3NFCC/tlvgyIZT+R9aTz4jOkGOijjXsz5TdiwcK8ScFZr7BqxNqblT9A
         qwBlhA+fy1GfYvC/bjwg9j8znuxtQu9VolT5A=
Received: by 10.210.54.17 with SMTP id c17mr9899691eba.71.1231594617169;
        Sat, 10 Jan 2009 05:36:57 -0800 (PST)
Received: from ?192.168.1.11? (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 24sm731458eyx.55.2009.01.10.05.36.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 05:36:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0901101237050.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105103>

On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> On Sat, 10 Jan 2009, Jakub Narebski wrote:
> > Thomas Rast wrote:
> > 
> > > --color-words works (and always worked) by splitting words onto one
> > > line each, and using the normal line-diff machinery to get a word
> > > diff. 
> > 
> > Cannot we generalize diff machinery / use underlying LCS diff engine
> > instead of going through line diff?
> 
> What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
> That's why we're substituting non-word characters with newlines.

Isn't Meyers algorithm used by libxdiff based on LCS, largest common
subsequence, and doesn't it generate from the mathematical point of
view "diff" between two sequences (two arrays) which just happen to
be lines? It is a bit strange that libxdiff doesn't export its low
level algorithm...

-- 
Jakub Narebski
Poland
