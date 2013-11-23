From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 16:47:54 -0800
Message-ID: <20131123004754.GL4212@google.com>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121114837.GB7171@sigill.intra.peff.net>
 <20131123002405.GK4212@google.com>
 <20131123003014.GA11012@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 01:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk1OG-0005tA-A8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 01:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab3KWAsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 19:48:00 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:56423 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab3KWAr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 19:47:59 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so1366787yha.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 16:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HKX+vDq6O3HaJGo2+kkODHHdJ11DbSP/kWpuAsZWxIU=;
        b=rUUJU90G9nOT7/+j+0U7rY3yo+a4sp+JqkhavoS0zmbzO+kmq1z2lVLE0FjTbD9xhL
         NhQV+7vHrypOnNH/ZpW+300aMOOOdsrgh58R6iyNyNKJYf/5a62eMk4vxGQ/brTV7uZ7
         67XR38SLJaT5i5Sfws8LkvtfALjujqEOgYjz8AKtWZTJDJcFhUNH2BsrjqL3qLtMhYUv
         eMc7PMhotlBSK1hq2fAKgmGdiCnnh5gHRCOp/n9PWj46IygTezenKROtospZWGtmxAEo
         DzzKkujyszI2pU8Nb6W79U+y9X+dkSUpXGaL+wW/24tPFVPvevKVzkqluoL+Z7PAalRI
         qP+w==
X-Received: by 10.236.100.144 with SMTP id z16mr14244137yhf.9.1385167677465;
        Fri, 22 Nov 2013 16:47:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id n48sm59817307yho.24.2013.11.22.16.47.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Nov 2013 16:47:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131123003014.GA11012@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238225>

Jeff King wrote:
> On Fri, Nov 22, 2013 at 04:24:05PM -0800, Jonathan Nieder wrote:

>>>  t/t1013-loose-object-format.sh                     |  66 ------------------
>>
>> Hmm, not all of these tests are about the "experimental" format.  Do
>> we really want to remove them all?
>
> I think so. They were not all testing the experimental format, but they
> were about making sure the is-it-experimental heuristic triggered
> properly with various zlib settings.
>
> Now that we do not apply that heuristic, there is nothing (in git) to
> test. We feed the contents straight to zlib.

Ok, makes sense.

In principle the tests are still useful as futureproofing in case git
starts to sanity-check the objects as a way to notice corruption
earlier or something.  But in practice, that kind of futureproofing is
probably not worth the extra tests to maintain.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
