From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Thu, 28 Jan 2016 16:09:02 -0500
Message-ID: <20160128210902.GE9629@LykOS>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <xmqqwpqwavtf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:09:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtoU-0005py-7Q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbcA1VJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:09:06 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36722 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcA1VJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:09:05 -0500
Received: by mail-qk0-f172.google.com with SMTP id s68so16577539qkh.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=FnaOUrlqjoUE6ChSFxJUOL7gOMA13s0vbM/KLKrQVfE=;
        b=s6tkfl21rU9+Kuvih+DNQ1G5odoBLLJv+1lApsBFmmiGuchglbjlBte8pA8tfXRJIr
         mfIUBEQ0Iayxvyvh6adAV9v0/ilNEZkd7wjtP8/RLOMk00y2TtJrg2nCW57ZjaW2/Udx
         AGVhoqy6kJVXM/NVfVwHd1Zp803kjGIbWHc0ovG4wMLkKSOd3tinGQJHEE6fX2Ky5FiE
         AjuMyFJs+kpEBDTwupG33p+W9tKZ0I4AOnbwMlvRy7/I9pLvXGaB/ArYwpS5TQaotSVc
         IX9VzUCyVa/45S6Ryfxm9bQt9fEm1AlLJfjT02rA3V1bsE8b8Xpr+bEEFnq/7+alIB9K
         wetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=FnaOUrlqjoUE6ChSFxJUOL7gOMA13s0vbM/KLKrQVfE=;
        b=dq2xfnIC6TC1YBqks/r39gyLM434PrXHn9+VtinGmVP8xyGzapnWgrNjGdOK0xm0Fh
         m6NuNE7FtcgL/lP0Wipf+4Uscm+hKCAvMjt7Ut+JpgoP9zDq14lLPDWKat7DSjjQAXSs
         FrhNXKQYtXZUwf2x5ycMHavY4Y5zCDCcOJ3V+HxiARc1XE3cSkiD/4yXy8xph2mYvkgP
         HDtpR43g7R2kpnGoW00Tg0BlbX7/OPfxY4ZOipbGcbw06x2e9rvF8Ow7HCyDVjnCUVIZ
         2SxqNAjqdP8XwaASUfQA7UkLTXvNJkZvfKYTIpT6W0ha9440AdraA4spsEttUbvhG1lX
         ECbQ==
X-Gm-Message-State: AG10YOTjx6UPQDaUrWZeRdQrzm2HWo0UyEq1xemfXeDBp0VatlXzq/VmmTRPg/qykezFQo3r
X-Received: by 10.55.76.73 with SMTP id z70mr6293111qka.105.1454015344395;
        Thu, 28 Jan 2016 13:09:04 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-12.NATPOOL.NYU.EDU. [216.165.95.1])
        by smtp.gmail.com with ESMTPSA id x79sm4626623qka.37.2016.01.28.13.09.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jan 2016 13:09:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqwpqwavtf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285031>

On Tue, Jan 26, 2016 at 01:13:16PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 26, 2016 at 10:29:42AM -0500, Santiago Torres wrote:
> >
> >> > If you cannot trust those with write access to a repo that you are
> >> > pulling and installing from you might want to re-check where you are
> >> > pulling or installing from ;)
> >> 
> >> Yeah, I see your point, but mechanisms to ensure the server's origin can
> >> be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
> >> source pointed to is the source itself. The tag signature can help us do
> >> this.
> >
> > Right. I think the more interesting use case here is "I trust the
> > upstream repository owner, but I do not trust their hosting site of
> > choice."
> 
> Yup, and push-certificate is there to help with that issue.

Yes, I agree, but wouldn't this provide an in-band solution to this
very particular scenario. In order to provide the spureous tag, you have
to provide the tagname it should be pointing to (or tamper with the tag
object).

Push certificates can address many other sorts of attacks, but are not
in-band in this sense are they?

Thanks!
-Santiago.
