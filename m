From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Wed, 6 Apr 2016 23:33:14 -0400
Message-ID: <20160407033313.GA17848@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <xmqqy48qy9mc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 05:33:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao0h9-0008BD-Fb
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 05:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcDGDdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 23:33:17 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33907 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbcDGDdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 23:33:17 -0400
Received: by mail-qg0-f67.google.com with SMTP id j35so6187895qge.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kchNNAAC85uv5V2wu7jDbcRTegLuevl+b6r37sXHjfU=;
        b=nR9yIT4foXzFJwAx3maSeth9BZRotDa/QqkxzR5gfPYECdQVF/0S8wfAGNWKsHEKv6
         qv4FgRMzfUNFbjPdJGq0jGM5g8/ByG/ySp7OT+XMu0KG/tQgVm+FmAuRucyNtHBBUiRy
         iGvzjnn5Yaotq1VXy4Qr0KMzBLIrp5sdxNYAyKaX/+pCjr+8bv7AJpiNcWzhDLM6lJ0C
         V2YbzksPs1KOsOpyNa40tNkWfUjbOlt/7gr1WUqOoCvuETxmUz302OUJoutrtnN2RSv2
         2XAL96qZKzSCYX69EYPIl9e7mURp/L8fCd6ec0AlL1nLLcS+5omDsc2MTx0jsukThJ3j
         ElJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kchNNAAC85uv5V2wu7jDbcRTegLuevl+b6r37sXHjfU=;
        b=N4wH1o52zkkhTRTNWnG3EiPfD/mIJyhFauzQOJJ3ZphYCM6C/vSa7EIG9xx/nMQn5v
         XbRd/GBQahnnmgXIyEaItmSXSCYR4Z9nt/7f16QzoDIRsMbJSBPLM4R/Z+jD1KeGtpMk
         rcWjWuharumeYURIKpGJJ7/6Pcl8DYjyJKT4RedueXmiyFKec/SGXVNOSdQRoDUgUcR/
         Jaibu9lC6w/y76tRXmb0aglLFIqj5yFQ3eh8V4+sqKr8n3f/9IVY6kH4uMkEd8KxfNln
         TU1j3tuJYkoyweMUS1QDrgUja9N0HIMQwMeKRlBLHxiuo7rj3XhDAWAz4vEd+bU2Cpp8
         Nz+g==
X-Gm-Message-State: AD7BkJIksV2TBa+D3p/q2xTrrGxFMMQadELsqL9HHOAn6i2m5xqhLC+wQp2qiD2eOBmo/Mms
X-Received: by 10.140.151.130 with SMTP id 124mr906502qhx.26.1459999995660;
        Wed, 06 Apr 2016 20:33:15 -0700 (PDT)
Received: from LykOS ([12.11.110.3])
        by smtp.gmail.com with ESMTPSA id l12sm2641126qki.19.2016.04.06.20.33.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 20:33:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqy48qy9mc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290902>

Thanks for the reviews!

I'll update the commit messages. It appears that I there's a lot to
learn on my side on the art of writing good commit messages.

-Santiago.

On Wed, Apr 06, 2016 at 09:39:39AM -0700, Junio C Hamano wrote:
> The first three looked almost good.  I do not fully agree with what
> 4/6 does, and update to its function signature is likely to require
> updates to 5/6 and 6/6.
> 
> Thanks.
