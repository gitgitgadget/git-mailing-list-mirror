From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 08:08:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270807250.2896@virtualbox>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de> <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de> <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com> <20160426171238.GA7609@sigill.intra.peff.net>
 <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com> <20160426174418.GC7609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:08:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avIeZ-0008IF-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbcD0GIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:08:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:57979 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbcD0GIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:08:47 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M3d9B-1bmRIG3obR-00rIVX; Wed, 27 Apr 2016 08:08:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160426174418.GC7609@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EuBMgTN2h4bQttHyRZ7zLM6WKJ64DPfsAuF9DWj+ULRX+9u4lMb
 yFT9tQxbkvCr1zmMS40xJsJxpSvQiYG7eHPGXrgjZ65pTONbCygp33Ghit+MtavKPyY/yao
 13rOmdcj1fnl/G8k9rRV4Tzu3U6mFRKgbnli82o3t5IdpSEQaXconk16dsh7tmqD5uER8VU
 JmAKV/kXMFt42DSxnBy5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aCAqB8LffgE=:Nq0Q5Aq3yjzypO+aNBhzZy
 fovcQgahBPfLr83y6HtR2mLhah083S19EKZRjjeXdmKc5kRUtw8ZwoEB9MV8Yod/5OlYjPluf
 74rS+SdOEuN/qxWfm2a3F3Xc1ApdNq0leHKu38dXM2dsOy48f3h3qMHH8inZGjlpuNIEd4PSF
 3bOSaMRkJL+ZZOGtLya1aLoyS7Km2WwUdDdmKX0KPnYRv9HVbKALbQ5GA4sC84gpr7vf2p5+U
 FCIvngI4P0oY4O8pLziEI27o7W/nrKyRX5kRCg+rwzbzPAm0S/L52vZqf4qJVxNSafHbQf+GC
 rltyj5UEVl6pBLguXNje3T4IaFQ6aMAmboV6nkoDdYVC4n0C4ea4avSTL4zSYCq91+k35aHFC
 yPujWKXKFB+PXZSpVR27tvbwNg0rW/2jZmsyNNKEWB7kJ7T06m9ghVEuWERJCYanllgqdGQZ8
 Q1KtX5GRYVHal5wXCupUNfXQ2w+LC5fTtI5FzzLSSFsBHxFpsrr/ERepIsrak2gYcoZ5k5Pvs
 8SCZh1za6OpQgndZWT6X0LFeod6ILvoY73S2KVadU0rMeoAxF029HBq6aeOkVn1euOtk0r9LI
 5/4agpZG+1l7UY4KZXp4YviAq4oyBeqkcY0ErpXF4QNeR/x8BAmagczyHTSqrjzsusdPR+Xcs
 SyOIp+5vErZhiTHDWY/lbQkm/qjriq6plCl0ZNXvowoAvshdxmg2zpPOIbk3Xt4VXQUc4OtSp
 gsV30u69j8ZCTcd9zRiW8h4kyB1LLBJjToFzFk1zcFea6P6tHEg6zHV7JOzX3Rgz1G5mx7g6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292705>

Hi Peff,

On Tue, 26 Apr 2016, Jeff King wrote:

> On Tue, Apr 26, 2016 at 10:20:19AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > But I think this block (even before my patch) also needs to handle the
> > > case where "value" is NULL (presumably by complaining with
> > > config_error_nonbool).
> > 
> > OK, so squashes found to be necessary so far amounts to the attached
> > patch.  I still haven't figured out the best way to rephrase the "by
> > default" in the proposed log message that made me stutter while
> > reading it, though.
> 
> I think that part is just trying to explain the implementation hackery.
> Maybe something like:
> 
>   Note that `curl_easy_setopt(..., CURLOPT_HTTPHEADER, ...)` takes only
>   a single list, overriding any previous call. This means we have to
>   collect _all_ of the headers we want to use into a single list, and
>   feed it to curl in one shot. Since we already unconditionally set a
>   "pragma" header when initializing the curl handles, we can add our new
>   headers to that list.
> 
>   For callers which override the default header list (like probe_rpc),
>   we provide `http_copy_default_headers()` so they can do the same
>   trick.

Thank you very much for this. I replaced that part of the commit message
with your version.

Ciao,
Johannes
