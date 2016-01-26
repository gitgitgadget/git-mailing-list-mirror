From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Tue, 26 Jan 2016 09:00:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260758070.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de> <xmqq60yibe89.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601251747050.2964@virtualbox>
 <xmqq1t95fgig.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 09:00:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNyYa-0004yL-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 09:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbcAZIAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 03:00:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:58364 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcAZIAv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 03:00:51 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MWkep-1acbgk1yAd-00XvAu; Tue, 26 Jan 2016 09:00:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq1t95fgig.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7V5XiDk1y2YXGXh1XGhuIgHfv45mgm7hQOtpfAPWiyLsiiTy5oZ
 C1oXopGVnZm2SjWsDWJTHUbkFVVt+F37h0p2cknQrNGtcPHVW9TPwZJHW0dH03Ih1UybYsQ
 YJ8PVxh4qcKTInrhbPZnKqr0pB+Tsiv9QRWFpQfsdwf7f7N8RuI+OKHMpVfc2cgTMtg7PWW
 tc38NWWIm5OXtMgF6ofMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UXqR/8I2v60=:x2o06AlsALGqBnIrB7bEOB
 DdwYPSqP1XtCus1GmPoAs7e64bcrUxVORkzmhRY+UI1eRL8L9N4bSiash1J4Gbb/52Ygi0hgh
 Y3E6VT4Q92OAm2/NN4nKnnlNYQdNCjV1H9MRPpqWTDW+69/0P0DljLLi4+vZBm1IFKsavsKYn
 ORrag8XSRXirpXr3ezIMS1u0D1jgkYKJP1iP+zhGbsDjfZ57sDX8f0C31kmfo/S4Iev8YDaYP
 RwBHsTN5uSfKkv7/epO5OC31IwuGmDo+ZVgrkGojSiL9iKdXk9qJG2N/Zra6V0pC4keVOWyKh
 bsKS1N0f5C/TQi7Bh3yfGX91TiiImHrqP00/ZpItg3nZufBk0uOEgErnoFU8tcczBfUPXwbX8
 MnbSFV3jvQeD8R6RkjxlS6Hmml57P7387t/ONum60Z0oXTk0PIQoWsyQiqMBlOQWDV2s1/ooT
 Hyce708aU+sfT1luc1DbOb1hXtWH8QoK+JcFW60r/yk88pWI5s8TMoDFomrjGFWd6/l4Zippq
 Kit2S/RaLCxtVii8jX3JGyAZiAmkuQXTEdgUPxLCCpHz2YZE4hSaNMCtT+2ggfpDo9nDTdy5g
 qkpIvCjuko5Rx4pqUguIq/3+9rTMoX/l42k28m1E6be9MCqhfHUmLN3zMpVn/pk8sF3uu3xlF
 sYQ31UnIbyJNdFo2J1oklKs2KwGy9Pc2VATw5F+vn9UcTJGQ6lS3Pp7MveMS+ZZpFgzOAttrm
 TEAGq6PoExis7lLBr5ZX1fP33i3kzPWMmTuKihRlIww3oT8d79bnIm4MpyMLz+p8+sTnBWPo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284785>

Hi Junio,

On Mon, 25 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Is the fact that $global_excludes is specified using an absolute
> >> path significant to the correctness of this test script?
> >
> > Apparently not. So I followed your suggestion and made this independent
> > of the OS:
> >
> > 	https://github.com/dscho/git/commit/0b9eb308
> 
> I see many "cd" in the script, some of which come before the global
> exclude file is enabled, but others ("--stdin from subdirectory",
> for example) do run from a subdirectory.  It turns out that this
> file is used as the value of core.excludesfile.  By the time that
> file is read in setup_standard_excludes(), presumably we have
> already done setup_git_directory() and moved back to the root of the
> working tree, so I guess such a change would be harmless.

Yeah, it appears that after the entire test ran, there is only one
global-excludes file, and none of the `rm` commands removes any
global-excludes file.

> It somehow makes me feel dirty, though.  But that is not a specific
> problem to mingw port.

Well, I found the entire file a little hard to read ;-) But yeah, I do not
think that is specific to the Windows port.

Ciao,
Dscho
