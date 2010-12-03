From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 12:13:05 +0100
Message-ID: <201012031213.06321.jnareb@gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031136.09156.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 03 12:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POTZr-0005uX-RT
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 12:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab0LCLNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 06:13:18 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59006 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab0LCLNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 06:13:17 -0500
Received: by fxm20 with SMTP id 20so2069828fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tou/lrt9KWnLzDva+q5FY+ywaAf0iJB3YHp+nYI8Nlw=;
        b=Lp8ZVVjx9V5nXUtH8WLmYI/DFHJNSKg9EYH9Oqp1ciNtvHzrXEkwQKWMpS5r4sKqJm
         mF7BY1xjNY0I2kFTm3su9Z3oY8NY9wq8quFo9PRhYFdgVIdYdHyn/nzHU6zy4dZlRiVt
         W1Q8lcQIJmIMWfXst/M5a628Qel6IIu0Krajc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sViJQSc2H75/PLwwUvVp/rkttS6abaXACFi841WiX5lNUsULgKXLs0Zq6rr7BBSGfY
         3l1pnrTOFoDYZ+oDLtMl/gyBqNU0m8BLKXkSF84UdS9g8qj2TGEd/N73j2AX5dhWKlZX
         7WLkIeFKmzauEufMAs+SNzw/Oh6DAcHBDLoM0=
Received: by 10.223.122.16 with SMTP id j16mr1964665far.133.1291374796220;
        Fri, 03 Dec 2010 03:13:16 -0800 (PST)
Received: from [192.168.1.13] (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id n3sm571617faa.5.2010.12.03.03.13.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 03:13:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012031136.09156.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162790>

On Fri, 3 Dec 2010, Thomas Rast wrote:
> Junio C Hamano wrote:
> > * jh/gitweb-caching (2010-11-01) 4 commits
> >  - gitweb: Minimal testing of gitweb caching
> >  - gitweb: File based caching layer (from git.kernel.org)
> >  - gitweb: add output buffering and associated functions
> >  - gitweb: Prepare for splitting gitweb
> 
> "gitweb: File based caching layer (from git.kernel.org)" does not work
> on my automated tester:
> 
>   ok 1 - setup
> 
>   expecting success: 
>           gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
>           check_snapshot ".git-$SHORT_ID"
> 
>   basename=.git-1005c80
>   tar: This does not look like a tar archive
>   tar: Error exit delayed from previous errors
>   not ok - 2 snapshot: full sha1
>   #       
>   #               gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
>   #               check_snapshot ".git-$SHORT_ID"
>   #       
> 
> Should I disable something with a Makefile option, or is that a bug?
> 
> (If you need more data you need to tell me what to look for, since I
> don't usually do gitweb.  The above is just the relevant snippet from
> 'make test' output).

What are the results of relevant part of

 $ cd t
 $ ./t9502-gitweb-standalone-parse-output.sh --debug

output?

Gitweb output caching should be turned off by default, so it shouldn't
affect tests before 'enable caching' test.
-- 
Jakub Narebski
Poland
