From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 09:56:11 -0700
Message-ID: <20130608165611.GB3109@elie.Belkin>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
 <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
 <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 18:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMRD-0005mB-Rk
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 18:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab3FHQ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 12:56:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40610 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab3FHQ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 12:56:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so17774pab.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nwEAgrH/f2h4iZC3GpA2X0bVmHEqvJcJKBMJ0yrKF2g=;
        b=uWZ6KQoM0Grb70svnYWg/vWnzsyCMFzAHhNwGkEelrYCurkFyuBpI/JbCFzW5bswE+
         cB0OiK01780cxeRirINzy4rHXOP7r+PUZVxgmHCNqdc4Gxkin3bBO6w/ATU40BCeo7hH
         +6n9Nd1R2+m1u/AZQ7onIe293ur71t2tOaCEtpcbCqcKFf7SQ9SLbQ4BuPjtwrcgwgyb
         qV7kE/mpg+vNhXqr3ML0OJlAZ/WCBmO2b0kYB5qwGQA7IKpt1SdQZ9ESj3Cgswbv0Opo
         +AxfQzXE0dfBKOKxxBHfc9BaID7GqRhF42DVzJIs42vyuzMBqxoy0Z1vO//E0xkwNl/n
         VRBA==
X-Received: by 10.66.82.162 with SMTP id j2mr7639336pay.168.1370710578607;
        Sat, 08 Jun 2013 09:56:18 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ri8sm3668229pbc.3.2013.06.08.09.56.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 09:56:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226840>

Ramkumar Ramachandra wrote:

> How else am I supposed to write them?  If there is a stale state from
> the previous test, there isn't too much I can do.  Or should I be
> cleaning up state at the beginning of each test, instead of at the
> end?

That's one strategy.  "test_when_finished" to restore the set-up
state is another.

Making tests skippable unless labelled otherwise is currently an
aspirational goal rather than a practical one.  Hopefully some day
we'll get there and the test harness can start checking it. :)  It
makes reorganizing test scripts, for example by reordering tests, much
easier.

Thanks,
Jonathan
