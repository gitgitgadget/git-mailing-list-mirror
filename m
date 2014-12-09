From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 15:07:48 -0800
Message-ID: <20141209230748.GA3442@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209224949.GB16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyTso-0008VP-NT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbaLIXHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 18:07:51 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:62095 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbaLIXHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 18:07:50 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so214875obb.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oOxDg8BRwd3OP4k2R00G89XdG07EpPJoHNBLZ4Ie0CA=;
        b=imQBh1QKPsyjMwJuoGRCBbd7LB+PCS03LDpYZPJrCMj6G8c4AzHuMbfL5UPelHmIfg
         JKbzeGIKFtJ2SDFwsHbmEdfZkvepXvvxlpMXeq1tb+7mcAezdHERUng6nSCalyitPAxT
         /U2oeoO8Mgc9ZNJAZIUB7bYoTNHMEDqxxd/xAbrdNP+3HWSWldZX2vM70Xwb9x9cK1V/
         zkYl9dgMvPH6JbbMbMoxkP2wMFno/lbtl0tRCOOND+VgVbiSiHnz6XEqKhKUPv/prRPS
         35G9xT+7d9OcPkGDlH/hQXj+BIVwL7IABopDv9vYZ6jyts4jSBpleLqu866D1ZGidTvd
         vCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=oOxDg8BRwd3OP4k2R00G89XdG07EpPJoHNBLZ4Ie0CA=;
        b=ILA2zmUziA/w4Q9WFGr4AZiJjscwAq73LjzSXFNc7OmbDx078Fnqzlx9YKkrxRDQ7c
         M7Q/ZY3Vvv4F7519Kzvz3RgP8ANrvQKiSbK2RldYDr/mculnMLSWRmBaHNo0w7odLKZU
         +9iWh2e9AdJXFo41qy4vKsbvbJL3LcNsxL1o4oJDB+OT6HtiTbOLdSjQAsnmoAbNSGdv
         WMZKZxuzMZe10hZxjTdW6DZl1vCd0CQe47cil7RKCa/EKWLjEQ9DYV2XOoBa63smhsG9
         xfFDVV30SoUsbryLGxjDdoQZX3wsvuILOpiyaVVhN5jK7iM2QJtrAy4dV9n599nkYj4y
         9Ceg==
X-Gm-Message-State: ALoCoQkLdxdiMpLPFHr/PUX+81Kdyo13yJbX3brNq4qKWpcEVRF8+OCfcpPmeC19lryWcdWhOuyE
X-Received: by 10.182.120.8 with SMTP id ky8mr1044801obb.14.1418166469490;
        Tue, 09 Dec 2014 15:07:49 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id u7si598676qcf.2.2014.12.09.15.07.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 15:07:49 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id FXsS49t9.1; Tue, 09 Dec 2014 15:07:49 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 6E602140BC4; Tue,  9 Dec 2014 15:07:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141209224949.GB16345@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261174>

On Tue, Dec 09, 2014 at 02:49:50PM -0800, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> > Stefan Beller wrote:
> >> On Tue, Dec 9, 2014 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >>> Perhaps the API doc that currently says "Free" is the only thing
> >>> that needs fixing?  And perhaps add "See $doc" at the beginning of
> >>> the header and remove duplicated comments we already have in the
> >>> file?
> >>
> >> The reason I wrote this patch originally was because I seem to forget we have
> >> more than one place to document our APIs. If there are comments in the header
> >> I seem to have thought it were the only place where we have documentation.
> >
> > How about this patch?
> 
> And another:

this goes on top or replaces the previous one? (This applies cleanly on origin/master) 

> -- >8--
> Subject: put string-list API documentation in one place
> 
> Until recently (v1.8.0-rc0~46^2~5, 2012-09-12), the string-list API
> was documented in detail in Documentation/technical/api-string-list.txt
> and the header file contained section markers and some short reminders
> but little other documentation.
> 
> Since then, the header has acquired some more comments that are mostly
> identical to the documentation from technical/.  In principle that
> should help convenience, since it means one less hop for someone
> reading the header to find API documentation.  In practice,
> unfortunately, it is hard to remember that there is documentation in
> two places, and the comprehensive documentation of some functions in
> the header makes it too easy to forget that the other functions are
> documented at all (and where).
> 
> Add a comment pointing to Documentation/technical/ and remove the
> comments that duplicate what is written there.  Longer term, we may
> want to move all of the technical docs to header files and generate
> printer-ready API documentation another way, but that is a larger
> change for another day.
> 
> Short reminders in the header file are still okay.
> 
> Reported-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks a lot for this patch. It's improving the situation a lot.
No information is lost albeit many deleted lines, have a 

Reviewed-by: Stefan Beller <sbeller@google.com>
