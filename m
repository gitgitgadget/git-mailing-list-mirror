From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Wed, 10 Sep 2008 12:53:07 +0100
Message-ID: <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com>
References: <20080907184537.GA4148@regex.yaph.org>
	 <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
	 <20080910100301.GA27748@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Arjen Laarhoven" <arjen@yaph.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 13:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdOH4-0005Ef-MO
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 13:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYIJLxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYIJLxK
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 07:53:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:13472 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYIJLxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 07:53:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2357201rvb.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ShaMUEDXSdAAxXabFjgo6JdkYWQ0cLYQHIsMb8GMwKw=;
        b=tG6OY1a6B90D7zemirGhz1EWyGyQ8NdKFlr37wzAiIM5VNrPrdCkjm6mTrriMs7q5X
         cRwFuuT1De2XX+9oYg02BRPKfpy4VZUALTtxUO2OKNhGCG4uVj0hNbg1Pm6busGyx1xl
         nwgebTcT8Q3//oG20JnNRG5PlMhNrjOCjxkmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fXkn0BtMskfIDJlEoIRKTLJIyCKsoIBdKHtM+ng8BCJDnbqPXoBrZCq6wlanIvbF0+
         Lej3OAjf6innnAN53c2HIjeD/tRc7QvnmK91h57EquA/kb1dIqbnLHfIlZQhbfnT5BIz
         pRkQ8ereaPXblxmPsZPSYabsYfCiesXpEEE/s=
Received: by 10.141.52.5 with SMTP id e5mr706274rvk.125.1221047587886;
        Wed, 10 Sep 2008 04:53:07 -0700 (PDT)
Received: by 10.140.143.2 with HTTP; Wed, 10 Sep 2008 04:53:07 -0700 (PDT)
In-Reply-To: <20080910100301.GA27748@regex.yaph.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95513>

2008/9/10 Arjen Laarhoven <arjen@yaph.org>:
> On Wed, Sep 10, 2008 at 09:03:05AM +0100, Mike Ralphson wrote:
>> 2008/9/7 Arjen Laarhoven <arjen@yaph.org>
>> > The standard libc regex library on OSX does not support alternation
>> > in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
>> > functionality on OSX.
>> >
>> > Also, I'm sure the problem occurs on more non-Linux systems (or non
>> > GNU libc systems).  If people who have access to those systems (BSD's,
>> > HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
>> > patch so it can fix for multiple systems at once.
>>
>> I can confirm that the issue shown up by your new testcase is also
>> present in AIX 5.3.

>> Adding -lcompat/regex to COMPAT_CFLAGS as per your Darwin hunk
>> provokes lots of warnings:
>
> I think your problem is a lowercase ell instead of an uppercase i ;-)

Doh. I think my problem is this font! And having not used a language
with a separate linker since last century.

I guess I picked a really bad patch to try and pick up and test direct
from gmail. No reflection on your patch, just my workflow.

Having carefully checked the content of the testcase too, I can now
say this does fix the issue without extra warnings or testcase
failures on AIX 5.3, so for what it's worth:

Tested-by: Mike Ralphson <mike@abacus.co.uk>

Thanks both, and sorry for the noise.

Mike
