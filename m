From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Thu, 4 Feb 2016 13:01:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041258400.2964@virtualbox>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com> <alpine.DEB.2.20.1602041204430.2964@virtualbox> <CA+EOSB=ky8E7J0Fa26DjgT=5-X9N09=4kRbGvWZo5K7PhwS7hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:01:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIbI-0006MM-KG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbcBDMBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:01:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:56415 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbcBDMBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:01:23 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0PdN-1aCuui3jLR-00uabQ; Thu, 04 Feb 2016 13:01:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CA+EOSB=ky8E7J0Fa26DjgT=5-X9N09=4kRbGvWZo5K7PhwS7hg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:DqZTxLpUvHkpP7GiqGg+8N1SR+FpCIcP91CDRPGC1z+5lQ8Y6OE
 HgAo5SFk3Zxf2Nq17YWy0sLpMV6KWvEEOCecl2XpiD1fvLsmQfQ+FR6XFDyQXZ3LyLYy2ZS
 hKg8RTk8vKZ9XwRImE3560iPF7VyobACBjBMT0kGar8+2gxKhYRRkARhyLZfoB6IlJBmi39
 cGJ4pau9wh+GgTuLwHq6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QKyR/3tjjAU=:VF5VUYfqv79JrNI1PYT83j
 GpNt344FVh0JCBOe6muZn44vwkCcQwFnibdGXFdTKevmIHP5nrqim5z6IutBLwbwfE5kdHULE
 l97sXDIcV7Ndijx3sOZwz0bEyQZgmnSekvZN+2zs8oSBk/Ch1gh6eZWtcIIO+kIotHpvLSfyq
 p+dsaiu0qGxVAk7DO5+3C+gmIBxT1oymc7imeiY/lH/rBDlzejjSmq9KxNvjgpacGKwWPi6kT
 6WH7QDXOF/NuhBL9P4P5qcHSXRLYs3aoxaGVh0Cp/xFg2yPYbgmn2rrrcf8XfxFEus18YFjlQ
 p0WO5oiVyGx5XY9JunJlgKfoQz/ImwMyqjpul86JDkpmNekds+KNehysNv8sPFK1L9dZaGtjS
 HBV10SXaXo8ow6XvI2HsD9le/aQCpntqmbpitIj9DTEtXcx+FGnbJFinp0nE7pj+YGKAduVnC
 PWCdH/K0A7hrhI2gsfBBY7YebknRxG2AsaWoDqKenluDtix0eOYOQIhVDPHwGtOH6nLr9wlBO
 lfHL2+OQDFQmRVKbXU0mZhc/5IBVs3wynotbxMADLJsFEKFMZzcwfh54TXzS7DfUIqUnF5A2A
 t1mfykvBaM5QHDcP6xtcxq0GrwbKmzJqFw5dEZU/K07PCdM8So3cx856YROKCIz9gkDG0p2xj
 o3X0FeG3QrbIYSRh4+Ijclef8gC4G6fGzpDfNaUO30qBisMYY6JMgano8OaQv0XV+fxd3Pq7k
 5ttJNZBXTjxDpngfHUzUECwgLBsy8aKQ0CAusSg4LC/x8Nv326lvFq1GOOv2+0vBOqjdDNK8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285455>

Hi Elia,

On Thu, 4 Feb 2016, Elia Pinto wrote:

> 2016-02-04 12:14 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi Elia,
> >
> > On Thu, 4 Feb 2016, Elia Pinto wrote:
> >
> >> -                     this=$(expr "$this" + 1)
> >> +                     this=$(( "$this" + 1 ))
> >
> > Why the funny spaces? We do not do that anywhere in the existing code
> > except in three places (2x filter-branch, 1x rebase--interactive, all
> > three *not* my fault) and in some tests.

I actually noticed more places now, and will send a quick fixer-upper
patch series in a few seconds, that we can hopefully apply before your
series?

Thanks,
Dscho
