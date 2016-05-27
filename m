From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Thu, 26 May 2016 22:47:48 -0500
Message-ID: <20160527034748.GB31629@zoidberg>
References: <20160525015649.GA13258@zoidberg>
 <20160525223904.GD13776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 05:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68kg-00017F-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 05:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbcE0Dry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 23:47:54 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38698 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcE0Dry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 23:47:54 -0400
Received: by mail-it0-f49.google.com with SMTP id l63so65943639ita.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5q3SYDMIqtZ+H/2kbjAFJHIAg5mUKtlZ6jpGBGkPDFs=;
        b=ycozFOuhx/LJ/yI6jOV2HpDatkdvTKNPSXV5Yf+xvfRrE0jjFhvP4U6pNaC9mK/s6L
         +xf6CoEPt2PEJ40xsNCaXkezCRmZKueyxy1iJF0bi2T+CjMHiJspVhiPLfHf7NW4+iNe
         zQBYI86f/Kox7rlSJr3B7FZ7691DytdkfZvTqwOw9iRqVKYkfMdiBIkSxbDWFYb4LY02
         Oa/FR3cXjN49N+WsQCN2jTbBadjrixsQ8CZGNM0cJzNnJmMV+CHN+B2joFpQ5I1duGDe
         yxD1mZx8a8D9Z0AsmAXwIVMo2rS18IqtWDI7+hFyXkM/2yzwOKzMLDtt0k785U3SRBYw
         DJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5q3SYDMIqtZ+H/2kbjAFJHIAg5mUKtlZ6jpGBGkPDFs=;
        b=UPXCGi0KSZlRQIS6f9NlZ/eoIrI76fPyaUyqat1gGIg03F169FpywsxzeNYwDd2V2t
         FKSyaC/JLX8loaiBHUO26hbgneVa4kGBzd76/RchUhzohT1DjzItJVKVHSLngz+AAa57
         BAWFJxP5vv4sTT9akxazapp6Kmh0/1XAM51Irf4I3rokbKCjNKBYvWhiFWQtKSIhVIeI
         xwham7zWPmP0i/71i/osqf9nKzDsxZq85IsgE06PFTHYCr9JZT2eceZAJPklnbL5Cfix
         spp3RcDiVKbeIGSdgeIg7QY5SpgdWNn+0XCDBjs2E3RqrhelknmghbVzK1qAhoNo0NFw
         5i1Q==
X-Gm-Message-State: ALyK8tIkFGp2fjze6m1SLEjmTFgWhsB09nvP1h0VzUYk/UJTiq4Zv+uPXmXQbNTibSv5Og==
X-Received: by 10.36.160.5 with SMTP id o5mr6527013ite.31.1464320873200;
        Thu, 26 May 2016 20:47:53 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:3125:f490:e3f1:e1d])
        by smtp.gmail.com with ESMTPSA id k72sm2103455ita.17.2016.05.26.20.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 20:47:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160525223904.GD13776@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295723>

On Wed, May 25, 2016 at 05:39:04PM -0500, Jeff King wrote:
> Looks like we didn't have any tests at all for %C(auto). And the tests
> for %C(auto,...) were labeled as %C(auto), making it all the more
> confusing. Perhaps it is worth squashing this in:

Thanks, peff.  Indeed I did squash that into my updated patch.

-ed
