From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 2 Apr 2010 08:43:00 -0700
Message-ID: <y2rd411cc4a1004020843we196537ak35ab6006ce28fefe@mail.gmail.com>
References: <m2wd411cc4a1004011514w6d350ac7l15ab6bb1a6be8d89@mail.gmail.com>
	 <7veiiymk75.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 17:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxj1o-0003pv-2W
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 17:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab0DBPnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 11:43:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43598 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0DBPnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 11:43:01 -0400
Received: by wwb17 with SMTP id 17so1441388wwb.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xd1DMKx0vJUjJ6kp8/rT9yQXNA5kpEPis8iADK9Llag=;
        b=XyLcFF1kYkfVAQ4KMRc7/xmILOKBxAFuIEvPEg8+n+khPeFRlRcGcmNHNL2WHfnI++
         czIZkBjqOp8a8kmpWQilGGuFBkgKqZnL1X7xTijWRf1ub06DNuG/OncBsSjYIC/2CmrP
         BEQ6duNm6PQzK6DyNKGMUqtK2lHMaIYV7AJvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rrc2wWUX5qD08gq5O4b7F4iIYhNqckwNvXadEUmx4L/0ul0gIHTXLURAwgvvB+DX5K
         6ejfKoT2DbWDJfS7Fbwkkd9cRYwL44cVY5F63F3c0sXH1XfjekQYDMsI6ny77c6Nr3D0
         AKBU46ACxzwUQaTP6+fhOVsP3DqbySOxfO2Q4=
Received: by 10.216.10.66 with HTTP; Fri, 2 Apr 2010 08:43:00 -0700 (PDT)
In-Reply-To: <7veiiymk75.fsf@alter.siamese.dyndns.org>
Received: by 10.216.162.204 with SMTP id y54mr1274931wek.224.1270222980185; 
	Fri, 02 Apr 2010 08:43:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143821>

Hey,

On Thu, Apr 1, 2010 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> An obvious enhancement could be to make "http://user@host.com/repo.gi=
t"
> ask for password lazily. =C2=A0Then such a URL can be used even for a=
n access
> that does not need authentication and the user does not have to promp=
ted
> for the password each time, which was what you wanted to really solve=
, no?
>
> Actually that could not just be an enhancement, but might be a better
> alternative solution to the problem, but I haven't thought things
> through.

Actually, what I want to do is be able to show a single URL that will
work for everyone - both read-only and read-write users, so I much
prefer the way I wrote the patch.  This way, GitHub and kernel.org and
whomever else can just publish the one url and it will prompt if they
need auth for some reason, and just work if not.

I do however agree that if someone _does_ put their username in the
url that it should only prompt for the password if it 401s.  That
should probably be a separate patch, though.

Scott
