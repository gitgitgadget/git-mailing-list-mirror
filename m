From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v18 16/48] refs.c: add an err argument to delete_ref_loose
Date: Thu, 19 Jun 2014 08:56:58 -0700
Message-ID: <CAL=YDW=Xj49fxUvuFU8s-9c6iB=rVoc6+AAbKYuBVMvSPGznOA@mail.gmail.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
	<1403020442-31049-17-git-send-email-sahlberg@google.com>
	<53A1FAF8.4050700@alum.mit.edu>
	<CAL=YDWnbKTysV=OaDuxOz10=QbpSWkzmoYteSeq_-Fv=HtcOSQ@mail.gmail.com>
	<53A21500.2050508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 17:57:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxei1-0001gz-8F
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbaFSP5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:57:00 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:42331 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbaFSP47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:56:59 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz11so2478821veb.31
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N1SIKCJD0kCFyMX2ucR0tr5ssQIYlrBTqInGtGJ8k5M=;
        b=iRNxlnRPiGHioUrFegPoLXuS7m27J/XrdNHmT3cvzQJPBuIwXC3If4FPdn+Ma9pYKM
         mbCPtK6B6Frs4WB2Pjzg2lcSiwct5GC9TJGykIdS2xtIkzo5JmEy6bLaQVEckPWUqAq2
         NoqFAkYV2tNDgf5/YbK8RuAGGRHQtSUpPkD8Xt7vzTjg+uVkScqJ/67GbN66l0VCAnUp
         oxZ7qrx7sbH2FXrAplGPAcT6Bb4dtVvwSiUAihxeE5c3iXHHsTeGOFoFfj9XHv39+aDf
         31gwpxvAYRNtLvfq0Zal+fy3CTtS6ni/QNxtCevGI1kA0ekd88Q+6uiJKQD4Ocjd1k/0
         d5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N1SIKCJD0kCFyMX2ucR0tr5ssQIYlrBTqInGtGJ8k5M=;
        b=gQhxpKWTX4y8GBqVSHgzvGV8siSp30zFhfU8KfIybFCb/UfHX28PMQLHra2dbIIuop
         xwJOx2OyuFaGeoDciSs6T7mlv1w1e3cRXv7riUrc2BrP4xSC8lnp7rkrPCv7YIxXfQcA
         N6nZQHsp3BGTlWK4WqvSoJsx2xBKxkpxN0q/fLiGaLygEpMfLc+DLmICNcc7zw5q941G
         MhbBCWr4mbm+CfZ/U3+KROvCnc398D/4ALnIvKwdi9r8OWbYFolqDORhiWRRSF7FIGho
         nTZH5B1Oo+j7Yr99F20K/Nz1grCqdS3lka1XPVMAMhg6WEjuTWwS7Lut3er+nuGUpJ0a
         GRcA==
X-Gm-Message-State: ALoCoQlfxeSN697TySHAaYATdxI0jpraF1wGAZkuRhnn8lBtjruGtftmg66kstPLbf2S3lIVH9V1
X-Received: by 10.52.130.18 with SMTP id oa18mr818495vdb.78.1403193418439;
 Thu, 19 Jun 2014 08:56:58 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Thu, 19 Jun 2014 08:56:58 -0700 (PDT)
In-Reply-To: <53A21500.2050508@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252164>

I have resent v19 that does
1, remove the spurios redundant errno line
2, fixes the type
and
3, reorders the patch as mentioned previously in this thread.

This I hope will be the final version of the series we will need.

regards
ronnie sahlberg

On Wed, Jun 18, 2014 at 3:38 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/19/2014 12:27 AM, Ronnie Sahlberg wrote:
>> It looks like we need to reorder two of the patches.
>> This patch needs to be moved to later in the series and happen after
>> the delete_ref conversion :
>>
>> refs.c: make delete_ref use a transaction
>> refs.c: add an err argument to delete_ref_loose
>
> That agrees with what I have found out since my first email.  The
> failures go away starting with the later commit that you mentioned.
>
>> I will respin a v19 with these patches reordered.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
