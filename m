From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
 requirements
Date: Sat, 17 Dec 2011 02:45:13 -0600
Message-ID: <20111217084513.GA27411@elie.hsd1.il.comcast.net>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
 <20111102182015.GA11401@elie.hsd1.il.comcast.net>
 <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
 <20111102220941.GA3925@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 09:45:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbptm-00018g-LC
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 09:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab1LQIpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 03:45:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33314 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1LQIpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 03:45:22 -0500
Received: by iaeh11 with SMTP id h11so5585210iae.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 00:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XAm9vJ9b/UiqbFZZIrBMNKD3M4LJEl/qtg9Li1UWjgA=;
        b=ZLlNupo5nmOsJmUTqcGvGZ5zAJcRaInSSV4bRYc1uK3qhfn86QCsNM5m+CNTeuZa9M
         doymMKPBNAqLAjQMgmEHYCTG3RZ6GBHwEtqLsSy1SitVxlr96tzzAeADayoZq0Ira69A
         ggsuCBM88wkCtLmkhLHN3B4MKLfaMPWSR6a5Y=
Received: by 10.50.15.130 with SMTP id x2mr13495262igc.21.1324111521942;
        Sat, 17 Dec 2011 00:45:21 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id lu10sm18809953igc.0.2011.12.17.00.45.19
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 00:45:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111102220941.GA3925@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187352>

Hi Eric,

Eric Wong wrote:

> I don't have much time to help you fix it, but I got numerous errors on
> SVN 1.6.x (svn 1.6.12).  Can you make sure things continue to work on
> 1.6 and earlier, also?
[...]
> Here are the tests that failed for me:
>
> make[1]: *** [t9100-git-svn-basic.sh] Error 1
[...]

I tried the patch with subversion 1.6.17dfsg-3 from Debian and all
tests passed.  Odd.  Could you send output from running the test with
-v -i with Ben's patch applied?

Ah, the subversion CHANGES file mentions a bugfix that might explain
the difference:

| Version 1.6.13
[...]
|    * properly canonicalize a URL (r984928, -31)

Thanks,
Jonathan
