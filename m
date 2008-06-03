From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 15:00:20 +0200
Message-ID: <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
	 <m34p8a2173.fsf@localhost.localdomain>
	 <b77c1dce0806030503r55c95d73t5ff244821f76cf1@mail.gmail.com>
	 <200806031445.23002.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 15:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3W8Y-0000Vh-Qg
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYFCNAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbYFCNAW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:00:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:57021 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYFCNAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:00:21 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1566825rvb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=atUW1N03k5ptljCQgZq5kEOfOxYhGdC9eDXgmL/s/ho=;
        b=t4tOb8Xav/ku5+zVcrGSnzk/WsUdmWfa1e8mCjm6VRpDnA1iXBqJkQ1Tl/KXE188LUgrUS9AmF2PSv3p08CkcOCC47Chpav34rHBW3YUG/R/0CuBlGFv2CK9zOZDZy+ZsGu8lS2zLpF+GqtIvOugldZK6RH3w3NJ9mbbIbbPXt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A8O298nWp3M69ZBTCkYl/ORBhPhYAN5sIJmG3I5Ax2pYDrNziFFIUtKBlWtiZUlcn/QLDH9WAFmOLVZK/pflXZk+eEl1HZEnHtsdLquWbjmVCV89DdOJ8w1zq6yfd7gHRtwyDDD6P10Mqx0egAQFeNc+3cMr71FpIq1H74d6dcI=
Received: by 10.141.107.13 with SMTP id j13mr5691635rvm.276.1212498020538;
        Tue, 03 Jun 2008 06:00:20 -0700 (PDT)
Received: by 10.141.178.21 with HTTP; Tue, 3 Jun 2008 06:00:20 -0700 (PDT)
In-Reply-To: <200806031445.23002.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83651>

2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>>> I'd rather remove this, correct it, or make it optional (this is very
>>> fork-heavy).
>>
>> Not sure how to do the same thing in pure Perl.
>
> I was thinking about extending git-blame porcelain format (and also
> incremental format, of course) by 'parents' (and perhaps
> 'original-parents') header...

OK, I see. That would be nice. Also: currently taking "$full_rev^"
directs the user to the parent commit, but it would be more
user-friendly to point at the previous commit where the selected file
was modified instead.

>> We could however cache the results of git-rev-parse, since the same
>> rev is likely to appear many times in the list.
>
> ...but starting with cache of git-rev-parse results, or optionally
> allowing extended sha-1 syntax (including <hash>^) in hash* CGI
> parameters in gitweb would be a good idea.
>
> But as I wrote, I'm fine with the patch as it is now.

I've sent a new version (take 2) with caching. And comments, as Lea suggested :)
