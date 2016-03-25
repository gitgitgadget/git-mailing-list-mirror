From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Fri, 25 Mar 2016 12:40:58 +0100
Message-ID: <CAP8UFD0vm1Sn07ickfPz5segbM-M7+HR43CMMGsB9WTqj5s-yw@mail.gmail.com>
References: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
	<CAP8UFD0muBUEp9XknmcTWqg==ChzWP3m-p-v6vXyC09OC88U7w@mail.gmail.com>
	<CAFZEwPM=+U8gC0JRL1Zi6yJboenuSw6hBKJeLNzf_=NYQTCSGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:41:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQ6z-0007ki-5e
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbcCYLlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:41:00 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32819 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcCYLk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:40:59 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so22948845wml.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lP5CNt1/I6tvrkd4c8Z0v8LIkxll/+rNLzZ9CNRZo6Y=;
        b=HSJU0sfz5ywuymeH4a9VgfJmzNojFoP1PmCRYFxPsdVmiIsXfQhGcuhQlW6N1kcGZ5
         /LI/ZRgH0HghGoH/RVvD6LUV/8WQe7IXEEmHRwoQa3eHLv4DboPCphwtyxx5nDkQX6se
         1FykgcMECPtECh6BugruPbw4YE2Wi3PphluRjcYKmS8kKtl1U3MxxmR8w9m5jmCR3g/P
         XpmsSSEf9ReN+PLNV2dNPYOks07BnI5+gKvWt7V0OtYf5MGRi1U76tBp28p3z9ohLKw0
         uJyJVLi09AfTnzxIEOWeh/7m6v+hCpeazMLOTSKZfcajwnacuR/CjIuzvQuDvyEkCqb+
         DUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lP5CNt1/I6tvrkd4c8Z0v8LIkxll/+rNLzZ9CNRZo6Y=;
        b=TjJZO1nqdC6WkjMlOOijkZC5QYd5Lu2glA3HVmOkGFDMcQms0X/mPSpPb+ExKBdCyX
         3J8ckH3JVOTQohruhDoLHa8drG1udu6y40CgSlk9HB5yJ9PphtXs7Zpgu2jxriVWn0jo
         fr4v8rDWB0/f7eH11BAipEpdDTgeEmGnwfrIomOjc6oXpvv7rGgSiXJRLbTft/KB+903
         8L9451EQvoJ7f5ekUjEO+/b4EwqeO0hcsKVPFd8sReKPuwdD+T9+vHMcqzqPvDPzRVSE
         NQKh+8Vj+zaEyOfX1z5XnDkn4Bw0YX0EbsoHoGta1A350SS2yuskGRwJ2ziI1Ynim8Z+
         U8gA==
X-Gm-Message-State: AD7BkJIx4LtoPseaxsSsGOx0qqnxVbMdYIPZa/GYIW5e850+mK3pTik/pcw1HTSXd49004VjpZ/Lahe8mz/8ew==
X-Received: by 10.194.78.37 with SMTP id y5mr14623200wjw.78.1458906058426;
 Fri, 25 Mar 2016 04:40:58 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 25 Mar 2016 04:40:58 -0700 (PDT)
In-Reply-To: <CAFZEwPM=+U8gC0JRL1Zi6yJboenuSw6hBKJeLNzf_=NYQTCSGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289878>

On Fri, Mar 25, 2016 at 11:15 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> - you will add an option to "git bisect--helper" to perform what the
>> git-bisect.sh function did, and
>> - you will create a test script for "git bisect--helper" in which you
>> will test each option?
>
> I had very initially planned to do this. But Matthieu pointed out that
> it would be much better to use the existing test suite rather than
> creating one which can lead to less coverage.

Ok, then perhaps:

- you will add tests to existing test scripts, so that each "git
bisect--helper" option is (indirectly) tested.
