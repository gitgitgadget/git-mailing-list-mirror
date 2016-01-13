From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Wed, 13 Jan 2016 08:40:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130838430.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <04a7a497f9a5771d4dbf5fd605f138607b2bae0a.1452585382.git.johannes.schindelin@gmx.de> <5695A077.7070606@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:40:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJG2g-0000WP-27
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbcAMHk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:40:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:57380 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbcAMHkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:40:25 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2ojS-1a0tdj0HEU-00sfsm; Wed, 13 Jan 2016 08:40:13
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5695A077.7070606@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zFBgysidgXelJBgq7du3qt7YNJEjNjvX4bAsJFg2P68njUOSXBQ
 xuCq4Fh5UYYt1NKoOO9d86uADtPDKt+3LzMy5jvRvGrQsXrA6yurA+KFPUQ1ELjLMp+Re4Q
 QQ2rO33xPwQhJF8csYFhXBeV7ejcwgcSwyD+0a4OYFC7wE9uB51xCt87jeteNcE6zlYUEeP
 YihmXOS6wLtCZT9iN/uyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F0aR1FuDEPA=:pCbYagimenRHEpDsuFHwVP
 y4aMWONJHF1xFwUBcNrIxeIkMI1Sd5xLSfZJQMe/dTZED/2BFQCpgY1M+Lp+CoZniZDnzbr9j
 g+QlhrwxY04tiR99kbMIaZJ3PqMGygOsEggxPt5uDh2NIGKESmayZqvqEdD0FBKyongLYuc8+
 DeEsyZuzbmXM7+o1D8cHb/ax0SG8YoZOajoCM6KElMRn5lIrt2N4tFAaEQ+Uumk73yGY+MHrc
 9DD5Qs77PNaAfmv8GMTlkPjov7f7KyvxvngOrTa7n8s+WHm6tSV4n1K+nH5lBIqjFvTfmQTt5
 03dhUF6b0K/RUa91o04lmGn/nr3HAfswCZp1nGEEbFAVoCJJB5+hsGms13PQ1fE8cfMobE5Ex
 XAjZ99VA+VMqLl8VVXbkMBfAzse0+JgMkjKOTGZ4Ro+YSQZMaRviPxMJe26wx64kTkCjv8stf
 SQuBenZ03jPlm+HBXLPl3CWKiunhHaRZmMwIdNTNhWq0UT+OXk6VBiSG2jOeztL6FdfR/bkga
 QJeJ5SK9u6n2tAMZCDctG/l/zDWB/V1S3hjCc24iUeqnfPMhzWNHJ6o2yB+reJq7NWBGqenk4
 Y2T4/iWpUKXjnt3iPCl6iAgkaU8DnDMDZIkQNFr5YhOywQhfvuzRcsoHUAL1Kreyc1imI0oWS
 UymUniYfsQR3HZLfSwoUhqJmAyZ0KrybHOlJdJ5vXRuhcReGmL+wYhE/+zsYj59y14Iddr7N2
 iEbdcy2CDp78yR3Yamh0H3mEX6m7209YrJKn3n7Y7nqKxGc2K8QONY7SqIQrnSoDosemWpgs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283894>

Hi Ramsay,

On Wed, 13 Jan 2016, Ramsay Jones wrote:

> Also, when compiling on Cygwin with NO_LIBGEN_H, I need to
> include the following here:
> 
> #undef basename
> 
> in order to suppress approx 230 warnings about the redefinition
> of the basename macro.
> 
> (I suppose that should go in the previous commit. dunno)

I think this is an incorrect use of NO_LIBGEN_H (because Cygwin obviously
has it), but in any case, it is a completely independent issue from
fixing/testing basename()/dirname(), so your #undef basename should be in
a completely separate commit, methinks.

Ciao,
Dscho
